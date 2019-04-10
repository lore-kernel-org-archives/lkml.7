Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E41C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B512083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDbQcOKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfDJIMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:12:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40904 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfDJIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:12:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so933712plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u9cNHVBQFOA3+ERbAVlBwxB1+QVUR47dBgKSjAPMWFk=;
        b=kDbQcOKED2zn7VgZnX+QUXzluE6rOeD/GqTTLoJfi+gM1sPJCIJx2cprhj7IF/tfXY
         pobIHtIHZlr3JR2bcQW9NtPPUcZ4Jam5dVJKJVGitl3oO3A4WE8N/n+6BC54WUkdtYFa
         Fw15qzgXO0J+aFBqOCoi2mT/rdxBalUdZQkz9TUur2EUF5ld3HvbQrbJ/RgKz1CqhucA
         4Ap+0o9vJcOTruUVYZrma1fpAqk3uiKjR/Ak72tUYLBsoZUFjS2Z5X8lEDB6a71ijlJE
         LTRzthTilY1yna2hM/KEO8z8DeBtKxrJUz9lDRAwHwAz3N5lxiFeUljyeUdzd5106o6y
         n/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u9cNHVBQFOA3+ERbAVlBwxB1+QVUR47dBgKSjAPMWFk=;
        b=M3dRxfiKT49aBt69/qWyCyOoieol3qMMcYGQGXyc2uvOnODG+xF9xCis6cX45c0zQV
         SXeuI7ZNwBuCIMEYmFJfDj5zvb18Vt7bV00SRrzrxfWe+zGBfASi/J19ReHQoegbrufI
         wbbpUfk3flwDtx7Ozri1YRTr9tJt1b8X+u1+a2kny5UOUcq9+wLeiZOJ7wLRwQTn2AzU
         cAS+agefd+s/jXJ4yK7Z7zdDgLrgYjojjvwJ6Y/64i8dRH3t9UloneENuJEmeNaPcazU
         ppNgnSGBsUYECO0wKkk86TaJgwK14xn7qiDYDlO+f3ecieMvfcYUglWHWrzMIpH/qB5X
         j+og==
X-Gm-Message-State: APjAAAUULKrZT+2IK20OrywFAMqmEVAEPwAfy/FzYIhQ6CcnyEmpZKsd
        wpkUC80T/lCT/yh7NlaOXHnk/Xvrdcs=
X-Google-Smtp-Source: APXvYqxHuxZiTYqjtGx/YD6jbwdS8Wlb6Cuw3iV4uEg3KChRUCuh/qOcwyMdkXNy28HTegyJPXijrg==
X-Received: by 2002:a17:902:f094:: with SMTP id go20mr42153419plb.159.1554883918998;
        Wed, 10 Apr 2019 01:11:58 -0700 (PDT)
Received: from Vicamos-MacBook-Pro-3.local (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id i15sm18521965pfr.8.2019.04.10.01.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:11:57 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Xiaoming Gao <gxm.linux.kernel@gmail.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chuanhua Lei <chuanhua.lei@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20190408104012.26791-1-vicamo@gmail.com>
 <alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de>
From:   You-Sheng Yang <vicamo@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vicamo@gmail.com; keydata=
 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
 XrYK6J7j97Lsy/ndgkptXAlGEHjsV/+zKZgCJg==
Subject: Re: [PATCH] x86/tsc: mark tsc reliable on CoffeeLake
Message-ID: <b37e870c-033d-61ca-7993-48f9105e2ec6@gmail.com>
Date:   Wed, 10 Apr 2019 16:11:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/8 8:03 PM, Thomas Gleixner wrote:
> On Mon, 8 Apr 2019, You-Sheng Yang wrote:
> 
>> From: You-Sheng Yang <vicamo.yang@canonical.com>
>>
>> On Intel CoffeeLake it's observed tsc is always marked unstable
>> unexpectedly after entering idle state Package C10(PC10), and then clock
>> source is switched to hpet. This patch marks tsc as reliable when CPUID
>> matches CoffeeLake.
> 
> This lacks a proper analysis:
> 
>   1) Why is it marked unstable

Usually the differences between wd_nsec and cs_nsec in function
clocksource_watchdog in kernel/time/clocksource.c would be less than a
few thousand nanoseconds. However, when CPU is entering deeper idle
state, PC10, the hpet clocksource readings starts to give inaccurate
values for unknown reason, and the differences to cs_nsec varies from a
few hundred nanoseconds to several hundred millisecond, which is larger
than WATCHDOG_THRESHOLD (62.5ms) and finally results in tsc being marked
unreliable. No HPET overflow is found when this occurs.

>   2) Why is it correct to set that for coffeelake

So far this strange behaviour is only found on coffeelake. Besides this,
no much I can tell actually. This could be probably wrong, but may serve
as a start to bring up some more discussion/investigation to solve the
problem. I would be more than willing to help verifying further
appropriate fixes.

Thank you.

You-Sheng Yang
