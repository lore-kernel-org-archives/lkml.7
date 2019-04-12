Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8902C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBD12084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDLBCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:02:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:2184 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfDLBCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:02:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 18:02:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,339,1549958400"; 
   d="scan'208";a="135081015"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2019 18:02:06 -0700
Subject: Re: [RFC PATCH v3 3/4] x86: Use HYPERVISOR_CALLBACK_VECTOR for
 acrn_guest upcall vector
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-4-git-send-email-yakui.zhao@intel.com>
 <20190408150011.GH15689@zn.tnic>
 <36ff9827-da90-0736-f0a4-2f38b9c8bf3b@intel.com>
 <20190411135547.GH30080@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <1aaea739-ded7-13da-c2d0-54423de0eab0@intel.com>
Date:   Fri, 12 Apr 2019 09:00:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190411135547.GH30080@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月11日 21:55, Borislav Petkov wrote:
> On Wed, Apr 10, 2019 at 03:57:08PM +0800, Zhao, Yakui wrote:
>> It is used to avoid that one function declaration has no definition
>> when asm/acrnhyper.h is included and ACRN_GUEST is not enabled.
> 
> And that is a problem because...?

This is not a problem.
I take a look at the header file of mshyperv.h and xen/events.h.
It seems that they have no such extra conditional definition.
To follow the same style, I will remove it.

> 
>> Do you have any suggestion about the header order?
>>>
>>> linux/ path includes still need to come first, of course.
> 
> As said above:
> 
> linux/ path first, then asm/
> 
> Feel free to look around the tree for inspiration :)

I take a look at the file of vwmare.c/mshyperv.c under the directory of 
arch/x86/kernel/cpu. It seems that the header file only follows the 
order of: linux/ path first and then asm/.

Anyway, I will follow your idea in previous email and use the alphabetic 
order.

Thanks
> 
