Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D1BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074AE20879
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554094739;
	bh=3rumWFu+f6Bn/Lsb6E0iRdjV70+/QJZtdx97wepBgPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oY/lFf/qJOPBOP8SEs75iwGKGCjNQKHtgMRU5u4CCYZsYs6Zor1MhqYT2TkkTIwuW
	 kgD93nJg0euH3M/FfpbIVQjicK6p4St+0noRJitSQxgmvrdfepykaheCy97OEdyQvV
	 Oc0k9+FNWDzn5xkdFohJ+xY95Nna8lXik9oZQRpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfDAE64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:58:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:20665 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfDAE64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:58:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Mar 2019 21:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,295,1549958400"; 
   d="scan'208";a="160163267"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2019 21:58:55 -0700
Date:   Sun, 31 Mar 2019 23:00:16 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCHv8 07/10] acpi/hmat: Register processor domain to its
 memory
Message-ID: <20190401050016.GA16792@localhost.localdomain>
References: <20190311205606.11228-1-keith.busch@intel.com>
 <20190311205606.11228-8-keith.busch@intel.com>
 <CAPcyv4j5bLiUtmjdnjt7KNOtNm4sRHWp=5T3m1bWD=U1zBXeqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j5bLiUtmjdnjt7KNOtNm4sRHWp=5T3m1bWD=U1zBXeqQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 02:15:03PM -0700, Dan Williams wrote:
> On Mon, Mar 11, 2019 at 1:55 PM Keith Busch <keith.busch@intel.com> wrote:
> > +static __init struct memory_target *find_mem_target(unsigned int mem_pxm)
> > +{
> > +       struct memory_target *target;
> > +
> > +       list_for_each_entry(target, &targets, node)
> > +               if (target->memory_pxm == mem_pxm)
> > +                       return target;
> > +       return NULL;
> 
> The above implementation assumes that every SRAT entry has a unique
> @mem_pxm. I don't think that's valid if the memory map is sparse,
> right?

Oh, we don't really care if multiple entries report the same PXM. We do
assume there may be multiple entires with the same PXM and have tested
this, but we're just allocating one memory target per unique memory
PXM and consider multiple entires comprise the same memory target. That
is okay if since we only need to identify unique PXMs and have no use
for the adderss ranges that make up that target, which is the case
for this series. I see you have a future use that has address ranges
considerations, so separate targets for sparse ranges can definitely
be added.
