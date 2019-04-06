Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A84C282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE932175B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDFBkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 21:40:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfDFBkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 21:40:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB300307E04A;
        Sat,  6 Apr 2019 01:40:03 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BE9B5D9D6;
        Sat,  6 Apr 2019 01:40:00 +0000 (UTC)
Date:   Sat, 6 Apr 2019 09:39:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com, dyoung@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v3 2/3] x86/kexec/64: Error out if try to jump to old
 4-level kernel from 5-level kernel
Message-ID: <20190406013957.GV7627@MiWiFi-R3L-srv>
References: <20190312103051.18086-1-bhe@redhat.com>
 <20190312103051.18086-3-bhe@redhat.com>
 <alpine.DEB.2.21.1904052223120.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904052223120.1802@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 06 Apr 2019 01:40:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/19 at 10:38pm, Thomas Gleixner wrote:
> On Tue, 12 Mar 2019, Baoquan He wrote:
> 
> > In relocate_kernel() CR4.LA57 flag is set before kexec jumping if
> > the kernel has 5-level paging enabled. Then in boot/compressed/head_64.S,
> > it will check if the booting kernel is in 4-level or 5-level paging
> > mode, and handle accordingly. However, the old kernel which doesn't
> > contain the 5-level codes doesn't know how to cope with it, then #GP
> > triggered.
> 
> The above is more than confusing. I assume you want to say:
> 
>   If the running kernel has 5-level paging activated, the 5-level paging
>   mode is preserved across kexec. If the kexec'ed kernel does not contain
>   support for handling active 5-level paging mode in the decompressor, the
>   decompressor will crash with #GP.
> 
> > Instead of triggering #GP during kexec kernel boot, error out during
> > kexec loading if find out we are trying to jump to old 4-level kernel
> > from 5-level kernel.
> 
> Prevent this situation at load time. If 5-level paging is active, check the
> xloadflags whether the kexec kernel can handle 5-level paging at least in
> the decompressor. If not, reject the load attempt.

Yes, exactly. I will rewrite patch log with simpler sentences as you
have demonstrated. Thanks.
>  
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/kexec-bzimage64.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 1f3b77367948..4c9c079b5673 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -321,6 +321,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
> >  		return ret;
> >  	}
> >  
> > +	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> > +		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");
> 
> This is confusing at best.
> 
>      	"bzImage cannot handle 5-level paging mode\n"
> 
> or something like this.
> 
> > +		return ret;

Will change too as you suggested.
