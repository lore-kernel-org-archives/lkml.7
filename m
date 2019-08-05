Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617D1C32750
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3636F2182B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="hRIlQEDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfHEJdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:33:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfHEJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:33:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so83664188wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e6mpzWuHkNsT3rptUQH52jVRQqHIX7D9o531pV6bORY=;
        b=hRIlQEDNX2xX5rCHoSv+sGZD59H38Ow/EYR0T1ajP5OaF8L2KA9hQBFUoMpXh0HE0D
         HWTHxMzmEfrB4IqyQa3yGqNfq4mXnhyIMusHeOGkp4+HUBtc8iTNqXU9vDkI9BIZ95kw
         V5Vfh+j570DChZJqUnBHLzIpqgGHLJm+0JL1BWcSvVJzyYuiMvzEYRrpgZ78fURUHl3N
         ovjUGELg40J2Gm0d8pMCnljPsXVktlFARe436/iKTp8psqDnHGt3p3ILoUeA8pd6dAO9
         ovpfVwtj4qN7LkFnoKf71I32m17M4sE0fJM7zWE/+42S4VhFJq2Of1UsBjFi2ClfbWeY
         1HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e6mpzWuHkNsT3rptUQH52jVRQqHIX7D9o531pV6bORY=;
        b=FGcxS3pautycG93IIkoqX7uSWht3gyk776CX9o6R9moTtHWBsXW+PCO9970onVlewh
         EmlwzZPAtvkcJnqV3RAc5NgDHhhO4ICFONoEe379/8u/rcFes2nF7aST2v4spBm6ZLVA
         Whmcnc6Xe+sYYpjZHSLSa+K5xfninxluYcDvg215AbmS4cKxmLn2VM2UhBgsDqbtRf1C
         iDBBBvm71lj2GeRwovAR4cIcBtecQBAJNmsUloZGUpr1uLLi68PGmRMHNuHcPjPu5QpR
         Jtublt8jp9DhHp3ipvwDpnkV4PW7huWjr8v5srLNC4vfCRXAB2lnd5JG38sVNBLeOCgg
         ZSbg==
X-Gm-Message-State: APjAAAWnqUH2KC+BwL/q5cuwKtViOUkrfiuWauXYVVGKQ1jAnHuh0L/F
        +7mV3B6Jn/Zqk8JoeT9xIicmWw==
X-Google-Smtp-Source: APXvYqz6T7cZ7wa/+gLiHZdm5Uiv/PuUcbTNxoUWmZaDsCa8yclPwjoVxW6PV7E51zV0/r2XvX7/NA==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr45767334wro.133.1564997593542;
        Mon, 05 Aug 2019 02:33:13 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:28f7:ac40:788a:ffa1? ([2001:858:107:1:28f7:ac40:788a:ffa1])
        by smtp.gmail.com with ESMTPSA id a84sm108098037wmf.29.2019.08.05.02.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 02:33:13 -0700 (PDT)
Subject: Re: [PATCH] drbd: do not ignore signals in threads
To:     David Laight <David.Laight@ACULAB.COM>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
References: <20190729083248.30362-1-christoph.boehmwalder@linbit.com>
 <6259de605e9246b095233e3984262b93@AcuMS.aculab.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Message-ID: <ad16d006-4382-3f77-8968-6f840e58b8df@linbit.com>
Date:   Mon, 5 Aug 2019 11:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6259de605e9246b095233e3984262b93@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.19 10:50, David Laight wrote:
> Doesn't unmasking the signals and using send_sig() instead  of force_sig()
> have the (probably unwanted) side effect of allowing userspace to send
> the signal?

I have ran some tests, and it does look like it is now possible to send
signals to the DRBD kthread from userspace. However, ...

> I've certainly got some driver code that uses force_sig() on a kthread
> that it doesn't (ever) want userspace to signal.

... we don't feel that it is absolutely necessary for userspace to be
unable to send a signal to our kthreads. This is because the DRBD thread
independently checks its own state, and (for example) only exits as a
result of a signal if its thread state was already "EXITING" to begin
with.

As such, our priority here is to get the main issue -- DRBD hanging upon
exit -- resolved. I agree that it is not exactly desirable to have userspace
send random signals to kthreads; not for DRBD and certainly not in general.
However, we feel like it is more important to have DRBD actually work again
in 5.3.

That said, there should probably still be a way to be able to send a signal
to a kthread from the kernel, but not from userspace. I think the author of
the original patch (Eric) might have some ideas here.

Jens, could you take a look and decide whether or not it's appropriate for you
to funnel this through the linux-block tree to Linus for rc4?

> The origina1 commit says:
>> Further force_sig is for delivering synchronous signals (aka exceptions).
>> The locking in force_sig is not prepared to deal with running processes, as
>> tsk->sighand may change during exec for a running process.
> 
> I think a lot of code has assumed that the only real difference between
> send_sig() and force_sig() is that the latter ignores the signal mask.
> 
> If you need to unblock a kernel thread (eg one blocked in kernel_accept())
> in order to unload a driver, then you really don't want it to be possible
> for anything else to signal the kthread.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
--
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
