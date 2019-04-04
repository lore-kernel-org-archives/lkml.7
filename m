Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B3B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDDBYa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:24:30 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:46633 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDBY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:24:29 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x341O6c9028330
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Apr 2019 10:24:06 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x341O6pD008918;
        Thu, 4 Apr 2019 10:24:06 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x341LHho003344;
        Thu, 4 Apr 2019 10:24:06 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3961909; Thu, 4 Apr 2019 10:23:27 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Thu, 4
 Apr 2019 10:23:26 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>, Dave Young <dyoung@redhat.com>
CC:     Borislav Petkov <bp@alien8.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU6UwPBuKir5aKdUeGLetpGKkWo6YpVH0AgAAFNwCAABiYgIAADUsAgAAD3gCAAArrgIABEieA
Date:   Thu, 4 Apr 2019 01:23:26 +0000
Message-ID: <c8613886-7014-cbd2-788f-a4f29bb5b4a5@ce.jp.nec.com>
References: <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403072141.GE1555@localhost.localdomain>
 <20190403080846.GB2579@dhcp-128-65.nay.redhat.com>
 <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
In-Reply-To: <20190403090210.GH1555@localhost.localdomain>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D8F13C0C845E5C4F8800DDBABD57EC59@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave and Chao,

On 4/3/19 6:02 PM, Chao Fan wrote:
> On Wed, Apr 03, 2019 at 04:23:06PM +0800, Chao Fan wrote:
>> On Wed, Apr 03, 2019 at 04:09:16PM +0800, Dave Young wrote:
>>> Fix 3.  need more debugging, have you or Junichi run tests on more real
>>> hardware, maybe it is easier to reproduce on real hardware, I'm glad to
>>> help to try test patch or provide any help. 
>>
>> I am still testing in real hardware.
> 
> Hi Dave,
> 
> I find a Fujitsu Desktop PC to test it.
> Without this PATCH, it failed to kexec and kdump.
> With this PATCH, it succeed to kexec.
> But failed to kdump. From the log, I think it didn't jump to the second
> kernel, just reboot after panic. I have not figured out what's the
> problem, but it seems not caused by this PATCH.
> So I still think this PATCH works for the Fujitsu Desktop PC.
> 
> As for your issue, I think there may be some problems related to specified
> hardware. Are you using a Lenovo laptop?
> 
> And I am not sure how Nomura tested it.

I've tested 3 different models of EFI-booted baremetal servers with both
normal kexec and panic kexec.  So far as I've tried Linus's v5.1-rc3,
the problem always reproduced without the patch and disappears with the patch.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
