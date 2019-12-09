Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4CAC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7DA2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLIV3k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:29:40 -0500
Received: from mail-oln040092253085.outbound.protection.outlook.com ([40.92.253.85]:35326
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfLIV3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:29:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ9xIbKymN97ThhFLEcY9m6B+wOJYhPzXHYl8nmDUA+eWw40yeeMPVIlQDU2G2oWOQggf3d17g9s1xnT96X4NtAH6ztSXda0GZg9YQBACOWNUiiL4Vy+/tAHGH7PttYN0MgQkdCGeQxqYomRZ5Qc8lQNBoqtRSTGFno3PYCXPvbdlW6PAfyJ8vz0hCeYkLQ/pkZUX9bVCSl5d7SHljQTY6XaJkESyRKKbysodYDam79HO6SY55vuEyDeC5B6g/suqawllH2rOx0J3JDuN9nQWWgk964+ZAvEerCXH6t771Oo1RfcHiWEOD4M2DvlUig8zC4hQlXq+3DViRFKA+COqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVdxpc7IfVnDIDRCpdUwxG1KC44jhQek3xcFcswJxLY=;
 b=iwV2E93l4YszVU5a7M7B/WPwI5Ps4EEqL0sgvhsrGDpCFCmSPxNjTo1dqNrFXyBhN9yTf6WkkvKBGfxogZjVo1yxKPvuZwQRwsE5ir02mG4l9Dv7Y96F2uv03dnT7OPXAPICPKKK2WFVxvMagBA5GVRc2QkRvFOhmjHHfKS0HoSKPD74IoFMSGrGabYDkXuYE1MgF45mLkLH+xjmKZ/7fJFfaGE6RIp8R8tTlLwEUXMpIC87BGG17G8fCvJaW/lj88LzSEbYcui6wmNs33v/b0HyIG/tv01RbhziUm0JFfsu0j80aEuKZJIbzVv90ATey+jaEnnRJDdeo6lBZQYCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT017.eop-APC01.prod.protection.outlook.com
 (10.152.250.56) by SG2APC01HT063.eop-APC01.prod.protection.outlook.com
 (10.152.251.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 21:29:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
 SG2APC01FT017.mail.protection.outlook.com (10.152.250.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 21:29:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 21:29:34 +0000
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
Thread-Index: AQHVrtfAIsnZ9QYdckySps24P6syCA==
Date:   Mon, 9 Dec 2019 21:29:34 +0000
Message-ID: <PSXP216MB04385B2C1BB518E5219C30CE80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0084.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::17) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:25B9FD6B8D0523CE33338572B32B133AE153C2BA11CD99F07547EF2445DCABA7;UpperCasedChecksum:6E81D8B0C287F3D469F45FC1B5EC85A936A327BE466C12BA9250C9B3D261ECB9;SizeAsReceived:7523;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [V1YKfg2q+00AA89CcJYVh5vpLzE8QTkjYbi5bBiXuNzpD4oUnGbK6Y6BeDxUvU/NQyzKSsBgqGo=]
x-microsoft-original-message-id: <20191209212918.GA12436@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c2622c0e-f2c8-42c7-a69b-08d77ceee2a2
x-ms-exchange-slblob-mailprops: zswcL9HXbeWFySZoc/1CdWpwdPrvG2YoABjzVq03XR6s9aAG8OpTmZlkm0vj6oFLdRkpTH6fG74FjA3Vc057v3CwcQkC+7EECky6pUiQpO1v6tYC37u/dA2iCSrCy8dPylbSoB+5CdfMaoZHra7hqrHVwNDT4uFGUeaXLWQ5XYLOGiIlXrvl7NyOIWTUg2qsyC6aVGYNa8hObFTxLxdk/wcty2Wb14Rmn4EHiJ7aAzbkfVLhhzJsU2s8tBFvcUPFw8ROJBbiHGh4hsh/k/TJmCtBEf3AW0dJWDxKxZS8Y2DVj1d20QhRpun0C5ysjPx82K9/jBnZa0mHeQnqlv1oIiZqfTTMUP2XusA98U7yf2Wh8IKofQ0Iv5NPRkrSXBayyDFRkaCbTR39a6z75XFBNsNMN1rXjfuQ9pPGK0G9L4UOzL79zhuu6145qUfy7E5UdsfMrc4gmorHGWxJ/N0GpiZ5x+AL6INEU44k9zqFGTQ6oPJZx0pdB5joAe4J2OuE5OUX+/ZpAoI2pe3SZ/9zHH3vJM4SjSdrBvs3PIvOZpT65Z529YHfJ386gHH7I5MLQsYJaLKqy27yfpS8NWdv6ehVr2Va6fsYBjx99Nr7pr328S7pqMHq2fhatCmccKoAbfuuzBg6Y4Vt+p9a2f5YQEMieuVItA6Zet84OyB106IJBPRUdKFfIOA3DVKR5knRmofWPAm4N1abxgisQCZtVsWh+haNlcR604FYMGW+MO/1siPfukc5/Na++MIB5c0f
x-ms-traffictypediagnostic: SG2APC01HT063:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6IPFuQyFFyjHel7ymV9e8VldhssBwDrkBSTAHvQDbE5SMCHq9cSxncd0uPXwIV7nkBH+VuNZlghuC/l73IhipcML3AFkFZ+nBWLxN2hjlVc97nv0jAiyZFWgapLJRM0gBjqKp7ZHWtKAqRVUF/hOT8Go+euxo31jgP8JlzvRTpWSPJJHLjCVywiWwjw+Fbz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9A7E9DC50AEA74580DA51B2E0E59905@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c2622c0e-f2c8-42c7-a69b-08d77ceee2a2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 21:29:34.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re-posting as the first time I sent cover letter twice instead of cover 
letter and patch, oops]

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

