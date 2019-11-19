Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266EDC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B8D22318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QxRyOWEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfKSEe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:34:29 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42667 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfKSEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:34:28 -0500
Received: by mail-pl1-f169.google.com with SMTP id j12so11033411plt.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 20:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkdEpR62sDVJxgsklhz1UnFEmVbcNibLh8/QnTcfFDc=;
        b=QxRyOWEATY2cC2tVR5io3QZcV+0POPsUjI9K7u3AsC/BnxcStwWEfJUlXHl0Vi791Q
         Io6aVIdnaAJRnpxHlJEpBsiNM58/23Ti/xY5Ge5bZp80Z0bCNHXJtcFtHdbiDZenPI09
         PKFZNRtVzPyhTH/hzpAn0eFyDgIcZyTbRgiMdIYuOqaMSVnEoyAlU5RDlhVmnlGGLMAW
         j2nw7EU7CUklvXki/4UaU2nPoGgjr+laZc020JOvx3acdSInUg46Qu6OC5UXAJF9LXdS
         kmSfLrmPjbYJBiFx0vHl43XvtDqbJEVpR8AGeGRQbXBHGq41ywd0nP0brZuC6EyE47IC
         brHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkdEpR62sDVJxgsklhz1UnFEmVbcNibLh8/QnTcfFDc=;
        b=Eo6wa6/eB38fLarUVIh+aiYIZk840utHp0RrjTxycPKVj+hhuITJ1BpG9+KATQKFSV
         I1haVqBgHTQZ3k6AcHLRczIaneNfKuDoENrSKrdI4Ky2PFCMv7cXvR+jfgIDyEZ8EOcm
         osWPOS93vpyyA8vi+nFFM2sCZ6trE9VhRAIWUHnKyagXzVxvVavNkKle/lD9U050SDIv
         nzlI4DI8RnekiYk00QCJcScMjsI6af/TXil7MFXw54ZTBnJVD26UBCIcH/JoL3iyhNDZ
         IIJj0rRCWqiY5fw9rVx4xw0qY1Vr0rHozRl9zu7lVqJX4pjRLdQysIOxREMJ/3oeNVwm
         +ZrQ==
X-Gm-Message-State: APjAAAXIcD+/OCfzzyIZ1qF1ml5GqQoQvCjdRjnTSeGDjSIfxgvikikC
        yTrdOlBqm1xyfwDiPhFZnkPUAg==
X-Google-Smtp-Source: APXvYqwS6dQ3WixHS9SBX1WTB0MYVtzBe/zIaYNktn/PyxM7sW/RB1GkPzkJraCwg45ZOoaYSWA9Lg==
X-Received: by 2002:a17:90a:22a6:: with SMTP id s35mr3454079pjc.3.1574138067544;
        Mon, 18 Nov 2019 20:34:27 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id s2sm21838748pgv.48.2019.11.18.20.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 20:34:26 -0800 (PST)
Subject: Re: INFO: task hung in io_wq_destroy
From:   Jens Axboe <axboe@kernel.dk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+0f1cc17f85154f400465@syzkaller.appspotmail.com>,
        andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        idosch@mellanox.com, kimbrownkd@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, petrm@mellanox.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, wanghai26@huawei.com,
        yuehaibing@huawei.com
References: <000000000000f86a4f0595fdb152@google.com>
 <f1a79e81-b41f-ba48-9bf3-aeae708f73ba@kernel.dk>
 <20191119022330.GC3147@sol.localdomain>
 <bc52115c-3951-54c6-7810-86797d8c4644@kernel.dk>
Message-ID: <c7b9c600-724b-6df1-84ba-b74999d6f4a6@kernel.dk>
Date:   Mon, 18 Nov 2019 21:34:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bc52115c-3951-54c6-7810-86797d8c4644@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 8:15 PM, Jens Axboe wrote:
> On 11/18/19 7:23 PM, Eric Biggers wrote:
>> Hi Jens,
>>
>> On Mon, Oct 28, 2019 at 03:00:08PM -0600, Jens Axboe wrote:
>>> This is fixed in my for-next branch for a few days at least, unfortunately
>>> linux-next is still on the old one. Next version should be better.
>>
>> This is still occurring on linux-next.  Here's a report on next-20191115 from
>> https://syzkaller.appspot.com/text?tag=CrashReport&x=16fa3d1ce00000
> 
> Hmm, I'll take a look. Looking at the reproducer, it's got a massive
> sleep at the end. I take it this triggers before that time actually
> passes? Because that's around 11.5 days of sleep.
> 
> No luck reproducing this so far, I'll try on linux-next.

I see what it is - if the io-wq is setup and torn down before the
manager thread is started, then we won't create the workers we already
expected. The manager thread will exit without doing anything, but
teardown will wait for the expected workers to exit before being
allowed to proceed. That never happens.

I've got a patch for this, but I'll test it a bit and send it out
tomorrow.

-- 
Jens Axboe

