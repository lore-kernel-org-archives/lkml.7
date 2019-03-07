Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BAA2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCGRMP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:12:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56325 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfCGRMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:12:15 -0500
Received: from [172.19.131.165] ([8.46.77.96])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x27HBAXR2267629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Mar 2019 09:11:14 -0800
Date:   Thu, 07 Mar 2019 09:10:38 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
References: <20190307114511.870090179@infradead.org> <20190307115200.697533978@infradead.org> <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
From:   hpa@zytor.com
Message-ID: <5127C62D-E97D-40B0-85B3-16F30B7ED514@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2019 8:33:26 AM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Thu, Mar 7, 2019 at 3:52 AM Peter Zijlstra <peterz@infradead.org>
>wrote:
>>
>> XXX: are we sure we want __memset marked AC-safe?
>
>It's certainly one of the safer functions to call with AC set, but it
>sounds wrong anyway. It's not like it's likely to leak kernel data
>(most memset's are with 0, and even the non-zero ones I can't imagine
>are sensitive - more like poison values etc).
>
>What's the call site that made you go "just add __memset() to the
>list"?
>
>            Linus

Agreed... it seems fishy at least.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
