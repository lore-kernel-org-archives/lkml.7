Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860B9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BE222BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBHdhb5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfGZHc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:32:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39510 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZHc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:32:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so24347865pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mx7nzsw+kehYssznF0o6isKJQ7dTu7q6T4pd3Vi6CD8=;
        b=iBHdhb5nJs0QirfvncZsXvFSET6cWPxTcyc97dF+Xrwo9Lv7qx+wBIch4xQ+mPOJKk
         v//zJ8nXYe0ygoSlH0/jZoONeDd7vctDFx0KOKdIgofvhBrDBZ7vieku1KEK/F6yO8xA
         2YUkb9XFsFQIm9JDF0XqtGr9Z8Z/AYHXXGx1nNVMAPsryommaeQQtEG87RyMDavoUxIN
         CsyRT4xhcXgcKTjjLnLm7+7le+xBG4Rh47ZmXJfUfmUbLRFMyZHMAdGyQW8JBy+gy0ie
         1hTAGFoqdPWy10Kj8YBLUO+KQ9J2dIbZVAmXixRdvj53n0sXJoFKxqnXNugk4qDsVSVD
         rEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mx7nzsw+kehYssznF0o6isKJQ7dTu7q6T4pd3Vi6CD8=;
        b=FC5DOVEVhzOYpQq4fEr3QjJ3X2+VTaH2WNEizMeOpdSwoe7FzATfitrBMriYM9IH3A
         T65HwbT6Vzppcdd7b3Nho9AH2skOjeKnnUiyVmfa9Xk7Vwc5o35KoYIp3Tg3LJ9Tdsfl
         /vcCLxqKdpi3otwmdbXF8WQmvpNewcMIovOKpDwUbcFLjFTiY/wDBYObp8ZGc0e2wfkT
         TqpfNe6tRZUpxiNUCnbZgzsrOcwNqFi/jYhoCIZuq1ZIewSVSF4Cyb5UkqLIx8ebgeut
         yrXTpMQPC5U7d/aQM7b0sVzmVg8gZUhj/YbJD/K+vTLERpjXHxPAHsVDu7aHKXvJ9K6m
         queg==
X-Gm-Message-State: APjAAAVUUjk+qvq8eKnXTPktRg4ZSaujSkdFFcB+cM2KO+u/ADf3DdLz
        bOwlA4uJ7CBcjw7833w93JwAK+NO
X-Google-Smtp-Source: APXvYqwZEZvScFHxog2tSwZM9tLcRsotSsstnqsfEGS/Q6zUgmw0gbMsWdR+bluerbUCMK+/66HVVw==
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr100737592pjx.15.1564126377506;
        Fri, 26 Jul 2019 00:32:57 -0700 (PDT)
Received: from [10.0.2.15] ([110.227.69.93])
        by smtp.gmail.com with ESMTPSA id f8sm7895069pgd.58.2019.07.26.00.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 00:32:56 -0700 (PDT)
Subject: Re: [PATCH] regulator: of: Add of_node_put() before return in
 function
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190724083231.10276-1-nishkadg.linux@gmail.com>
 <20190724154701.GA4524@sirena.org.uk>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <af559a36-c926-e2a5-a401-aae0f6867a6e@gmail.com>
Date:   Fri, 26 Jul 2019 13:02:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190724154701.GA4524@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/19 9:17 PM, Mark Brown wrote:
> On Wed, Jul 24, 2019 at 02:02:31PM +0530, Nishka Dasgupta wrote:
>> The local variable search in regulator_of_get_init_node takes the value
>> returned by either of_get_child_by_name or of_node_get, both of which
>> get a node. If this node is not put before returning, it could cause a
>> memory leak. Hence put search before a mid-loop return statement.
>> Issue found with Coccinelle.
> 
>> -		if (!strcmp(desc->of_match, name))
>> +		if (!strcmp(desc->of_match, name)) {
>> +			of_node_put(search);
>>   			return of_node_get(child);
>> +		}
> 
> Why not just remove the extra of_node_get() and a comment explaining why
> it's not needed?
> 
I'm sorry, I don't think I understand. I'm putting search in this patch; 
the program was already getting child. Should I also return child 
directly instead of getting it again, and continue to put search?

Thanking you,
Nishka
