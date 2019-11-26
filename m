Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C8DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0E220659
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+pbj3pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKZCsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:48:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33842 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZCsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:48:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id d202so6517559qkb.1;
        Mon, 25 Nov 2019 18:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=N6aJnWMZRZWzAAOOxFKD/hxOJ1yM0VSBu9ZPQ2gP2ck=;
        b=b+pbj3pNm3mI0H5Jny7sffyoMIg+dE6lT3iDy+6M8R26CGE+GWExEQR8QFRrPqu7Qc
         jqoBVHq93NwtbThidmbbC/AHesulYfBdwzNLg6zTt6V8VhFR0hKqCNQqItEiAfeggUJb
         99hfx4aNIfNZhOxoUsUE1R6O6Dp8W1gmh1rIFZ8a38S9V/G2oll/7YAXUg131HDTDIx0
         JaVG2nO7o7U/M4YOAKcTtZyAGCIl6J78+10NsHN+etc+baeF5zlqHognh84jcWjg4sot
         YlP/vEi2f5uEDjtYSfygGnyucH9SLln4evpVPxAUKTNrgWKtlTddZXZvmqs2tiIVe9CJ
         M+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=N6aJnWMZRZWzAAOOxFKD/hxOJ1yM0VSBu9ZPQ2gP2ck=;
        b=ZWhoNXnyqyPPmijYbM/iM9QTAejSUr+RzrwNgfkVmefxWkzzw8YB884UEMCadQXFpG
         7/EBlyPr9NtC6jIZUoh1XLKDOLqsxb8Q5+W9P+DHW13/eCsmu2LZXUZQ2O6Sg92EnpV6
         dMtUxWYHql3igsFHtZ7Kw6s4jAbrMUdzNJmVD+XsizKoaiqNKlQaZT6+xwowlqX7OxHf
         0QbsV3sUKptpWOgfAp03rrQY7WUs9vHZQKfa5jLKSUgE83QLysbKIESQG0zpZqP/2Fmq
         uyiJeoaq46EWQdOHGlufsUqyy6/yqYN3lfy6q5izoKraAtSZVtSiQAxfrySTgs+hncs3
         BQcQ==
X-Gm-Message-State: APjAAAWzBrKDPBYxhujsOmYMAmbt+7c6HsvoFrNUYMwuLVuWSvKn1zv2
        eg74cxI+nnlp48dmUCH71NOXe8bLCA==
X-Google-Smtp-Source: APXvYqw7JlmG7TScZx6Y//aZoyvRhNLOtpm50KVrhsiCNH3hmfvifKTObWTnr2Hu2JIoGgMi6p3+YA==
X-Received: by 2002:a37:bf82:: with SMTP id p124mr13666700qkf.337.1574736519893;
        Mon, 25 Nov 2019 18:48:39 -0800 (PST)
Received: from [120.7.1.38] ([184.175.21.212])
        by smtp.gmail.com with ESMTPSA id r37sm5158715qtj.44.2019.11.25.18.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 18:48:39 -0800 (PST)
Subject: Re: kernel 5.2+: suspend freeze in VMware Player.
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
References: <bc51bc4e-21e5-d6a9-22ee-7c1194deefc8@gmail.com>
 <1725395.bLeSF54TfN@kreacher>
From:   Woody Suwalski <terraluna977@gmail.com>
Message-ID: <fd0e4df9-9619-8465-37e6-0ed14e4a2912@gmail.com>
Date:   Mon, 25 Nov 2019 21:48:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <1725395.bLeSF54TfN@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday, November 23, 2019 11:51:19 PM CET Woody Suwalski wrote:
>> Rafael, Thomas, this is the same VMware Player 15.2 freeze on suspend issue
>> I have been discussing with you in August.
>>
>> It has surfaced after Thomas Gleixner's change in kernel 5.2
>> dfe0cf8b  x86/ioapic: Implement irq_get irqchip_state() callback
>>
>> It is still with us in 5.4, 100% repeatable on a second suspend after a
>> reboot.
>>
>> I have traced it down to the ioapic_irq_get_chip_state() function, where
>> rentry.rr is stuck hi.
>>
>> On the first suspend I can see that for IRQ9 the test exits with irr=0,
>> trigger=1, but on second and consecutive suspends it is returning
>> irr=1 trigger=1, so *state=1, and this results in a never-ending loop
>> in __synchronize_hardirq(), because inprogress is always 1.
>>
>> I have been usig a "fix" to timeout in __synchronize_hardirq() after
>> 64 iterations, and that seems to work OK (no side-effects noticed),
>> but of course is not addressing the underlying problem.
>>
>> And the problem may be somewhere in VMware emulation code, returning bad
>> data?
>>
>> Would you have ideas as to what should be the right setting for
>> IRQ9 in VM environment?  Edge or level?
>> And which part of code is reading the "hardware" state from VMware?
>>
>> OTOH, current implementation is not really safe, as the wait loop should
> It is not clear to me the current implementation of what exactly you mean here.
Sorry, by implementation I have meant the source code of a never-ending 
loop where suspend may be indefinitely blocked by a flaky hardware bit. 
The result is a frozen VM. (check kernel/irq/manage.c line 73 on version 
5.4)
>> have a timeout, or else it may get stuck. Should I provide my safety-exit patch?
> Thanks!
>
>
>

