Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D30C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD3C20748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574081272;
	bh=60CLfEbq4pMzG6+q6vJq/HTMA8IDjElElAmgnjC8V0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NeYtfpIIX1KHFNZUi3AECiOFEaY6YxGs874zHST8iYCIQVOsDZY+KHC48+0LDHKJU
	 lBttLFr25ndN/2nruOSoaepIPT6QTrWEP4/KCyZly1crqOxlaaHFAFzYMuDkpet7ua
	 Ve8k+QCMr1R0gTztLN/mYnsqubm6eyGfM9ubbA88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKRMrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:47:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36967 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKRMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:47:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id b10so1078039pgd.4;
        Mon, 18 Nov 2019 04:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Jt2Z2DTdz9m9l3vyvKUFBjKIp4+FU+v0G8DHum771A=;
        b=Viac8KElXK7RaK+xVRUqrlCLNgnyM5j07czBGWxf4G70Ns1J9YjtxNd67A0FyJo27n
         PqgixuwjxiAfr4x4WnJafPCZXat1nxEuikRYo+Qln0jm8dABzWcK8z5s8l6Q5M6sPZPU
         rBghCtD6WKS9p9WjjkjhnZb4NY3nENBUJHj17gsiAYS1A2WBkliPshWoqUQscp1qaG/F
         KWLSBE8GCU++1mZtzCHIptgrR6q9htDZD5lx0Odt5kTRV2Y3V7za7idxhZAnQWKSpLRw
         WH527yZg2Oeffflaag6I+PaGTDfw272aJijA4fvbk3hAbr8o7ft1vSurWb/zqJqp3qzu
         qqIQ==
X-Gm-Message-State: APjAAAW2AbbXtWt0M6x8Ss2VuT9EdD0MqmYxz4Oj5+IxzD8QYhHUHwVz
        Hr3E44MmiFnhXr8pCK7h740=
X-Google-Smtp-Source: APXvYqypHkNV4Ku4i48wIkDxM+JEyi/xuvsuyJR7dNNMFpHvTas3E1Acz5HRaCwycwKDyjfD+TmU9Q==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr7904180pgj.388.1574081270099;
        Mon, 18 Nov 2019 04:47:50 -0800 (PST)
Received: from kozik-lap ([118.189.143.39])
        by smtp.googlemail.com with ESMTPSA id h185sm5758334pgc.87.2019.11.18.04.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 04:47:49 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:47:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marian Mihailescu <mihailescu2m@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org
Subject: Re: [PATCH v6] ARM: dts: exynos5420: add mali dt node and enable
 mali on Odroid XU3/4
Message-ID: <20191118124745.GA14766@kozik-lap>
References: <20191114234211.1032-1-mihailescu2m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114234211.1032-1-mihailescu2m@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:12:11AM +1030, Marian Mihailescu wrote:
> Add device tree node for Mali GPU for Exynos 542x SoC.
> GPU is disabled by default, and is enabled for each board after the
> regulator is defined. Tested on Odroid-XU4.
> 
> Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
> ---
> 
> Changes since v5:
> - fixed compile warnings
> 
> Changes since v4:
> - fixed so it applies for latest 5.4-rc7
> 
> Changes since v3:
> - fixed compatible to match bindings
> 
> Changes since v2:
> - separate patch for bindings
> - fixed bindings typo
> 
> Changes since v1:
> - used generic node and label for GPU
> - added bindings for compatible
> - fixed irq indentation
> - fixed interrupt-names to match bindings
> - added cooling cells for future TMU connection
> - used generic node and label for GPU opp table
> - removed always-on from SoC GPU regulator
> 
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 50 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  6 +++-

Thanks, applied.

Best regards,
Krzysztof

