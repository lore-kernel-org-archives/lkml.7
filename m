Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BD4C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2568206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVDAJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:00:09 -0500
Received: from mail-oln040092255097.outbound.protection.outlook.com ([40.92.255.97]:5788
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfKVDAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:00:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQqALV8DbgVLQSH/rIIauk8M5PuAbagJXNrfIwDnNzzK5x9oxqkzQ5UBoBWqDKJqmHK4DPzYcXtAE7nfQYKeg0VGvbuWf/W/K2vxWVsW6vNfp/sEivK6mkacJ4Fk9C94N9Bjf5x+t9hdUgP2ovGtaH+BhxSviLGLiQcmb6Wfs2aK3FUPGLjVwBeJVNRZ3U46ZVqFHoymjedocdg9RQDsM71VGupDe6sOold3N0Tak+rQ29of9SmaOKPkHqL9rYG0C9LnRh/+i10WotZaAK6yXl40tQd94hA8M0XMKg/7QVoZtGWDTAVdoKHNgDqNy8OBV4eM8s68xdKfwgO1s7pjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/GcbV9eN0WgES9CQbv7Y6I1dEDn1ZQ6wNvdFCBd6WY=;
 b=U9XAs6azQ8CW4alOidz2QrpZfyjT+nFl8z2xOCtEURWlbF9QTWEpwIQwBlCE+fxfUXT6A6jJ5RjEhMqL7SP6H66B9Gp7r4CO52RFKKtUZHWb6ybqgDIVGmyOqOolx/UUKZhRbh7V32ZBsq7iUOi6CPOWMCHkul8qAVxBJpd2nZkd6MU8JRdj+cdOV3ziuGZidk8Yz+HXIUyoizSOU+EN0OHU5f6hk55V3rnjVBmf5HH1yt3FDu2IdxO3xtB7VJzKh3AuBTE4Ziy11h45hXiINERHCrrgkm6yvFtcC7lckOWZcRIfAN35mFHstLJaWmQlC0nyEInbK3REETYIzagAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT025.eop-APC01.prod.protection.outlook.com
 (10.152.250.58) by SG2APC01HT080.eop-APC01.prod.protection.outlook.com
 (10.152.251.239) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Fri, 22 Nov
 2019 02:59:22 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.53) by
 SG2APC01FT025.mail.protection.outlook.com (10.152.250.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Fri, 22 Nov 2019 02:59:22 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::b880:961e:dd88:8b5d]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::b880:961e:dd88:8b5d%12]) with mapi id 15.20.2474.021; Fri, 22 Nov
 2019 02:59:21 +0000
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
Thread-Index: AQHVoODWhXDf7VZ4p029AmCe5Y+Ysg==
Date:   Fri, 22 Nov 2019 02:59:21 +0000
Message-ID: <PSXP216MB0438B640B2BC48B5338FDE0280490@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0240.ausprd01.prod.outlook.com
 (2603:10c6:220:19::36) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:DE8E3D50627D1C8A59071D7E0002EC3B8162861E6079A3F6CC2750BC570F26EA;UpperCasedChecksum:7E2DAAEE16A46673DA033213D44B6553DC091E9E77C2E0CD2DDFE4F3963DBF4F;SizeAsReceived:7465;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [huFbT3C3rH+HQt/TKD7PxVm7mg2jFEsp]
x-microsoft-original-message-id: <20191122025913.GA4291@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 9d482bc3-2aa0-4251-c43e-08d76ef7f928
x-ms-exchange-slblob-mailprops: Z/LFrRplwz5CBrXgV5KURwZ8ebthhMcysJBJNDQBvnHOrXN/rJNobuCwLzru0MU+01aEwIu57G8FJLmQV2NS5wBXOmgeh1dD7i/pIt1w/7L6gbXq/dwfBo/ZDhEcPopWVKoejQE0Kjqfq/UZKeBn9rlFdZDRIf0MX4lyoYITuq0Frd6bWuFl78Jkm0Bml/nbTA/xD+88q7LofvN2QK3O9Wp5P2vwC+iIoB45dLAIarG7u3OJ0pLMIuzBWFK2VzcIxNrqHkqkrwBnJddKsCm5rLS2NmMp0cIck2z9ReQAQOrQRFXvHf+vT6t3GQxdFcf2tsTB4BxA0IdOojh5RSRhoJqAAy4QYzmTuxGEYzGlRjuREoNFfnxl1rCT+f3ohNT9iGjqk1E1xxcZLfRr092OPPlQoLOzS1HB2bubK/hxXqRBY0MG5seAStIt5eRiALeA4n2eZuvOC9p9TqPd3BKkWhpyGPhxK/G4xpHxPCamRkZSzEssX46K41KL3jnZ1p49m91vY3ppYZb7ugtrtV7JQTi9Zw3SyO5gANErMxksGxHePIyL6jKa5TEFHARskYWMy6iarNGlfViWGmM85PeG45hZ1XNav2sOdGVmeV13VO/csEcTi2zYKtTVQyDvydm24kQ66jw3+XfTz4HYTiJoPPrXYVy3PqNotKVG36K1gP+O7hurNCD52uKAoCFFymPMaGYXXbg4uIH0Tc15gaMotFLb4CfKUSitD/G/9BsBHieeYlNhhKN0P/0lvR1crufb
x-ms-traffictypediagnostic: SG2APC01HT080:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tu+DLVLCgHDZs0ndqen9wzzV5K3RFQ1du1OEl7NOaUOzhFwKajJ50MSbvoyI4FHvgbDli7DsKIEUHhbi2hGtC/CwDnAGmA9dy2LQf7Q7s/F64eu25CJnQtElaj8txHEk4gYMdwBDqDHdWik0jEWkI/r9It3+fQSx3KYK60EOUBO4goKnbSKPRhIFxvu3dzHW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C7CA53BFA5424498163D27086D2390B@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d482bc3-2aa0-4251-c43e-08d76ef7f928
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 02:59:21.6778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT080
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

