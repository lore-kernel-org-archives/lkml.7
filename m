Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F54D20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfC2J5p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:57:45 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:52356 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfC2J5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:57:45 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2T9vQEE017524
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 18:57:26 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T9vQf0023958;
        Fri, 29 Mar 2019 18:57:26 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T9teEO007998;
        Fri, 29 Mar 2019 18:57:26 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3819778; Fri, 29 Mar 2019 18:56:54 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Fri,
 29 Mar 2019 18:56:53 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
CC:     Borislav Petkov <bp@alien8.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "Dave Young" <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU5R0gSF49+PGwf02T2oxnk4CVXaYgAhGAgAAQvICAAIi3AIAAvAQAgABdKwCAAAdoAIAAAt2AgAAF2ACAAAH/gIAAA4+A
Date:   Fri, 29 Mar 2019 09:56:53 +0000
Message-ID: <71880195-70ae-13e9-08c6-364c157c9ab1@ce.jp.nec.com>
References: <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
 <20190329083920.GA21152@zn.tnic>
 <20190329090550.GI4234@localhost.localdomain>
 <20190329091605.GB21152@zn.tnic>
 <ee8045cf-5100-6bd6-1ccc-e9654da922b6@ce.jp.nec.com>
 <20190329094409.GM4234@localhost.localdomain>
In-Reply-To: <20190329094409.GM4234@localhost.localdomain>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <CCAF4965E588C945B9AC8079FF63597F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 6:44 PM, Chao Fan wrote:
> But in my qemu guest, they are different and the address of ACPI20 is
> higher than ACPI 1.0:
> [root@localhost ~]# cat /sys/firmware/efi/systab
> ACPI20=0xbfbfa014
> ACPI=0xbfbfa000
> SMBIOS=0xbfbcc000
> 
> In this condition, ACPI 1.0 comes before ACPI 2.0. So I suggested you
> to keep this logical.

Thank you for the information. The proposed patch keeps the logic
and should work fine on that case as well.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
