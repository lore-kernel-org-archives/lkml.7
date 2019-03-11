Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD96205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="SqeQtkyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfCKQgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:36:50 -0400
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:30536 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbfCKQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:36:50 -0400
Received: from pps.filterd (m0111314.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BGYwKR021774;
        Mon, 11 Mar 2019 17:36:38 +0100
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59])
        by mx08-00287e01.pphosted.com with ESMTP id 2r44kfsyqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 17:36:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFAxOtIKwKrk5RRjUrNOwGI8YqeFMwFQsm0gkky66CA=;
 b=SqeQtkyvpmij0wSlwje6htYrkDBoCB09kER9MDdDlf6ehRfrRwC6Vts4otmmN85KmunCOIf9i2BXh6cPazrwh+WwPCbBRtKS9bXwXpkN7Nscqi3WR4VYICKLHa3FhB8JvvWGqygXYoLw9cX6QwlHm4qj3qJyKg2ZZiEvb353sPg=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB4384.eurprd04.prod.outlook.com (20.177.55.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Mon, 11 Mar 2019 16:36:36 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:36:36 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Erwan Velu <erwanaliasr1@gmail.com>
CC:     Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "esc.storagedev@microsemi.com" <esc.storagedev@microsemi.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Topic: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Index: AQHU0Ej71hFBJ8QqukmW6H53WkBkdaX+5ShZgAfLa4A=
Date:   Mon, 11 Mar 2019 16:36:36 +0000
Message-ID: <8ce82168-0108-1a9d-1fbb-471b6da0200d@criteo.com>
References: <1551455797.3334.6.camel@linux.ibm.com>
 <20190301160806.16099-1-e.velu@criteo.com> <yq1y35rzz31.fsf@oracle.com>
In-Reply-To: <yq1y35rzz31.fsf@oracle.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [71.6.57.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4204ed5b-9c0e-477e-7499-08d6a63fba34
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4384;
x-ms-traffictypediagnostic: VI1PR04MB4384:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0Mzg0OzIzOmdIaVdJWUtreUFzSU5QTHJkUENOREk3OU5n?=
 =?utf-8?B?K1VLa0pVbUFEUVFqcm1LdjZNSU5haE1vWVY1V3B3VlpSd1MwRGNRbXBhL3NB?=
 =?utf-8?B?UVhvVm13YXBBcDBCWWZTVTVOc3duUTdiVXBEOThpUU5zdS9lRkd5ZEdzRWRn?=
 =?utf-8?B?aUJuc1phSVA3cVA3VUt3NVlXZE1DQktUL28zSGNKWVdVdHkrbzlqWXR5dktS?=
 =?utf-8?B?Q21vUkhUNjZCY0h3QTVRU2dOeVVKQVh2bVpITnhFUTRwZWhDaDFVNXFvU3dn?=
 =?utf-8?B?bCt3dTNaSjcwN2dZbk14VjhQY08ybnNCTVFWemVBdnJmcVgxaFI5TlRLak5u?=
 =?utf-8?B?U3J0WW1sZXlTMkpGRmJFSUxscmI1aVVIb01sa29CZUdyYVUrOHRaTGpZaHQ1?=
 =?utf-8?B?NVhoM0JlaWpDV2N5U0VVODY1WTF4RzQwWTFzQUk1RWVVWHEzUXc4ZDJ0ZjZ6?=
 =?utf-8?B?S2V1M1lPelp5emtGR2RURlNtUmVvRVh5dlhudzZUdjFwWExLTzc4YmJNMENj?=
 =?utf-8?B?N2pQNGkyNXE4cXg1T0pHTlVzaUh3ZVcrWTRiYnJ1a0tFODBzMU9SVytLcDhm?=
 =?utf-8?B?UllJbVdBWDZyKzZkVDRxbWxOTTA3VVhaZnhVVGhhN1ZqZUdPTjFIRjBPL1ov?=
 =?utf-8?B?VTBFRHRMRzhkUlpVMXVKV2VmUFYwbW95UFVrQmJUckI0dmZ5ajd5L0lhYkFo?=
 =?utf-8?B?QXhVQzFoeng0TXFMY3ZTbFpLOCt0Q0hIaHQzSmRndXozS0MvcUJDRUdoZHps?=
 =?utf-8?B?RFVPaEgzdHh1YnE2YlVLU0NBWElyRmtjQ0VodVdhaktrVE9CeW9SMHMyL05P?=
 =?utf-8?B?WnhBVFNQNkZXdEtCSWJOZ21wNFFhdzdIWFA4K3d2WUo4L2hEb1dnaGgzckRU?=
 =?utf-8?B?c3FwSElNSnVaSmRZZEZDQlNVdkVZeUJDc0RLUHdFcVJqdG8yc2JJSWlLMHVO?=
 =?utf-8?B?VVdrZ2VDMitzQUZxQWdCRmxnNW5iRzFwT0xwVXQ4ZUNyejYwNjYvM09KV1k0?=
 =?utf-8?B?OGY5bk9yYlgrbzZsNUl5STJQOHBvLzFQQWFKcXBpWjRZdUJpZmQvZXl2Umpm?=
 =?utf-8?B?UjBmSlVCQlY2WEN2TEp5c3QyMlBWdzNBN3lpQndQMUlHTmRTSE45RENpNWtZ?=
 =?utf-8?B?bXVoT2EvcHg5YzF2MWZOZVVVaXNqQW8rUGYzQ3VQRmJoY0tDejZDUE8rTGpp?=
 =?utf-8?B?amsyYjhKTkVKNzF3TU1vZVRMK1BwWnZXMWJIWFBJREp6ZE9ITjlHaXAxSXNM?=
 =?utf-8?B?ZjlRcHNkV1dRQ1RVQ2IxUk02cXphYjJIZUdzVGFjdzNaWFZvU1ZPOGtFaG5V?=
 =?utf-8?B?U0FMY3l2OTdzTFRPZ0pMK1N0K0NLSG9wT2xnb0owd0UwRGx6akpCb1J5ck5M?=
 =?utf-8?B?bjNQNU9pN25RcS9zcmZTSU9JV1pVbXRqakF0dEs2S0NkVENqQlh6S3VsR2t1?=
 =?utf-8?B?SVduQlI1MmNRak8yS3VBdXNwektQQTFaL2F1Wldxcm5Wbjg5NXorMUQwSm1J?=
 =?utf-8?B?VzY5bU14MFVhMXcwWGl5US93NlUzMStMUUs3YTkzcldCSFAxemtPdjhtTmNJ?=
 =?utf-8?B?VkxsZWNmMFY4TExoNzFtOXFmeWNaQThMT2hSakhDbjJwcHl5bW5Wc0NXS2RW?=
 =?utf-8?B?L3hNNldXbERQUTlYQ2xmRk9yNTMvbkFjd1JuRjN6YUh3WENuNlBxT3htRzVw?=
 =?utf-8?Q?OiMqnK3lIhAgNXSRU39TXhjo4D/QD0DiUSAO4NM?=
x-microsoft-antispam-prvs: <VI1PR04MB4384547C07E886674D677372F2480@VI1PR04MB4384.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(6506007)(316002)(54906003)(110136005)(31686004)(446003)(6246003)(2616005)(11346002)(476003)(2906002)(6512007)(105586002)(106356001)(99286004)(86362001)(25786009)(53936002)(386003)(3846002)(6116002)(31696002)(97736004)(102836004)(36756003)(256004)(71190400001)(71200400001)(5660300002)(81166006)(81156014)(66066001)(8936002)(68736007)(14454004)(6486002)(486006)(229853002)(4326008)(52116002)(8676002)(7736002)(305945005)(76176011)(478600001)(4744005)(26005)(186003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4384;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wr5jy7smavTTQWdDMWGKL+gaRnkwGARAFhS7xXYpbCKM6H0nCPBXeot3uVSpojuGXk8vvH1eivp1N7XHFbvHuWRV6wdpZTTqRwngnvhkr2CoLRPnhCCTEwCMsZ5IWImvtKzIP69H51I0i9kQlkvLZCsYR+Imxwx2btYIEwF14Yh59qYSAA3RH1cE3OuOc+91t8Uzh2r2eoyoC0htv76R6pc/W3yAmtLbub0kvUakPGFrhurmOC2jSsJ3MAHs3fKgrlhvQNzl6dQiNbt2OqPshnF6PoxM8T8A64IR74JeftEmJyckRLhrvOjBIpvzc0gqIBWu7+YJeMdVhPk6nebUw9izWRXbelrG16syQ6zxDN7xWvcVMSDYc9dzJTqwqA3a/iqrDL1cZv8sUUxEuKvLutaITIhPF1zNPCHTdcw230k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <734C1720F0E7C244B53232326B87896D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4204ed5b-9c0e-477e-7499-08d6a63fba34
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:36:36.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAwNi8wMy8yMDE5IMOgIDE4OjM0LCBNYXJ0aW4gSy4gUGV0ZXJzZW4gYSDDqWNyaXTCoDoN
Cj4gRXJ3YW4sDQo+DQo+PiBXaGVuIHRoZSBIQVJEV0FSRV9FUlJPUi8weDNlLzB4MSBjYXNlIGlz
IHRyaWdnZXJlZCwgdGhlIGxvZ2ljYWwgdm9sdW1lDQo+PiBpcyBvZmZsaW5lZC4gIFdoZW4gcmVh
ZGluZyB0aGUga2VybmVsIGxvZywgdGhlIHJlYXNvbiB3aHkgdGhlIGRldmljZQ0KPj4gZ290IG9m
ZmxpbmVkIGlzbid0IHJlcG9ydGVkIHRvIHRoZSB1c2VyLiAgVGhpcyBzaXR1YXRpb24gbWFrZXMN
Cj4+IGRpZmZpY3VsdCBmb3IgYWRtaW5zIHRvIGVzdGltYXRlIHRoZSByb290IGNhdXNlIG9mIHRo
ZSBpc3N1ZSB0aGV5DQo+PiBhbmFsaXplLg0KPiBBcHBsaWVkIHRvIDUuMS9zY3NpLXF1ZXVlLCB0
aGFua3MuDQo+DQpUaGFua3MgTWFydGluICENCg==
