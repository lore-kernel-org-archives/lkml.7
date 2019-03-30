Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE68C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3B42183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfC3K6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 06:58:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:21461 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfC3K6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 06:58:16 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2UAvoEd042700;
        Sat, 30 Mar 2019 19:57:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sat, 30 Mar 2019 19:57:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126072090247.bbtec.net [126.72.90.247])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2UAvnJD042695
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 30 Mar 2019 19:57:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in corrupted (3)
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+65cecdd27b726c261799@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <000000000000b08190058543449f@google.com>
 <8ecb5bc9-5761-64d0-64b2-1310300a64ec@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1903300843230.2476@nanos.tec.linutronix.de>
 <daec0343-b905-f483-602b-9c0b9e9b1379@i-love.sakura.ne.jp>
 <20190330104529.GB5935@zn.tnic>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <77650d72-e2ec-e084-c929-210b16b8afb9@i-love.sakura.ne.jp>
Date:   Sat, 30 Mar 2019 19:57:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330104529.GB5935@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/30 19:45, Borislav Petkov wrote:
> On Sat, Mar 30, 2019 at 07:40:11PM +0900, Tetsuo Handa wrote:
>> But how can the scheduler be aware of various watchdogs' thresholds?
> 
> I think what tglx means is sched_setattr() should be fixed to fail due
> to the bogus value.
> 

Yes. But what such threshold be? 0.1 second? 1 second? 10 seconds?
Can we find a threshold where everyone can agree on?
