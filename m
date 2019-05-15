Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD62FC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE821473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfEOFXm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 01:23:42 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:57151 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOFXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:23:41 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x4F5MFXo002708
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 May 2019 14:22:15 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4F5MERe023708;
        Wed, 15 May 2019 14:22:15 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4F5KPwI027934;
        Wed, 15 May 2019 14:22:14 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-5066124; Wed, 15 May 2019 14:17:20 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Wed,
 15 May 2019 14:17:19 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "kasong@redhat.com" <kasong@redhat.com>
CC:     "dyoung@redhat.com" <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Thread-Topic: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI
 systab and ACPI tables
Thread-Index: AQHVCt13YD4lckvUHUCIqj5Wl9aEBQ==
Date:   Wed, 15 May 2019 05:17:19 +0000
Message-ID: <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv> <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv> <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv> <20190513075006.GB20105@zn.tnic>
 <20190513080210.GC16774@MiWiFi-R3L-srv>
In-Reply-To: <20190513080210.GC16774@MiWiFi-R3L-srv>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <CA26469105FD8045B8909AFA561E0308@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

On 5/13/19 5:02 PM, Baoquan He wrote:
> On 05/13/19 at 09:50am, Borislav Petkov wrote:
>> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
>> So we're going to try it again this cycle and if there's no fallout, it
>> will go upstream. If not, it will have to be fixed. The usual thing.
>>
>> And I don't care if Kairui's patch fixes this one problem - judging by
>> the fragility of this whole thing, it should be hammered on one more
>> cycle on as many boxes as possible to make sure there's no other SNAFUs.
>>
>> So go test it on more machines instead. I've pushed it here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=next-merge-window
> 
> Pingfan has got a machine to reproduce the kexec breakage issue, and
> applying these two patches fix it. He planned to paste the test result.
> I will ask him to try this branch if he has time, or I can get his
> machine to test.
> 
> Junichi, also have a try on Boris's branch in NEC's test environment?

while the patch set works on most of the machines I'm testing around,
I found kexec(1) fails to load kernel on a few machines if this patch
is applied.  Those machines don't have IORES_DESC_ACPI_TABLES region
and have ACPI tables in IORES_DESC_ACPI_NV_STORAGE region instead.

So I think map_acpi_tables() should try to map both regions.  I tried
following change in addition and it worked.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.


diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3c77bdf..3837c4a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -56,12 +56,22 @@ static int mem_region_callback(struct resource *res, void *arg)
 {
 	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	struct init_pgtable_data data;
+	int ret;
 
 	data.info = info;
 	data.level4p = level4p;
 	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
-				   &data, mem_region_callback);
+	ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
+				  &data, mem_region_callback);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
+				  &data, mem_region_callback);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	return 0;
 }
 #else
 static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
