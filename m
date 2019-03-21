Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B39C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E37218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGX2lASC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfCUAMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:12:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41277 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfCUAMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:12:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so3068460pfn.8;
        Wed, 20 Mar 2019 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tMLrvx8+zG3Jns/jYCFw0orTfQrFk4BN0q9E0k9u7c4=;
        b=tGX2lASCjCm2x+rKt7jdkpssUjM6VGqlRQ1av3cUet4unLWVu5G1V/sCewnTgcte6z
         yk54n6vUhWnFnP5chj3r7jG01yA2/0i47Ljr7RzmUelUwgEZPlwioncKkm/TDJ27MuJx
         cOulkAa9XgHspUcIsVJ2tszEg3FZTr9qx8d7UraW3rzUfK40RdotWKdaARAUvJ7fU0dH
         +aTUYWuXaTGJCNBL89A+KSDioRzqtJf7UvtrB5YFBjjtMc5ZXCtQAnKOb2WuwZnmEW7c
         QpuztW1+a+XV/jAOjvDBPs3/2CpsiLsXjHf0lrz4i15gsTfjAolAv3tc7vreuKfBtNw2
         HsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tMLrvx8+zG3Jns/jYCFw0orTfQrFk4BN0q9E0k9u7c4=;
        b=QD/NPCFqJr4fFhAweLHjnhzm6Xt6x3HiA8VZs6o5HgczJZHuyuB5bWNHAPnqvhxLl8
         36qSoPdDk4znV7MGGiUhbzFo0mUzxpJsablVC3wQveV0TzEYmh+FuaaP02mEF47VN3fF
         HTRvYrbvIgr1nGxd3hxCQTmsO2AOwyiLxXOzLNFVmMO+G+tuuxOt9xzLL8akgfoSQSaW
         p1ooKB3/g0lS5IUFIAwL/3NfSo2enhAGsFzLl/nbIHYFXudCic4LePyrd68WK8aDn16J
         cuz5OlxOHxzqSihvAO9DIkdh6AFpf1fLQN27qcf4s1bCmIhTSwdznMufkeiGVa5y7lvy
         4viw==
X-Gm-Message-State: APjAAAVuMTWj2jLufX7HB/5OVKvmKVc+42hth9xNFrKxbx7AoCfYK7F0
        00N3ovWpnPltR7Ha7GZgvRs=
X-Google-Smtp-Source: APXvYqyEdahEnJR1eJxTs9NHza9wSWhv60fEVab1vPcwbK+ZPaYYYXBdR2cYfM9TinO0dvINsDZCiQ==
X-Received: by 2002:a62:e904:: with SMTP id j4mr549741pfh.174.1553127125274;
        Wed, 20 Mar 2019 17:12:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x13sm3501888pgr.87.2019.03.20.17.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:12:04 -0700 (PDT)
Subject: Re: [PATCH] watchdog: alim7101: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190320181658.GA6749@embeddedor>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e041fd69-0cbc-edb8-cc30-037b333e29cc@roeck-us.net>
Date:   Wed, 20 Mar 2019 17:12:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320181658.GA6749@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/19 11:16 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/watchdog/alim7101_wdt.c: In function ‘fop_ioctl’:
> drivers/watchdog/alim7101_wdt.c:279:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     wdt_keepalive();
>     ^~~~~~~~~~~~~~~
> drivers/watchdog/alim7101_wdt.c:282:2: note: here
>    case WDIOC_GETTIMEOUT:
>    ^~~~
> 
> Notice that, in this particular case, the /* Fall through */
> comment is placed at the very bottom of the case statement,
> which is what GCC is expecting to find.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/alim7101_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
> index 12f7ea62dddd..f5ada07e9202 100644
> --- a/drivers/watchdog/alim7101_wdt.c
> +++ b/drivers/watchdog/alim7101_wdt.c
> @@ -277,8 +277,8 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   			return -EINVAL;
>   		timeout = new_timeout;
>   		wdt_keepalive();
> -		/* Fall through */
>   	}
> +		/* Fall through */
>   	case WDIOC_GETTIMEOUT:
>   		return put_user(timeout, p);
>   	default:
> 

