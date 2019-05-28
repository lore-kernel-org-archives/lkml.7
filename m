Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB284C04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 01:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AA72075E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 01:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfE1BLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 21:11:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:27325 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfE1BLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 21:11:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 18:11:54 -0700
X-ExtLoop1: 1
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2019 18:11:53 -0700
Subject: Re: [PATCH v6 4/4] x86/acrn: Add hypercall for ACRN guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
 <1556595926-17910-5-git-send-email-yakui.zhao@intel.com>
 <20190515073715.GC24212@zn.tnic>
 <b8210e0e-bdf2-3e17-ce9a-d7a3ca0e6672@intel.com>
 <20190527224618.GB8209@cz.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <0e0cd383-da3a-aa9c-d35e-5321f718e42e@intel.com>
Date:   Tue, 28 May 2019 09:08:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190527224618.GB8209@cz.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年05月28日 06:46, Borislav Petkov wrote:
> On Mon, May 27, 2019 at 10:57:09AM +0800, Zhao, Yakui wrote:
>> I refer to the Xen/KVM hypercall to add the ACRN hypercall in one separate
>> header.
> 
> And?
> 
>> The ACRN hypercall is defined in one separate acrn_hypercall.h and can be
>> included explicitly by the *.c that needs the hypercall.
> 
> Sure but what else will need the hypercall definition except stuff which
> already needs acrn.h? I.e., why is the separate header needed?

In fact there is no much difference that it is defined in acrn.h or one 
separate header file.
When it is sent with the driver stuff, I will add the hypercall into 
acrn.h. If the further extension is needed, we can then consider whether 
it is necessary to be moved into the separate header file.

My initial thought is that the acrn.h/acrn_hypercall.h defines the 
different contents.  Then the each source file in ACRN driver part can 
include "acrn.h" or "acrn_hypercall.h" based on its requirement.
Of course it is also ok that they are added in one header file. Then it 
is always included.

> 
>> The hypercall will be used in driver part. Before the driver part is added,
>> it seems that the defined ACRN hypercall functions are not used.
>> Do I need to add these functions together with driver part?
> 
> Yes, send functions together with the stuff which uses them pls.

Sure.

> 
> Thx.
> 
