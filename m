Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3462AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A24A20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nO7h2DDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfEISs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:48:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfEISs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5q/s2hrhUTj3cVinMhLy+5FPiQBrNa6bCN5Wvxe1rU4=; b=nO7h2DDN4IXo4GrmU5T+DEyyB
        Dq4yGuLSObfqN0nGFYMG70Nsl2yUxl0pJG07OOvIN9x6U7utlVnpLZrmJVfMxnoDEMFuprPKEqyAC
        FUumBOHk4uDS/UyGed7kHHq4fb9IdYeU95mNZvCqtD2UnCX9+Xo3lI7jEt4cuJbYlllTESaHNgAsN
        LPZgWvac8G3BN8bTx1AFH6lljoHzlDHK/GY3VM+nJmAkgxJftmMWg6Mq0lE3HaUXfGMwT/cvT4yi9
        f1zIt2deD739xKFAmh3gL43IU3/Klx7I7qev2OjoCj+YibB5/aRvpHcBAV7+ekZoiDFi07WeJzlJh
        KtBGRddaw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOo68-000583-JQ; Thu, 09 May 2019 18:48:52 +0000
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
References: <20190318153840.906404905@infradead.org>
 <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
 <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
 <20190509090058.6554dc81@gandalf.local.home>
 <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
 <20190509142902.08a32f20@gandalf.local.home>
 <20190509184531.jhinxi2x2pdfaefb@treble>
 <20190509184715.6y2uzlld4irlm3tw@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3998ab5d-225b-0680-5edf-60b4068e3e59@infradead.org>
Date:   Thu, 9 May 2019 11:48:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509184715.6y2uzlld4irlm3tw@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/19 11:47 AM, Josh Poimboeuf wrote:
> On Thu, May 09, 2019 at 01:45:31PM -0500, Josh Poimboeuf wrote:
>> On Thu, May 09, 2019 at 02:29:02PM -0400, Steven Rostedt wrote:
>>> On Thu, 9 May 2019 09:51:59 -0700
>>> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>
>>>> On Thu, May 9, 2019 at 6:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>>
>>>>> This patch works. Can I get your Signed-off-by for it?  
>>>>
>>>> Yes. Please write some kind of comprehensible commit log for it, but
>>>
>>> How's this:
>>>
>>> "Peter Zijlstra noticed that with CONFIG_PROFILE_ALL_BRANCHES, the "if"
>>> macro converts the conditional to an array index.  This can cause GCC
>>> to create horrible code.  When there are nested ifs, the generated code
>>> uses register values to encode branching decisions.
>>>
>>> Josh Poimboeuf found that replacing the define "if" macro from using
>>> the condition as an array index and incrementing the branch statics
>>> with an if statement itself, reduced the asm complexity and shrinks the
>>> generated code quite a bit.
>>>
>>> But this can be simplified even further by replacing the internal if
>>> statement with a ternary operator.
>>>
>>> Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
>>
>> Actually, my original fix already went in:
>>
>>   37686b1353cf ("tracing: Improve "if" macro code generation")
>>
>> But it introduced a regression:
>>
>>   https://lkml.kernel.org/r/201905040509.iqQ2CrOU%lkp@intel.com
>>
>> which Linus' patch fixes for some reason.
> 
> /me curses URL encoding
> 
> https://lkml.kernel.org/r/201905040509.iqQ2CrOU%25lkp@intel.com
> 

Still fails for me.

-- 
~Randy
