Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFC62075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfHFSxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:53:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:40663 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfHFSxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:53:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 11:53:43 -0700
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="325721927"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.91]) ([10.24.14.91])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 06 Aug 2019 11:53:42 -0700
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
 <20190802180352.GE30661@zn.tnic>
 <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
 <20190803094423.GA2100@zn.tnic>
 <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
 <20190806155716.GE25897@zn.tnic>
 <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
 <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
 <20190806183333.GA4698@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
Date:   Tue, 6 Aug 2019 11:53:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806183333.GA4698@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/6/2019 11:33 AM, Borislav Petkov wrote:
> On Tue, Aug 06, 2019 at 11:13:22AM -0700, Reinette Chatre wrote:
>> Some platforms being enabled in this round have SKUs with inclusive
>> cache and also SKUs with non-inclusive cache. The non-inclusive cache
>> SKUs do not support cache pseudo-locking and cannot be made to support
>> cache pseudo-locking with software changes. Needing to know if cache is
>> inclusive or not will thus remain a requirement to distinguish between
>> these different SKUs. Supporting cache pseudo-locking on platforms with
>> non inclusive cache will require new hardware features.
> 
> Is there another way/CPUID bit or whatever to tell us whether the
> platform supports cache pseudo-locking or is the cache inclusivity the
> only one?

Unfortunately there are no hardware bits that software can use to
determine if cache pseudo-locking is supported. The way software
currently determines if cache pseudo-locking is supported is through
initialization of the hardware prefetch disable bits. Cache
pseudo-locking requires the hardware prefetch bits to be disabled
(during the locking flow only), those cannot be discovered either and
thus software hardcodes the hardware prefetch disable bits only for
those platforms that support cache pseudo-locking.

What you will see in the code is this:

int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
{
...

        prefetch_disable_bits = get_prefetch_disable_bits();
        if (prefetch_disable_bits == 0) {
                rdt_last_cmd_puts("Pseudo-locking not supported\n");
                return -EINVAL;
        }
...
}


In get_prefetch_disable_bits() the platforms that support cache
pseudo-locking are hardcoded as part of configuring the hardware
prefetch disable bits to use.

The current problem is that an upcoming platform has this difference
between SKUs so a single platform-wide decision is not sufficient.

Reinette



