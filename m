Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82E4C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4FE2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Mc+80LP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfCOJZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:25:47 -0400
Received: from mail-eopbgr780081.outbound.protection.outlook.com ([40.107.78.81]:57632
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbfCOJZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/OVzmd22kEFFk3DLn7Nz7ueqQQ3s0SSLhr7xOmInD0=;
 b=Mc+80LP6a17SMVir3+RkHoBvT5wvZE0RjgFP1jHovGz/QXGSWxRsxIYyXXlPowmeq21wj25ZIeoWnw0Yu0qCBzPW3POlbufKb+KcBoJEjtoAbEJOkhdckRutvTSg57cGVcdAR4RcbjszSK1EuO0lYogkiOsiBMDuL4BSFMCV8rI=
Received: from BN6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:404:23::34)
 by BLUPR03MB551.namprd03.prod.outlook.com (2a01:111:e400:882::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Fri, 15 Mar
 2019 09:25:44 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR03CA0024.outlook.office365.com
 (2603:10b6:404:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Fri, 15 Mar 2019 09:25:44 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Fri, 15 Mar 2019 09:25:40 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2F9Pd1u009218
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Mar 2019 02:25:39 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Fri, 15 Mar 2019 05:25:39 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "colin.king@canonical.com" <colin.king@canonical.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: fix indentation issue, remove extra tab
Thread-Topic: [PATCH] iio: adc: fix indentation issue, remove extra tab
Thread-Index: AQHU2r1N+2jrg0fwyU2UMXFTkVJVEqYMr60A
Date:   Fri, 15 Mar 2019 09:25:38 +0000
Message-ID: <1552641938.13791.2.camel@analog.com>
References: <20190314232603.30531-1-colin.king@canonical.com>
In-Reply-To: <20190314232603.30531-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.224.122]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DA53FCB4A37A24F95C45AE2CBD6059D@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(54906003)(7696005)(110136005)(476003)(47776003)(2486003)(23676004)(2616005)(446003)(126002)(106002)(486006)(103116003)(316002)(436003)(426003)(106466001)(14444005)(36756003)(8936002)(6116002)(3846002)(11346002)(7736002)(72206003)(478600001)(356004)(4744005)(2906002)(246002)(4326008)(2501003)(8676002)(50466002)(102836004)(76176011)(305945005)(14454004)(26005)(6246003)(229853002)(7636002)(2201001)(186003)(86362001)(5660300002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB551;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f82999ea-143e-45ff-7b3b-08d6a9283301
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BLUPR03MB551;
X-MS-TrafficTypeDiagnostic: BLUPR03MB551:
X-Microsoft-Antispam-PRVS: <BLUPR03MB5519F17D3DE316AC1AB06F29D440@BLUPR03MB551.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09778E995A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tuGOd0Txz6yTr4Lr6uZdfDWnKkIgEg1dpt8oYC9rPk/Xjucd8SqTBTYXwPVESw3BlcNmUMg+28C9wLIpAdVWhxnIVBw7Caq3BWmuozgvZvA2sdr9AEulH8ixBYcuSLB52307re/iMTOXUOHCWpcn5m6AvgBPtFw6aRl+8OK+dRIpLYktxtAwqW1uG8SQ9Z9EwzTxXfjCPnN269wf4ilueLZtx/QpNStSC3joUp9yQW3oVzBDbBjEvas0rVoAuIz5LHylERcLpXpah4uZ1kyJ/p5/QQ3mFgJtjNx3t6hp+POAdPoErrNefKMJwTQ/Hb2INMRN8hXEUkia7wk8CgbWEGfdFVUFW8oxou/g9C+U6mhFSrR2mQqwT9+1HU+/xUyNyiIP5Dj5srC0m1dtoWpRh0PSGtujfoQGS8edjQmnlRY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2019 09:25:40.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f82999ea-143e-45ff-7b3b-08d6a9283301
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSm8sIDIwMTktMDMtMTQgYXQgMjM6MjYgKzAwMDAsIENvbGluIEtpbmcgd3JvdGU6DQo+IFtF
eHRlcm5hbF0NCj4gDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5v
bmljYWwuY29tPg0KPiANCj4gQSByZXR1cm4gc3RhdGVtZW50IGlzIGluZGVudGVkIG9uZSBsZXZl
bCB0b28gZGVlcGx5OyBjbGVhbiB0aGlzDQo+IHVwIGJ5IHJlbW92aW5nIGEgdGFiLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4N
CkFja2VkLWJ5OiBTdGVmYW4gUG9wYSA8c3RlZmFuLnBvcGFAYW5hbG9nLmNvbT4NCg0KVGhhbmtz
IQ0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvaWlvL2FkYy9hZDcxMjQuYyB8IDIgKy0NCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9hZGMvYWQ3MTI0LmMgYi9kcml2ZXJzL2lpby9hZGMvYWQ3MTI0LmMN
Cj4gaW5kZXggN2Q1ZTUzMTFkOGRlLi42NTllZjM3ZDVmZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaWlvL2FkYy9hZDcxMjQuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWQ3MTI0LmMNCj4g
QEAgLTQxMSw3ICs0MTEsNyBAQCBzdGF0aWMgaW50IGFkNzEyNF9pbml0X2NoYW5uZWxfdnJlZihz
dHJ1Y3QNCj4gYWQ3MTI0X3N0YXRlICpzdCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2Vycigmc3QtPnNkLnNwaS0+ZGV2LA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IkVycm9yLCB0cnlpbmcgdG8gdXNlIGV4dGVybmFsIHZvbHRhZ2UNCj4gcmVmZXJlbmNlIHdpdGhv
dXQgYSAlcyByZWd1bGF0b3IuXG4iLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWQ3MTI0X3JlZl9uYW1lc1tyZWZzZWxd
KTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIFBUUl9FUlIoc3QtPnZyZWZbcmVmc2VsXSk7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIFBUUl9FUlIoc3Qt
PnZyZWZbcmVmc2VsXSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0LT5jaGFubmVsX2NvbmZpZ1tjaGFubmVs
X251bWJlcl0udnJlZl9tdiA9DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShzdC0+dnJlZltyZWZzZWxdKTsNCj4g
LS0NCj4gMi4yMC4xDQo+IA==
