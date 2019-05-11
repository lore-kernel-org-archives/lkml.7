Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7604C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD4B20896
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 19:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnncB4n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfEKTkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 15:40:53 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:39025 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKTkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 15:40:53 -0400
Received: by mail-qk1-f170.google.com with SMTP id z128so5774063qkb.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xgKOhp4qONWAhp/OZyPcsCOWswS3QMUCHxxb5I+OkcE=;
        b=mnncB4n+ZhJAvAdzFvQVTesV93WYamwJk5zOwCKEYZXgn5CW9nB0cxjlQzcFVTrI53
         LCHQfFkY8PATSVX4c4jSx3/pyefqa4eSqo/Ivty7/R4oYpAzrYH7x0+5JugQ87WgY5GI
         Xn8u2LceA5pwDbnZz7WZnGl5Ui/TNomcZQHUN+lwoeb/DnQiSCLz8aVCQ88c5Kicdtbm
         NoPG+NQd6/xD+MjpTI/69C2ko237XRWE2W75I1QW9lcq07oElkfF98zIoJqyTo2WOS13
         QdmpzkQre0FRYEe0X1PvhM88HR6MoRGAURKIW6mQdtxf/DT6p4EQMa8Q/uopkwNYlsG9
         xKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xgKOhp4qONWAhp/OZyPcsCOWswS3QMUCHxxb5I+OkcE=;
        b=QuIzrqmp2ZjmO3bru5NC/NOOjCwplrqGsaLC+XpZx/FL8YbxYJT2Kk6O1b+ySmSgF6
         z6RaTqQe4B2UFA6AzxgXO/sjJ/T6EUf4s7cl6O+2BWqwApEH2J1Npmz+6cIKGzzgnUj8
         fjlxsRVfTbvmrVaR/BDlv8qEwsnr+qHTeSG4ZMKG+jnKzvLKnRe5abWtBUqn81tkx4S5
         q3gW9o5OTwu2Nf2rSJYCeE0wlWrderqErLzwFYMkcrOe/xnxY9ANAGriBOE6Qc8RlQyX
         ZSBVSs5NjHaMFU8p2MWUi6P8ATbTfziz1cU5wOgb9SSWHuV2P2sfkgfEfbFuEGsLgMIX
         E1WQ==
X-Gm-Message-State: APjAAAVO/M3+ZsqpiHVGkUwcoo6piQolsXfxh2qg7l97tKDZ+95YvbGk
        NUiWKEE3qhXoIMeu/lynCdU=
X-Google-Smtp-Source: APXvYqzfKyks85ChX/J2HqFGeqoXAIo/MQnJ5nm28fHlRqWgiVMaoWzrE0MbM7xZJAKv9MQ7jq+50w==
X-Received: by 2002:a37:6394:: with SMTP id x142mr15495301qkb.323.1557603652007;
        Sat, 11 May 2019 12:40:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k22sm4047086qtj.93.2019.05.11.12.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 12:40:51 -0700 (PDT)
Date:   Sat, 11 May 2019 15:40:49 -0400
From:   Arvind Sankar <niveditas98@gmail.com>
To:     Arvind Sankar <niveditas98@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: kexec failure (Undefined symbol: __stack_chk_fail)
Message-ID: <20190511194048.GA57048@rani.riverdale.lan>
References: <20190511191658.GA25716@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190511191658.GA25716@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 03:16:59PM -0400, Arvind Sankar wrote:
> I'm running v5.1.0 trying to kexec into v5.1.1. I get an error when
> trying to load the kernel image, I enabled some debugging of
> arch/x86/kernel/machine_kexec_64.c and got the following log:
> [90028.591812] kexec: Applying relocate section .rela.text to 1
> [90028.592438] kexec: Symbol: sha256_update info: 12 shndx: 01 value=159 size: 1bc4
> [90028.593077] kexec: Symbol: purgatory_sha_regions info: 11 shndx: 08 value=0 size: 100
> [90028.593744] kexec: Symbol: sha256_init info: 12 shndx: 01 value=117 size: 42
> [90028.594406] kexec: Symbol: purgatory_sha_regions info: 11 shndx: 08 value=0 size: 100
> [90028.595086] kexec: Symbol: sha256_final info: 12 shndx: 01 value=1d1d size: b5
> [90028.595775] kexec: Symbol: purgatory_sha256_digest info: 11 shndx: 08 value=100 size: 20
> [90028.596486] kexec: Symbol: memcmp info: 12 shndx: 01 value=1e9b size: c
> [90028.597203] kexec: Symbol: purgatory_backup_dest info: 11 shndx: 08 value=130 size: 8
> [90028.597947] kexec: Symbol: purgatory_backup_src info: 11 shndx: 08 value=128 size: 8
> [90028.598701] kexec: Symbol: purgatory_backup_sz info: 11 shndx: 08 value=120 size: 8
> [90028.599449] kexec: Symbol: __stack_chk_fail info: 10 shndx: 00 value=0 size: 0
> [90028.600199] kexec: Undefined symbol: __stack_chk_fail
> [90028.600955] kexec-bzImage64: Loading purgatory failed
> 
> I have attached the config.gz from the running 5.1.0 kernel and the
> built 5.1.1 kernel. The config was working ok with the 5.0 series.
> 
> Thanks


I get the same error message when trying to load even the currently
running kernel.
