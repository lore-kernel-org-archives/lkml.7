Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C9C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 09:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B855D20665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 09:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMpPFe/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFWJhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 05:37:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42727 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfFWJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 05:37:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id l19so5480577pgh.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RqUHLEsccNI1hj4DCJDYKmH8si6r0vguFQAwU1QV9kQ=;
        b=IMpPFe/GbIv/wiuQ97qK7WgGyOsqbRv0ro63JAYkamFt553gBG1L/Di2etxvuZJw4z
         IT5WUPjL8T8txJaoNMCf4c6V2ynWOOto7rrBN/L+j2dDKHosJBy0MD1+ErJkJN+y8g2i
         l+A+3jp2KZiWeOja+QQ5+Uz0494kd1iXQ0Omf7gwtUMByw915irHj6JXDXnPx2StU/q8
         2Kh8RBVdhcsE3lBXDCpU4mEnmmo8a47a0QtiCT1hPxIeZ9c/LnIBSsk1Eech3Pow4BCA
         zSuR3DHK5bgZzQSPCMbKE6zWMJUbAAgUr/K0FKU75WY8P56L9YgvwLrFnGUV4+myy8FB
         yYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RqUHLEsccNI1hj4DCJDYKmH8si6r0vguFQAwU1QV9kQ=;
        b=WlpFjRqYrBiHKYijiwTUUdMIFzGxnQk3r98m4VCM7ujkWti+SHdYUJyP9f7h123ina
         GwtFHF84H5XFTd9DMewUIl8BPdvAVviTt9YLrP2KmciXxzTjAfVlqUIwVI0K4QWtIYeE
         V5bfOX+6rCd6ucPa1alcr6f1o8hzslJLZz+xTNlMeVC7VLtuvQkqmQNA1GqQ5O7YHWcu
         lrEVDFIx+vMm4bGnT0fRnGgO5PHwiDDiXtaeLLYrev2lBXS7ha8g3UWZdtVMFFkagO6M
         7uX3OUAFVtMVIc0qn8kNPurXfGsiCBFF/XZOA5QA4bGUCCMpxoCA99u1ffaNP4NLLzJ1
         dqJg==
X-Gm-Message-State: APjAAAUugCRrVZWqILslohvqVkDipzm85qibuSWPAVcb4rU66ptGNeIl
        XCGgQ0MaqWkZcSfdM4mYmJHzjAw+
X-Google-Smtp-Source: APXvYqyjNOgBZiJhQ/Kh3bKzMSnMmj3ULiQqcEvb1QdOQuANgwaLq6YG/XUxFBt4xV8mQEC9/ccmIA==
X-Received: by 2002:a17:90a:3463:: with SMTP id o90mr18208289pjb.15.1561282642666;
        Sun, 23 Jun 2019 02:37:22 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w16sm10383572pfj.85.2019.06.23.02.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 02:37:22 -0700 (PDT)
Subject: Re: [PATCH 3/3] tools: memory-model: Improve data-race detection
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20190621084129.GA6827@andrea>
 <Pine.LNX.4.44L0.1906211023040.1471-100000@iolanthe.rowland.org>
 <20190621235439.GJ26519@linux.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <91a9c6f8-7bbf-376d-b1e0-0e2693c84ee8@gmail.com>
Date:   Sun, 23 Jun 2019 18:37:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190621235439.GJ26519@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul and Alan,

On 2019/06/22 8:54, Paul E. McKenney wrote:
> On Fri, Jun 21, 2019 at 10:25:23AM -0400, Alan Stern wrote:
>> On Fri, 21 Jun 2019, Andrea Parri wrote:
>>
>>> On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
>>>> Herbert Xu recently reported a problem concerning RCU and compiler
>>>> barriers.  In the course of discussing the problem, he put forth a
>>>> litmus test which illustrated a serious defect in the Linux Kernel
>>>> Memory Model's data-race-detection code.

I was not involved in the mail thread and wondering what the litmus test
looked like. Some searching of the archive has suggested that Alan presented
a properly formatted test based on Herbert's idea in [1].

[1]: https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/

If this is the case, adding the link (or message id) in the change
log would help people see the circumstances, I suppose.
Paul, can you amend the change log?

I ran herd7 on said litmus test at both "lkmm" and "dev" of -rcu and
confirmed that this patch fixes the result.

So,

Tested-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

>>>>
>>>> The defect was that the LKMM assumed visibility and executes-before
>>>> ordering of plain accesses had to be mediated by marked accesses.  In
>>>> Herbert's litmus test this wasn't so, and the LKMM claimed the litmus
>>>> test was allowed and contained a data race although neither is true.
>>>>
>>>> In fact, plain accesses can be ordered by fences even in the absence
>>>> of marked accesses.  In most cases this doesn't matter, because most
>>>> fences only order accesses within a single thread.  But the rcu-fence
>>>> relation is different; it can order (and induce visibility between)
>>>> accesses in different threads -- events which otherwise might be
>>>> concurrent.  This makes it relevant to data-race detection.
>>>>
>>>> This patch makes two changes to the memory model to incorporate the
>>>> new insight:
>>>>
>>>> 	If a store is separated by a fence from another access,
>>>> 	the store is necessarily visible to the other access (as
>>>> 	reflected in the ww-vis and wr-vis relations).  Similarly,
>>>> 	if a load is separated by a fence from another access then
>>>> 	the load necessarily executes before the other access (as
>>>> 	reflected in the rw-xbstar relation).
>>>>
>>>> 	If a store is separated by a strong fence from a marked access
>>>> 	then it is necessarily visible to any access that executes
>>>> 	after the marked access (as reflected in the ww-vis and wr-vis
>>>> 	relations).
>>>>
>>>> With these changes, the LKMM gives the desired result for Herbert's
>>>> litmus test and other related ones.
>>>>
>>>> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>>>> Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
>>>
>>> For the entire series:
>>>
>>> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
>>>
>>> Two nits, but up to Paul AFAIAC:
>>>
>>>  - This is a first time for "tools: memory-model:" in Subject; we were
>>>    kind of converging to "tools/memory-model:"...
>>
>> Yeah, sure.  That's the sort of detail I have a hard time remembering.
>>
>>>  - The report preceded the patch; we might as well reflect this in the
>>>    order of the tags.
>>
>> Either way is okay with me.
> 
> I applied Andrea's acks and edited as called out above, thank you both!
> 
> 						Thanx, Paul
> 

