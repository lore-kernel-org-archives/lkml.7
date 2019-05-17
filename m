Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299FEC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5B0216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaZHohHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfEQQZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:25:21 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:55038 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEQQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:25:20 -0400
Received: by mail-wm1-f42.google.com with SMTP id i3so7503033wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8x2Jy6/gxZmiezgdFVn1BQR/C6WvCQ7LwkCWGJtj+hI=;
        b=QaZHohHYfmwHjH4GvWttm3+9MJWC/0IJ5/Aro3Wu+pdYp7FyBA1SYgTXoWSUFJPpZF
         yyHQmF+d2nOxFU8JzNBbveifLDji7skAw5dWHCnc+z2dSJGpNvs3685UrWXp7u0fXnd5
         +mIt8qddf2y4wwI0ffXo+rr3bittdci8FYuzZbEonksAISNEquDZNrkAo5XghTlRP6AX
         3fgq5Hoc7sWuMARPZuo19SMlYM30mYhupvF9gCXQHLGB0IZkJNwtZzNakL0qdAXdz749
         nhDmsikrJAlgjjTZb5RDfxAY6A8BNFfIW+kWbROm6RTdRjoxVoQuBEPj3JjnQxchB9xj
         Wl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8x2Jy6/gxZmiezgdFVn1BQR/C6WvCQ7LwkCWGJtj+hI=;
        b=lIhT+byerOjD7GHWQALCW5kA2Cnsq4nza/yDKFXl22petG8a9+AIEO3EwsSArIK3cu
         31XVZAfsqRCoHw8se7LeRtE/fvbaFk0opPLwAI3l++gV+KigSp+6Zn0F+lYWP7/FF6Me
         wjdlhz5tzIpEUNjjZ2zOiyooaQj1oc0fBSlT3T9Qv8w5YmJ71k5BA60oJYdqTpneIWEi
         Bcc5mirNM8TXCn86at8Tb38VcwQv6BExufyc4Yyh+ax1T51svv4Ru/WS4HVr5S+f4uPT
         vVOLuZ1okQjRvrlTebQdL/Sf3MQeVqkwivbVGthrCNg9jFvS5pGyl6t0BuAHawoBqgy5
         4S7Q==
X-Gm-Message-State: APjAAAVTBdyAfzY3HnvQgN9y3wPcfV3DIrqkNm/JJdU/zMHmScio/oky
        RV2IxurtXsuapbWMj4gjFZoKKg==
X-Google-Smtp-Source: APXvYqwPm5Uo6MeWvcRhGVDqKtnGQIbzB18KIfogvsXWSaBa2KfTjIHRF150v5mcpy4LLvwCUH28FQ==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr17740012wmj.25.1558110318183;
        Fri, 17 May 2019 09:25:18 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id k30sm13228108wrd.0.2019.05.17.09.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:25:17 -0700 (PDT)
Subject: Re: [PATCHv1 8/8] arm64: dts: qcom: sdm845: Add PSCI cpuidle low
 power states
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        devicetree@vger.kernel.org, mkshah@codeaurora.org
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <044cd74e461a1dd7934f44531802f4b557264365.1557486950.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2132b7dd-8832-7db3-d05a-69eec3d5f139@linaro.org>
Date:   Fri, 17 May 2019 18:25:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <044cd74e461a1dd7934f44531802f4b557264365.1557486950.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 13:29, Amit Kucheria wrote:
> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
> 
> Add device bindings for cpuidle states for cpu devices.
> 
> [amit: rename the idle-states to more generic names and fixups]
> 
> Cc: <devicetree@vger.kernel.org>
> Cc: <mkshah@codeaurora.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

