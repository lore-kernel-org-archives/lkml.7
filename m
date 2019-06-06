Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A7C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BA320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9QAxuF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFFL6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:58:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35275 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfFFL6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:58:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2136155wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iQVQsp7yTMbyUZ8rytSHxonc28Ex6r7FqihQPfOnjW8=;
        b=a9QAxuF04hTpg0B8dGsEuCpH8U7gtBioreWz0yIR638Zk80u2ahFA2obpDkysuExhi
         gnaZvRR3Gzqvc+jwCKhnb8IqIHmtNipH1yenzXcY++kYCwnvpyecHFHDMOcM3BpWdk/S
         ygi63H8UyT4Xzrzwm6SDEOia8/arndrYDj4aiBS2pyz9ntCR8KbKEN0wdzZj2+L1ySwa
         9Nmm+Fo/SAwU7sue0OJks8G8Algw0Bmv6dE2pRj2hNN8yZK3+n9irrcwzw/lEZAA6G61
         7+1yI/zkl46awiFDWa9pV+PgZ5YnbbYQU/wKCHdS63TrBop9qUL4Y0OCGDAnQzRxWJcp
         twiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iQVQsp7yTMbyUZ8rytSHxonc28Ex6r7FqihQPfOnjW8=;
        b=KrbKEK97LlWqAfJAghLGBWFjZ/lc+w8xlTC8B1wQW122ade/O3rPps69eP8HaCRy7K
         YM5nhW8STprBFe4vGCahRRLIUSKgtDv9wo4oeTgmGVn1Lz2P/8i2lVAQYlfxJctJr5lf
         iaPucAo401QPRsfXWWxTZzEIgJAs3BDn607RLmAwiGcA5FA4HZB437v6dtCxYTvfWGBE
         ow5b9zB/ertzSKU4WlVa1+pNG4owjTAdFe5Cpigto4LvUnlDeDQ1w+2hg3IYL61lAi/J
         cr41UJqMzjoupGFMylZuMoQaOHvBTm73k7eIZaupCTYxIziFjrPv4jJuRS+Za5bjWiYC
         /qRA==
X-Gm-Message-State: APjAAAVvfSB3EKmpWojr3rEV4TQJPkXsLsaNY21dFximlPuaq1Ts+pIn
        KpPMzKE0MeDFyoAfNrbUfX8DEQLjTOMXww==
X-Google-Smtp-Source: APXvYqxYzBpcZtw9gqPO/J05cK+ojwGsBT4wUti524KX8WKqkfLLTYe3HsMes+lMVRuANk648TV7hg==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr15711726wrp.277.1559822281127;
        Thu, 06 Jun 2019 04:58:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k184sm1836981wmk.0.2019.06.06.04.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 04:58:00 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: qcom: Add Dragonboard 845c
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190606043851.18050-1-bjorn.andersson@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <64d89d4e-df71-1204-42cf-be5c93617a06@linaro.org>
Date:   Thu, 6 Jun 2019 12:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606043851.18050-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2019 05:38, Bjorn Andersson wrote:
> This adds an initial dts for the Dragonboard 845. Supported
> functionality includes Debug UART, UFS, USB-C (peripheral), USB-A
> (host), microSD-card and Bluetooth.
> 
> Initializing the SMMU is clearing the mapping used for the splash screen
> framebuffer, which causes the board to reboot. This can be worked around
> using:
> 
>    fastboot oem select-display-panel none
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
