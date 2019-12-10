Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6424C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782392073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLJUPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:15:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:35135 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfLJUPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:15:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 12:15:06 -0800
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="207421314"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.138]) ([10.24.14.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Dec 2019 12:15:06 -0800
Subject: Re: [PATCH] x86/resctrl: fix an imbalance in domain_remove_cpu
To:     Qian Cai <cai@lca.pw>
Cc:     Ryan Chen <yu.chen.surf@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Tony Luck <tony.luck@intel.com>, tj@kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <37341135-a0db-6d1c-236f-e32461b4c398@intel.com>
 <35666437-F8AF-4170-A00F-79C34370BEF0@lca.pw>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <c8124e0b-4c6e-cce8-d38d-1bc2c8f4438e@intel.com>
Date:   Tue, 10 Dec 2019 12:15:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <35666437-F8AF-4170-A00F-79C34370BEF0@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On 12/10/2019 11:08 AM, Qian Cai wrote:
> 
> 
>> On Dec 10, 2019, at 1:44 PM, Reinette Chatre <reinette.chatre@intel.com> wrote:
>>
>>
>> "A system that supports resource monitoring may have multiple resources
>> while not all of these resources are capable of monitoring. Monitoring
>> related state is initialized only for resources that are capable of
>> monitoring and correspondingly this state should subsequently only be
>> removed from these resources that are capable of monitoring.
>>
>> domain_add_cpu() calls domain_setup_mon_state() only when r->mon_capable
>> is true where it will initialize d->mbm_over. However,
>> domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
>> checking r->mon_capable resulting in an attempt to cancel d->mbm_over on
>> all resources, even those that never initialized d->mbm_over because
>> they are not capable of monitoring. Hence, it triggers a debugobjects
>> warning when offlining CPUs because those timer debugobjects are never
>> initialized.
>>
>> ODEBUG:..."
> 
> Looks better to me. Do you want me to send a v2 for it or you could update it for merging?
> 

Could you please send v2? I am not the one that provides final approval
for inclusion nor the one that will take care of merging afterwards.

Thank you very much

Reinette
