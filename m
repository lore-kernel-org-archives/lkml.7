Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A91C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FCC20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfDBK0J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:26:09 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:49671 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDBK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:26:09 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x32APuFm020574
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Apr 2019 19:25:56 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x32APuxJ029137;
        Tue, 2 Apr 2019 19:25:56 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x32APtBI000597;
        Tue, 2 Apr 2019 19:25:55 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3914660; Tue, 2 Apr 2019 19:22:10 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Tue, 2
 Apr 2019 19:22:10 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
CC:     Borislav Petkov <bp@alien8.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "Dave Young" <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU6TAPBuKir5aKdUeGLetpGKkWo6YoCrIAgAAUVAD///OVgA==
Date:   Tue, 2 Apr 2019 10:22:08 +0000
Message-ID: <cbe93b95-5bde-c77f-4984-fb982a3cb24f@ce.jp.nec.com>
References: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402094149.GB1555@localhost.localdomain>
 <20190402095350.GA20733@jeru.linux.bs1.fc.nec.co.jp>
 <20190402110635.GC1555@localhost.localdomain>
In-Reply-To: <20190402110635.GC1555@localhost.localdomain>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A14B196DC5264A4C9ED9C2E5B572E8BE@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 8:06 PM, Chao Fan wrote:
> On Tue, Apr 02, 2019 at 09:53:51AM +0000, Junichi Nomura wrote:
>> On Tue, Apr 02, 2019 at 05:41:49PM +0800, Chao Fan wrote:
>>> [   77.989030] kexec_core: Starting new kernel
>>> early console in extract_kernel
>>> input_data: 0x000000017f6033b1
>>> input_len: 0x00000000008412d4
>>> output: 0x000000017e000000
>>> output_len: 0x0000000001e15844
>>> kernel_total_size: 0x0000000001e2c000
>>> trampoline_32bit: 0x000000000009d000
>>> booted via startup_64()
>>>
>>>
>>> Physical KASLR disabled: no suitable memory region!
>>> ------
>>>
>>> I am not sure whether I have done the right test.
>>> This guest is booted from EFI. Here we can see the kexeced kernel
>>> has completed the compressed boot stage. So I think your PATCH works.
>>
>> Thanks for testing.  If your test bed doesn't boot even with the patch,
>> you could check what was found as RSDP with a debug patch like below.
> 
> Oh no, it booted. I just put the compressed stag log.

Ah, then I think the patch worked as expected. Thanks.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
