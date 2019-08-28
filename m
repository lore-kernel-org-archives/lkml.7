Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52375C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E111205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfH1DJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:09:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42733 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbfH1DJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 23:09:14 -0400
X-IronPort-AV: E=Sophos;i="5.64,439,1559491200"; 
   d="scan'208";a="74415566"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Aug 2019 11:09:10 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0C9974CE032B;
        Wed, 28 Aug 2019 11:09:10 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 28 Aug 2019 11:09:17 +0800
Subject: Re: [PATCH] x86/cpufeature: drop *_MASK_CEHCK
To:     Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
References: <20190827070550.15988-1-caoj.fnst@cn.fujitsu.com>
 <20190827074151.GA29752@zn.tnic>
 <57ef4cd4-dfb8-256b-dc88-3f57c43dfe89@intel.com>
 <20190827172015.GH29752@zn.tnic>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <6b7de083-4901-6a72-8d89-75ea3456ffb8@cn.fujitsu.com>
Date:   Wed, 28 Aug 2019 11:10:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190827172015.GH29752@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 0C9974CE032B.ABE68
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 1:20 AM, Borislav Petkov wrote:
> On Tue, Aug 27, 2019 at 09:33:11AM -0700, Dave Hansen wrote:
>> The point was that there are 5 files in the code that need to be changed
>> if you change NCAPINTS:
>>
>> 1. arch/x86/include/asm/required-features.h
>> 2. arch/x86/include/asm/disabled-features.h
>> 3. tools/arch/x86/include/asm/disabled-features.h
>> 4. tools/arch/x86/include/asm/required-features.h
>> 5. arch/x86/include/asm/cpufeature.h (2 sites)
>>
>> Each of those sites has a compile-time check for NCAPINTS.  The problem
>> is that the *-features.h code doesn't get compiled directly so a
>> BUILD_BUG_ON() doesn't work by itself.  So, for the sites there, we put
>> it somewhere that *will* get compiled: the macros that actually check
>> the bits.
>>
>> It looks weird, but the end effect is good: If you change NCAPINTS, you
>> get compile errors in 5 files and have to go edit those 5 files to fix
>> it.  Your patch makes it easier to introduce errors and miss one of
>> those sites.
> 
> ... and we wouldn't want to debug any strange bugs from missing a case.
> So, Cao, I wouldn't mind having the gist of that above somewhere around
> there in a comment explicitly.
> 

A subtle issue hard to detect by eyes.  Sure, on the way.
-- 
Sincerely,
Cao jin


