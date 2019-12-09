Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D586FC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11DC2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XlwlAish"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfLIOsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:48:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42058 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfLIOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:48:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so15922871ljo.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0HvN+3e+7om8qumnXzunxi56S61TczW41AS4hCzUgbE=;
        b=XlwlAisha/IQ7vS/gPNErAprRksj1pwwuHY/qJSvFrQftdWih8AAn/4LDfkagAGmLA
         sZR6bvN2z4ljSMIpTJi/Il6SofvgqRgEX78t/iRPfj2M2D+ks0ropUWEp3cqkqLB+Et2
         sSqnzNYvkMhxhSpfXfdpygzs7CQVB0+tm1fxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0HvN+3e+7om8qumnXzunxi56S61TczW41AS4hCzUgbE=;
        b=MsXID8qSm60x1M9vN/xSaj8CdpzbxCIpmOC+qEklIkeVvVJSYLZXOgH/3NVQQLoO6H
         xUTh8AGsWi+SGUMtLqiGqYCAp0mT6JYUss4w+100ltHetu7jT9CRoMtNM6u+swTxLS+X
         s5e6Np4avnbXDy1w5qdLndRW4c21h+ufhPy3pJwqd+DQUwfpC04OmsU6nUUH8/irCUWa
         35jtTHoJ9sz9OL3m5w3GJ6ZIu95A7jl4eQT3Caq0DIya4dTPbMFPSeVcemAS2LaFjuqi
         wUrl2JffmF4V4lFLcIHP3n4KiJ1rIgHGv8wVHCwmuwZQjMYjzExwHUmmIDiQ7VNifNIa
         gofg==
X-Gm-Message-State: APjAAAXMn5qqPOt2XIyb2c+Q44Ey0SqIKPwW9/KSNfir7mmVRB+E5Y3l
        DTJDc6ALHXKG9p6jTFmjgrxEnnHsicQH0LyF
X-Google-Smtp-Source: APXvYqwnB1DDe+vJLnMUeAdtaqnv/hdl6VeHTg1Ng86FZHxtqmmJu4heJ3e9QqQCJC7P0kUcC7OWoQ==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr14634556lji.112.1575902882749;
        Mon, 09 Dec 2019 06:48:02 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h24sm21816ljl.80.2019.12.09.06.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:48:01 -0800 (PST)
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
 erratum A-009204 support"
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yinbo Zhu <yinbo.zhu@nxp.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191204085447.27491-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4d61ffef-f325-e1f9-7d02-d546f2f3d2cb@rasmusvillemoes.dk>
Date:   Mon, 9 Dec 2019 15:48:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204085447.27491-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping, any comments on this revert?

On 04/12/2019 09.54, Rasmus Villemoes wrote:
> This reverts commit 5dd195522562542bc6ebe6e7bd47890d8b7ca93c.
> 
> First, the fix seems to be plain wrong, since the erratum suggests
> waiting 5ms before setting setting SYSCTL[RSTD], but this msleep()
> happens after the call of sdhci_reset() which is where that bit gets
> set (if SDHCI_RESET_DATA is in mask).
