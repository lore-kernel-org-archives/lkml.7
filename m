Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37B5C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C969B20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oeNyLCil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfFRVlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:41:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51626 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbfFRVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:41:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so4877697wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=npjnmaSr2vkCmDXoz3+FiT+jLOxPrHd/kPwcRCCzYl4=;
        b=oeNyLCilPkITLmXVFaDVzdrf/aLDJjiKitNEZaENhh0M8+Z+FgTWcVTe3mvprvIMmZ
         kVDAXDElMa+5FkusYyYQg0ZDapkRSnri4u8NuDbzt8OFV6ctmH/yrMbKetHVjwInbqni
         RGNkgOHbdzojbDhs3HnKRB84CKYsunDDcNAgi5zqsOjOJ5n4V4G16PQ4v9V864qKKF5I
         g5FAOLo9bt0kjeixgYLexM4fiYyXsMWLmSR20ETaAb3XZLCrd2xKlA94AWpVJbO/pBwP
         6SAvTW0tN5x9kMA2BmeoKxidSrlTWWtzTSynsZqvwoB5t6QtUt+9DlCBaiaVDDTPLmlY
         t5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=npjnmaSr2vkCmDXoz3+FiT+jLOxPrHd/kPwcRCCzYl4=;
        b=A/UjOG/THP5SeV40mP82nrUtmvVRYNs1uw4t+ufiMwOcnDbrjuCSgELSUhg9pdnbD3
         ulwQMPcSdlzwBFPQwqwzJE4oqPlXbfx3T7lrOH7Umd2ypTy3NBKa2LeW7orcXt8oSkZa
         XS+ry+nVkl3LU6AN6iqTneb64oiKFLSTj4iLfB32VEQ7o4jEeBLXpOoYQ730zEn+XX/R
         nUmWV61cwpA92Vq7CfbiAzWXssvlf3NJwp2G9r9+RYTDqIUiiOtF482OtoiPS6KJkhH4
         bHaRqhfq/d9K5ESTT7iSGGNis02Zn8/9FqAuW3J2XK5q3UqSQnk4wcW/WE8JNpdrebRp
         XxUg==
X-Gm-Message-State: APjAAAW5X6zurjbl1sLodFVBlyt52pZ7d4wUjxNNoKal3T0RpsuSQYHI
        DgxfFgPeyC0pwFvZUjyLe5hBxLlDmQJNzg==
X-Google-Smtp-Source: APXvYqzriXXa80Q7KkVfSb96pNBw5Q2jgBhKV3KaX+d4NgOHn6hjzmn39dYZ9VMJZ+4IgzakHn7xRg==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr5010451wme.157.1560894093099;
        Tue, 18 Jun 2019 14:41:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o20sm19019027wrh.8.2019.06.18.14.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 14:41:32 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Correct apr-domain property
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190618052547.32376-1-bjorn.andersson@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b0036d9f-eec1-7531-545f-67b651ded729@linaro.org>
Date:   Tue, 18 Jun 2019 22:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190618052547.32376-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/06/2019 06:25, Bjorn Andersson wrote:
> The domain specifier was changed from using "reg" to "qcom,apr-domain",
> update the dts accordingly.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
LGTM
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
