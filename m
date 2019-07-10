Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E26FC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A7320651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfGJTJh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:09:37 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44557 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGJTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:09:37 -0400
Received: by mail-pl1-f172.google.com with SMTP id t14so1667936plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 12:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=71riRWOoSktFJs5cdX1C5IGCrBRGHS9gadld7oiJg9A=;
        b=Q9LsXN7h8e3tUTzee0XzEMarS73bHOrNIQz85hVS8ymqqP5CX2WsIxiDU0xxUHx1c6
         5S2OAt/rHig+KS4dmz6dJgHkrVPKDjgQ1AB5qNYb85zwQHFPWLZo/n8WfwLMG38QEwK2
         luHzI7rM/jDT4nvSh8Dji5IdtxLYDN8CEWLlA63M/yL/H7LNpj5YU11j46F7aUF3UJ34
         1CAwjiEgqMuSy86pELwZgneun4lB4voOm8jCegxOUelZsF3NDYMPGEV9jHkl45wim3hE
         Ox1S/sP7OhrTqb6Btg8KVgCeNbLdkaq/VfFLvLNfTbZGIN3JutSo17ODPAxCiaOi1WO0
         Jduw==
X-Gm-Message-State: APjAAAXqjFsFrA7Ar2CVMWghzJvUzvbIRct80vNOMfoWMI0Z7L+M8mdP
        gt3wjkTOKZNIMVSy05HomR8=
X-Google-Smtp-Source: APXvYqzirLrgjYpJGab89dcs2EwsAfBdjjdqR+b6catZXda236vT2M29PT3g8/RRLfSzvPCuK9Qisg==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr39758496plf.246.1562785776376;
        Wed, 10 Jul 2019 12:09:36 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id h14sm3044518pfq.22.2019.07.10.12.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:09:35 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Eric Dumazet <eric.dumazet@gmail.com>,
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
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cdfeb3f8-8dc5-aa60-2782-7b3c5110edf5@acm.org>
Date:   Wed, 10 Jul 2019 12:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <47a9287d-1f02-95d5-a5cf-55f0c0d38378@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 11:44 AM, Eric Dumazet wrote:
> If anything using workqueues in dynamically allocated objects can turn off lockdep,
> we have a serious issue.

As far as I know that issue is only hit by syzbot tests. Anyway, I see
two possible paths forward:
* Revert the patch that makes workqueues use dynamic lockdep keys and
thereby reintroduce the false positives that lockdep reports if
different workqueues share a lockdep key. I think there is agreement
that having to analyze lockdep false positives is annoying, time
consuming and something nobody likes.
* Modify lockdep such that space in its fixed size arrays that is no
longer in use gets reused. Since the stack traces saved in the
stack_trace[] array have a variable size that array will have to be
compacted to avoid fragmentation.

Did I overlook anything?

Bart.


