Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DEDC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BB72085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfF0KUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:20:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfF0KUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:20:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A83AC30832D3;
        Thu, 27 Jun 2019 10:20:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C1FC19C68;
        Thu, 27 Jun 2019 10:20:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 50B5711AAF; Thu, 27 Jun 2019 12:20:47 +0200 (CEST)
Date:   Thu, 27 Jun 2019 12:20:47 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "Yuan, Hang" <hang.yuan@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Lv, Zhiyuan" <zhiyuan.lv@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>
Subject: Re: [RFC PATCH v3 1/4] vfio: Define device specific irq type
 capability
Message-ID: <20190627102047.elwxbzqcyw4ixy7x@sirius.home.kraxel.org>
References: <20190627033802.1663-1-tina.zhang@intel.com>
 <20190627033802.1663-2-tina.zhang@intel.com>
 <20190627061942.k5onxbm27dju3iv5@sirius.home.kraxel.org>
 <237F54289DF84E4997F34151298ABEBC87683644@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237F54289DF84E4997F34151298ABEBC87683644@SHSMSX101.ccr.corp.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 27 Jun 2019 10:20:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 08:55:21AM +0000, Zhang, Tina wrote:
> 
> 
> > -----Original Message-----
> > From: intel-gvt-dev [mailto:intel-gvt-dev-bounces@lists.freedesktop.org] On
> > Behalf Of Gerd Hoffmann
> > Sent: Thursday, June 27, 2019 2:20 PM
> > To: Zhang, Tina <tina.zhang@intel.com>
> > Cc: Tian, Kevin <kevin.tian@intel.com>; kvm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; zhenyuw@linux.intel.com; Yuan, Hang
> > <hang.yuan@intel.com>; alex.williamson@redhat.com; Lv, Zhiyuan
> > <zhiyuan.lv@intel.com>; intel-gvt-dev@lists.freedesktop.org; Wang, Zhi A
> > <zhi.a.wang@intel.com>
> > Subject: Re: [RFC PATCH v3 1/4] vfio: Define device specific irq type
> > capability
> > 
> >   Hi,
> > 
> > > +struct vfio_irq_info_cap_type {
> > > +	struct vfio_info_cap_header header;
> > > +	__u32 type;     /* global per bus driver */
> > > +	__u32 subtype;  /* type specific */
> > 
> > Do we really need both type and subtype?
> Then, if one device has several irqs, how can we identify them?
> Thanks.

Just assign multiple types?

cheers,
  Gerd

