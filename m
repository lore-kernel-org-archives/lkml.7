Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6014E2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWzpCcgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbgAISeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:34:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33235 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgAISeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:34:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so8550435wrq.0;
        Thu, 09 Jan 2020 10:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VFJ3xIIkT+cbdzjfutrDdpZrJagndmFNonhtgg/BtSw=;
        b=kWzpCcgAYo8/OuCHxa1VIYf7367unZ2vOvPriiOgVi7nNHR0TkkCls/j6I+GHT0u76
         JQEP9meZhsw6Om2B7V733N+h06H6Emv2GZdLL6Yde62GoVUienAmFnxqxRuMIVipqvob
         XkY1fs8ee3dhNACbPHklqCCTRPtSTYoGOtutiX9fbp31ufm3jDMInN3woX6s5EMUAn/2
         xO9oGwWhLpfqJDgU4tZcAjmXrwS41BLJ6kchsn43lYnn5gTTGl7xCXWaaejfu/HFC0Wa
         /NJcCZAu4h2fgAwpuggaSP/V0UQ9d2IcS3zByvX6NAOVSBMZIalzS63VC1xgd9NXzdSL
         BA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VFJ3xIIkT+cbdzjfutrDdpZrJagndmFNonhtgg/BtSw=;
        b=B8ZSVrv84Wuclj1eGQXXIT8T+w9eazkTnlfhEyplDzk7t/MuvuM7qs8yT62ZYydfQ6
         VUPesQg3nlEsuT1v1czbfWNPw4OQT7LDU53v6nZZ8zs97YajFuDA0nVekqFWNddSAtcp
         k70JF03D0C6wwC8FKdB9ZgTiFRNqn5BF69ThqVkL3GT4HTnaOseefl+ZobxlOiuoV2jh
         ABI+YEnlQq/rTrTPAruXd0pkEBea9CNR29C7OvS3RVPfXw9iQtrmivc76qRVZb1jmyrA
         41erHt5lCGt7E3t962JN5ilvtzpGuqlwAzziL6FEaIShdkorKdN78QyDLynG7lHDe7KA
         7u+Q==
X-Gm-Message-State: APjAAAXhzuiqlCiglGYN30YziOuGDDAKHd2mcZCR/kdlnRk7PeJjVLru
        DwAsiYrBohvKZ4ETeziW3ep+ZhlyEeS9yg==
X-Google-Smtp-Source: APXvYqyV2/5QuIoHe8526NZbLMVS26GP/nzlygEIgvgVJ9vpwNkjMdmQir4WQq8vYpJnSxE4X7Bp/w==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr12239983wru.344.1578594848706;
        Thu, 09 Jan 2020 10:34:08 -0800 (PST)
Received: from [192.168.0.104] (p5B3F655B.dip0.t-ipconnect.de. [91.63.101.91])
        by smtp.gmail.com with ESMTPSA id x10sm9784016wrp.58.2020.01.09.10.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 10:34:07 -0800 (PST)
Subject: Re: [PATCH v6 3/4] regulator: mpq7920: add mpq7920 regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200109112548.23914-1-sravanhome@gmail.com>
 <20200109112548.23914-4-sravanhome@gmail.com>
 <20200109132835.GA7768@sirena.org.uk>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <aefe7c78-6bd9-bafd-9215-5784f8168400@gmail.com>
Date:   Thu, 9 Jan 2020 19:34:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109132835.GA7768@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/20 2:28 pm, Mark Brown wrote:
> On Thu, Jan 09, 2020 at 12:25:47PM +0100, Saravanan Sekar wrote:
>> Adding regulator driver for the device mpq7920.
>> The MPQ7920 PMIC device contains four DC-DC buck converters and
>> five regulators, is designed for automotive and accessed over I2C.
> This doesn't apply against current code, please check and resend.

Means should I rebase this v6 patch to linux-next and send, or
of_parse_cb callback changes as separate patch on top of v5?


