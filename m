Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42BCC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B37217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDKJPF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:15:05 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:47835 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfDKJPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:15:04 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3B9ElZD014368
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Apr 2019 18:14:47 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3B9Elu4029214;
        Thu, 11 Apr 2019 18:14:47 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3B9E0Jk025505;
        Thu, 11 Apr 2019 18:14:47 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-4211335; Thu, 11 Apr 2019 18:14:37 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Thu,
 11 Apr 2019 18:14:36 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqAgACP04CAAAH9AIAABzmAgAAI8gA=
Date:   Thu, 11 Apr 2019 09:14:36 +0000
Message-ID: <1bb7bccb-0270-d073-fa2f-43e1a1c73fbe@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411084235.GJ3805@localhost.localdomain>
In-Reply-To: <20190411084235.GJ3805@localhost.localdomain>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <AAFE3663B74F2A44B26E2A0C20DD4FE0@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 5:42 PM, Baoquan He wrote:
> On 04/11/19 at 08:16am, Junichi Nomura wrote:
>> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
>> setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
>> will hit the problem of accessing invalid table pointer again.
> 
> Seems you are trying to address Dave Young's comment in 
> http://lkml.kernel.org/r/20190404073233.GC5708@dhcp-128-65.nay.redhat.com

Right. His "In case kexec_get_rsdp_addr failed.." comment.

> We may need discuss and make clear if those are doable. E.g the first
> comment, if not hang by below line of code, returning 0 for what? Can
> kexec still be saved, or just reset to firmware?
> 
> 	error("EFI system table not found in kexec boot_params.")

If we return 0 and also don't hang in the rest of get_rsdp_addr(),
it just work as the same way as v5.0 and earlier kernel do.

Failure cases in kexec_get_rsdp_addr() are followings:
1. efi_setup_data is invalid
2. loader signature is invalid
3. EFI systab is not found in boot_params
4. RSDP is not found by parsing tables pointed to by efi_setup_data

I think all of them are critical for EFI boot, so one option could be
we never return failure in kexec_get_rsdp_addr() and just hang.
But hanging in this very early stage of boot may make the problem
harder to investigate once happens. Even earlyprintk is not working yet.
So the other option is returning 0 to defer the crash for later stage.

> It may need be clarified firstly, then go further to rearrange patch.
> That can ease the work, I guess.
> 
> Personal opinion.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
