Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F5C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4822089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEOGpR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:45:17 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:47498 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfEOGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:45:17 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x4F6iUPw006696
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 May 2019 15:44:30 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4F6iUqq006150;
        Wed, 15 May 2019 15:44:30 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4F6iUtQ027363;
        Wed, 15 May 2019 15:44:30 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-5068272; Wed, 15 May 2019 15:43:51 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Wed,
 15 May 2019 15:43:50 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Thread-Topic: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI
 systab and ACPI tables
Thread-Index: AQHVCS06YD4lckvUHUCIqj5Wl9aEBaZoC86AgAAHHwCAAATOAIAABLCAgAFCxgCAAFs9gIAAL20AgAAWZYCAABPAAIAAuEgAgABdmIA=
Date:   Wed, 15 May 2019 06:43:49 +0000
Message-ID: <19532243-e02a-838a-732a-a47c15339dde@ce.jp.nec.com>
References: <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic> <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic> <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
 <20190514113826.GM2589@hirez.programming.kicks-ass.net>
 <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
 <20190514140916.GA90245@gmail.com>
 <20190515010850.GA9159@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190515010850.GA9159@dhcp-128-65.nay.redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6C5001855D1CA0499D67A26346A777CB@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 10:08 AM, Dave Young wrote:
> On 05/14/19 at 04:09pm, Ingo Molnar wrote:
>>> Hmm, it seems caused by some WIP branch patches, I suspect below:
>>> commit 124d6af5a5f559e516ed2c6ea857e889ed293b43
>>> x86/paravirt: Standardize 'insn_buff' variable names
>>
>> This commit had a bug which I fixed - could you try the latest -tip?
> 
> Will do, but I do not use tip tree often, not sure which branch includes
> the fix.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/
> Is it tip/master or tip/tip?

Just in case, when I tried tip/master, one of test machines crashed
in the same way as:
  https://lkml.org/lkml/2019/5/9/182

and I found this patch was needed:
  [PATCH] x86: intel_epb: Take CONFIG_PM into account
  https://lore.kernel.org/lkml/3431308.1mSSVdqTRr@kreacher/

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
