Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C762C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5056021773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfC2Vvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:51:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60207 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbfC2Vvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:51:47 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8680:2bb0:e269:95ff:fe35:9f3c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2TLpVp73962284
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 29 Mar 2019 14:51:31 -0700
Subject: Re: Potentially missing "memory" clobbers in bitops.h for x86
To:     paulmck@linux.ibm.com
Cc:     Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>
References: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
 <20190328162222.GO4102@linux.ibm.com>
 <CAG_fn=WKA_4Vzsh6yH+=5TFv-EMrX87pr+2c_ANoH_MOVpbe1w@mail.gmail.com>
 <8e32ab34-c14c-1ccb-76f9-0dcd729a0ef6@zytor.com>
 <20190329210918.GZ4102@linux.ibm.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <8092b8aa-bb1c-0266-b308-5cebfb25e2ef@zytor.com>
Date:   Fri, 29 Mar 2019 14:51:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190329210918.GZ4102@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 2:09 PM, Paul E. McKenney wrote:
>>
>> Note: the atomic versions of these functions obviously need to have
>> "volatile" and the clobber anyway, as they are by definition barriers
>> and moving memory operations around them would be a very serious error.
> 
> The atomic functions that return void don't need to order anything except
> the input and output arguments.  The oddness with clear_bit() is that the
> memory changed isn't necessarily the quantity referenced by the argument,
> if the number of bits specified is large.
> 
> So (for example) atomic_inc() does not need a "memory" clobber, right?
> 

I don't believe that is true: the code calling it has a reasonable
expectation that previous memory operations have finished and later
memory operations have not started from the point of view of another
processor. You are more of an expert on memory ordering than I am, but
I'm 89% sure that there is plenty of code in the kernel which makes that
assumption.

	-hpa

