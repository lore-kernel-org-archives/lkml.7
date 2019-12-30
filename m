Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4155BC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212FA206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfL3NvF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 08:51:05 -0500
Received: from mail-oln040092254050.outbound.protection.outlook.com ([40.92.254.50]:57952
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbfL3NvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 08:51:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGKSA2iBksRqrnkr9oMG0llzVoF7Emr0HfVLXbtSHXN8tVzA0n3iRh1sK9JNUNLNrbwtzRUpB93KAZNMZl4lpnyHRfJH3CtBFVOjsYKd7OTL7kqkQ1k4syfzl45roueiqCp9FoJBsodDO9CILIb98dBN6QIMvCVbOcYPZR+IJVVhs/i/ICCHcmlhP9oRrNS6tNr+DiQnlI5tZLke317lRliXPDYBNmhjbEjvBLNFGP9vRv+8JRTEkBGVsaoDwnLDwu73JzgxZlxPieQ1ZVF3B1b+Miapk6PXW5mVWqoQvFpqCI02UmJkDVrWs8nuS6wv3c0EWuqJhdKISfcT366ylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4cETaqnPfnkvfzZNb0gvjEUc3VoPSvpqiQGmjAX02E=;
 b=DeAn+k8GAmeda3Cu4aDtr4uxUWwaVbeItpAWwfyo/DTYx9s/cRPxGQXcqhsLX9I+/ADLDDTPwZl9w8HnDtRcmtLAVUovu+FXS5LJeuMxL6BJ48JErAGYRAFJkanjj6mwRwZAO0T2E0JETGsFxT1YSlip11XA2hyIP2N+ng3ymuuSVXzSbYl4ZSRCcICZu/5jbclGuMYTxP7+MVhmx2A7OhCqEBVGgdLfGLq6y6m89C+ypKn/hAzR09cQgmiKdzX4oKVoiS/L/vqewNSSAY+VF/JqKXlRk1YIfWGEthof+NdE7JJSjLKS6st3+axZ4K2dQ+l6/mEmp+4JPAV4gPi2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT219.eop-APC01.prod.protection.outlook.com
 (10.152.249.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Mon, 30 Dec
 2019 13:51:01 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.54) by
 HK2APC01FT035.mail.protection.outlook.com (10.152.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Mon, 30 Dec 2019 13:51:00 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2581.007; Mon, 30 Dec
 2019 13:51:00 +0000
Received: from nicholas-dell-linux (2001:8000:1c3e:2000:b6d5:bdff:fe9e:43f5) by SYBPR01CA0007.ausprd01.prod.outlook.com (2603:10c6:10::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Mon, 30 Dec 2019 13:50:57 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: NVMEM real world need for write-only entries
Thread-Topic: NVMEM real world need for write-only entries
Thread-Index: AQHVvxgr0GAj/tuwzkCNhv3os1tIlQ==
Date:   Mon, 30 Dec 2019 13:51:00 +0000
Message-ID: <PSXP216MB043878A11EAFC967500D30DE80270@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0007.ausprd01.prod.outlook.com (2603:10c6:10::19)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:E82A78A6513D886339B56ECFCCACE0C9CE149E663442BD5972DD784D284C8156;UpperCasedChecksum:D10108B5C141E7E0FB83370A08828F300E4C1698B78640909DAE0D4F851FA251;SizeAsReceived:7655;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Wp0m1TNmqsyzKvS+7ZR8VXagInrRStgp26NnjghRX4h+sUNgqJkTnVIZgdOsF2nzodLvnGFG5rs=]
x-microsoft-original-message-id: <20191230135052.GA1522@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: de351a51-3ce4-4090-5c9d-08d78d2f4d4c
x-ms-traffictypediagnostic: HK2APC01HT219:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMh7swvtES50ooRzHb+nRWXkyoKWCdBqPSf+3lwSseOv/gMxFKPEJVd+Y8sKpPSU4EuTUxkxjdgPvSfJCexMGjsdWMRIpyrKwCKmRyF3ruQstzh4ogIBRVqjAjYtU/xeuIIV6GQm3/U0LLc0Wm/GTvWwZ6HuOR5PEeOKW68+wVP4BOLZa/2E21di/4ztXIUt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9019542750287143B2D565500B66A0E6@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: de351a51-3ce4-4090-5c9d-08d78d2f4d4c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 13:51:00.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

I have been talking to Mika Westerberg who maintains the Linux 
Thunderbolt driver and it has become apparent that the ability to create 
NVMEM entries with write-only would be of great usefulness for the Linux 
Thunderbolt driver.

Upon visual inspection, it does not appear that it is possible to create 
a NVMEM as write-only, as of this time.

Is this something you would be interested in / willing looking into with 
us?

I could possibly offer a solution / proof of concept patch to add 
write-only support, but without prior discussion, any such efforts would 
likely go astray.

Thank you!

Kind regards,
Nicholas Johnson
