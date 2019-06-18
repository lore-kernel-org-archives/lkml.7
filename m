Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BEDC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8449520873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfFRO53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:57:29 -0400
Received: from david.siemens.de ([192.35.17.14]:35859 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfFRO53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:57:29 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x5IEu7bC031531
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 16:56:07 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x5IEu4CT006763;
        Tue, 18 Jun 2019 16:56:04 +0200
Subject: Re: [PATCH] x86: Optimize load_mm_cr4 to load_mm_cr4_irqsoff
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
References: <0fbbcb64-5f26-4ffb-1bb9-4f5f48426893@siemens.com>
 <fc5cd013-c230-2eb2-02c5-cf9bbf350ec2@intel.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d9bcbb64-6961-c52f-bb8e-bef3c424e224@siemens.com>
Date:   Tue, 18 Jun 2019 16:56:03 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <fc5cd013-c230-2eb2-02c5-cf9bbf350ec2@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.19 16:41, Dave Hansen wrote:
> On 6/18/19 12:32 AM, Jan Kiszka wrote:
>> Thus, we can avoid disabling interrupts again in cr4_set/clear_bits.
> 
> Seems reasonable.
> 
> Your *_irqsoff() variants need lockdep_assert_irqs_disabled(), at least,
> though.

It inherits this check via __cr4_set, so I didn't add that to the outer path.

> 
> Can you talk a bit about the motivation here, though?  Did you encounter
> some performance issue that led you to make this patch, or was it simply
> an improvement you realized you could make from code inspection?
> 

I ran into a downstream issue adjusting patches to this code. In a nutshell, 
Xenomai has something like an NMI context over most Linux code that shares some 
codepaths with the kernel, though. One of them is switch_mm_irqs_off, and there 
our checking logic warned. The rest was code inspection.

For upstream, this is a micro-optimization. But given that something like 
switch_mm is in the path, I thought it's worth to propose.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
