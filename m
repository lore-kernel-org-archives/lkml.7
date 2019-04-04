Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80077C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C88920663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AQUQ+/79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfDDUvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:51:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60218 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbfDDUvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xv8cNFmpE8W4+MPi9lMkTvAZTd4wrds89tk7y4AvM6A=; b=AQUQ+/79mrgr1oc2B9fDmmYZ+8
        h23KfNenVwpdHunMjATl3ndp8GfrNz8h4I3+esuWPMy4otCRhjRdU20ZVfbZvIknNfwcEI/Rm7wBP
        CmMlgM+uM2lm91OvoaxNPPOrd1lQ/fukjdeUuZYfi3h+5viuxfdIVKRxk800RVHeCNkVqoUsDRHIx
        FXzqyYvQYaKIOO14wTLK18SfWvfmL2QoJiDV8DHoXCKZj3+Pu1Oilhnj5DIHoHbs0tHrmHwCwCE0g
        Y0eefLHkreFk8AQ8VJkR6e2YFpppfMEirIuUSljkRtw7ONQukJZ9UCVmEAlCVbr04n4xGVbKIRopi
        TUoMQNQQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hC9Ku-000645-JW; Thu, 04 Apr 2019 20:51:49 +0000
Subject: Re: linux-next: Tree for Apr 3 (objtool)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190403192407.13a99513@canb.auug.org.au>
 <d37e0909-cacc-7c6c-4376-33891fa69f53@infradead.org>
 <20190403205305.tqqwttjytunzgtub@treble>
 <6a2455b9-5c02-99dc-e41c-e6b7d1c3118d@infradead.org>
 <20190404171618.6u36y5zu3euvd4zp@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e4eb742-f306-7aea-a3d7-9abbb244bb55@infradead.org>
Date:   Thu, 4 Apr 2019 13:51:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404171618.6u36y5zu3euvd4zp@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 10:16 AM, Josh Poimboeuf wrote:
> On Wed, Apr 03, 2019 at 03:29:17PM -0700, Randy Dunlap wrote:
>> On 4/3/19 1:53 PM, Josh Poimboeuf wrote:
>>> On Wed, Apr 03, 2019 at 08:02:43AM -0700, Randy Dunlap wrote:
>>>> On 4/3/19 1:24 AM, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Changes since 20190402:
>>>>>
>>>>
>>>> on x86_64:
>>>>
>>>> arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x909: unreachable instruction
>>>
>>> Your .o file looks odd.  I can't recreate the issue when I build the
>>> same object.
>>
>> This (randconfig) build has tracing enabled?  Could that have anything to do
>> with it?
> 
> No, I can't see any reasonable explanation for it other than a buggy
> toolchain.
> 
>> The randconfig file is attached.
> 
> I still can't recreate with your randconfig.
> 
>>> Did the issue only just now show up?  Can you bisect it?  What version
>>> of binutils are you using?
>>
>>> ld -v
>> GNU ld (GNU Binutils; openSUSE Leap 42.3) 2.31.1.20180828-19
>>
>>
>> My build logs show it first occurred (in my randconfig builds) in
>> linux-next-20190204.
> 
> It seems really odd.  Can you do a bisect?
> 

Sure, I'll give it a try.

-- 
~Randy
