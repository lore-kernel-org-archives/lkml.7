Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28FBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89494217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDKO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:59:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:48448 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfDKO7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:59:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 07:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,337,1549958400"; 
   d="scan'208";a="163411880"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2019 07:59:14 -0700
Date:   Thu, 11 Apr 2019 09:00:57 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH] hmat: Register attributes for memory hot add
Message-ID: <20190411150057.GA7247@localhost.localdomain>
References: <20190409214415.3722-1-keith.busch@intel.com>
 <CAJZ5v0gOuHSoMd6dnGKN5fW1xKF89b2ak0F4mo+07FBpFUCP6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gOuHSoMd6dnGKN5fW1xKF89b2ak0F4mo+07FBpFUCP6A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 04:42:45PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 9, 2019 at 11:42 PM Keith Busch <keith.busch@intel.com> wrote:
> > -static __init void hmat_register_targets(void)
> > +static void hmat_register_targets(void)
> >  {
> >         struct memory_target *target;
> >
> >         list_for_each_entry(target, &targets, node) {
> > +               if (!node_online(pxm_to_node(target->memory_pxm)))
> > +                       continue;
> > +
> >                 hmat_register_target_initiators(target);
> >                 hmat_register_target_perf(target);
> > +               target->registered = true;
> >         }
> >  }
> >
> > +static int hmat_callback(struct notifier_block *self,
> > +                        unsigned long action, void *arg)
> > +{
> > +       struct memory_notify *mnb = arg;
> > +       int pxm, nid = mnb->status_change_nid;
> > +       struct memory_target *target;
> > +
> > +       if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> > +               return NOTIFY_OK;
> > +
> > +       pxm = node_to_pxm(nid);
> > +       target = find_mem_target(pxm);
> > +       if (!target || target->registered)
> > +               return NOTIFY_OK;
> > +
> > +       hmat_register_target_initiators(target);
> > +       hmat_register_target_perf(target);
> > +       target->registered = true;
> > +
> > +       return NOTIFY_OK;
> > +}
> 
> This appears to assume that there will never be any races between the
> two functions above.
> 
> It this guaranteed to be the case?

The hmat_init() will call this directly before registering the memory
notifier callback, so those two paths should be 'ok'.

I may have assumed memory notification callbacks were single threaded,
but after taking a quick look, I think I do need additional locking for
this to be safe. I'll get that fixed up, thanks for the catch.
