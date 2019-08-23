Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8772BC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF6E21874
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wg7Vh2cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436874AbfHWTor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:44:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38618 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436857AbfHWToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:44:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so6303748pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oqC5xMMUbO+7V3ahvqsbNQ/fSXZ8+DsANxH/wBr9efU=;
        b=Wg7Vh2cQk3mZ+LOk5wcrEiyksh6120g652gNH8TDhjTA5q3FBDvG0IIuxcjbCD8eIP
         LhliYDFeq/BrRg6qXP6XtIWDjsY6gx2dzpOWFIWG2BC4hx3fHQ6RIqO6vH2uuXO+LlXy
         K0ljUn6TVEunhoY/CgBzCEUPNHwh2/q8IJ6Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oqC5xMMUbO+7V3ahvqsbNQ/fSXZ8+DsANxH/wBr9efU=;
        b=CCvKXaCJBW4VjQ7QZJIBvHI1/oLbd1P8kJ6610wtMM9fuxHRL0BzF3r+5HQiOs6NpM
         pCwOi/1fiFaminupKq2laQQOmGPM5IpZYbrdEh7k2+8UO+Voy6vw0Tj2jzDO7ciDqfVX
         WMKV4+wcLqJtZza6lJ60UJdI7K6+9Arb/qB7Jpp3edG/XMVfiFnDkqAyxOeybJZtNciH
         IFJNuIOthfCsCwCmCGEFBLBEaGUgSTQlOfGi0ikDC2LyyBsOuUJAVqRv5W57EnDLWOuK
         DRy5+uKsg0T7nDMj0Q+tYf+eGeFYA0vd34kJRszoUrJ0YfZb2iEqxp5giwdxuqqJ//NO
         91Wg==
X-Gm-Message-State: APjAAAVZ/M2S17UlDrJKE2ckkbeKBgDNmAerXCCuf3LKkdJZkX2X5wB8
        yjBwQ3SMfUV8OQbTICo5QlhAXw==
X-Google-Smtp-Source: APXvYqzkVWrnPqc1ZXrsqfv6TsSH/aBZJ8pJxskRShIF3jD8xD9RghuJl0fSJBDJTy57m4Ln5Pxwiw==
X-Received: by 2002:a63:505a:: with SMTP id q26mr5298383pgl.18.1566589485862;
        Fri, 23 Aug 2019 12:44:45 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j15sm3332347pfr.146.2019.08.23.12.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 12:44:44 -0700 (PDT)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <s5hef1crybq.wl-tiwai@suse.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <10461fcf-9eca-32b6-0f9d-23c63b3f3442@broadcom.com>
Date:   Fri, 23 Aug 2019 12:44:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5hef1crybq.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

Thanks for review.  comments below.

On 2019-08-23 3:05 a.m., Takashi Iwai wrote:
> On Thu, 22 Aug 2019 21:24:46 +0200,
> Scott Branden wrote:
>> Add offset to request_firmware_into_buf to allow for portions
>> of firmware file to be read into a buffer.  Necessary where firmware
>> needs to be loaded in portions from file in memory constrained systems.
> AFAIU, this won't work with the fallback user helper, right?
Seems to work fine in the fw_run_tests.sh with fallbacks.
> Also it won't work for the compressed firmware files as-is.
Although unnecessary, seems to work fine in the fw_run_tests.sh with 
"both" and "xzonly" options.
>
> So this new API usage is for the limited use cases, hence it needs
> such checks and returns error/warns if the condition isn't met.
>
> IOW, this can't be a simple extension of request_firmware_into_buf()
> to pass a new flag.
>
>
> thanks,
>
> Takashi
