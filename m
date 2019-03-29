Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F269C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CA32183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553841364;
	bh=LZmNKLaqiprv20S43Ej2PY9OZAGTbPERUP4av8woKi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tkaf8QnZFPvKCsjpbMghzz4jlDd3KBaUDNGmknFw/F+geXZ84hi24izrhsyWe+zOm
	 4kA+0mTyTW8gRF/w2DDx/XnVbhtTPpz+5Mzhu24h7THC8FbNFnhfn4MdUlPZSJf6dP
	 ZHMHEz7OFjRiucBPb0davxTNB2Av+naonlIVv/FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfC2GgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:36:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40345 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfC2GgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:36:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so1125649wre.7;
        Thu, 28 Mar 2019 23:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BAoQ7RZT9hsWHPRFrsHlQcpGZ8KG0cCp5TBztwtvJGA=;
        b=gI7DcbcMOzwiSBOH4+Kox7SKYFYVjYOCbejYpTLP/6lge16FxN//P14oqBjhbfnfIR
         XqPYQHF92sCRohNSkm+1fHRpte+MAwiHRWVr94rOi8xWsBrGEktLGP2+5Q5YBRyVLV8X
         b3MoQHAOqCwslf+I4AU1DH/p1BPedHI/ZzW5t23EnGGY6Hzb+T09buJv4by2IiRe1gxp
         QEXEO+G9BAqTYFxroJiMrnVoI/+ciRfLTmqJ5+OAeFng8EFsICAAjgtFuhQ1ajdHbPgw
         VRL12rKD3/NzlXx4iIWRQgLfgB8z4vxZpkHhVZLc/pZZjtYqdTnJYoR9bXUuGB6QFWPm
         UrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BAoQ7RZT9hsWHPRFrsHlQcpGZ8KG0cCp5TBztwtvJGA=;
        b=bFhSLFOKp87WXcWH/Kp4UyJQ2tyVEu8Hx9oz114ADPWNOUDS1tCCdvpM2gPTErLW3K
         cH26o5DvZSJ3AmAyHapfxIggCliRN4z/mcuL/eLI58gYt03573v5NcKYTndRDsznZrVh
         G7/MNqvtioIUdImtMFCDbdqyO85pzbov2jN3TSJlLvleNOiCwzekvRwn94hX29G3AP2y
         zohWXAYATsM4JMm/PVOC6hz2xrbMsJnGNMaECSrjQVNKGbKdjlJizQFr6kS61Dq0r18P
         Q/UA6mndsHK6GofsXIH1E4zQAv6NktTCE08Y5nREP48XyEwxEw6ZolteN0GTP785pl3u
         9trg==
X-Gm-Message-State: APjAAAXY2tD5GCjkSEGCG22jt8hnxeoxtz/YApFK+C3g5FchJmiBZ7ye
        mcrgHzx/RPSYSsP2ZCewlo4=
X-Google-Smtp-Source: APXvYqyI79OLsTYE/H4v2dJJAv//s7zciPsacF9z73+JVS8ygx7xbgan01KwYbMitCJ1RM0etUfg+A==
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr29476794wru.195.1553841359819;
        Thu, 28 Mar 2019 23:35:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y5sm1338143wrw.23.2019.03.28.23.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:35:58 -0700 (PDT)
Date:   Fri, 29 Mar 2019 07:35:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Marcin Benka <mbenka@marvell.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Jones <pjones@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [GIT PULL 0/5] EFI changes for v5.2
Message-ID: <20190329063556.GA57868@gmail.com>
References: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:
> 
>   Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> 
> for you to fetch changes up to a72f65180feb446cc59616aab400475679b6ffce:
> 
>   efi/libstub/arm: omit unneeded stripping of ksymtab/kcrctab sections (2019-03-28 09:22:32 +0100)
> 
> ----------------------------------------------------------------
> EFI updates for v5.2:
> - Squash a spurious warning when using the EFI framebuffer on a non-EFI boot.
> - Use DMI data to annotate RAS memory errors on ARM just like we do on Intel.
> - Some followup cleanups for DMI.
> - Some libstub Makefile cleanups.
> 
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       efifb: omit memory map check on legacy boot
>       efi/libstub/arm: omit unneeded stripping of ksymtab/kcrctab sections
> 
> Marcin Benka (1):
>       efi/arm: Show SMBIOS bank/device location in cper and ghes error logs
> 
> Masahiro Yamada (1):
>       efi/libstub: refactor cmd_stubcopy
> 
> Robert Richter (1):
>       efi: Unify dmi setup code over architectures arm/arm64, ia64 and x86
> 
>  arch/ia64/kernel/setup.c              |  4 +---
>  arch/x86/kernel/setup.c               |  6 ++----
>  drivers/firmware/dmi_scan.c           | 28 +++++++++++++++-------------
>  drivers/firmware/efi/arm-runtime.c    |  6 ++----
>  drivers/firmware/efi/libstub/Makefile | 14 +++++++-------
>  drivers/video/fbdev/efifb.c           |  3 ++-
>  include/linux/dmi.h                   |  8 ++------
>  7 files changed, 31 insertions(+), 38 deletions(-)

Applied to tip:efi/core, thanks a lot Ard!

	Ingo
