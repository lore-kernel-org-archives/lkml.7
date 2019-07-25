Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17499C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AF32166E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="W5WgwoW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfGYUjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:39:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51353 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfGYUjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:39:09 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6PKcpZg1158853
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 25 Jul 2019 13:38:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6PKcpZg1158853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564087132;
        bh=9+UfSFFvVBfC/Y+BWP+Ce+brhw7Kq1b1vMVNHyn+PyQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W5WgwoW8LHGW5eRt4XIJhQBYTCC/r0o4d9h7R00QJAx/nMXMkSuTK7PqPXT1qyOig
         qiqczL7sMJFQGCBjok7AKaoEgEmwo2cUoQjIKgbW7vaF91kFAjUudC6zI8RHrDWUKF
         3JTn6P33/VkuhB9CgerMAq62nz7FWHEcyvfI/n1lRGxgQK+gUimYlUVJDz8XDzvxkb
         zikasoWIEf4QXDCsh6WO7l+6bt0QSadpV5enZgAX5g2FPJ7kFJZjVd/iwCW4I5/zPK
         Umgd7nk0vr9wAjYRRGjmiw1ueltbQUa1z84zySVJ1TdAHcBgPsF0LvNortXVyXp04k
         JUsQbHcrC4dzQ==
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     john.hubbard@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <20190724231528.32381-1-jhubbard@nvidia.com>
 <20190724231528.32381-2-jhubbard@nvidia.com>
 <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
 <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3831bbff-631a-2e62-9e82-e2b6181421c8@zytor.com>
Date:   Thu, 25 Jul 2019 13:38:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 12:22 AM, Thomas Gleixner wrote:
>>
>> The problem with this is that it will break silently when changes are
>> made to this structure.
> 
> That's not really the worst problem. Changes to that struct which touch any
> of the to be cleared ranges will break anyway if not handled correctly in
> the sanitizer function.
> 

Not really... that's kind of the point (the cleared ranges are cleared
explicitly because the boot loader failed to do so, so zeroing them is what
the boot loader should have done.)

The most correct way to address this would be to have an explicit list of
members to be *preserved* even if the sentinel triggers.

The easy way would be to put in a suitable cast to clear the warning -- I
would not be surprised if an explicit cast to something like (void *) would
quiet the warning, or else (yuck) put in an explicit (well-commented) #pragma
to shut it up.

	-hpa
