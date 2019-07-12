Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1815C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6583204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfGLXDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:03:23 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:39772 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfGLXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:03:22 -0400
Received: by mail-pl1-f169.google.com with SMTP id b7so5462458pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0XoSNhR/ASIgC29b1QcqzSACqNk99wrEhwjSvUDbz6c=;
        b=LSvJsO+/B8MK/xmdP9SdTKAr/9GUTxGhn6wmKLyc6pV1o3dKishqHavE/ci5Q+48V3
         Bnl6rjrNb/S7hs05zIOP+DBI/FMq7LnbbhnTJ6juICfsMqAUbNmJhdR6ihrpXbA+01JC
         4eIa3MFwb1n0ogLNS3xNYccQEfblqIVliqWAqalIpyFXV7b08zLe2PJtPfeOuEF8iOap
         aos/sAb+ipzPjoyaxR6LYYuzB7asHSxqmlecOOiKMF4s2M5Q24vnm6yZTM5DLVRqW/h1
         1iBWmiUUEmcUNshjhy7MMuHWPpjwaFwinpiGkzqEI8QWVe+P5zMOSbJbYaH6qzgEoofT
         KmqA==
X-Gm-Message-State: APjAAAW1L+aLTnV6eqLsGqEs8asZuj2HbD7Vig3YfNBbJrTctk5KXfi/
        lbltxkKJ8IbwhKOXukQ4byY=
X-Google-Smtp-Source: APXvYqxgxPxmJy4IeHukY/9neAMk58JMsreVeSXJGri+tBWS8g3JhfCE+V6EJMQYZANdY13bgj1coA==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr14968883pls.189.1562972601841;
        Fri, 12 Jul 2019 16:03:21 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 137sm12366805pfz.112.2019.07.12.16.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 16:03:20 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <20190710172123.GC801@sol.localdomain>
 <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
 <20190710180242.GA193819@gmail.com>
 <a19779d0-0192-8dc0-d51b-e6938a455f31@acm.org>
 <47a9287d-1f02-95d5-a5cf-55f0c0d38378@gmail.com>
 <cdfeb3f8-8dc5-aa60-2782-7b3c5110edf5@acm.org>
 <ee3bac8d-d061-7d07-5990-59871e7e2a4b@gmail.com>
 <9219c421-0868-f97f-2d84-df48aed9f8a8@acm.org>
 <20190710220943.GM3419@hirez.programming.kicks-ass.net>
 <e10e95c7-b832-5560-e3ca-3ce584bc0ca3@acm.org>
 <20190712085536.GP3402@hirez.programming.kicks-ass.net>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <efbf0db3-85bf-d8de-d0a5-21f15f4a8331@acm.org>
Date:   Fri, 12 Jul 2019 16:03:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712085536.GP3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/19 1:55 AM, Peter Zijlstra wrote:
> On Thu, Jul 11, 2019 at 11:53:12AM -0700, Bart Van Assche wrote:
>> On 7/10/19 3:09 PM, Peter Zijlstra wrote:
>>> One thing I mentioned when Thomas did the unwinder API changes was
>>> trying to move lockdep over to something like stackdepot.
>>>
>>> We can't directly use stackdepot as is, because it uses locks and memory
>>> allocation, but we could maybe add a lower level API to it and use that
>>> under the graph_lock() on static storage or something.
>>>
>>> Otherwise we'll have to (re)implement something like it.
>>>
>>> I've not looked at it in detail.
>>
>> Hi Peter,
>>
>> Is something like the untested patch below perhaps what you had in mind?
> 
> Most excellent, yes! Now I suppose the $64000 question is if it actually
> reduces the amount of storage we use for stack traces..
> 
> Seems to boot just fine.. :-)

Hi Peter,

On my setup after some time the space occupied by stack traces stabilizes
to the following:

# grep stack /proc/lockdep_stats
  stack-trace entries:                169456 [max: 524288]
  number of stack traces:        9073
  number of stack hash chains:   6980

I think these numbers show that there are some but not too many hash
collisions (the code for the hash statistics was added after I e-mailed my
patch).

Bart.
