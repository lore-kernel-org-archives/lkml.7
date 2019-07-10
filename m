Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83573C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5927620651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="POuovYGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfGJOZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:25:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44233 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfGJOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:25:41 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so5042344iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qni2yxbyN2x8hrbPuKtPxG5Ju3KZcomAfwDNiGzJBTY=;
        b=POuovYGn8iIzmvdNmDFSCKiEEL9gvltY1bZTxc5LZqMeCe3FO+oWOK7vULo4bEWWtz
         C7BAeM27iNEbef3pB17U+ThhFkd82zkxxjpfYhClkRp3pskj/WpvOpa+49rBnhCDqiw7
         XAj2psq8ANz4KUB/avVQtaXVkN+D9p1WwlbaqLcXEpasSLYmErjr3w+SuSSO2rXcnaDG
         FasVteuE43l5ty5TuKrtoX8quWklQ7+OwzdQNYh/afhtLotTLz/j8LOZ5QrgpIlt9mrn
         FWFm7Z5+oytJ9B/klfdyrEfnLk1+pu3hqV8hyAwPZKqEsDcExdpOu3oFSbuGxeSR+a64
         ZaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qni2yxbyN2x8hrbPuKtPxG5Ju3KZcomAfwDNiGzJBTY=;
        b=oHrrVnhk7on+uHgjoF7r/2MEPEG2kho0UC6nzmXDOPieor3Oth/Tnoc+18KrtmZLDE
         TtznrDr2HzIa3zMcS3tBWUKmIHjE3R9bitSJoBZWMwFN0LHqpkQzq30S6NnyZPJxbgLY
         eo98IFuehI/nkgoOo82zrNUBf6hq9efyRyzm4STmXuVF228OBTXjEmZ2RrThxa5mCww8
         uxhFOlWDrF8B3sJXaqykwE9WkbbQuS6tqtON/LDJd19UVgIztjQVd2t4mWQYcaBKe2F4
         c/wXra6Mwbn85lt+VhxDsGIq5/4Bq5zdRX7v6Nlqn8PMnp5/6Gksr2BxGcvFwcn1lOX2
         b1Cw==
X-Gm-Message-State: APjAAAXkQbE8OCLGiHqKoKWQ6CMxfFG/b+OhbcGzMW1vLxOww3PhQgVk
        8jEGgZNnRTQb6DwGyZy/7qgGRQ==
X-Google-Smtp-Source: APXvYqw8azb5NkZFLQ7cgLeUpf7dlu/q57qe6BQ3O8GmnOoy9pbpfQ6vQ4a+RiM2g5H49aRsjZVEBw==
X-Received: by 2002:a5d:9448:: with SMTP id x8mr34105785ior.102.1562768740719;
        Wed, 10 Jul 2019 07:25:40 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s24sm1944909ioc.58.2019.07.10.07.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 07:25:40 -0700 (PDT)
Subject: Re: [PATCH] blk-throttle: fix zero wait time for iops throttled group
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
References: <156259979778.2486.6296077059654653057.stgit@buzz>
 <30caacb5-4d45-016b-a97d-db8b37010218@kernel.dk>
 <f4be51ff-e426-cc44-db94-3c26e2cfbca9@yandex-team.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5087ebc3-96e9-44a4-a914-eb99f3c33054@kernel.dk>
Date:   Wed, 10 Jul 2019 08:25:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f4be51ff-e426-cc44-db94-3c26e2cfbca9@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 8:24 AM, Konstantin Khlebnikov wrote:
> On 10.07.2019 17:00, Jens Axboe wrote:
>> On 7/8/19 9:29 AM, Konstantin Khlebnikov wrote:
>>> After commit 991f61fe7e1d ("Blk-throttle: reduce tail io latency when iops
>>> limit is enforced") wait time could be zero even if group is throttled and
>>> cannot issue requests right now. As a result throtl_select_dispatch() turns
>>> into busy-loop under irq-safe queue spinlock.
>>>
>>> Fix is simple: always round up target time to the next throttle slice.
>>
>> Applied, thanks. In the future, please break lines at 72 chars in
>> commit messages, I fixed it up.
>>
> 
> Ok, but Documentation/process/submitting-patches.rst and
> scripts/checkpatch.pl recommends 75 chars per line.

Huh, oh well. Not a big deal for me, line breaking is easily automated.


-- 
Jens Axboe

