Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E39C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A863B2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnCEES/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfHRJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:08:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53780 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfHRJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:08:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so484323wmp.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXsOHISmCpUILyy9WHiVYPcKhs15OcsHvOVCutfJVTQ=;
        b=VnCEES/UltGfTFiTg/85Nqzwi5/ac6wr6TakwWpR7pOAZlH9NoN4dI+SNQbrTNye8+
         ArfSICQSVhQyfo4G9syzmU00C8Hzn3dUwkMMDfGVws4EIQ9zr8dOp+X4LukKiXZ7VmIC
         zkCyy6Ev4yGgywH69ioOaqXxOm6xPvV++me6ZhKHs1QgOJLY/yZXl2jmnC8D29sYRLHE
         +xhAWaS66VDRWtmazSF3gUeFaQbfC6etJ2lvgmeCxo4zelZjtIr4YLN7c2oAkVfFRrdm
         rcvS7tr74BBsCyDHTylY/ZLZi3wxoAiTuq9hNnxjIYU4HcX0z1vwatZ7a9PZRBbpdSfg
         ktkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXsOHISmCpUILyy9WHiVYPcKhs15OcsHvOVCutfJVTQ=;
        b=bQCvKliA8a+N4LQ+M/fkSOxyvOK1sY6lvFjpkiCeCIaiQOIuGe4G8Oku7mXzZGoxfl
         bS4dHj3lUG5oUtHz9M71sohlUTL+3EhSNSRJXBSk4OHUuGG9+kXi+wif7f1GtyMoIFx7
         P/SJZiyDSqES5Xv1+gMPKQGeZptU0EctEZOABhYiUigSxZpCqHe2i46b6uMBsaLoL1Pe
         YBb8dF3iq+YRx4VgP8dh7Fo1FeHqHIpt5U7Z4fBxS7m7QdTiAfpfnzmlNUHwElbp+i6A
         0n2u/376vtzy9sbvQFn/QgB697c1egS5XZCYbN6cDOuzQB0I3BQ87WhoTRwOVYvJJm5Z
         0lQA==
X-Gm-Message-State: APjAAAUcBO15EAk341GQY5RJ4ws6OTA4tg5jlUBUCJOcddD0b1hGz/Kh
        BQFoz1FiRaYc7td7+ikbwxeXFg==
X-Google-Smtp-Source: APXvYqyHX+LW9YR2h2Sapt+smYzR6FMkFbhNfzF9MEfgizCxuJ1WxMrjeaOYDF1/XkV6nlK+MuPFTQ==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr14813865wmj.152.1566119334824;
        Sun, 18 Aug 2019 02:08:54 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id p7sm8422702wmh.38.2019.08.18.02.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 02:08:54 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvmem: mxs-ocotp: update MODULE_AUTHOR() email
 address
To:     Stefan Wahren <wahrenst@gmx.net>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1565720249-6549-1-git-send-email-wahrenst@gmx.net>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5883944e-efef-ed3d-fdfb-19d9964762f9@linaro.org>
Date:   Sun, 18 Aug 2019 10:08:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1565720249-6549-1-git-send-email-wahrenst@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 19:17, Stefan Wahren wrote:
> The email address listed in MODULE_AUTHOR() will be disabled in the
> near future. Replace it with my private one.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> =2D--
>   drivers/nvmem/mxs-ocotp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied thanks.

--srini
