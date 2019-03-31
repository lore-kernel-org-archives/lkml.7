Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16924C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF84321773
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 07:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Ew/4p59M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCaHA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 03:00:28 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:52990 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbfCaHA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 03:00:27 -0400
Received: from mxback1j.mail.yandex.net (mxback1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10a])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id A162E674014F;
        Sun, 31 Mar 2019 10:00:22 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Rt4wCa2BxV-0IEq6xtR;
        Sun, 31 Mar 2019 10:00:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1554015620;
        bh=q8QLXGODLudj41ocQ19De3Mh7BhghNHmPdLkc9qJ9+A=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=Ew/4p59MkJHVLnmiq7z/V83sYjWuGYNBW9W7RtCYs8xY4Anbtnr+WtdH9fiNUapG0
         n08oXJPak6SfriaY3r/4720v4X1BrbloVNLrmroTo8fqQLJsFKu0kBc5B4i22jg2r9
         keeae2rfxM7gp+EpRSdcNWNbLDKV8ckv5SFNJhEw=
Authentication-Results: mxback1j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt1-cd60b8ae9bb9.qloud-c.yandex.net with HTTP;
        Sun, 31 Mar 2019 10:00:18 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     George Spelvin <lkml@sdf.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "richard@nod.at" <richard@nod.at>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vgupta@synopsys.com" <vgupta@synopsys.com>,
        "x86@kernel.org" <x86@kernel.org>
In-Reply-To: <201903302015.x2UKFnSL003850@sdf.org>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>,
            <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>,
            <20190330183826.GB21828@kroah.com> <201903302015.x2UKFnSL003850@sdf.org>
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in the swap function
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sun, 31 Mar 2019 10:00:18 +0300
Message-Id: <20434561554015618@myt1-cd60b8ae9bb9.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.03.2019, 23:17, "George Spelvin" <lkml@sdf.org>:
> On Sat, 30 Mar 2019 at 19:38:26 +0100 greh k-h wrote;
>>  On Sat, Mar 30, 2019 at 07:43:53PM +0300, Andrey Abramov wrote:
>>>  Replace int type with size_t type of the size argument
>>>  in the swap function, also affect all its dependencies.
>>
>>  This says _what_ the patch does, but it gives no clue as to _why_ you
>>  are doing this. Neither did your 0/5 patch :(
>>
>>  Why make this change? Nothing afterward depends on it from what I can
>>  tell, so why is it needed?
>
> It's just a minor cleanup, making things less surprising for future
> programmers. As I wrote in a comment in my patches, using a signed type
> for an object size is definitely a wart; ever since C89 it's expected
> you'd use size_t for the purpose.
>
> The connection is that it's a natural consequence of doing a pass over
> every call site.
>
> You're right it could be dropped from the series harmlessly, but it
> comes from the same work. But it's all of *three* call sites in the kernel
> which are affected. Surely that's not an unreasonable amount of churn
> to clean up a wart?

George Spelvin is absolutely right: "It's just a minor cleanup, making things less surprising for future programmers."

31.03.2019, 00:51, "George Spelvin" <lkml@sdf.org>:
> It was so obvious to me that I didn't question it, but you have a
> good point and I'm sure Andrey can clarify. Thanks for the attention!

I thought that it is obvious enough (argument called "size" should be of type size_t in the 90% of cases).
Should I resend this patch with better explanation "why"?

-- 
With Best Regards,
Andrey Abramov
