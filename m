Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A53DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64059216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404465AbfHHUJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:09:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:7358 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390202AbfHHUJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:09:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 13:09:01 -0700
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="186459097"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.6.227]) ([10.251.6.227])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 08 Aug 2019 13:09:00 -0700
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
 <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
 <20190806183333.GA4698@zn.tnic>
 <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
 <20190806191559.GB4698@zn.tnic>
 <18004821-577d-b0dd-62b8-13b6f9264e72@intel.com>
 <20190806204054.GD4698@zn.tnic>
 <98eeaa53-d100-28ff-0b68-ba57e0ea90fb@intel.com>
 <20190808080841.GA20745@zn.tnic> <20190808081342.GB20745@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <1b0b14aa-2c78-8259-9fdc-06ee7f6050f4@intel.com>
Date:   Thu, 8 Aug 2019 13:08:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808081342.GB20745@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/8/2019 1:13 AM, Borislav Petkov wrote:
> On Thu, Aug 08, 2019 at 10:08:41AM +0200, Borislav Petkov wrote:
>> Ok, tglx and I talked it over a bit on IRC: so your 1/10 patch is pretty
>> close - just leave out the generic struct cacheinfo bits and put the
>> cache inclusivity property in a static variable there.
> 
> ... and by "there" I mean arch/x86/kernel/cpu/cacheinfo.c which contains
> all cache properties etc on x86 and is the proper place to put stuff
> like that.

With the goal of following these guidelines exactly I came up with the
below that is an incremental diff on top of what this review started out as.

Some changes to highlight that may be of concern:
* In your previous email you do mention that this will be a "single bit
of information". Please note that I did not specifically use an actual
bit to capture this information but an unsigned int (I am very aware
that you also commented on this initially). If you do mean that this
should be stored as an actual bit, could you please help me by
elaborating how you would like to see this implemented?
* Please note that I moved the initialization to init_intel_cacheinfo()
to be specific to Intel. I did so because from what I understand there
are some AMD platforms for which this information cannot be determined
and I thought it simpler to make it specific to Intel with the new
single static variable.
* Please note that while this is a single global static variable it will
be set over and over for each CPU on the system.

diff --git a/arch/x86/include/asm/cacheinfo.h
b/arch/x86/include/asm/cacheinfo.h
index 86b63c7feab7..97be5141bb4b 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -5,4 +5,6 @@
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8
node_id);

+unsigned int cacheinfo_intel_l3_inclusive(void);
+
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c
b/arch/x86/kernel/cpu/cacheinfo.c
index 733874f84f41..247b6a9b5c88 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -187,6 +187,7 @@ struct _cpuid4_info_regs {
 };

 static unsigned short num_cache_leaves;
+static unsigned l3_inclusive;

 /* AMD doesn't have CPUID4. Emulate it here to report the same
    information to the user.  This makes some assumptions about the machine:
@@ -745,6 +746,11 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
        num_cache_leaves = find_num_cache_leaves(c);
 }

+unsigned int cacheinfo_intel_l3_inclusive(void)
+{
+       return l3_inclusive;
+}
+
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
        /* Cache sizes */
@@ -795,6 +801,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
                                num_threads_sharing = 1 +
this_leaf.eax.split.num_threads_sharing;
                                index_msb =
get_count_order(num_threads_sharing);
                                l3_id = c->apicid & ~((1 << index_msb) - 1);
+                               l3_inclusive =
this_leaf.edx.split.inclusive;
                                break;
                        default:
                                break;
@@ -1010,13 +1017,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
        this_leaf->physical_line_partition =
                                base->ebx.split.physical_line_partition + 1;

-       if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-            boot_cpu_has(X86_FEATURE_TOPOEXT)) ||
-           boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
-           boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
-               this_leaf->attributes |= CACHE_INCLUSIVE_SET;
-               this_leaf->inclusive = base->edx.split.inclusive;
-       }
        this_leaf->priv = base->nb;
 }

What do you think?

Reinette

