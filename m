Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176CCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F732070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHAo1WeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfG3A0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:26:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33551 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfG3A0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:26:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so28858119pfq.0;
        Mon, 29 Jul 2019 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jpO8sreDUzvlvw9og2Hp8i68FPwJ8U55RoYi0du41uw=;
        b=gHAo1WeQFtuGBTDEwAMCbseXy/B/bPQAtjCYg/HdwPS28nJqFO7jf7nsFZxNLVtqRA
         PqddFVYUFtXo2rw9iMUt5OCvlpYSioXj2Z8yGVNDbzqESA3gLqu3P8k/v7uHizSKoKhn
         du2IBREJ6kx4G+gOFQgUxTdbNqDPWA6nh0hJ85zTyVqesHAX2nrvFCSppHDz2e2H1LMw
         XCfaJOPe9GBh3L5a96L8CWHkdZa4cItaG+li34wz3Vl1FkZERqT1nejifIr2jJQORHaQ
         9XOGIkD9v9C9Ou0blkmLynJSlPAQtgOqgpnJ+lSiELoJlWAF0SHEurS+pgdNvaCk0qQX
         edtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jpO8sreDUzvlvw9og2Hp8i68FPwJ8U55RoYi0du41uw=;
        b=q1l3tHd4Z5bL7M0WOk11yZFGX0l3HzC2Aigd/nw0H9aAFwNbClYuCy3DFJpugePxI2
         WQj+6mMr5Ms/M1n2N2zNqTqIhJTQ0CSwWc+94Th3GJQqKGmjvDHS3NO0ZCSLuodZqacE
         kvv5NYSkgiSirKI7RCIDpDvmuS7fFvE7LN/u+JoVCArfNJZ6KmS8CmrLURCCSn9FF+5n
         sEHPkHY6Zm/gLro2PLVHhG3b9HTz8CJSEHxw5dwlZK0uDBWghAFpg3njIfilYW4BnHZ/
         qQW9QgaKnlc2cZ0rCoNLRyIbhdPBDgjKUA2yIwJLXWLu0bdZhw4YyPzVQ7QF45lBP18y
         J6fw==
X-Gm-Message-State: APjAAAWKEufvDVxgyTj5znN1olGoAaXORHkcU5gz0FYFLXdAtJ7lfMCQ
        nsY7ASB9mhWSvTICBtlu9mJvJPU8
X-Google-Smtp-Source: APXvYqytTwX1w7ww9EqbSB9XCZga85xJ5JB0M2Mdzt3Hx/ZNaYeDn5HitiAFbeJhTx0fTbfn/UDc4A==
X-Received: by 2002:a62:cd45:: with SMTP id o66mr39819439pfg.112.1564446363613;
        Mon, 29 Jul 2019 17:26:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i126sm74812969pfb.32.2019.07.29.17.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 17:26:02 -0700 (PDT)
Subject: Re: [PATCH] watchdog device drivers:pc87413_wdt: Rewriting of
 pc87413_wdt driver to utilize common watchdog interface (fwd)
To:     Mark Balantzyan <mbalant3@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org
References: <alpine.DEB.2.21.1907291614270.2893@mbalantz-desktop>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8e159e06-023e-6e20-ced5-3a645c0a1242@roeck-us.net>
Date:   Mon, 29 Jul 2019 17:26:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907291614270.2893@mbalantz-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 4:17 PM, Mark Balantzyan wrote:
> 
> 
> ---------- Forwarded message ----------
> Hi all, sorry for the duplicate message Guenter, wanted to be sure my
> message is transferred:
> 
> Thank you for your reply, Guenter! Sorry there were issues applying the
> patch, I used git format-patch to produce the patch and pasted the main
> contents into a plaintext email client so I thought it would work..
> 
> May I please request clarification on which functions are no longer needed?
> 

All functions dealing with file accesses directly. open, read, write, ioctl.
Don't you see that when you compile the code ?

> Sorry about forgetting about that last misc_deregister(). Will do more
> tests, if that’s alright with you.
> 
> In effect, may it be best to start the watchdog from the “init” function?
> 
The watchdog should only be started from its start function, when it is
opened. There are alternatives, such as informing the watchdog core that
the watchdog has been started even though it is not closed.

I am repeating myself here, since I don't recall an answer: Do you have
the hardware ? If not, it does not make sense to continue this work; it
is too risky to make all those changes without testing them on real
hardware (or, at the very least, with qemu, but qemu doesn't support
this chip).

Thanks,
Guenter
