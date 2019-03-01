Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A521A20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="XHh1jrhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbfCAPAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:00:10 -0500
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:49224 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727492AbfCAPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:00:09 -0500
Received: from pps.filterd (m0111312.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21EtTjf018636;
        Fri, 1 Mar 2019 15:59:56 +0100
Received: from eur02-ve1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2052.outbound.protection.outlook.com [104.47.6.52])
        by mx08-00287e01.pphosted.com with ESMTP id 2qtx4bxtkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Mar 2019 15:59:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myYBIk7VADvFi7QSVYgBolJLULfzoB1i/FhXinElTkQ=;
 b=XHh1jrhcdFz515/nrPlq1jZzgjt/uqRcy8RwUmRdWS/iRF//QniImfJCzkcX0WbdJnesFBoJIP6ElXTqEIspS3V3u3C396ZdlCm2QWzGrkxFFt6HcC5f/QLZndoI463Ok63meGe0Xj6pruNYC6EcG6uCLQN6+k3SIsrGOPHAaVM=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB4847.eurprd04.prod.outlook.com (20.177.49.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 14:59:54 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec%3]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 14:59:54 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
        Erwan Velu <erwanaliasr1@gmail.com>
CC:     Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <esc.storagedev@microsemi.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Topic: [PATCH] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Index: AQHUzrnze9rjAoGyP0WDHT7LWV0vu6X1o9kAgAE9iwA=
Date:   Fri, 1 Mar 2019 14:59:54 +0000
Message-ID: <2c6679d1-9492-6cfe-00ef-8f2308e67643@criteo.com>
References: <20190227163133.26283-1-e.velu@criteo.com>
 <AT5PR8401MB11696B5DDB2DA774A0E584F4AB750@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <AT5PR8401MB11696B5DDB2DA774A0E584F4AB750@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0442.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::22) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10309a03-1fb7-453b-3f8e-08d69e569008
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4847;
x-ms-traffictypediagnostic: VI1PR04MB4847:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0ODQ3OzIzOkJUZG1BVmg1Yy9VcThuWkRwQ25TMHR0NElJ?=
 =?utf-8?B?Q2I3L2luY2RFRWtOQWtSblI3c1RRUC9aYWdsb2lPNTdXOFphWlRJQnRFRVRS?=
 =?utf-8?B?VEEzUzZaZlc3Y0txdlBWVDVWRTV2M2xlSGpyK2ZnNFBHVFFheC9rMjIyeWFR?=
 =?utf-8?B?TXdiQzZ1NkxQdXNJNjFSQ2lhZUZVYTFtdHVxOERlYzQ1ODFUM0JMcldnSmsz?=
 =?utf-8?B?NXY3clFpV0xzdWc5YzdVMmoyYnZFTis1dktZMlo0UjE3bTdnUmVYL2dmbmRw?=
 =?utf-8?B?Sk9FY3VGOXVjRXJTbTlONDZmendSNFpSNE1mL0ZrWkNRdG9pd043K1hnSmRJ?=
 =?utf-8?B?bXdqMkhOVWEvNFVERHNxWUhRRlVHcWJ5WGp0bkdpbUgrajBwUXlDMTBQdE80?=
 =?utf-8?B?SEIyMk9Mcy9DMEc1dHNuT0dkUWxoZk9CcjZraVBSTmFuNFduVTlWZE40VTR6?=
 =?utf-8?B?MU1hMk1MdkFraUZwcTdGTTBveVJPVlJaOWx2Mis4UERDQlVaVVZydGVkU0JR?=
 =?utf-8?B?T0ZKS0VPbDROb2tFRjkxNVFGYWgrUUpneWhMVFNJV213QmIyLzNXWEtYMGJz?=
 =?utf-8?B?alE4c0lCTWxOdlJPaTNUQjhreHdYTkcrSlFXcHYxbG54OVZhSUNidEJKTzRB?=
 =?utf-8?B?aGsybmlCVjBnY2VOY1ZpZ0FWMzVuS1VnQnlIYjE4eXFoL3EwdHlvRXNzMTYw?=
 =?utf-8?B?a1FtTVdkdEFjUFhGcDg1NmdPbEg5MEUxNnZkaXBPRzRTVEplRVRWb1BmQUds?=
 =?utf-8?B?WDF1cVFNZ1k4Q0Q4SWt1N1VVU2p3WXlsRXlpOTFVWFJmN0xad2duL3NlZEhk?=
 =?utf-8?B?b2lKbVhHWi9YMWNTclB6WGxEUVFNTDdDVHk1eHFTRjZCSW56VTE2MTR5bTFy?=
 =?utf-8?B?R2VEdnNIbGhWMW9FVVF3TjdUcG5sVXQrUmh5SWdxbzZ3MnlsNWNTT0wvdjh3?=
 =?utf-8?B?dXFlU3ovUnN1WkRYdU5mUGhSWDhYeUxkSGUyMFl2YmtnUHY4cUQ3eDk4ejJU?=
 =?utf-8?B?UE5yUkY5LzRFY0NQSUQzTzluZmxNMFdqdVJhRFVKNG5TM2o2OFpJTFpjdkNa?=
 =?utf-8?B?ZlFuQzJSamZmK2RPMmo5d3dCRTJ2bXp2ZEhDU094UlI5RFpjdWFYd3VyY3pz?=
 =?utf-8?B?S1pIVjhiZDM3dnU3d3M1RjZUSkc2Q0laKzlrYlFmc0xER1c3WDFRTGI3SUkw?=
 =?utf-8?B?RWpJbEdCRk5EbUk4aFQzcUE1N0NnYUc1MFpKN0lvSFNieTJPeWVVWFhRQmZZ?=
 =?utf-8?B?N2VPY3hUQmdIVndrSlI0eHp1bkRwdUNLMU94Yi9JY0hmVi9VUExBdmszVDFS?=
 =?utf-8?B?T01ad1licmNQdXA4QkV6NVFiS1AxVGJGWjRpVnRFUXZzSjJjV0FLcW5pT0Z1?=
 =?utf-8?B?blRPL0VGMms3RHJkRFpyZ0lzeHlPbFdDbnJXcG91Q1VmR3hpRGNreWJLUUVv?=
 =?utf-8?B?S3hWT0llSVJ2NFQ3dDlUUkpicGFmbU9id09QbjE5a212aWtCS1FXRjhVbW8x?=
 =?utf-8?B?ZDJXZGdNQmZlRXJpbW1NZ3VOVjByM2J2dWxlK1c4MFUzK1M2c2dzUVdpSkRj?=
 =?utf-8?B?WkNWcmt5dnZvbXBlaUtOV0RiVFI1TFVhV3NxUEVpZGh6WjNGdzFBMjBNNktQ?=
 =?utf-8?B?VEV2am95eldLYTh6YWNiOFVLYkEwK2VCOEZKMnVhbmNpZTFwRlNHbXlDUk84?=
 =?utf-8?B?eHFpZEpJYlBzakE4TkJTNTN1UHhtNWlVVzRrdjZ6RGFhbkgzWHNVV3djR1Rq?=
 =?utf-8?B?T2xJVVIvV3haaXFzVngydz09?=
x-microsoft-antispam-prvs: <VI1PR04MB484742247265A980F4CF4455F2760@VI1PR04MB4847.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(51914003)(256004)(36756003)(106356001)(105586002)(31696002)(86362001)(5660300002)(4744005)(6436002)(3846002)(6116002)(97736004)(2906002)(31686004)(53936002)(6512007)(71200400001)(229853002)(71190400001)(6486002)(102836004)(316002)(26005)(76176011)(68736007)(25786009)(11346002)(52116002)(478600001)(14454004)(6506007)(386003)(186003)(110136005)(99286004)(8936002)(6246003)(446003)(4326008)(8676002)(81156014)(81166006)(66066001)(486006)(305945005)(2616005)(476003)(7736002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4847;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +RrJpKAQIQ/7G2v+JQtLGRkDH47rW1czIiBbPOKc72xvapJUCzDV1bNIi5AjOdizuGvczqcLP7cskiDy0PS/O8Yf3eSHq+sBpRqOgFX9cgR96X085yI4gBlRavBxG0rJqF9Jn8swqf9h5u6eyRjKSLlIOWX8aSx1G8cE5VkNTM9LpcpgxW6nGAWgT/OKw7bCHew8kt4w6tM2FR/63Grxjihd9Fba8l/mccVsWIiv/ruK+3Egs5kwcpyDtKSpMFlEZDN+i160aq87jpwDguLNQncaXdV7EOlKDoppmksiQmLEKfZcSHf/NEQ09n+4xVDMRPAEFnUbEsfEqKzzZ73TMMpo+57BPdP4UZUByFvnkrg1yOLgtu6uAWIHTBydoB6KouLNXKnII3q0wRmUkyd55rSNMDr23NCN81GeZY/PuJw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14219CE35EC50241AF2C6C13224BF3F7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10309a03-1fb7-453b-3f8e-08d69e569008
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 14:59:54.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCj4gQmUgY2FyZWZ1bCBwcmludGluZyBlcnJvcnMgcGVyLUlPOyB5b3UgY291bGQgZ2V0
IHRob3VzYW5kcyBvZiB0aGVtIGlmIHRoaW5ncyBnbyBiYWQuDQo+IFRoZSBibG9jayBsYXllciBw
cmludF9yZXFfZXJyb3IoKSB1c2VzIHByaW50a19yYXRlbGltaXRlZChLRVJOX0VSUikgZm9yIHRo
YXQgcmVhc29uLA0KPiBhbmQgdGhlIFNDU0kgbGF5ZXIgc2NzaV9pb19jb21wbGV0aW9uX2FjdGlv
bigpIG1haW50YWlucyBhIHJhdGVsaW1pdCBvbiBpdHMgb3duLg0KPg0KPiBUaGUgZGV2X2Vycl9y
YXRlbGltaXRlZCgpIG1hY3JvIG1pZ2h0IGJlIGEgZ29vZCBmaXQgaGVyZS4NCg0KVGhhbmtzIGZv
ciB0aGUgdGlwLiBJIHVwZGF0ZWQgdGhlIHBhdGNoIGFuZCBzZW5kIGEgVjIgZm9yIHRoYXQuDQoN
CkkgYWRqdXN0ZWQgYWxzbyB0byBjb21taXQgbWVzc2FnZSB0byBtYWtlIGl0IG1vcmUgZXhwbGlj
aXQuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KRXJ3YW4sDQoNCg==
