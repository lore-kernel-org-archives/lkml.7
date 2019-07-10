Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC099C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D9120844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRy7E8OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfGJUrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:47:48 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33754 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfGJUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:47:47 -0400
Received: by mail-wr1-f46.google.com with SMTP id n9so3910585wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5edpXTgbPHCD//rsOftrCCUKU/4KuUV8KkBni52zlLI=;
        b=PRy7E8OTL4coBxBIK6C3FkWfnnckm2zDhVdPZo/eX6fKIkK8/rfAeuA8aYUGGtZVKU
         PZtCrzkSZ9rMGs57dppG1NvKIhdnLGQ7s+Qte3YVEIGeOvd8Qebufo/UQHZtOe29ufQr
         S9CZpZkDSIYutYCrxD69f9hVyVS9KRG0Q7E3fSGvQQeNt1lTQjDrygJ6g/YCjWBWNMMt
         FSA2O/N2HWtrZw8U0lNRU4odwngIrmVO8nR3a2+GIGTSPaB0tw2TJ+wiNy4zDJemKk9B
         TVooN4ctdprscAR0Jyg9t45jjZp35vzjpQUOprTwELuiwhZE5qDeE68xG8XaHHNkoUrm
         o5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5edpXTgbPHCD//rsOftrCCUKU/4KuUV8KkBni52zlLI=;
        b=EjR1FdtI6NQupCdFkGic64X2FaGDZrpLwGtPhGS/bjHPlijp3h2r97KR89dbbY1kOo
         mBsDUMNetrQM/aqmG8glVdnlXZHK+wAfvvxlKccoxpoYQ46+rGeWJ3n5kYhBJqqjIYNg
         UTKHEXxnbtsor4eWc9cL9NAun1jmxqNDOqjgwfviFC8cxYPiPw3c09eYz7RmJtIfnIZe
         gVrzKnDCGjcC5FQ1TFlZyilgUgVlsIFkVp3Rp55+f8LIzzfjWWzi0cxpfoExm8h4qyck
         JHgkYrSQJQL/GMaS7e65uzZobs3dAXTo458rtlJ2AzAxxPyIYzycapPNJN0UGrPYzltu
         Bdhw==
X-Gm-Message-State: APjAAAXG0m60SWQY/jabaPMkYwfFT8fnaIF8hNoZUKZWM0siQ7cSoRjM
        IMsR7W6hL+KdqwKvFlm9hq8=
X-Google-Smtp-Source: APXvYqzDJve5qsdNmGOlLU5yLS2CysWNfXfLADq7p/SMBJ4HIg5EWZlSih6U0zv/Y5AMJHkZwO+ipQ==
X-Received: by 2002:adf:aacf:: with SMTP id i15mr2030577wrc.124.1562791665965;
        Wed, 10 Jul 2019 13:47:45 -0700 (PDT)
Received: from [192.168.8.147] (31.172.185.81.rev.sfr.net. [81.185.172.31])
        by smtp.gmail.com with ESMTPSA id y16sm5584617wrg.85.2019.07.10.13.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:47:45 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Bart Van Assche <bvanassche@acm.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
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
 <47a9287d-1f02-95d5-a5cf-55f0c0d38378@gmail.com>
 <cdfeb3f8-8dc5-aa60-2782-7b3c5110edf5@acm.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <ee3bac8d-d061-7d07-5990-59871e7e2a4b@gmail.com>
Date:   Wed, 10 Jul 2019 22:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <cdfeb3f8-8dc5-aa60-2782-7b3c5110edf5@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/19 9:09 PM, Bart Van Assche wrote:
> On 7/10/19 11:44 AM, Eric Dumazet wrote:
>> If anything using workqueues in dynamically allocated objects can turn off lockdep,
>> we have a serious issue.
> 
> As far as I know that issue is only hit by syzbot tests.



> Anyway, I see
> two possible paths forward:
> * Revert the patch that makes workqueues use dynamic lockdep keys and
> thereby reintroduce the false positives that lockdep reports if
> different workqueues share a lockdep key. I think there is agreement
> that having to analyze lockdep false positives is annoying, time
> consuming and something nobody likes.
> * Modify lockdep such that space in its fixed size arrays that is no
> longer in use gets reused. Since the stack traces saved in the
> stack_trace[] array have a variable size that array will have to be
> compacted to avoid fragmentation.
> 

Can not destroy_workqueue() undo what alloc_workqueue() did ?
