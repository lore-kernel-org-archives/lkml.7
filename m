Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D595FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F4C2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfHFVQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:16:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:44723 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfHFVQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:16:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 14:16:12 -0700
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="325758888"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.91]) ([10.24.14.91])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 06 Aug 2019 14:16:12 -0700
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20190803094423.GA2100@zn.tnic>
 <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
 <20190806155716.GE25897@zn.tnic>
 <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
 <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
 <20190806183333.GA4698@zn.tnic>
 <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
 <20190806191559.GB4698@zn.tnic>
 <18004821-577d-b0dd-62b8-13b6f9264e72@intel.com>
 <20190806204054.GD4698@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <98eeaa53-d100-28ff-0b68-ba57e0ea90fb@intel.com>
Date:   Tue, 6 Aug 2019 14:16:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806204054.GD4698@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/6/2019 1:40 PM, Borislav Petkov wrote:
> On Tue, Aug 06, 2019 at 01:22:22PM -0700, Reinette Chatre wrote:
>> ... because some platforms differ in which SKUs support cache
>> pseudo-locking. On these platforms only the SKUs with inclusive cache
>> support cache pseudo-locking, thus the additional check.
> 
> Ok, so it sounds to me like that check in get_prefetch_disable_bits()
> should be extended (and maybe renamed) to check for cache inclusivity
> too, in order to know which platforms support cache pseudo-locking.

Indeed. As you pointed out this would be same system-wide and the check
thus need not be delayed until it is known which cache is being
pseudo-locked.

> I'd leave it to tglx to say how we should mirror cache inclusivity in
> cpuinfo_x86: whether a synthetic X86_FEATURE bit or cache the respective
> CPUID words which state whether L2/L3 is inclusive...

Thank you very much. I appreciate your guidance here.

Reinette
