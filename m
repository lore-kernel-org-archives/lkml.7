Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB86C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB04218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9ecvdIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfCWEoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:44:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38959 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCWEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:44:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so2844415pfo.6;
        Fri, 22 Mar 2019 21:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V4+tK7xnRapGmbmkAwgPReJapWDE1U+B78y2KiJBElk=;
        b=G9ecvdIWF/LFppAyVNwMA10lk5+2q8SnTZpysp7Ce13HxixdnVVkJpYC63CXskr9Cp
         QkSpi9wtB3EYtSszaaImmy5IxLoZNhfbJfyUkqcevXiTfbgXPQR9xNhjwsb1F0X9fRE2
         nLWXDM8JeJkEjU30uspN2iK3GDyOWU0QN0ZRBdRoU70eMrrW3w6mECat9soXP8okui9S
         3vw8f9YtsN1wfv7xqu/NFfnyrVkXuKiOghsHUgqlXJavPpopIZCY+1pE6en6P8EIeifs
         NVwqfa8PCR2/Z+kFao66BX4KYaYa3+xauGr4P7b6GuxoXU9qgqOnAqqS8Q2MZGdtzTwf
         bKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4+tK7xnRapGmbmkAwgPReJapWDE1U+B78y2KiJBElk=;
        b=YTVlTQ/k4Sv+WcsfNn2+KIS0f/zHmgwQeOxV/wvslMJtrOYWPWjn709gaHL+W/7B5U
         HcGeQA21lL0gwFDHTblICxW2o+O+O6ri687SknHkt3QTvf5rnsk31ULs2K6Wk3L6TV25
         4kXLrGqwBiQT26LrAyvcePnYcbhutpiE/FELBQIDSVPSw+xbElHz9FuL6UDK6CCkVs2s
         pcVi53RYylzczZ0RLcwDDHNRsY/9XrL8AWUo8Yx9FbGyDQ5etvsNCSaWx6HNihKg6+G7
         cTtq5XW7gEP0TYzTtdL+jtHVOhR8WkqHe+xhYom6rrqGMPLgZWEfdb6n8O7iumdUJRnJ
         XWOw==
X-Gm-Message-State: APjAAAUSbdVl6beZRH+OwBX8qul4ihqtD2hzM2lKDX2Okil40G6SMqoH
        GMw41DkkQcEh7iIX6coHszE5Xi31
X-Google-Smtp-Source: APXvYqzqc7fFmx71q2gnIfndfgRKbQdN12NKeOz3G76mlJMvx4HKceJJ09StnKsMlMUhfFFCau3mFA==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr12882099pld.42.1553316241095;
        Fri, 22 Mar 2019 21:44:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h19sm625986pfd.130.2019.03.22.21.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 21:44:00 -0700 (PDT)
Subject: Re: [PATCH 4.4 000/230] 4.4.177-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190322111236.796964179@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7e46776b-b9d4-6034-061c-924d04abd020@roeck-us.net>
Date:   Fri, 22 Mar 2019 21:43:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 4:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.177 release.
> There are 230 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 24 11:10:58 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 292 pass: 292 fail: 0

Guenter
