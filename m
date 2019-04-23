Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4171DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC3E214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfDWGVP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:21:15 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:41186 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:21:15 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3N6KdCK014629
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 23 Apr 2019 15:20:39 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3N6KdqH016893;
        Tue, 23 Apr 2019 15:20:39 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3N6ESia028768;
        Tue, 23 Apr 2019 15:20:39 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-4548273; Tue, 23 Apr 2019 15:20:10 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Tue,
 23 Apr 2019 15:20:10 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Kairui Song <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Chao Fan" <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Thread-Topic: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Thread-Index: AQHU+O3agAmzlxHZg0mE9lemKT/NC6ZIsHeA
Date:   Tue, 23 Apr 2019 06:20:09 +0000
Message-ID: <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
References: <20190422092804.15534-1-kasong@redhat.com>
In-Reply-To: <20190422092804.15534-1-kasong@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <92F1F186A0F7274C960CCFCB661342A2@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/19 6:28 PM, Kairui Song wrote:
> The reason is the systab region is not mapped by the identity mapping
> provided by kexec. Currently kexec only create identity mapping for
> mem regions, wihch won't cover the systab. So second kernel will be
> accessing a not mapped memory region and cause fault.
> But as kexec tend to pad the map region up to PUD size, the
> systab could be included in the map by accident, so it worked on
> some machines, but that will be broken easily and unstable.

Is the mapping of ACPI tables just by luck, too?

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
