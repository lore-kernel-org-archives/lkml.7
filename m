Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7110C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DDA21734
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfGVTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:41:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfGVTl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:41:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AE96308424C;
        Mon, 22 Jul 2019 19:41:28 +0000 (UTC)
Received: from x1.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 522D0600C4;
        Mon, 22 Jul 2019 19:41:25 +0000 (UTC)
Date:   Mon, 22 Jul 2019 13:41:24 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Lu, Kechen" <kechen.lu@intel.com>
Cc:     "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "Lv, Zhiyuan" <zhiyuan.lv@intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Yuan, Hang" <hang.yuan@intel.com>
Subject: Re: [RFC PATCH v4 2/6] vfio: Introduce vGPU display irq type
Message-ID: <20190722134124.16c55c2f@x1.home>
In-Reply-To: <31185F57AF7C4B4F87C41E735C23A6FE64E06F@shsmsx102.ccr.corp.intel.com>
References: <20190718155640.25928-1-kechen.lu@intel.com>
        <20190718155640.25928-3-kechen.lu@intel.com>
        <20190719102516.60af527f@x1.home>
        <31185F57AF7C4B4F87C41E735C23A6FE64E06F@shsmsx102.ccr.corp.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 22 Jul 2019 19:41:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 05:28:35 +0000
"Lu, Kechen" <kechen.lu@intel.com> wrote:

> Hi, 
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Saturday, July 20, 2019 12:25 AM
> > To: Lu, Kechen <kechen.lu@intel.com>
> > Cc: intel-gvt-dev@lists.freedesktop.org; kvm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Zhang, Tina <tina.zhang@intel.com>;
> > kraxel@redhat.com; zhenyuw@linux.intel.com; Lv, Zhiyuan
> > <zhiyuan.lv@intel.com>; Wang, Zhi A <zhi.a.wang@intel.com>; Tian, Kevin
> > <kevin.tian@intel.com>; Yuan, Hang <hang.yuan@intel.com>
> > Subject: Re: [RFC PATCH v4 2/6] vfio: Introduce vGPU display irq type
> > 
> > On Thu, 18 Jul 2019 23:56:36 +0800
> > Kechen Lu <kechen.lu@intel.com> wrote:
> >   
> > > From: Tina Zhang <tina.zhang@intel.com>
> > >
> > > Introduce vGPU specific irq type VFIO_IRQ_TYPE_GFX, and
> > > VFIO_IRQ_SUBTYPE_GFX_DISPLAY_IRQ as the subtype for vGPU display
> > >
> > > Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> > > ---
> > >  include/uapi/linux/vfio.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index be6adab4f759..df28b17a6e2e 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -469,6 +469,9 @@ struct vfio_irq_info_cap_type {
> > >  	__u32 subtype;  /* type specific */
> > >  };
> > >
> > > +#define VFIO_IRQ_TYPE_GFX				(1)
> > > +#define VFIO_IRQ_SUBTYPE_GFX_DISPLAY_IRQ		(1)
> > > +  
> > 
> > Please include a description defining exactly what this IRQ is intended to signal.
> > For instance, if another vGPU vendor wanted to implement this in their driver
> > and didn't have the QEMU code for reference to what it does with the IRQ, what
> > would they need to know?  Thanks,
> > 
> > Alex
> >   
> 
> Yes, that makes more sense. I'll add the description for it at next version patch.
> 
> BTW, may I have one more question? In the current design ideas, we partitioned 
> the vGPU display eventfd counted 8-byte value into at most 8 events to deliver 
> multiple display events, so we need different increasement counter value to 
> differentiate the events. As this is the exposed thing the QEMU has to know, we
> plan adds a macro here VFIO_IRQ_SUBTYPE_GFX_DISPLAY_EVENTFD_BASE_SHIFT to
> make sure the partitions shift in 1 byte, does it make sense putting here? Looking  
> forward to your and Gerd's comments. Thanks!

Couldn't you expose this as another capability within the IRQ_INFO
return data?  If you were to define it as a macro, I assume that means
it would be hard coded, in which case this probably becomes an Intel
specific IRQ, rather than what appears to be framed as a generic
graphics IRQ extension.  A new capability could instead allow the
vendor to specify their own value, where we could define how userspace
should interpret and make use of this value.  Thanks,

Alex
