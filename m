Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8449C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C359920842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567784395;
	bh=eN0rPjmD+lPfuJLFM9ZQLySXMAzPIiVfgWcn+lLNqSE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FwfwFJ9QRFXDYJaVYIKQVdaGWMfZpt3kLYmYX0/g6VlfeXNbG3wpO31OmCaIhVQcc
	 k2aFkMem/qZOtgf3p9HD74rKglkhtAXmxIXp6yrKkkn5U5QArXwhR5oq5CC6gKLivC
	 Tio2/ZCRyu7FRyQncao4ZGzivqUPbelm3uuGoIkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405802AbfIFPjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:39:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37539 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405781AbfIFPjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:39:54 -0400
Received: by mail-io1-f65.google.com with SMTP id r4so13718403iop.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8RHJ4leAR/wkyDpJhQ/x19o61jLbTWUL3D7mVMACPs=;
        b=OcYaycXHpnVraoNGvlISPzzMWYxqcvr/1roS3d7O7HbVcwJ4iowOYMyvUfToJ7ftkt
         UeLmnyQx8D4yEcbwd+FXqshQVOimZBvrXLYYQdhjqlRsft6MHtT2jJ+DLV1J6MU+XDW9
         6qljA7rqLMLqOQNPC2RsUcszjHR6PJiY3QkHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8RHJ4leAR/wkyDpJhQ/x19o61jLbTWUL3D7mVMACPs=;
        b=N4b6oeKwZXpyXSfe6qwAS11cgKrSe74zwp67n9eewTqEFgd/s/nvj5ncexpB6p+Df9
         NhyRmwpouzdJORNvQ/OvuK9w+WgzBegXw6QNdOGBnPSpjLYN2FsMdLoc/em6D+KEJqv1
         2wWSma+jnP4y0b8nyteq4K6mo6LATgfjbqIE7g852LK7kkuTihPY6ohEi8jn5o7fk++0
         5V4jd4tN3XsqVnYiIJUMsqjAE1w+Yv2xZVUwwId5rNRIXI3CiJ3eimm+i7P6jBDe2Kzq
         2OHpStm/Lcxwluxz7+SLeZeD6I660Xg6lMgQy+AUBC3fk69KMM5KwkSdUGYQYnX4B7Xo
         HV0g==
X-Gm-Message-State: APjAAAWBi33oMFR62E4llOpvevnMZJ/lr+RxZObibL+7OyuZdQj2Eni5
        Mcy0P/QxuMfMKM8dr73lT7TytUzMnR4=
X-Google-Smtp-Source: APXvYqyx6+qiaYOFFceX/tUN9jPoZgdAJn3aAZscMtuYCStfnSJ0LEi+f7gjd/wREJQSPji6H8OkEA==
X-Received: by 2002:a6b:1542:: with SMTP id 63mr8416332iov.35.1567784393342;
        Fri, 06 Sep 2019 08:39:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l186sm11065424ioa.54.2019.09.06.08.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:39:52 -0700 (PDT)
Subject: Re: [PATCH] kunit: add PRINTK dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190906152800.1662489-1-arnd@arndb.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5dfe1bfc-0236-25cf-756b-ce05f7110136@linuxfoundation.org>
Date:   Fri, 6 Sep 2019 09:39:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906152800.1662489-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 9:27 AM, Arnd Bergmann wrote:
> The vprintk_emit() function is not available when CONFIG_PRINTK
> is disabled:
> 
> kunit/test.c:22:9: error: implicit declaration of function 'vprintk_emit' [-Werror,-Wimplicit-function-declaration]
> 
> I suppose without printk(), there is not much use in kunit
> either, so add a Kconfig depenedency here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   kunit/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kunit/Kconfig b/kunit/Kconfig
> index 8541ef95b65a..e80d8af00454 100644
> --- a/kunit/Kconfig
> +++ b/kunit/Kconfig
> @@ -6,6 +6,7 @@ menu "KUnit support"
>   
>   config KUNIT
>   	bool "Enable support for unit tests (KUnit)"
> +	depends on PRINTK
>   	help
>   	  Enables support for kernel unit tests (KUnit), a lightweight unit
>   	  testing and mocking framework for the Linux kernel. These tests are
> 

Hi Arnd,

This is found and fixed already. I am just about to apply Berndan's
patch that fixes this dependency. All of this vprintk_emit() stuff
is redone.

thanks,
-- Shuah
