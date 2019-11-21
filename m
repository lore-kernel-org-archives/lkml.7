Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA40C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF38D2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lym4Ssd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKUSS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:18:59 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38090 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfKUSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:18:59 -0500
Received: by mail-pj1-f66.google.com with SMTP id f7so1848136pjw.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=I6uJcXLoypW9tYMx28q19tiRpGF7WhpsZPZ8dyE27uE=;
        b=Lym4Ssd3e35Z/TKS4vPvCd7JusYX2kQ1Q1v9q/bpwdhs7fEIl23xxj/vA4CQCPEKoc
         1IKrPF83aLgBckBNv0OIQXuCNVtP1G1tPteLRA4qnLkTlSCmsksagYR0WkRtAkVXXvWi
         r/quP8FHUjN7z0thADVY3U5p+EWyxMcu8Vt0D2yccq8qJ7F8Xjrake4Ovgx9domVLTHr
         HIvKbRTmqA6BiekgV+i2T5b6PQgYoFBsEh8MwOflDw505mgb7noIAklKBW/zr9GfB4i5
         Jx2hrX1Ov084EZu6Es/fz2FNEO9032HTQ+iyP+2VXkqEvy7Byxbx+7hw00vDTixc+VfM
         rfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=I6uJcXLoypW9tYMx28q19tiRpGF7WhpsZPZ8dyE27uE=;
        b=SPVbGWWHiOlmdww0NPHBASyeqqioBeRP8nnaBv8/e5mzQHoZypMlcNY5TzeJPrZPaG
         MNOUYDPmxYnE1w5ccxw2+yb+MhemVpbgS2WiugZwGOzFBlN0yYBhXWNIFQKllr3LQcxh
         AmTt+Usr7K3X0tgnBtDMORmF+A3ajSzsd6D2Boezt3Yxuw09fyOfRWQcswzyLsCMQZSC
         fYlFfPZ0xgotsWLmbp6hhcajHvuv2CspAY4FTwhlcQMjOtzYYCamtmkWQNfrB7yzdnvn
         hanWSVF4NflXMZCoqbddi00PPmJiwuqDxJfbF+vAU6v6R5QmaxmE1y52H8Mhgx2of8XB
         v3AA==
X-Gm-Message-State: APjAAAWuKARKq3Pz2fgwBjjCsgWxqVogBZjmoKjUqgGSRvPGvD3Ru6Qe
        BvuT7ITKxfPtPBVqjIQ+3jVp0dPEJ4SpWA==
X-Google-Smtp-Source: APXvYqyM2GIMZHdRW2Vej8w2Qnki3iSJmX/UWdsxangnx58vkA5fuE9uxmqpw4Dve+DsdhaRBKYIww==
X-Received: by 2002:a17:90a:f0c8:: with SMTP id fa8mr13073809pjb.90.1574360337738;
        Thu, 21 Nov 2019 10:18:57 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id k6sm4307272pfi.119.2019.11.21.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:18:57 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:18:57 -0800 (PST)
X-Google-Original-Date: Thu, 21 Nov 2019 10:00:12 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH] riscv: Fix Kconfig indentation
In-Reply-To: <20191120133703.11956-1-krzk@kernel.org>
CC:     linux-kernel@vger.kernel.org, krzk@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
To:     krzk@kernel.org
Message-ID: <mhng-475ef954-a41d-40e1-b8d5-6fb091deab60@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 05:37:03 PST (-0800), krzk@kernel.org wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/riscv/Kconfig.socs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 536c0ef4aee8..85199004c6ef 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -8,6 +8,6 @@ config SOC_SIFIVE
>         select CLK_SIFIVE_FU540_PRCI
>         select SIFIVE_PLIC
>         help
> -         This enables support for SiFive SoC platform hardware.
> +	 This enables support for SiFive SoC platform hardware.
>
>  endmenu

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
