Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C85C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5FF20679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="BCcj9zef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKGDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:03:19 -0500
Received: from mail-eopbgr80098.outbound.protection.outlook.com ([40.107.8.98]:10694
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfKKGDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:03:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS0G4pu50xDTO9m0rh8/x5RyNQvd8H2WOr7nj6H/GIGX6aYlJzSCXSPUKBpY5uvOUuBreYaRg20vKhNYmSU6dpsI4/C4GoKAoLpkpRLqsv/N64RGST9csX1+dhuqbb7KXw0/6QJrG1ttndcOzABIVqqMPaDfUOLirRU2Dfbit7f3p82IUqx+NC2XLys9LUbIdAxf7Tx08K8IL0iF/FoWSmhyqmM9MXtbRcRPUJnD9fx/OAE8Qn1RDyI+lrPH0Sb+Pv12xgllPManDhWrYVEpG0MiFD0qlJnnN3DXyORsmB9KiIMvpzfFfahoyrVVBU9nfMquL78GSW+Hl64Fx2gP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Oc5+g5bUvICKCEU1iJ3KIC5pL91lYYSjVAfV4ms5lw=;
 b=NpDGhVghyViQfZ4DeyQcD7TGwNYSVOuqcGAg68PJ+4RptGuEWg3vRV8Dd85Uhb3vXZR5clGeRbnAAaqN5emecAf0fXL46rYD/h0SKFWno6f6LIc0eHox+ZvF3p1Ai5FTnOeY+jy3TOwG2V4YlJUPg2Dbx+Cjl8aTTeMzpKHG76L/ATF2SL3qUcRw+4kOMOoyEhPhS3vmu5xCSikKejg3HsLQ1IfpArSaPkRZMV/yrACfa6U1Bkbx/VhKAavD5iT3V7D7J+4HLofWyOGIhxF1hUPBXS8csVQGc+sfttHiSCrIjPyzbVA64g1evCRc8qer61z8u++oq2vVrwhYDNPvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Oc5+g5bUvICKCEU1iJ3KIC5pL91lYYSjVAfV4ms5lw=;
 b=BCcj9zefEKezwkal2ajRi9VkqTmSuGQwKN7DVhD0P2YLEo4t7CzNuJznomynCmDtSi+1Ov4yy5HvsK44Nxp3KQxDPYrJyu9QTsnFF+/w5/+SjEUEQhZP3hLpA2XFkqx0XxtLrv4fd07LkDMBvhTwlyfxXioYR1TlQleeq68+Su4=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3381.eurprd02.prod.outlook.com (52.133.28.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 06:03:15 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 06:03:15 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 4/6] habanalabs: increase max jobs number to 512
Thread-Topic: [PATCH 4/6] habanalabs: increase max jobs number to 512
Thread-Index: AQHVmBGX9nbjFJHkIkmsLHj+/r6XeaeFe2AA
Date:   Mon, 11 Nov 2019 06:03:15 +0000
Message-ID: <AM6PR0202MB338239BB13CB3245480B1CA4B8740@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
 <20191110215533.754-4-oded.gabbay@gmail.com>
In-Reply-To: <20191110215533.754-4-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.8.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92818d94-9ba2-4a8d-e6c6-08d7666cd772
x-ms-traffictypediagnostic: AM6PR0202MB3381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB3381A1DC51F147A9A52C43F8B8740@AM6PR0202MB3381.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39840400004)(376002)(366004)(199004)(189003)(476003)(9686003)(74316002)(26005)(7736002)(6246003)(478600001)(486006)(66066001)(81166006)(81156014)(4744005)(305945005)(55016002)(6636002)(14454004)(8676002)(4326008)(8936002)(25786009)(52536014)(86362001)(76116006)(66446008)(64756008)(446003)(6116002)(6436002)(66556008)(66476007)(3846002)(11346002)(256004)(66946007)(186003)(110136005)(71200400001)(71190400001)(5660300002)(229853002)(2906002)(6506007)(316002)(102836004)(33656002)(99286004)(2501003)(7696005)(76176011)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3381;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlbVTkUvPmDEKB6QYXGbHjMmidrxGKvjtLYfhSqRpwemYRFwtK7Of7Ht1zZRoR5G9V18aoXE/TT+e/6z05S1bZBbu8ZtyC8lOjSADsEmtqBrNTyyVJW7DWotjvxbDQv1dhfhh8hDO0uBL0S2aLTrqNLgdw2nW6JubayFCFJ+rpg1c0VbPX7YyLghNyPXoCxFUg5ARQVa7ptMfYHJDL1bpYHg9e0zxbe4ADbVIYypJlDq4Yn6HCi3E9nwEAvhFth205BDZ0apSEqwD6gFN2RdLiEYxiM4i8BskN3eOBT9FKgheVhGIHJtgNaquAVJJKK2wm4qg/G0AriQTuCy7InoEhQ8J1tvPTfX978mnfCg6U0SfE9X8qM+CUd3ZhQSqKF36nibVeHof6nj7wagFYIVKtHYvKuC6MFSCudRuRlDZkUJUSKT4Q2G8Z2mUrfZzH3B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 92818d94-9ba2-4a8d-e6c6-08d7666cd772
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 06:03:15.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygRVKdgn7yzvujiSBG0FKWZAN71y+pG3ykFm3OOltdhJulS17SY+TK4Yr+weaGJ+Z3KCNFr5FP5nk8tpl/0EkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBOb3YgMTAsIDIwMTkgYXQgMTE6NTYgUE0gT2RlZCBHYWJiYXkgd3JvdGU6DQo+IElu
IHRyYWluaW5nLCB0aGVyZSBpcyBhIG5lZWQgZm9yIGEgbGFyZ2UgYW1vdW50IG9mIHBhdGNoaW5n
IHRvIHRoZSByZWNpcGUuDQo+IFRoaXMgcmVzdWx0cyBpbiBtYW55IGNvbW1hbmQgYnVmZmVycyBj
b250YWlucyBhIGxvdCBvZiBETUEgcGFja2V0cy4gVGhlDQo+IG51bWJlciBvZiBjb21tYW5kIGJ1
ZmZlcnMgcGVyIENTIGlzIGxhcmdlciB0aGFuIHRoZSBjdXJyZW50IG1heGltdW0gb2YNCj4gNjQs
IHdoaWNoIGlzIGFuIGFyYml0cmFyeSBudW1iZXIgdGhhdCBpcyBlbm91Z2ggZm9yIGluZmVyZW5j
ZSwgYnV0IGl0IGhhcyBubw0KPiByZWFsIGFmZmVjdCBvbiB0aGUgY29kZSBhbmQvb3IgcmVzb3Vy
Y2VzIG9mIHRoZSBob3N0IG1hY2hpbmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPZGVkIEdhYmJh
eSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogT21lciBTaHBpZ2VsbWFu
IDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+DQo=
