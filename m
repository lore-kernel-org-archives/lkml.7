Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6307CC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DD72624F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCae6g8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEaCu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:50:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55000 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfEaCuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:50:25 -0400
Received: by mail-it1-f196.google.com with SMTP id h20so13389688itk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 19:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpeSwEptcSMGM9daV1oXmqD+2IRhi8nulKrxauaJnzQ=;
        b=bCae6g8qJP/Mk2Vt1cIDhcR4ht2TZLMe6UdTX1vRkYRkOxShX94VK9zc6jaPOQmkYo
         OrDixHm2Hoiy1xLvjp51g+iIEV3miXCopjAE2A3cj/llUiE6RxfA+gaCO4qLGG/NqB+l
         w6gFdJHlZdd5x6xph1uPOH9PnCBF8EVwhN44jeVdD+SXWO5kbLu4rziMROKTOlGgdE2+
         B2JnwAcDOOJ2lbntZYgeb80oPgnSdHLedrcAhYy3JS+KpODJTBOGYv5aPml3fHkZdDTq
         3Alem1caB91ME/H25Yg7UzMBktlR4AKBrCFaXE+rDDTdFU7UctOlmUBP+g8g6PZs9vt7
         CilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpeSwEptcSMGM9daV1oXmqD+2IRhi8nulKrxauaJnzQ=;
        b=pzSZiRnDhijtHwHFiPdR+PQURlh8Q7xay8czG+q5IG/IO+09/EHDWdJIskRDCLOdol
         fJ0G0jzbtgXqaYxcl6yxksHBFnu6Rh04VIBrLy4oYr/9FqZHv6K5RUji0r9iARyWw4cK
         IwOUpIacanhLSwbIFF3CFVRMSxbjYJcYasSc5ba5ZPb0Dozi1tGK3NcKM5NPmBk94vuu
         FR59FOAOk04gFXCXuw2xilKI7wa/QVC4bs0SOvADWNCwSO7w0wMNSzL+kdENEWaqNU62
         x3puzCsnlO3O+X1lig5l4SmHYkT4WkDkbUVce9zixHW6r6XJO7YXBn3VB3Spaul2whcL
         SgJg==
X-Gm-Message-State: APjAAAW3At8S8jFHt9HnibhTdqrszbr18Rgi/OX1ZXUGSAtMTtFql3rl
        FMVDZ+bClbApqhYXo+tchMKDmu9+AAo1IA8CFA==
X-Google-Smtp-Source: APXvYqw5gcrxBF4AjPX9qtiHjbfALQ/ZI8uwhofPsjXpTyJ18i9GB0azmM/5+z6gjovqKYsIbfBEmFHXL6sFL2TPjOg=
X-Received: by 2002:a24:1dce:: with SMTP id 197mr5727978itj.16.1559271025293;
 Thu, 30 May 2019 19:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <1557203494-7939-1-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1557203494-7939-1-git-send-email-kernelfans@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 31 May 2019 10:50:13 +0800
Message-ID: <CAFgQCTvZNv9svZr62uW=cnRgASYHo7z-nQLOhM=u0RP6E4qTiQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/2] x86/boot/KASLR: skip the specified crashkernel region
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintainers, ping?
Hi Borislav, during the review of V4, you suggested to re-design the
return value of parse_crashkernel(), the latest try is on
https://lore.kernel.org/patchwork/patch/1065514/. It seems hard to
move on in that thread. On the other hand, my series "[PATCHv5 0/2]
x86/boot/KASLR: skip the specified crashkernel region" has no depend
on the "re-design the return value of parse_crashkernel()".

Thanks,
  Pingfan
On Tue, May 7, 2019 at 12:32 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
> fail to reserve the required memory region if KASLR puts kernel into the
> region. To avoid this uncertainty, asking KASLR to skip the required
> region.
> And the parsing routine can be re-used at this early boot stage.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> ---
> v3 -> v4:
>   reuse the parse_crashkernel_xx routines
> v4 -> v5:
>   drop unnecessary initialization of crash_base in [2/2]
>
> Pingfan Liu (2):
>   kernel/crash_core: separate the parsing routines to
>     lib/parse_crashkernel.c
>   x86/boot/KASLR: skip the specified crashkernel region
>
>  arch/x86/boot/compressed/kaslr.c |  40 ++++++
>  kernel/crash_core.c              | 273 ------------------------------------
>  lib/Makefile                     |   2 +
>  lib/parse_crashkernel.c          | 289 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 331 insertions(+), 273 deletions(-)
>  create mode 100644 lib/parse_crashkernel.c
>
> --
> 2.7.4
>
