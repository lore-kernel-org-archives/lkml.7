Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B568C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A83120844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlcS+fnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfGJSov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:44:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34049 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfGJSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:44:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so5265185wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fIomvM0g/tNuUQqug//yGa4pni5MNqzRL2MaCAq6LXE=;
        b=XlcS+fnlGIMenCwHbTphXlDMuJjiwGMPtSN0MoOwQ/hyJ0HY59K79/4tts2l5+Cuw+
         VkdAlAUt1sODk+fqdGoymPnRdqiS139x1exmbo8Ftcw9BIYMWPpIakt01KtSydzA+tQ8
         PbfSfak7HBu7Jp1B7M/pgM5yoDD0VB4pggisZ/c2BI92h+TRYKuVFZqhDNCpDw3Jtjlr
         orH3R0qB26LAHr0ph+54ZXdJNvKpVxJN9yGEBo0OAcV7XtXbkCul3t7aK6SmaSpoEYQ+
         N1zLjOIjg5Bo6E7ZUXdE35oClA259GeSrrQSispO0f4i8tdjIfr2QknL/Xqf7IERe20p
         0QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fIomvM0g/tNuUQqug//yGa4pni5MNqzRL2MaCAq6LXE=;
        b=tn0LIYAEYUR7nEVA2qJ1cwWx7imkeB7S703vhJOTGU8peROsWzrm3K4+cY/7QsqioB
         Y7J12n6l/c/2Szv+Bxx+bOSwYpwfczUcp4QGWwkzMS3hv2/Ic+EVvOEUbIpf9e9ekJ2S
         BkaURghoaPRgtE8uU8oRMN7FhEaF2aQ3OfawfNrQ/cRMFN04nPZvPOeE/cG9oIYwve8p
         eubqxzoKcX6svYxN5yIjyMGG7VWDwxT5v/gtKiuj8P37YtbHKaG9vwM255+yLKZo1Vv1
         u829+VpL06z7sIWtG6ElD29PRP66rl8aEsVkmy/RP8Xrb6e6of06CRtY/HycAuJ9QXhI
         B0tQ==
X-Gm-Message-State: APjAAAUSgf9HzoCb17dsj5CWk88LM42NQqMjRlvwayNMtMOO8USJMxW1
        BGQeNQpUDccRyiCMJ13LkYY=
X-Google-Smtp-Source: APXvYqxVnf4BpifQf73xCJ6D45mRIZKAKpcvnjlNctqAc/Lel97RloPdPK92YrGC4RcHOKzwLXjZ+g==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr6045994wmk.147.1562784289277;
        Wed, 10 Jul 2019 11:44:49 -0700 (PDT)
Received: from [192.168.8.147] (31.172.185.81.rev.sfr.net. [81.185.172.31])
        by smtp.gmail.com with ESMTPSA id v65sm3376512wme.31.2019.07.10.11.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 11:44:48 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000089a718058556e1d8@google.com>
 <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
 <20190710053030.GB2152@sol.localdomain>
 <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
 <20190710170057.GB801@sol.localdomain> <20190710172123.GC801@sol.localdomain>
 <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
 <20190710180242.GA193819@gmail.com>
 <a19779d0-0192-8dc0-d51b-e6938a455f31@acm.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <47a9287d-1f02-95d5-a5cf-55f0c0d38378@gmail.com>
Date:   Wed, 10 Jul 2019 20:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <a19779d0-0192-8dc0-d51b-e6938a455f31@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/19 8:36 PM, Bart Van Assche wrote:
> On 7/10/19 11:02 AM, Eric Biggers wrote:
>> I already mentioned that io_uring triggers it too.
>>
>> Those are just 2 cases that syzbot happened to generate reproducers for.  I
>> expect there are many others too, since many places in the kernel allocate
>> workqueues.  AFAICS most are placed in static or global variables which avoids
>> this issue, but there are still many cases where a workqueue is owned by some
>> dynamic structure that can have a much shorter lifetime.
>>
>> You can also check the other syzbot reports that look similar
>> (https://lore.kernel.org/lkml/20190710055838.GC2152@sol.localdomain/).
>> Two of them have C reproducers too.
> 
> As you may know lockdep cannot use dynamic memory allocation because
> doing so would introduce a circular dependency between lockdep and the
> memory allocator. Hence the fixed size arrays in the lockdep code.
> Additionally, as far as I know lockdep works fine for human kernel
> developers and only syzbot runs code that triggers the lockdep limits.
> So I think it's up to the syzbot authors to come up with a solution. I
> mean another solution than finger pointing at kernel developers.

This is silly, syzbot simply uses kernel standard system calls.

If anything using workqueues in dynamically allocated objects can turn off lockdep,
we have a serious issue.

Please work on this issue instead of trying to blame someone else.

Thank you.

