Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BA2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D872206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfDWJmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:42:50 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:58190 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDWJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:42:49 -0400
X-IronPort-AV: E=Sophos;i="5.60,385,1549929600"; 
   d="scan'208";a="89162592"
Date:   Tue, 23 Apr 2019 11:42:40 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 2/2] xen/pvh: correctly setup the PV EFI interface for
 dom0
Message-ID: <20190423094240.ksiq2qtow44tzbmf@Air-de-Roger>
References: <20190423092829.67915-1-roger.pau@citrix.com>
 <20190423092829.67915-2-roger.pau@citrix.com>
 <ec713432-338e-9d14-f626-759b0f3f94d7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ec713432-338e-9d14-f626-759b0f3f94d7@suse.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:36:10AM +0200, Juergen Gross wrote:
> On 23/04/2019 11:28, Roger Pau Monne wrote:
> > diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> > index 4969817124a8..51ef98e96d88 100644
> > --- a/include/xen/xen-ops.h
> > +++ b/include/xen/xen-ops.h
> > @@ -209,6 +209,7 @@ int xen_xlate_map_ballooned_pages(xen_pfn_t **pfns, void **vaddr,
> >  
> >  bool xen_running_on_version_or_later(unsigned int major, unsigned int minor);
> >  
> > +#ifdef CONFIG_XEN_EFI
> >  efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
> >  efi_status_t xen_efi_set_time(efi_time_t *tm);
> >  efi_status_t xen_efi_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
> > @@ -233,7 +234,12 @@ efi_status_t xen_efi_query_capsule_caps(efi_capsule_header_t **capsules,
> >  					int *reset_type);
> >  void xen_efi_reset_system(int reset_type, efi_status_t status,
> >  			  unsigned long data_size, efi_char16_t *data);
> > -
> > +extern void xen_efi_init(struct boot_params *boot_params);
> > +#else
> > +static inline void __init xen_efi_init(struct boot_params *boot_params)
> 
> Is struct boot_params defined on ARM?

Seems to be defined for x86 and some mips only, so I will have to find
another header. Will post v2 shortly.

Thanks, Roger.
