Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1927DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E331B2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfDEEUc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:20:32 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:55201 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEEUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:20:32 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x354K9gA029556
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 13:20:09 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x354K8nt004149;
        Fri, 5 Apr 2019 13:20:09 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x354JrIL002608;
        Fri, 5 Apr 2019 13:20:08 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-4012596; Fri, 5 Apr 2019 13:19:52 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Fri, 5
 Apr 2019 13:19:51 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Dave Young <dyoung@redhat.com>
CC:     Borislav Petkov <bp@alien8.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH v3] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU6riZJD2HLBcqv0GoZn6cDbIQhqYsYU0A
Date:   Fri, 5 Apr 2019 04:19:50 +0000
Message-ID: <ddddba22-db88-0d1b-63e2-c70dc1346d0b@ce.jp.nec.com>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190402102529.GA21698@jeru.linux.bs1.fc.nec.co.jp>
 <20190404073233.GC5708@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190404073233.GC5708@dhcp-128-65.nay.redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <054A1887037BE0429EE23D2F37416DC1@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 4:32 PM, Dave Young wrote:
> While we are still debuggin the bug I reproduced, but for this patch
> I have still some comments inline.
> 
> BTW, it would be good to start a new thread when you send V4 :)

Sure.

>> +	/* Get systab from boot params. */
>> +	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
>> +	if (!systab)
>> +		error("EFI system table not found in kexec boot_params.");
> 
> Instead of hang the system, return 0 should be better

OK. I'll make it something like:
	if (!systab) {
		debug_putstr(...);
		return 0;
	}

>>  	if (!pa)
>> +		pa = kexec_get_rsdp_addr();
>> +
>> +	if (!pa)
>>  		pa = efi_get_rsdp_addr();
> 
> In case kexec_get_rsdp_addr failed, above code will try efi_get.. again,
> but that will also fail for same issue this patch is fixing.  In case
> kexec we should avoid the efi_get_rsdp_addr.

Yeah, I'll set efi_kexec_booted to true in kexec_get_rsdp_addr() if it's
kexec booted so that efi_get_rsdp_addr() can exit early in such a case.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
