Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86F22064A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfCYKiE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:38:04 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:39215 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfCYKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:38:04 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2PAbON7012663
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Mar 2019 19:37:24 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2PAbOXC016891;
        Mon, 25 Mar 2019 19:37:24 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2PAZbg3023627;
        Mon, 25 Mar 2019 19:37:24 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3646920; Mon, 25 Mar 2019 19:36:34 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Mon,
 25 Mar 2019 19:36:34 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Dave Young <dyoung@redhat.com>, Boris Petkov <bp@alien8.de>
CC:     "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bp@suse.de" <bp@suse.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU4uSRSF49+PGwf02T2oxnk4CVXaYbdAGAgAAWloCAAAX6gA==
Date:   Mon, 25 Mar 2019 10:36:33 +0000
Message-ID: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <895ABBA05F13AC4E969AC80CB8C41395@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 7:15 PM, Dave Young wrote:
> On 03/25/19 at 09:54am, Boris Petkov wrote:
>> On March 25, 2019 9:27:21 AM GMT+01:00, Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>>> On 3/25/19 3:59 PM, Dave Young wrote:
>>>> On 03/25/19 at 06:47am, Junichi Nomura wrote:
>>>>> On 3/25/19 3:19 PM, Dave Young wrote:
>>>>>> On 03/25/19 at 02:01pm, Dave Young wrote:
>>>>>> I think normally people do not see this bug, because kernel will
>>> set the
>>>>>> rsdp in boot_params->acpi_rsdp_addr.  Maybe you are testing with
>>>>>
>>>>> I think it's only done for file-based kexec interface.
>>>>
>>>> Saw Kairui's another reply, yes, kexec-tools need a patch to fill the
>>>> value as well then.
>>>>
>>>> I would vote for a repost of your old patch with some #ifdef
>>>
>>> Thanks for comments, Dave, Kairui and Baoquan.
>>>
>>> The problem for me is it's a regression in v5.1-rc1, that breaks
>>> existing setup. If early parsing of RSDP is required only for newly
>>> supported configuration, I'm fine such configuration requires
>>> new tools or new options.
>>>
>>> This is the 1st version plus #ifdef around the EFI code.
>>
>> I'm going to repeat that again until you get it:
>>
>> If the kexec kernel should continue to use efi_systab_init() then you
>> should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.
> 
> In that way, early parsing will fail in kexeced kernel, am I missing
> something?  The early code become complicated but since we have already
> the early acpi parsing why not to make it consistent in kexeced kernel?

AFAIU, early parsing is new code in v5.1-rc1 to support kexec on systems
with hotpluggable memory with KASLR enabled. For systems that requires the
new feature, it may be ok to say "you need to use another kexec interface"
and/or "you need new kexec-tools".

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
