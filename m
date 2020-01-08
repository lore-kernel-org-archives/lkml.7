Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1775C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B63220705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEakNOEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgAHTSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:18:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42536 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgAHTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:18:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so3285475lfl.9;
        Wed, 08 Jan 2020 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1e7F2RlUVhu0SkYfFPi2wHOfMcdKUgYhl2MgWfpXux4=;
        b=SEakNOEJDdeLyVkM6QJhA4x6bxL7RSJ4D+5ekOaBcMjikxNXfmz+GMoxp5xbWVAtCg
         ubU0TeYJqRjpF7BbtGOrmvvho3xYvPcK3UeyhHKBhe93R0rXTTTaY7bqKW06RpiirjJ9
         NX/FJPlGjRqSQuTCJB/DHeoyCnQ2eT6BTGCKAw4ORRTCvJKLowgaTbl4M+h5tR9Txgdq
         3OiBu5WHXVOHH/3b34uogUMmDYotX+uztmnsvDt2OPm7xvY/B5pg6wPJ/dufGcOQATwr
         7BW81hA0wSsVzgLy6ib0T74RtePNINVQJHDEWNj/ztf1yJ1h+fm7bXTGsbKlMnZ24IqQ
         e+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1e7F2RlUVhu0SkYfFPi2wHOfMcdKUgYhl2MgWfpXux4=;
        b=g237KjemkLxYOR+dfIYI3RfhdWF8k+Vp+xw0SlDRE+OrxxfGfhntdeQgGIstAeYip+
         7hvEHJyMf7fJ/JlGJkmqmb/G7xStWUgEnHLz+8VyX2BLjUXS68nqcxa2Ic6i8NIFo2C7
         5R8jWKgVEfYes6Frx6vzSE0YvL5nALGIfOvg97155q3Om/KHJpweHbpJxJT34OCR12Ru
         wFVbEQJQ2335QDLQzVOOctfG/LTkgLJmiPjxkjb+FQsP3bc2Hi4a6r9RId6fXrSM1XeW
         oXkiiHSSKeBf88BQZE7ynSA1nhnZLWqMMj9mZ4fg8JSSfBCTN+/qhAUygQLRghYznPSQ
         sTgA==
X-Gm-Message-State: APjAAAX2y/sP2DbWCbr5ON6TKWa6XnHkxTJxqBE4kGS9v+84arJlP4dW
        AAYjuEy92i9CpN4YuFy7Hf9X07IJ
X-Google-Smtp-Source: APXvYqw2ei9FuTxbPbBjLQtWFNYu3JU2iQCVFhh/zqhLw8S1Ud5Jwwg65rx67FVvo1a9XqQZA8cpIA==
X-Received: by 2002:a19:a408:: with SMTP id q8mr3648129lfc.174.1578511124483;
        Wed, 08 Jan 2020 11:18:44 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 138sm1911112lfa.76.2020.01.08.11.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 11:18:43 -0800 (PST)
Subject: Re: [PATCH v7 04/21] clk: tegra: Add Tegra OSC to clock lookup
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-5-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ac25ee8d-497c-e102-2ad9-382be03f3333@gmail.com>
Date:   Wed, 8 Jan 2020 22:18:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578457515-3477-5-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.01.2020 07:24, Sowjanya Komatineni пишет:
> OSC is one of the parent for Tegra clocks clk_out_1, clk_out_2,
> and clk_out_3.
> 
> So, this patch adds Tegra OSC to clock lookup.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
