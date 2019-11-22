Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5657DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215CF2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slpnirid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKVXxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:53:07 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38496 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVXxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:53:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id f7so3731554pjw.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 15:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/fgSJfDwWUJZk4qQCUjEfQX+RZkuy9vdX6awUKhe3pA=;
        b=slpniridXSVEw4nY4I5KMNh4NRv6/oWl+rZ0AG6M37LNSbSAPYsyHwFHowNhxVvbb7
         2IZcNdL2Jzv5Ecx2YnSIpEbvIiO8qOY+WnTZSq0IGMW0AmhuHjtW1Q6nkCxk/VLtjW9e
         iJHM71CPZQjaJd+YZcHy1GpU0DJyTGrYCA+PtaFk7ZFWfEkLapW2LTcBPAUENB0QApry
         UqCaqviFYqEwW5xvK07dMAdW+YHF1v021ATW//30WK++GzFN1njBfBeihAqZd8ywlIpp
         WJoi/6tucp6GN2V+Td1/SPOIM4fxBJPxuRfUvs8YrBCoPGSFmPms293tJoQ1pvbfpEf1
         B53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/fgSJfDwWUJZk4qQCUjEfQX+RZkuy9vdX6awUKhe3pA=;
        b=RzcRe7FC67U77J+P/HGB1XZVVveZJJFu9ANO11uJkW+lpA8J3fgJ06U+O7nTYS9RTf
         LTFBzvUv6OmFR57Hq6pB8Xdu/2evdH0V4YGDH7616bLlCSK9YTQBphzn3iRvfYwt2jra
         viP9WwqgKxAyDgRFoCABqB6CqjINqszb0qyaK3Q3KJu4tULXsMPr3l4UC5BHMbrlpQGY
         iRKLgRZEHHijMWPEoLMTXTIUHqwdGgFegQrbdGENuTQkpDlTdDhZZfBtmldR3iMmENK5
         BLLURGwH1GsUfbwAZT5OkBWqil6nZsYD+RydjEuhAXedu7IxXt//HX2DaZX0zZ2maVl1
         d/1g==
X-Gm-Message-State: APjAAAWsgMDxK5/dVWc8lOvC12eAnYDp+TKkxOqNuX6RPJYU/ZAZXRhC
        WId/ihOjhQun+MQxKAdbICmpHw8+v9Q=
X-Google-Smtp-Source: APXvYqyxKrpojY6n5qCm+4SIu4O0m88qkgp27+Y5i0/YgxpxjPstGnHC+gJZLE/Jn7clsUb9Abfs2w==
X-Received: by 2002:a17:902:8bc9:: with SMTP id r9mr15869159plo.319.1574466786535;
        Fri, 22 Nov 2019 15:53:06 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id l21sm13025pjt.28.2019.11.22.15.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:53:06 -0800 (PST)
Date:   Fri, 22 Nov 2019 15:53:06 -0800 (PST)
X-Google-Original-Date: Fri, 22 Nov 2019 15:36:55 PST (-0800)
Subject:     Re: [PATCH 1/2] riscv: defconfigs: enable debugfs
In-Reply-To: <20191122225659.21876-2-paul.walmsley@sifive.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-0f9ac780-ed6e-417b-8330-68bd11d76362@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 14:56:58 PST (-0800), Paul Walmsley wrote:
> debugfs is broadly useful, so enable it in the RISC-V defconfigs.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 420a0dbef386..f0710d8f50cc 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -100,4 +100,5 @@ CONFIG_9P_FS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_FS=y
>  # CONFIG_RCU_TRACE is not set
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 87ee6e62b64b..bdec58e6c5f7 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -97,4 +97,5 @@ CONFIG_9P_FS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_FS=y
>  # CONFIG_RCU_TRACE is not set

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
