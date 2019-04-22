Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40129C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F4220896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u72uE3d7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfDVQJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:09:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44071 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDVQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:09:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so5914929pfm.11;
        Mon, 22 Apr 2019 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=75VFUzhLBbZYSNlGyBfH4fDoJgiF5PjQye02mlG/7pM=;
        b=u72uE3d7p1vaP1N2IgElIcvf6X9J+Uy6bH6ZiyP9rM/7cHjUUN5JwVjWoc3Nl2mNzW
         wqqgTVtP8jqSs5wxLLGiBeiscKld3FER8FViGmoYiVgWBVWfBeokV0wgNDsxSohd18L/
         EIotd0NHACbmeGjRTp/85w9Bh1sgxd+gfMZ1D0kUhjEer/a4ng5p+NzmCkjkYQhKQ5xA
         4l/hAch7KUmQn1mquLvDa5uvp9T60pIsAwRkOSTBk2BiOYo2YpPly3KHke4sgBHygaMb
         GpQOyDA8A0JU/0Fv5J9bMQ42w2pYyu7P/1xhhHtzj5QYoj6Olna/pFVIuX1B8rsabKx2
         kawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=75VFUzhLBbZYSNlGyBfH4fDoJgiF5PjQye02mlG/7pM=;
        b=trGA2tUWVVMhxTLjgg7iJsXsyYdN4peHehIJUIvc3FrXsSY1aDnMidk1tznN7Vx+oB
         M6j6ksf1GDCMV2ZMncF9POO7yuef8/bZDpa5HP70yYfKPbBuhScE3oOZ6Rooqi9VOjH1
         bSIRv1dwQlBAoQhkrJ/tb/dcoqXkqBb5ivGEtfvLBnwBjeJH2YfLebXmQHPaehaPh5QJ
         tjfGrgLU3YQp8PH6AnScelJQ89X0tk5Ru5GnKptUAphmjRTXP5qYnwJyyo22um+4RDmG
         RaVNdknaiR0v9AUv/6BfWFlroNcuYNX3WJrF5prppF/4iRJX+btgw5P2PQpx3A/sUgvF
         xDDw==
X-Gm-Message-State: APjAAAViuuQlLhDgrrdUDYc1hGOw9/a5qJDwfP+L49nZpYiQkGR0i7/y
        wjSt6hnjLcCUA229feupnQ0IlWPU
X-Google-Smtp-Source: APXvYqxUOQF3sKyMR+ujTjAAmunnwEV+Afs6651FqwqjxwtU0CWJr1RanXfhCp0HdXqz2VvL1lhIiw==
X-Received: by 2002:a65:6205:: with SMTP id d5mr19826947pgv.61.1555949374719;
        Mon, 22 Apr 2019 09:09:34 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id t9sm13389833pgp.66.2019.04.22.09.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:09:33 -0700 (PDT)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     David Ahern <dsahern@gmail.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Julian Anastasov <ja@ssi.bg>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
 <dc7c06ae-204d-c287-04a4-d48875476d09@gmail.com>
 <20190421204126.GA19213@ubuntu>
 <458669e6-3d94-1daf-f80b-3c8d740790fa@gmail.com>
 <925fe55a-918e-e899-6f3c-43731712e369@gmail.com>
Message-ID: <3bf46fd2-1b7b-c380-a588-eadfd521ce19@gmail.com>
Date:   Mon, 22 Apr 2019 09:09:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <925fe55a-918e-e899-6f3c-43731712e369@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/22/2019 09:04 AM, Eric Dumazet wrote:
> 
> 
> On 04/22/2019 07:58 AM, David Ahern wrote:
>> On 4/21/19 2:41 PM, Stephen Suryaputra wrote:
>>> Hi David,
>>>
>>> I looked at patchwork. This patch hasn't been accepted. Is there a plan
>>> to resubmit? It is very useful. I had to debug refcnt issues multiple
>>> times for my employer.
>>
>> I think the inlined versions of dev_put and dev_hold are better for
>> performance.

However I do not really see dev_put()/dev_hold() being in very hot code paths.


>>
>> I could submit it with a DEBUG config to enable. It has been invaluable
>> to me over the past 3+ years debugging refcount problems.
>>
> 
> Sounds a good plan to me :)
> 

Another idea would be to track of all dev_hold(), by allocating an unique cookie
and providing the cookie at the corresponding dev_put()

The cookie would also keep track of the stack trace.

This would allow for an automatic finding of the missing release, but at extra cost of course.

This infrastructure would of course being a debug option at kernel build.


