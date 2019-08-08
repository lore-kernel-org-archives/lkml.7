Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C2CC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5D2186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfHHGVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:21:44 -0400
Received: from foss.arm.com ([217.140.110.172]:56526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731005AbfHHGVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:21:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E63DA337;
        Wed,  7 Aug 2019 23:21:42 -0700 (PDT)
Received: from [10.163.1.243] (unknown [10.163.1.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5E13F706;
        Wed,  7 Aug 2019 23:23:48 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: mm: print hexadecimal EC value in
 mem_abort_decode()
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Mark Rutland <Mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>
References: <20190807003336.28040-1-miles.chen@mediatek.com>
 <98bdbcfb-24ed-fcd8-4b2c-f2c78b245dda@arm.com>
 <1565244075.26350.3.camel@mtkswgap22>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <256df022-6ad2-bae8-cc94-908adf409a07@arm.com>
Date:   Thu, 8 Aug 2019 11:51:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1565244075.26350.3.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2019 11:31 AM, Miles Chen wrote:
> On Thu, 2019-08-08 at 11:19 +0530, Anshuman Khandual wrote:
>>
>> On 08/07/2019 06:03 AM, Miles Chen wrote:
>>> This change prints the hexadecimal EC value in mem_abort_decode(),
>>> which makes it easier to lookup the corresponding EC in
>>> the ARM Architecture Reference Manual.
>>>
>>> The commit 1f9b8936f36f ("arm64: Decode information from ESR upon mem
>>> faults") prints useful information when memory abort occurs. It would
>>> be easier to lookup "0x25" instead of "DABT" in the document. Then we
>>> can check the corresponding ISS.
>>>
>>> For example:
>>> Current	info	  	Document
>>> 		  	EC	Exception class
>>> "CP15 MCR/MRC"		0x3	"MCR or MRC access to CP15a..."
>>> "ASIMD"			0x7	"Access to SIMD or floating-point..."
>>> "DABT (current EL)" 	0x25	"Data Abort taken without..."
>>> ...
>>>
>>> Before:
>>> Unable to handle kernel paging request at virtual address 000000000000c000
>>> Mem abort info:
>>>   ESR = 0x96000046
>>>   Exception class = DABT (current EL), IL = 32 bits
>>>   SET = 0, FnV = 0
>>>   EA = 0, S1PTW = 0
>>> Data abort info:
>>>   ISV = 0, ISS = 0x00000046
>>>   CM = 0, WnR = 1
>>>
>>> After:
>>> Unable to handle kernel paging request at virtual address 000000000000c000
>>> Mem abort info:
>>>   ESR = 0x96000046
>>>   EC = 0x25: DABT (current EL), IL = 32 bits
>>>   SET = 0, FnV = 0
>>>   EA = 0, S1PTW = 0
>>> Data abort info:
>>>   ISV = 0, ISS = 0x00000046
>>>   CM = 0, WnR = 1
>>>
>>> Change since v1:
>>> print "EC" instead of "Exception class"
>>> print EC in fixwidth
>>>
>>> Cc: Mark Rutland <Mark.rutland@arm.com>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: James Morse <james.morse@arm.com>
>>> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>>
>> This version implements the suggestion, hence it should have
>> also contained acked-by tag from Mark from earlier version.
>>
> 
> No problem. Sorry for not including the tag.
> I was not sure if I should add the acked-by tag from Mark in patch v2.

Yeah because V2 has now implemented the suggestion as required for
getting the tag per Mark in V1.

> 
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> If I send patch v3, I should include acked-by tag from Mark and
> Reviewed-by tag from you, right?

Right.
