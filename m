Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F03C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA85D20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="VTjSGxZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfCAPnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:43:33 -0500
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:20550 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728234AbfCAPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:43:32 -0500
Received: from pps.filterd (m0111311.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21Fe5dp009343;
        Fri, 1 Mar 2019 16:43:19 +0100
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56])
        by mx08-00287e01.pphosted.com with ESMTP id 2qtwyfxxkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Mar 2019 16:43:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4qS21S3tC/uFmA9mZG/NUxyy3GMhGBqFrl+rot+InE=;
 b=VTjSGxZVYI+lQyh4a1pcw21e5rVVD3tg0JPraz97ievA5+iXvyWI7DiDmwfOoXa6MVYFYqQsk+rLyCt2SPyApJamboYcDSQlslO7x642ocAVq5AVEkb0KIm+PCNeCZbF5dVB6s13EEbLu6d4HqYNCM9N+YQvuoPKGGTZgG/gTI0=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB5279.eurprd04.prod.outlook.com (20.177.51.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 15:43:17 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec%3]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 15:43:17 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Erwan Velu <erwanaliasr1@gmail.com>,
        "elliott@hpe.com" <elliott@hpe.com>
CC:     Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <esc.storagedev@microsemi.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Topic: [PATCH v2] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Index: AQHU0D9MEwbiRTQ1W0O9RWBUcKAFRaX25ceAgAAEsoA=
Date:   Fri, 1 Mar 2019 15:43:17 +0000
Message-ID: <c858605b-7283-7882-64a8-8d1584274b95@criteo.com>
References: <20190227163133.26283-1-e.velu@criteo.com>
 <20190301145832.12735-1-e.velu@criteo.com>
 <1551453987.3334.2.camel@linux.ibm.com>
In-Reply-To: <1551453987.3334.2.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0018.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::30)
 To VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b4cec43-2978-4a92-eb6e-08d69e5c9f79
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5279;
x-ms-traffictypediagnostic: VI1PR04MB5279:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1Mjc5OzIzOjlHbTBBTzAzMU5oZEpXdWZUdlJuYUdjVWtC?=
 =?utf-8?B?RWE3UlBwcThqamJkQmRoOFUycmZwcGROK1BPbTZmVTVVTjBTRWFSVGE1S1BM?=
 =?utf-8?B?cDNKZk0yMERIaDV4dGVTL0x0QlYzem1UdHVKVngvUi8xelFhcFJFRkZQc2J4?=
 =?utf-8?B?c3VZTi9kRlZaVExtUzN6K1pUU3VCaVdqQitmbFhheVVFdDFxb0s3Z2VlR1dk?=
 =?utf-8?B?S3QyTXRlZjRWeHI5aS81MGlnd0pQU21GNDk3ZWYyYVBwUTc0M2FiRXQzMDJF?=
 =?utf-8?B?YmpEcW4xMkdnOHZpQWE3MHY5WUNHYlpTWWxxUU05T0RIbkVUcjFuV2FqTU9S?=
 =?utf-8?B?UkhqbnFwM2N3Y3RUZmkrTXd0emxzT0h4Sk45SlFla3NIYU5VdGFSSHM4T0Jw?=
 =?utf-8?B?MWxzbE0yUjdXWGQwVmczTlhsK2pkckw2QnY3V0NiMUxnYUZvaXFYSnB6RzdG?=
 =?utf-8?B?WnkvaGtDelAvMHY5d0lZYjl0akRJYTZacGRTUk1CWEIrR2tZSzhsb24zWmZr?=
 =?utf-8?B?RUZha3BaZ2xoNis2VC9ZRXFxYWJnVlR0aXNSbnp0SlBUa0QxR0IxSWlJUm1h?=
 =?utf-8?B?Z3ZzaWF6ZjV5YzVRQ29BVkU4Umx3eEM4VlVBa2o1N3hGMi9mL2RtTzloNE1X?=
 =?utf-8?B?NmhGVGFEaVJMbGVFcFFtVHhmRTRaeHh0eUJzSkNmRUYrODBuSk84dlJBMzhW?=
 =?utf-8?B?TFhpalpEbmpFUDFnNE40SVNrOE1KQXROaVdiVmhtOUlBKzBaaXAxYTVUU0V1?=
 =?utf-8?B?OEVRamZkbklNcFdOTmRzOXhsR2pZUmFaM3RyR0xscUllZko2blZ3dVlEZ1g4?=
 =?utf-8?B?SFNNNlU0MVJZRUdXdXREdDcrQUw4QlN1MXFnOEJ0OEQrcng2MVVhRkxNcnVz?=
 =?utf-8?B?T0h3ZVYybFk2eXc1a3VmcEM3RTJXeDlnR24zZlBsNGlMbU11RHlpYTVwUTlC?=
 =?utf-8?B?OGJzRU5MTmExanBsaVlwamVYUHFoMnQ4Y1lYQWJvN3VMampieXh1YklPNUI4?=
 =?utf-8?B?a2dUOHF5Nk1rVjY4NEptai9pUExNN0ZQNUsraXhWalp4ZXNsYkRNcDBJY3hK?=
 =?utf-8?B?SmFhWFB4ZnpiSUdDM2FQa2RhYUZ2TlQ0YUdqSEdrNnF5Zkozc0Y4SkVNZnNt?=
 =?utf-8?B?aVIzRTNpLzRwb2FZbUFSdXhURjdOSXR3ckV1OVhWYmxqbzR6eVBPWnNtZ2VG?=
 =?utf-8?B?NkZPenZ6K3RrelRDOVgwbUc5THZlQWZGQWJpM01YTkI4Skw3ZEtjbk9EV1Vy?=
 =?utf-8?B?TW1CcWMzdFNsRm1LOVNETnQ5Yk1GT2xRVjlxSkV5NUU5bEJqOWJYQzhTMkt3?=
 =?utf-8?B?ZGcwQmE2WXhNeTBuVDlvRnBUVVk4b1BJVUdnZFIwazVlYXpldklhdUYrZmVB?=
 =?utf-8?B?NjZlZ2hvb1d5bHZiNEltVWV0K0NhQkpTR3B0OVlNZG1SV0MzU3NQeFptQkE2?=
 =?utf-8?B?NTZyb2N1OW0yUUMybWU3dU1idFVpVUFoZzl5TCs3QXdveCtPYkZwL1VqQ1ZP?=
 =?utf-8?B?anFIN3RYUnZmd1l2a09nbGpuK2ZNaXNqK214ZFFibzd4b2EzODBzQkpFY1du?=
 =?utf-8?B?dXdIanEyQ0kwOW1naWxWbWRDdThNNjVycHBwSFZHdlU2WkVVdXdLaGhtMDBl?=
 =?utf-8?B?bnYzMklFeTl2VEdMNmQ5YnRkUTBXdkhGMWVwSmtIemU5cCtLUmZ1NEFtNVNK?=
 =?utf-8?B?eExUaGdWTDVpeW1WYjJOUUo5UUF3YndaQTNtZEtlYUM1SUdJd0J3S3ZScmpl?=
 =?utf-8?B?cCt3RjBuMDFFeDVPQk92QT09?=
x-microsoft-antispam-prvs: <VI1PR04MB5279CF64FA0665E11E501AD3F2760@VI1PR04MB5279.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(8676002)(31686004)(6512007)(25786009)(81166006)(54906003)(81156014)(86362001)(6436002)(31696002)(8936002)(4326008)(5660300002)(71200400001)(186003)(14454004)(2501003)(256004)(71190400001)(52116002)(7736002)(97736004)(6246003)(76176011)(229853002)(478600001)(6486002)(110136005)(26005)(106356001)(305945005)(105586002)(99286004)(6506007)(3846002)(446003)(316002)(386003)(2616005)(476003)(66066001)(53936002)(486006)(2906002)(68736007)(36756003)(11346002)(4744005)(102836004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB5279;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r/QCNxdjiVRDvVvZlxZUDSQyGTwKhhiLvBGQ4zoY86ICdP3KRKe0qo1bZqRiSZmlH41NmrX4aLaNbMWbIp/z/XZPkidH5KU7Z78Mpef0ihyBewKaK0X2jzbowsrIKzcDzJ9jOneAgFfeIQXc3i7Z3lUAtUYySp55DRp3LHUycwaaI3rbcndmaMKrNpbTGFpan9zvco2E5YDGoKQTkPiPRgsOCeWEXPXQNHWCmWXCAUB6EmQ4Nrom/L5ATYJtgpgwHsaDmhBLTLwhDvNAfQ5iOw//ibYlM/ziW0TDZa2qZlPMrIaBWbeCLobkN1mqQikPj2YyoxsOzwRX9ioh+qOzXdetCKCQe2ii2DSXUmB7vibKGjYR4lhg2ymaY972Y8EmfncfYZV7nK8oK50sz6zLNz0vmWaNa/PpLmb52WEMuX8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA79FA226588B240832546F5BA5927C3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4cec43-2978-4a92-eb6e-08d69e5c9f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 15:43:17.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAwMS8wMy8yMDE5IMOgIDE2OjI2LCBKYW1lcyBCb3R0b21sZXkgYSDDqWNyaXTCoDoNCj4g
Wy4uLl0NCj4gU2hvdWxkbid0IHRoaXMgYmUgYSB2YXJpYW50IG9mIHNkZXYvc2NtZF9wcmludGs/
ICBPdGhlcndpc2UgaXQgdGVsbHMNCj4geW91IHdoYXQgZGlzayBpbiB0aGUgYXJyYXkgdGVybXMg
aXMgdGhlIHByb2JsZW0gYnV0IG5vdCB3aGF0IGRldmljZSBpbg0KPiB5b3VyIGFjdHVhbCBzeXN0
ZW0gaXMgYWZmZWN0ZWQuDQoNCkhleSBKYW1lcywNCg0KTXkgaW5pdGlhbCB0YWtlIG9uIHRoYXQg
d2FzIHRoYXQgcHFpX3Rha2VfZGV2aWNlX29mZmxpbmUoKSwgd2hpY2ggaXMgDQpjYWxsZWQganVz
dCBhZnRlciwgd2lsbCBwcmludCB0aGUgInJlLXNjYW5uaW5nICIgbWVzc2FnZSB3aXRoIHRoZSBz
YW1lIA0KZm9ybWF0Lg0KDQpBcyB0aGV5IHdpbGwgYmUgYm90aCBwcmludGVkIGluIHRoZSBzYW1l
IGVycm9yIGNvbnRleHQgYW5kIG9uZSBhZnRlciB0aGUgDQpvdGhlciwgSSB0aG91Z2ggdGhhdCB3
b3VsZCBtYWtlIHNlbnNlIHRvIHJlcHJlc2VudCB0aGUgc2FtZSBpbmZvcm1hdGlvbiANCnRvIGVh
c2UgdGhlIHJlYWRpbmcgbGlrZSBjYXVzZSAtPiBjb25zZXF1ZW5jZS4NCg0KQXMgdGhlIG1lc3Nh
Z2UgaXMgYWJvdXQgdGhlIExVTiBpdHNlbGYsIHdoaWNoIGlzIHJlcG9ydGVkIGZhdWx0eSwgSSAN
CnRob3VnaCBpdCB3b3VsZCB3b3J0aCByZXBvcnRpbmcgdGhlIGluZm8gdGhhdCB3YXkuDQoNClNo
YWxsIEkgY29uc2lkZXIgcHJpbnRpbmcgYWxzbyB0aGUgZGlzayBuYW1lIGluIGFkZGl0aW9uID8N
Cg0KRXJ3YW4sDQoNCg0K
