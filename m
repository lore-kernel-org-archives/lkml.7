Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DFDC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EEE26FA3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hlmnc+h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfEaWZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 18:25:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40350 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfEaWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:25:57 -0400
Received: by mail-it1-f193.google.com with SMTP id h11so17750788itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jNO29A3eBJvwf2Vu9Oyg5E4jjTlIZetGj3NF5CjfGMc=;
        b=Hlmnc+h5861mci94IXNOb1Pm2K/0ArQ3l0KACnywjZOwv3P1ECcqa+VZ+zoiXhrRyS
         91dnqz/NNnw7ufWxstEtybtxLBrHrKA/qei/0QaNIh1IkhzJieUH47QlzmN284PWCGCY
         jBB2Kjbb4wm8ZhY0Id2+ri0jTqSC8oFOMEcSb8HPhHhPSyzRNIqNbWWQdVXlEkx5Kmt5
         nfaKo/Pjvo5vRWZzmGTWg/0xjYkxDVKxCASO7ynAFxG/yE//lxPCl3OwMSB5dAZSVR81
         YEKWnHi8tnyQec0gqdbuW4E0tHdQ+NkDo/eO0Ex4cHfU8SiCnN3IA0lXzzIqlU3lWNLr
         /5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jNO29A3eBJvwf2Vu9Oyg5E4jjTlIZetGj3NF5CjfGMc=;
        b=Lu13L7P/qAg2JcEt71ut7yZ789/hG5I3p27lWEPY2qMtiDmXlGPfrvh1jxHBvOgAwg
         18/0fCpJsyD4A18bEwCXSaoDvSDCWU1JatVSL8T8+e6N4Kjh6uESZkbRrjmSVnMQwZOL
         BCGCWQU8fcjWogEOhAI9gSuEy9sKWzYk67lb3FuiCkmcKkgMcZIdqfzHVC80gC9eQ1Cb
         i0+tHKjYTpl5l24YI5IwB/iWWry1mzQnNxkJWnlXBBfmIj0lTYxjRyPgq2A7qvziHpQr
         EAx6CqvxqzUk3r5C6pPcovuxK6ni8bBWrD5VNCHNRd+V2HT3gBkpXGfAnQMZ3zX2yFWc
         RyQw==
X-Gm-Message-State: APjAAAXUE9tbfn/F3HdRQZjqU2XmEky/erJfrjOASnAK+PU6bqWIeMcy
        eeXQk6v0KDwqSH6KxSD5w6s/jw==
X-Google-Smtp-Source: APXvYqxn/8sjKyKDB1q/z3xyIFqbE0YwBOLGF5GhVsgmlK6s3ApK9hMQ4eWtlgBcJSrXjR9IMGygzA==
X-Received: by 2002:a24:16c6:: with SMTP id a189mr8499974ita.179.1559341556857;
        Fri, 31 May 2019 15:25:56 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id 194sm3015704itm.40.2019.05.31.15.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 15:25:56 -0700 (PDT)
Subject: Re: [PATCH v2 03/17] soc: qcom: ipa: main code
To:     David Miller <davem@davemloft.net>
Cc:     arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, evgreen@chromium.org,
        benchan@google.com, ejcaruso@google.com, cpratapa@codeaurora.org,
        syadagir@codeaurora.org, subashab@codeaurora.org,
        abhishek.esse@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20190531035348.7194-1-elder@linaro.org>
 <20190531035348.7194-4-elder@linaro.org>
 <20190531.145005.798440469894507477.davem@davemloft.net>
From:   Alex Elder <elder@linaro.org>
Message-ID: <8295f702-2c3f-1fa3-0a4e-ebb51d5b03ee@linaro.org>
Date:   Fri, 31 May 2019 17:25:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531.145005.798440469894507477.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 4:50 PM, David Miller wrote:
> From: Alex Elder <elder@linaro.org>
> Date: Thu, 30 May 2019 22:53:34 -0500
> 
>> +	void *route_virt;
>  ...
>> +	void *filter_virt;
>  ...
> 
> If these are arrays of u64's, please declare them as "u64 *" instead of
> the opaque "void *".

Good idea.  I hadn't paid attention to that.  These tables are
arrays of 64-bit addresses so it's better to represent them that
way.

Thanks.

					-Alex
