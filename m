Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D3C2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="ZX6+qqMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfLJRJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:09:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46111 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfLJRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:09:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so20710135ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K8JiV5XMl1ac7XRD5k/O7VNVwdh93m34JRZ/SLdtoRs=;
        b=ZX6+qqMxhPUpUTDWrJnuNPHxxz5etn1hLQ1wuYuHaoGAb1gSrHBhPbjk2TX99LxMeG
         9agC5GfNWc4RhmnVU3DAFqYRBoOoWP7bve2KSpH0mS0Bk7WQmvglH+l9E1Gx3eVbLwYZ
         FkILqbcx4HbsBJQ6atLX/RCvk7xnThcheD693wemIlwoYjKEwMcPPE5FQD+SPpWb7hXP
         B3J9xhfJ62yfg6+cRj2gGA39+2LkRV2mR59v/ttAhgtjavJ0FbeLAGCJK/+NKi0T7Wnj
         8YngHG/7TaGTZZLWQ5brkgQKqK/yTKwIDabygCg3Vf1zIUO4bOo2QJq6hpdnZW67pNkl
         o9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K8JiV5XMl1ac7XRD5k/O7VNVwdh93m34JRZ/SLdtoRs=;
        b=ALQMwma0ksH99aYK0tRKBwF5pcLeVNaF0KAVPcLv5h85+raRD8w5CEcKdyE95o+8Zo
         1KTl8yTe8UymV6X4n9ewAyK3oZGz1Z7/0CaNMcFg9MyAp+0pvTKKHc0RJnuxNOFzB2lf
         MFZKGQWB0A92shrjeVPP7thASAh+BRIjxtym96vYX4Ir3uEo2hNyz/LCjJlEBUAiAbRx
         U41j7ZH+iB9MznhAphgSoauvqOKncdManSSViCNgevImhU8fu3KwrsfqFqAqMPjbKVTE
         GJ2BaLfXBsVrFi3MhBWcPR7q+DulrsYIIieGhQtL9qKBLt+vyT05lmT3Sb1T+6pohwdw
         Nebw==
X-Gm-Message-State: APjAAAUbRyjcDHIjN/bHBb2rkCU7P2Em4ggxzca3d4Js8EnhbB5KN91F
        FsDPsjpGBP9419u3N5x1Y91dTg==
X-Google-Smtp-Source: APXvYqwSNC3AoVowSGKWAMoJO0wCskeX6zxpbF6jEyh/Z2ToHaoH1Qc1J4IoiIVdIrO7JnqeEDq8gg==
X-Received: by 2002:a2e:880c:: with SMTP id x12mr18636490ljh.44.1575997779156;
        Tue, 10 Dec 2019 09:09:39 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id k25sm2099775lji.42.2019.12.10.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 09:09:38 -0800 (PST)
Date:   Tue, 10 Dec 2019 18:09:37 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: shmobile: defconfig: Restore debugfs support
Message-ID: <20191210170937.GA6956@bigcity.dyn.berto.se>
References: <20191209101327.26571-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209101327.26571-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2019-12-09 11:13:27 +0100, Geert Uytterhoeven wrote:
> Since commit 0e4a459f56c32d3e ("tracing: Remove unnecessary DEBUG_FS
> dependency"), CONFIG_DEBUG_FS is no longer auto-enabled.  This breaks
> booting Debian 9, as systemd needs debugfs:
> 
>     [FAILED] Failed to mount /sys/kernel/debug.
>     See 'systemctl status sys-kernel-debug.mount' for details.
>     [DEPEND] Dependency failed for Local File Systems.
>     ...
>     You are in emergGive root password for maintenance
>     (or press Control-D to continue):
> 
> Fix this by enabling CONFIG_DEBUG_FS explicitly.
> 
> See also commit 18977008f44c66bd ("ARM: multi_v7_defconfig: Restore
> debugfs support").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> To be queued as a fix for v5.5.
> ---
>  arch/arm/configs/shmobile_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 7f0985e023313b57..64fa849f8bbe0617 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -215,4 +215,5 @@ CONFIG_DMA_CMA=y
>  CONFIG_CMA_SIZE_MBYTES=64
>  CONFIG_PRINTK_TIME=y
>  # CONFIG_ENABLE_MUST_CHECK is not set
> +CONFIG_DEBUG_FS=y
>  CONFIG_DEBUG_KERNEL=y
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
