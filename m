Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B333C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 21:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D602082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 21:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="SwqNmgTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfC3VvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 17:51:13 -0400
Received: from mx.sdf.org ([205.166.94.20]:53593 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbfC3VvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 17:51:13 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2ULnJnf001935
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 30 Mar 2019 21:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
        t=1553982568; bh=3cYNnE/FBsA3L4QFmUGg+COhq867b5/quLF0sFMqsdc=;
        h=Date:From:To:Subject:Cc:In-Reply-To:References;
        b=SwqNmgTJSP3xohQRM1tpLqbM/iho6IxcIzoIHrKC3ZM61eDRLY3+bpS7ZSH1jTO4a
         h/VaHIIy+bExI4oPBT+snnXQzan/ORNWoCUHW6+QRz2dk3MSWDpOyTYNZXU1N3ZEsi
         hHu7w7HzU3ZH5/MpKQ4YU7isdf8XPvwdHvmG1qdE=
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2ULnHN8017274;
        Sat, 30 Mar 2019 21:49:17 GMT
Date:   Sat, 30 Mar 2019 21:49:17 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903302149.x2ULnHN8017274@sdf.org>
To:     gregkh@linuxfoundation.org, lkml@sdf.org
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in the swap function
Cc:     adrian.hunter@intel.com, ard.biesheuvel@linaro.org,
        benh@kernel.crashing.org, bp@alien8.de, darrick.wong@oracle.com,
        dchinner@redhat.com, dedekind1@gmail.com, hpa@zytor.com,
        jlbec@evilplan.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        mark@fasheh.com, mingo@redhat.com, mpe@ellerman.id.au,
        naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org, richard@nod.at,
        st5pub@yandex.ru, tglx@linutronix.de, vgupta@synopsys.com,
        x86@kernel.org
In-Reply-To: <20190330202418.GB27435@kroah.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>,
    <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>,
    <20190330183826.GB21828@kroah.com>,
    <201903302015.x2UKFnSL003850@sdf.org>,
    <20190330202418.GB27435@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2019 at 21:24:18 +0100, Greg KH wrote:
> On Sat, Mar 30, 2019 at 08:15:49PM +0000, George Spelvin wrote:
>> On Sat, 30 Mar 2019 at 19:38:26 +0100 Greh KH wrote;
>> > On Sat, Mar 30, 2019 at 07:43:53PM +0300, Andrey Abramov wrote:
>>>> Replace int type with size_t type of the size argument
>>>> in the swap function, also affect all its dependencies.
>>>
>>> This says _what_ the patch does, but it gives no clue as to _why_ you
>>> are doing this.  Neither did your 0/5 patch :(
>>>
>>> Why make this change?  Nothing afterward depends on it from what I can
>>> tell, so why is it needed?
>>
>> It's just a minor cleanup, making things less surprising for future
>> programmers.  As I wrote in a comment in my patches, using a signed type
>> for an object size is definitely a wart; ever since C89 it's expected
>> you'd use size_t for the purpose.
>
> You did not say that in this commit log :)

Just to clarify: Not My Patch.  I approve, but it's Andrey's patch.

Your point is taken that the commit message needs to be improved
to explain why.  I just answered because it wasn't clear how much
of your question was rhetorical.

> If you think it is a wart, wonderful, yes, let's fix it up.  But again,
> a changelog comment should explain _why_ a commit is needed, not _what_
> it does, as we can see from the diff itself exactly what the commit
> does.

It was so obvious to me that I didn't question it, but you have a
good point and I'm sure Andrey can clarify.  Thanks for the attention!
