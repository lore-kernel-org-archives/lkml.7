Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0DAC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F054D206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onuZy9b/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfD1PEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:04:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46036 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfD1PEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:04:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so487971pgi.12;
        Sun, 28 Apr 2019 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=effzDhT9KotxM2aIfIg+6LAFXv5mBZkrBnrUxjq/X8s=;
        b=onuZy9b/LE/6p2T99yzSAs0uRHqeejcfL8YEzTq2RTGYNkKWFjN6EiCmfEo+8T6Z+Y
         18DUKLdJzTQw/DcoNPoWApCw3FzNiZqmteoVPq6cQVPpWtoJMxzO/WEmXdUatlLlruXS
         GOReOFYY7BYieH4BMkFE6M9RHl4rEYz09UQ6yERnlnEMYsoxprAqUYBinOAHat6LNjJt
         458LBLicij9sipvvsedZI+Vukwrk8Q4t+3jty2yIuYCXFJQ1EZAXVEldUPofb/KLCwut
         2Mvstjq+d7QA5m57LDovQhtpr+oNE0LbXLiiL0oe7q/SBSKHzJ//g5fX4qkYkq0oc6tv
         XIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=effzDhT9KotxM2aIfIg+6LAFXv5mBZkrBnrUxjq/X8s=;
        b=CMpfntSDvR9gQY+kBCnLBtxhrU80L2uwoPDizqjeVh2/nEJ28TJWo/6fdkdfucnSUI
         He5DBT+jUtB0LOBToeO8IiOcQzwbKLtpync0L+jGE3sBeKN/mekrtAeEKPkkmDHvQIZJ
         BnY3tH0PFduzhiumSDEC4ymi9yHYMwKLAGAYP0/Xzjnyio9HlLRb8/OQ0HSn/OIKiJPN
         qlz78Gluk56H+bpL8AMAUiUKNxsIe8zg7ZCv1DVLjRZu9AwVVmdpU6RBMK2e1ZZjIZ9K
         5NDT1UjUbSAlE5Oskt8eVILdMrUu6Q4itXYUISE3r0jIPOMu7DDz7B4M3WqfqCDYv+W3
         Ys7Q==
X-Gm-Message-State: APjAAAVYDirPqMQ/ogRtm8K/UPH7T6wxmV9G6DO5Y3x3X3LhbtXJnw1u
        be3Vdpz7J8NIXOufSCm+AsQ=
X-Google-Smtp-Source: APXvYqwpNP9YTBRD+Pr6xxuYuporsLVL4c2BPriFMG01YdxnQ71PpjAwXRTmNi8Ndd1qvXhBN5ezuw==
X-Received: by 2002:aa7:86ce:: with SMTP id h14mr11140193pfo.84.1556463860780;
        Sun, 28 Apr 2019 08:04:20 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id n22sm42246930pfa.51.2019.04.28.08.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 08:04:19 -0700 (PDT)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
 <9d430543-33c3-0d9b-dc77-3a179a8e3919@I-love.SAKURA.ne.jp>
 <920ebaf1-ee87-0dbb-6805-660c1cbce3d0@I-love.SAKURA.ne.jp>
 <cc054b5c-4e95-8d30-d4bf-9c85f7e20092@gmail.com>
 <15b353e9-49a2-f08b-dc45-2e9bad3abfe2@i-love.sakura.ne.jp>
 <057735f0-4475-7a7b-815f-034b1095fa6c@gmail.com>
 <6e57bc11-1603-0898-dfd4-0f091901b422@i-love.sakura.ne.jp>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a9075b87-4f02-fe78-e86d-34f67bdf8b2a@gmail.com>
Date:   Sun, 28 Apr 2019 08:04:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6e57bc11-1603-0898-dfd4-0f091901b422@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/19 9:22 PM, Tetsuo Handa wrote:
> On 2019/04/28 8:52, Eric Dumazet wrote:
>> On 4/27/19 3:33 PM, Tetsuo Handa wrote:
>>>
>>> I'm waiting for davem why it is safe to move the dst entry from
>>> "a device to unregister" to "a loopback device in that namespace".
>>> I'm waiting for an explanation how the dst entry which was moved to
>>> "a loopback device in that namespace" is released (i.e. what the
>>> expected shutdown sequence is).
>>
>> The most probable explanation is that we make sure the loopback device
>> is the last one to be dismantled at netns deletion,
>> and this would obviously happen after all dst have been released.
>>
> 
> rt_flush_dev() becomes a no-op if "dev" == "a loopback device in that
> namespace". And according to debug printk(), rt_flush_dev() is called
> on "a loopback device in that namespace" itself.
> 

This is the design yes. We can not let a dst having a pointer to some garbage memory.
(since we are going to free it very soon)

dst can be long lived objects. netdev (but loopback) are not.

> If "a loopback device in that namespace" is the last "one" (== "a network
> device in that namespace" ?), which shutdown sequence should have called
> dev_put("a loopback device in that namespace") before unregistration of
> "a loopback device in that namespace" starts?

You'll have to study all the netdev notifiers to answer this question.
They are many of them, and they have a priority to let them run in a given order.

> 
> Since I'm not a netdev person, I appreciate if you can explain
> that shutdown sequence using a flow chart.

I am a netdev person, but I have no time to explain this at this moment.
