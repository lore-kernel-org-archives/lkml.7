Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2551BC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B6121537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="G7mOF71+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nu6KHhnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGIPXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:23:47 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:21478
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfGIPXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OTyrZRDasYdYzLyGsl0ijtdmSvUDfF3YiEuB+MxojU=;
 b=G7mOF71+H33GylfTtLHJCWg+XsPsCi7ARN4JzgIUQ2zd7LocRD+8UcKs0t85EbbkeMp8Sx56rZHSFE5juKI7r0XyyZvLaYum0DdQiGuj2TLPnzRSqGrzSB6gQn8+FkhgdR3lOuaye9cDMoCbjd+m0MDLPulssOfCNWuj5fGuS74=
Received: from VI1PR0802CA0005.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::15) by HE1PR0801MB1849.eurprd08.prod.outlook.com
 (2603:10a6:3:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.10; Tue, 9 Jul
 2019 15:23:36 +0000
Received: from VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VI1PR0802CA0005.outlook.office365.com
 (2603:10a6:800:aa::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Tue, 9 Jul 2019 15:23:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT026.mail.protection.outlook.com (10.152.18.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 9 Jul 2019 15:23:34 +0000
Received: ("Tessian outbound 3c2a520fbb81:v24"); Tue, 09 Jul 2019 15:23:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e367182eb9addf15
X-CR-MTA-TID: 64aa7808
Received: from c6fb3a27ff47.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2875D0C9-D0ED-412E-934D-A91321A53F1C.1;
        Tue, 09 Jul 2019 15:23:26 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c6fb3a27ff47.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 09 Jul 2019 15:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr9qDr+ZtTvcAQSKEnEWZCUkOr/isjMAYnoFTNLLw3bmKoackSWx0eO18iqnPMnqRNukXOy0N3WxWrYTHdGjZCdRb9DLxjkxLFX5Tit7O8Do0aRrpe+295fUpAo+SqPDKu/XVM4V/UUtefCj4OmQpnYl3fSOwHjyRVt8p4Rm3naYuOkTkToK+NsuZolrERm0mZOBHO0Rz08O4PABk81FgL27B3/dTzdEem7va9WzpPfGAzxSDBDhPgPTKA3/xGa4Brbvk15rKG8F4odEk3nLHnjjA9wzHXFd4CFTjjAT0HW0uzncAi/Pbb461Jqkhvj7SmxHalZLS4pTbQSgKAJVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM6d8yUM2M2W+XMWQyYNsT71rcOq061tTEhuTmL0i0U=;
 b=OsaAUZAbDVPkhgfsSAkrGqyn1MmHWPSaK5CW3mtchc1sTr460/Fbmsz71l06oHGp/RDxEi9zExYerYs+Kuf3YXQlkCfY7iV2hUkyK1GrzmE6+ILL+PGmPu89V7YTajjeYNfreXAqDQjzWyfnBmFT21Lu9z5lQKBHASuz5ikXqfk1uKGcXv97frLlLpZkAb+fQ6Cd1+G6wBudxYO0zztuRUiWNmcjjE2zWFPWIJSHvQIU7puQCAQtMv9a2d3qoBkJSs4H6AAatMN3AGYGSRZDeRIXYvENGNV6fEnag/21ewATzSRHKbfEu8CdjGBbV+fsE8IEvH673O1LoG1efW2j9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM6d8yUM2M2W+XMWQyYNsT71rcOq061tTEhuTmL0i0U=;
 b=nu6KHhnmSkcB8x+LdOv/CFlMxZmQORqGUFTWYrpkM3FsKmq8nuuwVy1oVfs7FJ0cygKX/qo9ADG/Y0Y2AL/PVXtYBS7DLhY0QrX0Rl7eszbW24fr/wLum6Zh0Ggv3jNI+ZepFxMq0NGLeVAvB20aUf2cEmAQYFQmPUOe98hADjE=
Received: from VI1PR08MB4142.eurprd08.prod.outlook.com (20.178.204.76) by
 VI1PR08MB3296.eurprd08.prod.outlook.com (52.134.31.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Tue, 9 Jul 2019 15:23:24 +0000
Received: from VI1PR08MB4142.eurprd08.prod.outlook.com
 ([fe80::5514:755e:2e2e:91a]) by VI1PR08MB4142.eurprd08.prod.outlook.com
 ([fe80::5514:755e:2e2e:91a%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 15:23:24 +0000
From:   Chris Redpath <Chris.Redpath@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        "Dietmar Eggemann" <Dietmar.Eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Update rq_clock, cfs_rq before migrating for
 asym cpu capacity
Thread-Topic: [PATCH] sched/fair: Update rq_clock, cfs_rq before migrating for
 asym cpu capacity
Thread-Index: AQHVNk2eWb+uIZxeu0KteuNhw6xRyqbCTgsAgAAZ14A=
Date:   Tue, 9 Jul 2019 15:23:24 +0000
Message-ID: <b0d82dbf-f23b-f858-4c60-b5a413c0e618@arm.com>
References: <20190709115759.10451-1-chris.redpath@arm.com>
 <20190709135054.GF3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190709135054.GF3402@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0329.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::29) To VI1PR08MB4142.eurprd08.prod.outlook.com
 (2603:10a6:803:e9::12)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Chris.Redpath@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 97d2d6c6-80ea-41bf-ac49-08d7048168b1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3296;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3296:|HE1PR0801MB1849:
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1849938F4EC0E2A001255E51F8F10@HE1PR0801MB1849.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0093C80C01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6916009)(44832011)(54906003)(6486002)(71190400001)(6436002)(71200400001)(316002)(256004)(58126008)(14444005)(6512007)(81166006)(7736002)(305945005)(478600001)(64126003)(36756003)(72206003)(66066001)(65956001)(486006)(229853002)(81156014)(11346002)(66946007)(476003)(2616005)(446003)(73956011)(68736007)(99286004)(8676002)(66476007)(66556008)(64756008)(66446008)(386003)(6506007)(53546011)(26005)(102836004)(65826007)(76176011)(52116002)(186003)(3846002)(86362001)(31696002)(14454004)(4326008)(65806001)(8936002)(6246003)(6116002)(2906002)(53936002)(5660300002)(15650500001)(25786009)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3296;H:VI1PR08MB4142.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: QMQbOApNEm1YBZ0dAD2UNHJBmvbmshUlzcOhVu3mfQDsEmzWrURXpZOXQwTYmo5nDuOQ1OedY3N3yLBItqOKgtvfpyFH8ShWPTB8P3R8b1JHoZNu3DtES3hrg1R81S15BSEI2IGfNaayY6R4WqHU6p9EzRRNFmcgQAn7hdzpoiGj2PE/4BIUoisZ7ZHX0nF23jheY1m1cwCCuiJxc2kZIJFLd809ZTO21OnyJsGi8geriBMTO7xiuROyy79sTL0xQf4YplSWyIqCwf866aJc74rsstnhJfuJNpWa3fvupi8zEd1VlYNez4W4+Sio60aHpT6BtlZHBzmz3i9GEVhNxQHeuIqb6MjiUqNU1fPvJQTMdoblkD4r+UpxHmOim/qqTUu2ScU631wRJxd/xm3ZXjomhMqM80ACHIKlaFPpU54=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D6C5E7CA572884EBF4ED79A4D25C99E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3296
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Redpath@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: =?utf-8?B?Q0lQOjYzLjM1LjM1LjEyMztJUFY6Q0FMO1NDTDotMTtDVFJZOklFO0VGVjpO?=
 =?utf-8?B?TEk7U0ZWOk5TUE07U0ZTOigxMDAwOTAyMCkoNDYzNjAwOSkoMTM2MDAzKSgz?=
 =?utf-8?B?OTg2MDQwMDAwMikoMzQ2MDAyKSgzNzYwMDIpKDM5NjAwMykoMjk4MDMwMDAw?=
 =?utf-8?B?MikoNDA0MzQwMDQpKDE5OTAwNCkoMTg5MDAzKSg4MTE2NjAwNikoODExNTYw?=
 =?utf-8?B?MTQpKDI1Nzg2MDA5KSg2NTEyMDA3KSg3MDIwNjAwNikoMzY5MDYwMDUpKDg2?=
 =?utf-8?B?NzYwMDIpKDQzMjYwMDgpKDEyNjAwMikoNjg2MjAwNCkoNDc2MDAzKSg0ODYw?=
 =?utf-8?B?MDYpKDcwNTg2MDA3KSgyNjE2MDA1KSgzMTYwMDIpKDU4MTI2MDA4KSg1NDkw?=
 =?utf-8?B?NjAwMykoNjU4MDYwMDEpKDY1ODI2MDA3KSg1MDQ2NjAwMikoNjYwNjYwMDEp?=
 =?utf-8?B?KDM1NjAwNCkoNjU5NTYwMDEpKDc2MTMwNDAwMDAxKSg3MjIwNjAwMykoNjQx?=
 =?utf-8?B?MjYwMDMpKDI2ODI2MDAzKSgzODQ2MDAyKSg0Nzg2MDAwMDEpKDYxMTYwMDIp?=
 =?utf-8?B?KDE0NDQ0MDA1KSg1MDI0MDA0KSg1NjYwMzAwMDAyKSg4OTM2MDAyKSg3NjE3?=
 =?utf-8?B?NjAxMSkoMzE2ODYwMDQpKDc3MzYwMDIpKDMzNjAxMikoMjI5ODUzMDAyKSgy?=
 =?utf-8?B?Mjc1NjAwNikoMzg2MDAzKSg1MzU0NjAxMSkoOTkyODYwMDQpKDI0ODYwMDMp?=
 =?utf-8?B?KDY1MDYwMDcpKDIzNjc2MDA0KSg4NjM2MjAwMSkoMTU2NTA1MDAwMDEpKDE0?=
 =?utf-8?B?NDU0MDA0KSgxMDI4MzYwMDQpKDMwNTk0NTAwNSkoMjYwMDUpKDQ3Nzc2MDAz?=
 =?utf-8?B?KSg0NDYwMDMpKDExMzQ2MDAyKSg2MzM1MDQwMDAwMSkoNjMzNzA0MDAwMDEp?=
 =?utf-8?B?KDQzNjAwMykoMTg2MDAzKSgxMDc4ODYwMDMpKDM2NzU2MDAzKSgyOTA2MDAy?=
 =?utf-8?B?KSg2NDg2MDAyKSgzMTY5NjAwMikoNjI0NjAwMyk7RElSOk9VVDtTRlA6MTEw?=
 =?utf-8?B?MTtTQ0w6MTtTUlZSOkhFMVBSMDgwMU1CMTg0OTtIOjY0YWE3ODA4LW91dGJv?=
 =?utf-8?B?dW5kLTEubXRhLmdldGNoZWNrcmVjaXBpZW50LmNvbTtGUFI6O1NQRjpUZW1w?=
 =?utf-8?B?RXJyb3I7TEFORzplbjtQVFI6ZWMyLTYzLTM1LTM1LTEyMy5ldS13ZXN0LTEu?=
 =?utf-8?Q?compute.amazonaws.com;A:1;MX:1;?=
X-MS-Office365-Filtering-Correlation-Id-Prvs: b7958614-c6ba-4a3b-e823-08d70481625e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR0801MB1849;
X-Forefront-PRVS: 0093C80C01
X-Microsoft-Antispam-Message-Info: Q2YjCEkfByzVNOWRKaOS44oLOGVN/sfYx/GDcTXcUOYUXasy+tXnTpELVPhX4rucgiPCuhXK5JaJ1qjYQGeexwpVKYHwWPLdKWfCK6iKAYVH6+PZZ8f17bUc2aQEk27P1/sY22IpcOysN3BCuDKlFEQ8RI4iju2nCWPQegU7NgwpVjFIZzj19KfCcvtdUshJgkRMK/uxKhhzVq/vnFsIwjBaxIyidbMgJuB1blSNc25SGzGybZROpX/Tc4rEaYC+Z2FQpDrKuV/LrRX0KQ/K23f1rDHXUkF2ixig8eyXVjVzMJXFp6a8amNJWPF9WDOt70v7n5A7+93uuh3CLvlBmbuX821l3KXnj+pS09W2KhNzCv9TYfEQ4NKuDICiUN2XhPo+ClOeT3miZWmPJs7Vc9Hl6b4pFOC61zqkZ3SLnKE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2019 15:23:34.7889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d2d6c6-80ea-41bf-ac49-08d7048168b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIDA5LzA3LzIwMTkgMTQ6NTAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0K
PiBPbiBUdWUsIEp1bCAwOSwgMjAxOSBhdCAxMjo1Nzo1OVBNICswMTAwLCBDaHJpcyBSZWRwYXRo
IHdyb3RlOg0KPj4gVGhlIGFuY2llbnQgd29ya2Fyb3VuZCB0byBhdm9pZCB0aGUgY29zdCBvZiB1
cGRhdGluZyBycSBjbG9ja3MgaW4gdGhlDQo+PiBtaWRkbGUgb2YgYSBtaWdyYXRpb24gY2F1c2Vz
IHNvbWUgaXNzdWVzIG9uIGFzeW1tZXRyaWMgQ1BVIGNhcGFjaXR5DQo+PiBzeXN0ZW1zIHdoZXJl
IHdlIHVzZSB0YXNrIHV0aWxpemF0aW9uIHRvIGRldGVybWluZSB3aGljaCBjcHVzIGZpdCBhIHRh
c2suDQo+PiBPbiBxdWlldCBzeXN0ZW1zIHdlIGNhbiBpbmZsYXRlIHRhc2sgdXRpbCBhZnRlciBh
IG1pZ3JhdGlvbiB3aGljaA0KPj4gY2F1c2VzIG1pc2ZpdCB0byBmaXJlIGFuZCBmb3JjZS1taWdy
YXRlIHRoZSB0YXNrLg0KPj4NCj4+IFRoaXMgb2NjdXJzIHdoZW46DQo+Pg0KPj4gKGEpIGEgdGFz
ayBoYXMgdXRpbCBjbG9zZSB0byB0aGUgbm9uLW92ZXJ1dGlsaXplZCBjYXBhY2l0eSBsaW1pdCBv
ZiBhDQo+PiAgICAgIHBhcnRpY3VsYXIgY3B1IChjcHUwIGhlcmUpOyBhbmQNCj4+IChiKSB0aGUg
cHJldl9jcHUgd2FzIHF1aWV0IG90aGVyd2lzZSwgc3VjaCB0aGF0IHJxIGNsb2NrIGlzDQo+PiAg
ICAgIHN1ZmZpY2llbnRseSBvdXQgb2YgZGF0ZSAoY3B1MSBoZXJlKS4NCj4+DQo+PiBlLmcuDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19fX18NCj4+IGNwdTA6IF9fX19fX19f
X19fX19fX19fX19fX19fX3wgICB8X19fX19fX19fX19fX18NCj4+DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHw8LSBtaXNmaXQgaGFwcGVucw0KPj4gICAgICAgICAgICBf
X19fX18gICAgICAgICAgICAgICAgICBfX18gICAgICAgICBfX18NCj4+IGNwdTE6IF9fX198ICAg
IHxfX19fX19fX19fX19fX3xfX198IHxfX19fX19fX198DQo+Pg0KPj4gICAgICAgICAgICAgICAt
PnwgICAgICAgICAgICAgIHw8LSB3YWtldXAgbWlncmF0aW9uIHRpbWUNCj4+IGxhc3QgcnEgY2xv
Y2sgdXBkYXRlDQo+Pg0KPj4gV2hlbiB0aGUgdGFzayB1dGlsIGlzIGluIGp1c3QgdGhlIHJpZ2h0
IHJhbmdlIGZvciB0aGUgc3lzdGVtLCB3ZSBjYW4gZW5kDQo+PiB1cCBtaWdyYXRpbmcgYW4gdW5s
dWNreSB0YXNrIGJhY2sgYW5kIGZvcnRoIG1hbnkgdGltZXMgdW50aWwgd2UgYXJlIGx1Y2t5DQo+
PiBhbmQgdGhlIHNvdXJjZSBycSBoYXBwZW5zIHRvIGJlIHVwZGF0ZWQgY2xvc2UgdG8gdGhlIG1p
Z3JhdGlvbiB0aW1lLg0KPj4NCj4+IEluIG9yZGVyIHRvIGFkZHJlc3MgdGhpcywgbGV0cyB1cGRh
dGUgYm90aCBycV9jbG9jayBhbmQgY2ZzX3JxIHdoZXJlDQo+PiB0aGlzIGNvdWxkIGJlIGFuIGlz
c3VlLg0KPg0KPiBDYW4geW91IHF1YW50aWZ5IGhvdyBtdWNoIG9mIGEgcHJvYmxlbSB0aGlzIHJl
YWxseSBpcz8gSXQgaXMgcmVhbGx5IHNhZCwNCj4gYnV0IHRoaXMgaXMgYWxyZWFkeSB0aGUgc2Vj
b25kIHBsYWNlIHdoZXJlIHdlIHRha2UgcnEtPmxvY2sgb24NCj4gbWlncmF0aW9uLiBXZSB3b3Jr
ZWQgc28gaGFyZCB0byBhdm9pZCBoYXZpbmcgdG8gYWNxdWlyZSBpdCA6Lw0KPg0KDQpJIHRoaW5r
IHlvdSdyZSBmYW1pbGlhciB3aXRoIHRoZSB3YXkgd2UgdGVzdCB0aGUgRUFTIGFuZCBtaXNmaXQg
c3R1ZmYsDQpidXQgc29tZSBtaWdodCBub3QgYmUsIHNvIEknbGwganVzdCBvdXRsaW5lIHRoZW0u
DQoNCldlIGhhdmUgcGVyZm9ybWFuY2UgYW5kIHBsYWNlbWVudCB0ZXN0cyBmb3IgYSBzdWl0ZSBv
ZiBzaW1wbGUgc3ludGhldGljDQpzY2VuYXJpb3Mgc2VsZWN0ZWQgdG8gdHJpZ2dlciB0aGUgRUFT
ICYgbWlzZml0IG1lY2hhbmlzbXMuIFRoZQ0KcGVyZm9ybWFuY2UgdGVzdHMgdXNlIHJ0LWFwcCdz
IHNsYWNrIG1ldHJpYywgYW5kIHdlIHRyeSB0byBtaW5pbWlzZQ0KbmVnYXRpdmUgc2xhY2sgKGku
ZS4gbWlzc2VkIGRlYWRsaW5lcykuDQoNCkluIHRoZSBwbGFjZW1lbnQgdGVzdHMgd2UgZXN0aW1h
dGUgdGhlIG1pbmltdW0gZW5lcmd5IGNvbnN1bWVkIHRvIHJ1biBhDQpwYXJ0aWN1bGFyIHN5bnRo
ZXRpYyB0ZXN0IGpvYiBhbmQgd2UgY2FsY3VsYXRlIHRoZSBlbmVyZ3kgY29uc3VtZWQgaW4NCnRo
ZSBhY3R1YWwgZXhlY3V0aW9uIGFjY29yZGluZyB0byBhIHRyYWNlLiBXZSBwYXNzIHRoZSB0ZXN0
IGlmIG91cg0KZXN0aW1hdGUgb2YgYWN0dWFsIGlzIGxlc3MgdGhhbiBpZGVhbCsyMCUuDQoNCldl
IGVudGVyIHRoaXMgY29kZSBxdWl0ZSBvZnRlbiBpbiBvdXIgdGVzdGluZywgbW9zdCBpbmRpdmlk
dWFsIHJ1bnMgb2YgYQ0KdGVzdCB3aGljaCBoYXMgc21hbGwgdGFza3MgaW52b2x2ZWQgaGF2ZSBh
dCBsZWFzdCBvbmUgaGl0IHdoZXJlIHdlIG1ha2UNCmEgY2hhbmdlIHRvIHRoZSBjbG9jayB3aXRo
IHRoaXMgcGF0Y2ggaW4uDQoNClRoYXQgc2FpZCAtIGRlc3BpdGUgdGhlIHJlbGF0aXZlbHkgaGln
aCBudW1iZXIgb2YgaGl0cyBvbmx5IGFib3V0IDUlIG9mDQpydW5zIHNlZSBlbm91Z2ggYWRkaXRp
b25hbCBlbmVyZ3kgY29uc3VtZWQgdG8gdHJpZ2dlciBhIHRlc3QgZmFpbHVyZS4gV2UNCmRvIHRy
eSB0byBrZWVwIGEgcXVpZXQgc3lzdGVtIGFzIG11Y2ggYXMgcG9zc2libGUgYW5kIG9ubHkgcnVu
IGZvciBhIGZldw0Kc2Vjb25kcyBzbyB0aGUgaW1wYWN0IHdlIHNlZSBpbiB0ZXN0aW5nIGlzIGFs
c28gcHJvYmFibHkgaGlnaGVyIHRoYW4gaW4NCnRoZSByZWFsIHdvcmxkLg0KDQpJIHRvdGFsbHkg
YXBwcmVjaWF0ZSB0aGUgcmVsdWN0YW5jZSB0byBhZGQgdGhpcyAtIEkgZG9uJ3QgbXVjaCBsaWtl
IGl0DQplaXRoZXIsIGJ1dCBJIHdhcyBob3BpbmcgdGhhdCBzdGlja2luZyBpdCBiZWhpbmQgdGhl
IGFzeW1fY3B1Y2FwYWNpdHkNCmtleSBtaWdodCBiZSBhIHJlYXNvbmFibGUgY29tcHJvbWlzZS4N
Cg0KQXQgbGVhc3Qgb25seSB0aG9zZSBwZW9wbGUgd2hvIHNlbGVjdCBhIENQVSB1c2luZyB0YXNr
IHV0aWwgYW5kIGNhcGFjaXR5DQpzZWUgdGhpcyBjb3N0LCBhbmQgd2UgaGF2ZSBzbWFsbGVyIHN5
c3RlbXMgc28gaW4gdGhlb3J5IHRoZSBjb3N0IGlzIHNtYWxsZXIuDQoNCkknbSB2ZXJ5IG9wZW4g
dG8gZXhwbG9yaW5nIGFsdGVybmF0aXZlcyA6KQ0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBS
ZWRwYXRoIDxjaHJpcy5yZWRwYXRoQGFybS5jb20+DQo+PiAtLS0NCj4+ICAga2VybmVsL3NjaGVk
L2ZhaXIuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvZmFpci5jIGIva2Vy
bmVsL3NjaGVkL2ZhaXIuYw0KPj4gaW5kZXggYjc5OGZlN2ZmN2NkLi41MTc5MWRiMjZhMmEgMTAw
NjQ0DQo+PiAtLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jDQo+PiArKysgYi9rZXJuZWwvc2NoZWQv
ZmFpci5jDQo+PiBAQCAtNjU0NSw2ICs2NTQ1LDIxIEBAIHN0YXRpYyB2b2lkIG1pZ3JhdGVfdGFz
a19ycV9mYWlyKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IG5ld19jcHUpDQo+PiAgICAgICAg
ICAgICAgICogd2FrZWUgdGFzayBpcyBsZXNzIGRlY2F5ZWQsIGJ1dCBnaXZpbmcgdGhlIHdha2Vl
IG1vcmUgbG9hZA0KPj4gICAgICAgICAgICAgICAqIHNvdW5kcyBub3QgYmFkLg0KPj4gICAgICAg
ICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgIGlmIChzdGF0aWNfYnJhbmNoX3VubGlrZWx5KCZz
Y2hlZF9hc3ltX2NwdWNhcGFjaXR5KSAmJg0KPj4gKyAgICAgICAgICAgICAgICAgICAgcC0+c3Rh
dGUgPT0gVEFTS19XQUtJTkcpIHsNCj4NCj4gbml0OiBpbmRlbnQgZmFpbC4NCj4NCg0Kb29wcywg
d2lsbCB0d2VhayBpdA0KDQotLUNocmlzDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMg
b2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1h
eSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Ns
b3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJw
b3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFu
ayB5b3UuDQo=
