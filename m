Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E92C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1352085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEANwz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 09:52:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:44567 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfEANwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:52:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 06:52:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="342443601"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 01 May 2019 06:52:55 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 1 May 2019 06:52:54 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 1 May 2019 06:52:54 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.116]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.184]) with mapi id 14.03.0415.000;
 Wed, 1 May 2019 07:52:51 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Subject: Re: [RESEND PATCH v6 07/12] x86/fsgsbase/64: Introduce the
 FIND_PERCPU_BASE macro
Thread-Topic: [RESEND PATCH v6 07/12] x86/fsgsbase/64: Introduce the
 FIND_PERCPU_BASE macro
Thread-Index: AQHU22qyUcuqr+FxmUStDhVADE0c8qYcgLmAgDp3WwA=
Date:   Wed, 1 May 2019 13:52:51 +0000
Message-ID: <89147C5F-4F1D-4E19-AF68-658F6F638B3C@intel.com>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
 <1552680405-5265-8-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1903250954110.1798@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903250954110.1798@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.48.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D43032D5614DBB46AE88859205FCD81F@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 25, 2019, at 02:02, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Fri, 15 Mar 2019, Chang S. Bae wrote:
> 
>> diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
>> index f5a796da07f8..d063841a17e3 100644
>> --- a/arch/x86/include/asm/inst.h
>> +++ b/arch/x86/include/asm/inst.h
>> @@ -306,6 +306,21 @@
>> 	.endif
>> 	MODRM 0xc0 movq_r64_xmm_opd1 movq_r64_xmm_opd2
>> 	.endm
>> +
>> +.macro RDPID opd
> 
> So the update to require binutils >= 2.21 does not cover RDPID?
> 

I can see RDPID support in 2.27 release. I wonder if we can even require >= 2.27
right now.

> Thanks,
> 
> 	tglx

