Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E767C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DC020859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FMHNpjnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfDVPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:17:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbfDVPR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:17:27 -0400
Received: from zn.tnic (p200300EC2F07AE00B522724F4D48BE41.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:ae00:b522:724f:4d48:be41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77A091EC027B;
        Mon, 22 Apr 2019 17:17:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555946245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JFpPLtfkepV9r9+lHEYcsdq9WsB7wkVB6MPpylxpGW8=;
        b=FMHNpjnrXbYmVyRsNnRzG136ACapGj3qe3EoZZCyU6ah8CwfJmNoLsf8xx+9Wx62M7AvWR
        WXRCQ1LwEsyIAx7IPhGgYEYYw1fR1XoSbGhSNPCAineeJYnAfRujXlRrwHGjlIZ04v7iQ6
        HNFp7ZD/aGj6aZ85f6LoUlSaCQdNqeI=
Date:   Mon, 22 Apr 2019 17:17:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>, dyoung@redhat.com,
        Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190422151723.GD21457@zn.tnic>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <20190419112801.GB10324@zn.tnic>
 <20190419113621.GD10324@zn.tnic>
 <20190422143346.GD3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422143346.GD3584@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ hpa

On Mon, Apr 22, 2019 at 10:33:46PM +0800, Baoquan He wrote:
> On 04/19/19 at 01:36pm, Borislav Petkov wrote:
> > On Fri, Apr 19, 2019 at 01:28:01PM +0200, Borislav Petkov wrote:
> > > Read again what I said: "should all be passed through boot_params".
> > > Which means, boot_params should be extended with a field of a flag to
> > > say: "this is a kexec'ed kernel".
> > 
> > And by that I mean similar to the XLF_EFI_KEXEC mechanism. The first
> > kernel or kexec(1) should prepare the info needed by the kexec'ed
> > kernel.
> 
> We have set the loader type to '0x0D << 4' for kexec specifically, in both
> kexec_load and kexec_file_load. We can check this to identify if it's
> kexec-ed kernel or not.
> 
> Update patch with it?
> 
> static void *bzImage64_load(struct kimage *image, char *kernel,
>                             unsigned long kernel_len, char *initrd,
>                             unsigned long initrd_len, char *cmdline,
>                             unsigned long cmdline_len)
> {
> 
> 	...
> 	/* bootloader info. Do we need a separate ID for kexec kernel loader? */
>         params->hdr.type_of_loader = 0x0D << 4;

That's already documented in Documentation/x86/boot.txt

Field name:     type_of_loader
Type:           write (obligatory)
Offset/size:    0x210/1
Protocol:       2.00+

	...

        D  kexec-tools

And yes, the question in the code is still valid: do we need a separate ID.

I'd say no and we'll simply call 0xD all kernels loaded using a
kexec-type syscall.

IMO.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
