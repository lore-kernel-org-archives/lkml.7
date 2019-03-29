Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7FC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314C62082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfC2ImG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:42:06 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:36083 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbfC2ImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:42:05 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2T8fhd6019771
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 17:41:43 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T8fhF8017481;
        Fri, 29 Mar 2019 17:41:43 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T8fCd4026948;
        Fri, 29 Mar 2019 17:41:43 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-3810137; Fri, 29 Mar 2019 17:39:51 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Fri,
 29 Mar 2019 17:39:45 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
CC:     Borislav Petkov <bp@alien8.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "Dave Young" <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU5f/pEKRtoxrazkaGBqQRlpXVXaYhsC2AgAAC3QA=
Date:   Fri, 29 Mar 2019 08:39:45 +0000
Message-ID: <5dba5878-4bc7-e9cd-134d-ce88e8b6a766@ce.jp.nec.com>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190329072037.GA5840@jeru.linux.bs1.fc.nec.co.jp>
 <20190329082929.GH4234@localhost.localdomain>
In-Reply-To: <20190329082929.GH4234@localhost.localdomain>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <CB82848D49C08A4D966AE2E0D113EFA0@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 5:29 PM, Chao Fan wrote:
> On Fri, Mar 29, 2019 at 07:20:38AM +0000, Junichi Nomura wrote:
>> +	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
>> +#else
>> +	return 0;
>> #endif
>> -	return rsdp_addr;
> 
> I remeber the rsdp_addr is defined before #ifdef CONFIG_EFI
> If so, you don't need
> #else
> 	return 0;

I moved the whole __efi_get_rsdp_addr() to the inside of #ifdef CONFIG_EFI
and both kexec_get_rsdp_addr() and efi_get_rsdp_addr() just return 0 if
CONFIG_EFI is not defined.

> BY the way, what's your patch based on? I like add patch on my local
> branch and then review code, but failed.
> I try to use 'patch -p1 <' your patch to the latest tip master branch,
> but failed.

The patch is based on Linus's v5.1-rc2.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
