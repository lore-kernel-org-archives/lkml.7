Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5E2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635AB206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVDA0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:00:26 -0500
Received: from mail-oln040092254037.outbound.protection.outlook.com ([40.92.254.37]:36949
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbfKVDA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:00:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgBPgl5LIggF6UxYUf8P0Dh/8Nap4yhMaSL3/xMjO6m6p9DaLZsJ6iF0p5VOXgMVjiMofqdwKPkNPURO4AKiRVH3TG577nFqEIVUgZTFphveD7SBft6ibfwmj8thryJ/w/uMpwUOAViMaPFclGcEm0PYyygiA6B9KOlI1WR7K7lUooNlharOfttjY86/LVR4nb3mMDHHY+4XwLwFpTT17Uvgd46xFtzFOx1O8I4UR+LBzvHJTTYNw9D+becrUP64gItpArMC0GZxmC2jZuuPrSz0T/hgvGPccI1yAnLAWHu70U4Hwh0Kjfc9rBmy4tnSr+C1EOjLLqT6gHMzafrWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/GcbV9eN0WgES9CQbv7Y6I1dEDn1ZQ6wNvdFCBd6WY=;
 b=a3Cn9JZ401wqMhT7MXhHGx2p8GIS8Piv3WFPTqz3J0boGmOk3DfF3INX5NMITfAq7+D4zSUlVzUxoUQNljcBJvbhPIiFjcSQ8cp3VtNcDSNIsThtyJlZPEQTWXrMhgRwsvmV6xcdmOfr5N3aOkJrQI1xQ8AprueDHIyqcttAd+MXc2O+pnG60o31eBRmC8pEfl1rpz1n5jH+flScU9R0UcOgYlPsIs9KQr0IzqVsKm/a5QlmoPFzmQ+ZpfAKms2GnHni5zHQsrH/7M5upsSTiCe5auREC2zkozKnRO7gio/J7DFkzZwRMlSas77hzErq5ElbpSpPeg4FK8CZiIelyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT025.eop-APC01.prod.protection.outlook.com
 (10.152.250.58) by SG2APC01HT098.eop-APC01.prod.protection.outlook.com
 (10.152.251.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Fri, 22 Nov
 2019 02:59:41 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.53) by
 SG2APC01FT025.mail.protection.outlook.com (10.152.250.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Fri, 22 Nov 2019 02:59:41 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::b880:961e:dd88:8b5d]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::b880:961e:dd88:8b5d%12]) with mapi id 15.20.2474.021; Fri, 22 Nov
 2019 02:59:40 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [[RFC PATCH v1] 0/1] Add pci=nobbn to ignore ACPI _BBN method to
 override host bridge bus window
Thread-Topic: [[RFC PATCH v1] 0/1] Add pci=nobbn to ignore ACPI _BBN method to
 override host bridge bus window
Thread-Index: AQHVoODiiG1xuuRCOEaC/dBx8A2UfA==
Date:   Fri, 22 Nov 2019 02:59:40 +0000
Message-ID: <PSXP216MB043824762539AFC40143D75880490@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0227.ausprd01.prod.outlook.com
 (2603:10c6:220:19::23) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:23DB0BD3EA2774EDC44665EF0CEE95B7D31025FFDB2706BC83D57C6FB32628FE;UpperCasedChecksum:CDA46BA634B29DA0469E8484F2AB62081164C64BE01D30E583C3A690CAF41486;SizeAsReceived:7463;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ClQTX4QG8QygjZY/wke4n29sjcScnJBf]
x-microsoft-original-message-id: <20191122025933.GA4294@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 372e556b-7e04-4666-4ddf-08d76ef804a2
x-ms-exchange-slblob-mailprops: zswcL9HXbeWFySZoc/1CdWpwdPrvG2YoABjzVq03XR6s9aAG8OpTmVnUh8KKxRu9+rc5BM/kv+GIg3Jcq4HKa/M6hdQ8viaCUiTq3zDafY1GES5pdtG9nN6G6/NJlTRWljmOVtsOU6RX70qx0o6+/y6pNXcyN1roUbrBg0yDePyAHh0cv1NYmDzHe0MwUsLKWIQAwjFu33uk8WrDUlK9BlAw7+8pypY87U903dQrTfKaTE5xIhdjJcX9pNc7b9EmLpBk3G7TX6UH4wak2BJD3kB6UD+sFnOEj5lR+exy3oSFI1NtljemtRNE2Ehgp/K+XRt47+JdAUXPnmIzd9EMSNkWK8cVu/GxTDRMSTrpofSqFfmYOhHyeYP/xI7uoV39xIhTL4M5MxZTx022eDXLKxtLGriq9FUocRVJruH/bOFMmEMbVbUi+dKJ+PrSnmoEi2RRwRUPoHrOZp0zScU3E++mUUlObevu58dTglvPVz47k17jb2HNk4VapQT6M6fMSYbms9S8NJxZohAgKtzAL6tLtquZdrpkE2u7yMu2LctsBGAQD0hhhV+M5eZQpN0hznf2Rm1XLShFTBMWvIcJRVXRciTdoHxlY6y9swTCUaBliprTMwc8zTmeIValxJ6O76hiMzP4NTKzxjXN2jh19ouADl6ncxGUZT9t64peaP5TztfT/vI6FWrolhD+2CHtTDpbpe6GRaGKKhe66UvN9rSNJ0ITY3W4A/HtIw3o5U7mUauq8w9/5Bv+60OZJePi
x-ms-traffictypediagnostic: SG2APC01HT098:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bs1UXGsSX3gz+b4rbiyodZRLbBBXU0GzQfyO2OCJ3o5ztXaZAHJG+shc3zZtsPhwFK/vuHmo5qeYuLSMIvCy7QMDcbfv0gYG1Zq6pIzC0x7lz8KFfzb52qGr+4UcWm7K06qD0eo6oCnmHKUe9d0EurHNG9ep2TWSrLxf6ZiQHDSipU4dw72vwFV40SVoeFPG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D23CA545A35124E9D68E96A40847255@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 372e556b-7e04-4666-4ddf-08d76ef804a2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 02:59:40.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I want to be able to override the bus resource from ACPI, but nocrs does 
not do it. I am putting this out here to get a feel for the sentiment 
for doing something like this.

What is my motivation for doing this?

I have a Gigabyte Z170X Designare motherboard which only gives resource 
[bus 00-7e]. I want the full [bus 00-ff] because I am trying to add as 
many Thunderbolt 3 ports with add-in cards as possible. Thunderbolt 
consumes bus numbers quickly. An Intel Ice Lake implementation (ideal) 
consumes 42 busses per port, but prior solutions consume 50 busses per 
port and have additional busses required for the NHI and USB 
controllers, as well as the bridges from the root port.

Why not change nocrs to do this? Why the new kernel parameter?

I imagine that on systems with multiple PCI root complexes, things will 
get hairy if we do this, if they are not placed on separate segments / 
domains by the firmware. I do not own such a beast, but from what I 
understand, the firmware normally places them on the same segment / 
domain with non-overlapping bus numbers. But we may still want to use 
nocrs for other reasons. I need to use nocrs to allow Linux to allocate 
vast amounts of MMIO and MMIO_PREF under the Thunderbolt root ports 
without the BIOS support for Thunderbolt. Hence, they should be kept 
separate.

Why do this in general?

The bus resource is still a resource which is specified from ACPI, just 
like those overridden by nocrs. Even if we do not use pci=nocrs to 
override it, it should be possible to override it, just as it is 
possible to override _CRS.

Topics for discussion include, but are not limited to:

	Is my code great, good, bad, ugly, or does it need work, etc?

	Which way to skin the cat / achieve the end goal, in terms of 
	code?

	Should this be done?

	Is pci=nobbn a good name for the new parameter?

	Should the documentation notice say to report a bug if you use 
	this, like the nocrs one does?

	What are the potential risks and fallout if it is done, if any? 
	My stance on this is that it will be limited to people who use 
	the parameter, so it should be safe.

	What would it take to convince you to support this?

	In relation to arch/x86/pci/acpi.c in the function 
	pci_acpi_root_prepare_resources(): When using CRS, we remove the 
	resource that satisfies resource_is_pcicfg_ioport() without the 
	dev_printk(). But when doing nocrs, we remove it along with all 
	of the others and do the dev_printk() notice. Should it be 
	changed in another patch to skip printing the notice for this 
	resource when using nocrs?

Lastly (semi-unrelated), you may notice that the email linkage is 
broken. It is because I made the mistake of using an @outlook email 
address. It interferes with the encoding. If I send patches with git 
send-email, the encoding is broken. If I use mutt -H, the encoding 
works, but the linkage is broken. I have heard that Gmail also has 
problems, but I tested it the other day with an old Gmail address I 
have, and it appears to work. But I am open for suggestions on what my 
new email domain for kernel development should be. I hope I can use a 
consumer email provider, and not mess with hosting my own domain (it 
sounds like a lot of work). I will switch over soon and send an email 
from this account to confirm that the new account is actually me.

Thanks for any comments or insights.

Kind regards,

Nicholas Johnson

Nicholas Johnson (1):
  PCI: Add pci=nobbn to ignore ACPI _BBN method to override host bridge
    bus window

 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/include/asm/pci_x86.h                  |  1 +
 arch/x86/pci/acpi.c                             | 11 +++++++++++
 arch/x86/pci/common.c                           |  3 +++
 4 files changed, 17 insertions(+)

-- 
2.24.0

