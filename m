Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A2BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AE92186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wK+lVV6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfCTOwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:52:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41622 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfCTOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:52:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so3084375wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLKX56PwivRBdTxOXedN1NAh/qhj9skVKrE3vyQ5qKA=;
        b=wK+lVV6DjKDsYwS8nfTGo1jJHryRRXmE1IyqwlL4uLhnIT3aRJsyNLQ5Q2a3+htCJp
         ekOa0VlNQnq1L6UyPgm6T6y2XD9Fl41Yelb/mEKnotGKRVpY0hnh/z22H4+wZPUU6Ury
         7MsPjeSzJjOx8KEhYi0ITu2QiUZrD8uA+lT0N+HwGBNxo8mpxFm1kHeO0zOWek7z0dGv
         Ja+9DjMXv3RH/wnrQ6blHHEB7QiR0RIkg1rg0NvfnVFK32jhBWt8Im6JZCHNagPLnxFU
         9s4NPLvjxqHU1OqzurUjxCu5pu89ahE1VUCcCT5ria9uzefk1xPyoMCNpofbw9RDtQ+N
         ioOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLKX56PwivRBdTxOXedN1NAh/qhj9skVKrE3vyQ5qKA=;
        b=IjkikKfiZZ7MQNh98KfLnkmIwufLmBGbIqY7FEQ4Urf9+4qXBqBZTTmyytSFWmj275
         NILS31dOv9gQjWOAn14KDHHVETxYjfUtbstG5w4oKwdOQ0hXE+oCUNLRbjsr6TOX/2iI
         cWU1vHFUvPRtIwiacom0dxDfARCATR93z8jF3fLuNStnTGyaQoxegfYK+z6TIlh3wQ7j
         vZUDMj6DFA0PfCnf5n1ckqVaIVqs9Umqg25ku8biSaK6SXSt/05/sea+GX7kCbeQX5CC
         rC1aV2Y1F4xEh4pPQtA4+zwww0c6Yh5ofavFJadeCGnDyapqO/9v6OAU3T7X7yow4HBK
         ToOQ==
X-Gm-Message-State: APjAAAXAbYkI4otqXjnrskgOPQm/f3wRa94i/ys1LDSseLoTL9mz2yl+
        Q2VINt9yEUvONwt/g0Rx1YVTTs2stsk=
X-Google-Smtp-Source: APXvYqzsfKidOkFwKSOAsIHyFJLR8yO1u86B27wGZXK0EratLXXr0f7qfLKnfFZzCft7gru8A5bIvA==
X-Received: by 2002:adf:f841:: with SMTP id d1mr5380760wrq.114.1553093530041;
        Wed, 20 Mar 2019 07:52:10 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n4sm3352234wrx.39.2019.03.20.07.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:52:09 -0700 (PDT)
Subject: Re: [PATCH] slimbus: fix a NULL pointer dereference in
 of_qcom_slim_ngd_register
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190315062048.16642-1-kjlu@umn.edu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6f7c2485-ef98-491f-185d-420a6373bfb3@linaro.org>
Date:   Wed, 20 Mar 2019 14:52:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315062048.16642-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/03/2019 06:20, Kangjie Lu wrote:
> In case platform_device_alloc fails, the fix returns an error
> code to avoid the NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
Thanks Applied.

--srini
