Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3673C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1EC20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moq8V8Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDCKr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:47:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34539 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfDCKrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:47:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id y18so11356834lfe.1;
        Wed, 03 Apr 2019 03:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RCJexLECZYJ44wCF7gsf+T2QGTgtN+mF5xYWIADKFxM=;
        b=moq8V8Ro/xtPS289Kh0hoFv1s5gDUszvZpDogEnHEfTWtsL5a+e8f8wQoGyLoKLQ82
         P04/AsqTUSSO0VTE3AmrS60z0msq6uE4V//A9kpqFLCSAvOVu7olHna26uE0nckvPF/J
         VQXCXL/n9gywK2Xq+yjHdtmdZJW7t4XDC/yzfWu/Lsa7PW7B8U8hCDK/kXHP11qCxLS1
         IAk1Q0nNRqLARxnmocessXvqo5tk6PDeoXk7ImC2TNG2tBQhwX15bdY0Rdqno0fz3IX/
         vVYsu9oz+/GEsRS+YkGSrAjofyWH0pdPjx3/qhCj3Nm33GAlEvIq2CC9gzGSwMBlmoCg
         FlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCJexLECZYJ44wCF7gsf+T2QGTgtN+mF5xYWIADKFxM=;
        b=UpbsMcW1nv29hSn37Y3HXlDkIdtimDOSi/sk9AD/aB2LoyjjuhSGSq3itL0AE2cukv
         7J0Q9RagISAJd2w4sKzx7Kfq5OHO0v/UO+g0sG57J54AjKiloTG9C7AfhOvTbLdrLUtl
         sh1Qm9YEZq/fyHLsO/J6+LeheUHxatot0n/iDOZCVkB6Qn5EKIyBRCLfWC0whX+VaHp0
         8iHAEtIb0TWGRU/AxqttNRtCfees4buqIO6sU4sNckIpdnlEbpsCL6s/owGxd9j0/xqo
         DK00mLBODgjhNfV40ID2IcXSHFg41+VcANWKMj+aBcS6qP3th/MPxQTVGcRZ0CB1KoyE
         DzkQ==
X-Gm-Message-State: APjAAAVS948F3oPfEn2Omsgs1YwYnTKBLA0UbLWQb3EZhRHtDTdHEL3a
        R4YPtEIrxy5cEaXyJ9pB84drZD6Q
X-Google-Smtp-Source: APXvYqziPZonIDQ4NCQzW5iEeD/Hn9qomFDVxPS6D8C3lRKFoCt67riDaA4Hy0C1FHcKUq/5w2myFQ==
X-Received: by 2002:ac2:53a4:: with SMTP id j4mr35679700lfh.106.1554288472924;
        Wed, 03 Apr 2019 03:47:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id z13sm3142196ljk.41.2019.04.03.03.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 03:47:52 -0700 (PDT)
Subject: Re: [PATCH v1] drm/tegra: gem: Fix CPU-cache maintenance for BO's
 allocated using get_pages()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190306225519.4538-1-digetx@gmail.com>
Message-ID: <f0f0a6f0-62e9-3410-d244-f0716263311a@gmail.com>
Date:   Wed, 3 Apr 2019 13:47:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190306225519.4538-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.03.2019 1:55, Dmitry Osipenko пишет:
> The allocated pages need to be invalidated in CPU caches. On ARM32 the
> DMA_BIDIRECTIONAL flag only ensures that data is written-back to DRAM and
> the data stays in CPU cache lines. While the DMA_FROM_DEVICE flag ensures
> that the corresponding CPU cache lines are getting invalidated and nothing
> more, that's exactly what is needed for a newly allocated pages.
> 
> This fixes randomly failing rendercheck tests on Tegra30 using the
> Opentegra driver for tests that use small-sized pixmaps (10x10 and less,
> i.e. 1-2 memory pages) because apparently CPU reads out stale data from
> caches and/or that data is getting evicted to DRAM at the time of HW job
> execution.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Thierry, please don't forget about this patch.
