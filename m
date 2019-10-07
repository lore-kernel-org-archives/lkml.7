Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D772DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0916206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUSSXO9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfJGVwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:52:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44079 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGVwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:52:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so14212776qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yj0XbGw7Bq6WSvRBmShSEs1vB7x0y/JZH0AJjB3HNM4=;
        b=SUSSXO9Kbm7ScAYZMq+gQtLASIjyXgtc+v9aX0vYvOfWSQvAF3eCa05cuUv9HJZow7
         QgyNZor+gjGJan36835UwAiizPKqi4JCqwPiIQSmiyN4u+vZSfyRAvbl5VPnx6FcPBUE
         eTzfB78WiaT6oUn8dzMsOVZUWsrafdThSGh0DrJl28fgnoR3RVoXVtpdePE6rUhpGBZQ
         qROfKMDGTo707VFSu+4wbB1LtrsbFFQv1XKVc2taups4e2IE1LyhxUE//7/B7pkvcSMG
         CdBPTXRqjuG0FAC1yvjVIofRT4AqdHtVsiXFCcd/olcPjA4uUSnD2+pc2F+/iNH01KyF
         N10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yj0XbGw7Bq6WSvRBmShSEs1vB7x0y/JZH0AJjB3HNM4=;
        b=HAGQrbnsvQRW1wCNeXXBkvTJuJwsPUQaOiXYED5f1fet7RX11PmL/bo6E7VltIwH9c
         zB3O3637lh5+Q1VkiZsNCCoWFJRhvs9S4qKDVXDMCEi+QBCRELREH+7Dm7j6lWm5/JBe
         Gw+KUuPJddSKuUQYtDIE3wA0HazcGpSMLDGeyxj8VGBFaBgvkbAxx7szv5IudxCcso/H
         Pl6FYjLvUDX+JZFRq1eBkXJgzFb9af1ZZzgT+Q6bkXNNSoCX2DwswZKz1DF0p5yw0snj
         qGS34pUkKy2fnZSWRI/YEREGMqrcBOfQf7pysdV7IBszj4T/qWEcQesn/9xV9UNvkXbm
         eOnw==
X-Gm-Message-State: APjAAAW2e+Y00J+cagLrssK09DwN7C4hZh6pdWLgfUTg7o2JhwhO447B
        3U/MUHcsV6jreaeUuer8LJ8=
X-Google-Smtp-Source: APXvYqzxeqOe+j4ith9gN3EklQBCHrOla1wM8jdwjKi2KQp0Q6Ov36xjPCX5i84400FceWIG4+1eQw==
X-Received: by 2002:a05:620a:15db:: with SMTP id o27mr3876369qkm.368.1570485135906;
        Mon, 07 Oct 2019 14:52:15 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c18sm7012800qkk.17.2019.10.07.14.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 14:52:15 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Oct 2019 17:52:13 -0400
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20191007215213.GA405660@rani.riverdale.lan>
References: <20191007175546.3395-1-hdegoede@redhat.com>
 <20191007200529.GA716619@archlinux-threadripper>
 <c24d8bef-ad76-4986-0c16-268e7d09bf7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c24d8bef-ad76-4986-0c16-268e7d09bf7c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 10:31:49PM +0200, Hans de Goede wrote:
> HI,
> 
> On 07-10-2019 22:05, Nathan Chancellor wrote:
> > On Mon, Oct 07, 2019 at 07:55:46PM +0200, Hans de Goede wrote:
> >> Since we link purgatory.ro with -r aka we enable "incremental linking"
> >> no checks for unresolved symbols is done while linking purgatory.ro.
> >>
> >> Changes to the sha256 code has caused the purgatory in 5.4-rc1 to have
> >> a missing symbol on memzero_explicit, yet things still happily build.
> >>
> >> This commit adds an extra check for unresolved symbols by calling ld
> >> without -r before running bin2c to generate kexec-purgatory.c.
> >>
> >> This causes a build of 5.4-rc1 with this patch added to fail as it should:
> >>
> >>    CHK     arch/x86/purgatory/purgatory.ro
> >> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> >> sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
> >> make[2]: *** [arch/x86/purgatory/Makefile:72:
> >>      arch/x86/purgatory/kexec-purgatory.c] Error 1
> >> make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
> >> make: *** [Makefile:1650: arch/x86] Error 2
> >>
> >> This will help us catch missing symbols in the purgatory sooner.
> >>
> >> Note this commit also removes --no-undefined from LDFLAGS_purgatory.ro
> >> as that has no effect.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>   arch/x86/purgatory/Makefile | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> >> index fb4ee5444379..0da0794ef1f0 100644
> >> --- a/arch/x86/purgatory/Makefile
> >> +++ b/arch/x86/purgatory/Makefile
> >> @@ -14,7 +14,7 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
> >>   
> >>   CFLAGS_sha256.o := -D__DISABLE_EXPORTS
> >>   
> >> -LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
> >> +LDFLAGS_purgatory.ro := -e purgatory_start -r -nostdlib -z nodefaultlib
> >>   targets += purgatory.ro
> >>   
> >>   KASAN_SANITIZE	:= n
> >> @@ -60,10 +60,16 @@ $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> >>   
> >>   targets += kexec-purgatory.c
> >>   
> >> +# Since we link purgatory.ro with -r unresolved symbols are not checked,
> >> +# so we check this before generating kexec-purgatory.c instead
> >> +quiet_cmd_check_purgatory = CHK     $<
> >> +      cmd_check_purgatory = ld -e purgatory_start $<
> > 
> > I think this should be $(LD) -e ... so that using a cross compile prefix
> > (like x86_64-linux-) or an alternative linker like ld.lld works properly.
> 
> Good point, also the ld command is actually outputting an a.out file
> which is also something which we do not want.
> 
> I will prepare a new version fixing both.
> 
> Regards,
> 
> Hans

We could just use $(NM) -u, right?
