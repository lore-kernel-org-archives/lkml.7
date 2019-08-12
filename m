Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B793C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C18A20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UbB3ZtYe";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Z+N5feL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfHLJns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:43:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:16752 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbfHLJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:43:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C9gGSs024777;
        Mon, 12 Aug 2019 02:43:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=3/2rOdGdj/3VGkgTwviGs4LGzcfDmoCB1CbOb+ifJy8=;
 b=UbB3ZtYehTYSRJ+hUAxw1gMREL2/fHrf9RRg9CSuEweJXf6/W46pNoTmv2vzfccnrbv0
 KTMBeC+M4ho0vuyJZz+PgUFdu7gcT5Fut3BewTVZBwNtXrleY1J57u3JtxrTpfUiDIde
 0ok83XobOMkJW5Wh7M3jMZXaq/0jeWRUtVC9noNCTa3gBhGFvi8fSZrmRXUBdZZab37q
 XMswkbybXs/saH2D7rTzweMsr8BOCYMu+0En60svih5zJdwH3IlcRzNFiytplU/nxgG4
 5rev4klGywTh8Ad0rUqXExWwVzlNIglaI56sTI2MaKBOuToI8WWzuELkpqQDn+t5ejC4 0w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u9tfs572s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 02:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZfME/XZ/CEJJA1erXEFmN2qsMHJpLWsbcJcw5vPL6wWzplNG194VcsSknLJWmOmRzi+VNXg6FC3OssjexKU4+gmplMQt6p8we1ufyfVtKOdyRjyQe+46jKaCLlJZq7wAl3+HPRvwwRWnTXUUMZGjpkja+SKnD5LmT+InqXfFL8emdr5AmAYE+fitxiXkvbVsQ6kWCIcyBKr4V0f2JKp7y4EzmLmqWn7pqCcYbhqgSg8n2g5Xq0mi8Sym+rZo8uTEjJxJvG7oJz6hHbR42XIWd75L5KqI+5tbi3a3+j+Y2AZ79pp4QW9f4Hjp5Ocp1hezrR+bUqJ4E37zspECYrgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/2rOdGdj/3VGkgTwviGs4LGzcfDmoCB1CbOb+ifJy8=;
 b=QbV5/+R1VSViaCqM2t3EgzmlQUs86KzXLl2NpDEmHjwIbn5nyiSxk97MoyLd88xiSGlAvKCQNVpO+/YDDp5e7ET+5TamjFkNzLS89s3slW159UvmCtXxxSbwa/oPM5PSkHnuqNidu0fM6e6VOUnkc3kwioF4iISB2vhxksSBz2jXs9tHEtun2zh0wNekA1JH2EeXtNgCnuzCSzQrZEeP3j9u+gfCfAHYIWxPjoCv6ZSRNrBxWHPuTIestyE+Gl/3aqWWqSEahBYcW5JaBDBUJajWvcjDW6ocJ+KIJszBE7V6Aogx0ifN22BytnTY4amdN2Gv+5VKqm3Pid79CqrSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/2rOdGdj/3VGkgTwviGs4LGzcfDmoCB1CbOb+ifJy8=;
 b=Z+N5feL+7DBsN4zk4rUqS9eiqc6KUlPedRSVbNa/MPgXkAuEd98l3+EkZsGIs+XNt7XHrakc36UYx+WduWEaHiY4AA1B421SaG9BPQ7rAG9I7hDhPpIhi+GwsESIoVJF1mCF5cSFUpuXFCIDKMb779+o5qYSoDxbFA1v1iSxrB8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4677.namprd07.prod.outlook.com (52.135.204.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 12 Aug 2019 09:43:32 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.022; Mon, 12 Aug 2019
 09:43:32 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVP/LMLOdqGz4qV0qb+zFnj54Ok6bvscSAgAYO39CAAZQggIAAClTA
Date:   Mon, 12 Aug 2019 09:43:31 +0000
Message-ID: <BYAPR07MB4709F306EC472B7AABEB7D4CDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
 <88742d5b-ee10-cf4e-6724-58e7bdd19cb9@ti.com>
 <BYAPR07MB47090BCA728600F0C2F4E129DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
 <1e557bcf-2d50-f600-0e81-1f9fba5499a1@ti.com>
In-Reply-To: <1e557bcf-2d50-f600-0e81-1f9fba5499a1@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctN2U3NGQxZjktYmNlNS0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDdlNzRkMWZhLWJjZTUtMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNjQ3MCIgdD0iMTMyMTAwNzY1NDc3MTY3MTgzIiBoPSIzY1pKRndwVERPUlN4OWRMNksxdGQzTlkxTnM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [158.140.1.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f18e5dc7-2677-48db-22da-08d71f0989b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR07MB4677;
x-ms-traffictypediagnostic: BYAPR07MB4677:
x-microsoft-antispam-prvs: <BYAPR07MB4677932126A4F975FC3892B0DDD30@BYAPR07MB4677.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(199004)(189003)(36092001)(33656002)(6116002)(14454004)(6436002)(54906003)(71200400001)(6506007)(305945005)(99286004)(256004)(5024004)(14444005)(66446008)(53546011)(71190400001)(102836004)(52536014)(66476007)(26005)(64756008)(110136005)(76116006)(8936002)(74316002)(66946007)(25786009)(7696005)(76176011)(4326008)(81156014)(7736002)(81166006)(316002)(66556008)(5660300002)(478600001)(229853002)(3846002)(486006)(11346002)(2906002)(6246003)(8676002)(9686003)(66066001)(55016002)(2501003)(186003)(446003)(86362001)(53936002)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4677;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BoN0DOr71RYp7odXyy4F5C654WVWbn2h0ewxw4oy3QBb/yy1T29lr92Q5MY+dT4HbB5oGVCdm3oSNc4O7XEmQnMutPIr80oRKZhPShMG2XUwT/S8DNv748nEj1XfDUoI+F2vJQZ5jW3cuVeKGEu7NlkrhmwlZylnmpiOUSr98OwhP3qu/rDQKpo9I5y3APsfoX2lULFiwFYWXbBCIbS0CU/aH3t96Rnx3WNgSzFFC7hy5qXiSt0qPJ2BO4xjJ7BSo6EaUYmyIAM9kb/LqbEnK3cF8fG4cjjZdF/k8aDK2PG2U80bl71rUWOtrVeOInTh/0U7Nu6giUhiPFsT38QADhsPgRtOqYaenPsSHyz2DMYcaX3XmeWfGPEg1HCSmYKiQFLcVdQ3gNoXct+MMZicBEE4571AYSV3cy+++NHCIHA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18e5dc7-2677-48db-22da-08d71f0989b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 09:43:31.8795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4677
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4NCj5PbiAxMS8wOC8yMDE5IDE0OjU5LCBQYXdlbCBMYXN6Y3phayB3cm90ZToNCj4+
IEhpLA0KPj4NCj4+Pg0KPj4+IE9uIDIxLzA3LzIwMTkgMjE6MzIsIFBhd2VsIExhc3pjemFrIHdy
b3RlOg0KPj4+PiBUaGlzIHBhdGNoIGludHJvZHVjZSBuZXcgQ2FkZW5jZSBVU0JTUyBEUkQgZHJp
dmVyIHRvIExpbnV4IGtlcm5lbC4NCj4+Pj4NCj4+Pj4gVGhlIENhZGVuY2UgVVNCU1MgRFJEIENv
bnRyb2xsZXIgaXMgYSBoaWdobHkgY29uZmlndXJhYmxlIElQIENvcmUgd2hpY2gNCj4+Pj4gY2Fu
IGJlIGluc3RhbnRpYXRlZCBhcyBEdWFsLVJvbGUgRGV2aWNlIChEUkQpLCBQZXJpcGhlcmFsIE9u
bHkgYW5kDQo+Pj4+IEhvc3QgT25seSAoWEhDSSljb25maWd1cmF0aW9ucy4NCj4+Pj4NCj4+Pj4g
VGhlIGN1cnJlbnQgZHJpdmVyIGhhcyBiZWVuIHZhbGlkYXRlZCB3aXRoIEZQR0EgcGxhdGZvcm0u
IFdlIGhhdmUNCj4+Pj4gc3VwcG9ydCBmb3IgUENJZSBidXMsIHdoaWNoIGlzIHVzZWQgb24gRlBH
QSBwcm90b3R5cGluZy4NCj4+Pj4NCj4+Pj4gVGhlIGhvc3Qgc2lkZSBvZiBVU0JTUy1EUkQgY29u
dHJvbGxlciBpcyBjb21wbGlhbnQgd2l0aCBYSENJDQo+Pj4+IHNwZWNpZmljYXRpb24sIHNvIGl0
IHdvcmtzIHdpdGggc3RhbmRhcmQgWEhDSSBMaW51eCBkcml2ZXIuDQo+Pj4+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+DQo+Pj4+IC0tLQ0K
Pj4+PiAgZHJpdmVycy91c2IvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPj4+PiAg
ZHJpdmVycy91c2IvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgIDIgKw0KPj4+PiAgZHJpdmVy
cy91c2IvY2RuczMvS2NvbmZpZyAgICAgICAgICB8ICAgNDYgKw0KPj4+PiAgZHJpdmVycy91c2Iv
Y2RuczMvTWFrZWZpbGUgICAgICAgICB8ICAgMTcgKw0KPj4+PiAgZHJpdmVycy91c2IvY2RuczMv
Y2RuczMtcGNpLXdyYXAuYyB8ICAyMDMgKysrDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9jb3Jl
LmMgICAgICAgICAgIHwgIDU1NCArKysrKysrDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9jb3Jl
LmggICAgICAgICAgIHwgIDEwOSArKw0KPj4+PiAgZHJpdmVycy91c2IvY2RuczMvZGVidWcuaCAg
ICAgICAgICB8ICAxNzEgKysNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2RlYnVnZnMuYyAgICAg
ICAgfCAgIDg3ICsrDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9kcmQuYyAgICAgICAgICAgIHwg
IDM5MCArKysrKw0KPj4+PiAgZHJpdmVycy91c2IvY2RuczMvZHJkLmggICAgICAgICAgICB8ICAx
NjYgKysNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2VwMC5jICAgICAgICAgICAgfCAgOTE0ICsr
KysrKysrKysrDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQtZXhwb3J0LmggIHwgICAy
OCArDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYyAgICAgICAgIHwgMjMzOCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQu
aCAgICAgICAgIHwgMTMyMSArKysrKysrKysrKysrKysrDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5z
My9ob3N0LWV4cG9ydC5oICAgIHwgICAyOCArDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9ob3N0
LmMgICAgICAgICAgIHwgICA3MSArDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy90cmFjZS5jICAg
ICAgICAgIHwgICAxMSArDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy90cmFjZS5oICAgICAgICAg
IHwgIDQ5MyArKysrKysNCj4+Pj4gIDE5IGZpbGVzIGNoYW5nZWQsIDY5NTEgaW5zZXJ0aW9ucygr
KQ0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL0tjb25maWcNCj4+
Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZQ0KPj4+PiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLXBjaS13cmFwLmMNCj4+
Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4+Pj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmgNCj4+Pj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9kZWJ1Zy5oDQo+Pj4+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy91c2IvY2RuczMvZGVidWdmcy5jDQo+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy91c2IvY2RuczMvZHJkLmMNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3VzYi9jZG5zMy9kcmQuaA0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNi
L2NkbnMzL2VwMC5jDQo+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMv
Z2FkZ2V0LWV4cG9ydC5oDQo+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2Ru
czMvZ2FkZ2V0LmMNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9n
YWRnZXQuaA0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2hvc3Qt
ZXhwb3J0LmgNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9ob3N0
LmMNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy90cmFjZS5jDQo+
Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvdHJhY2UuaA0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvS2NvbmZpZyBiL2RyaXZlcnMvdXNiL0tjb25m
aWcNCj4+Pj4gaW5kZXggZTRiMjc0MTNmNTI4Li5jMmU3ODg4MmY4YzIgMTAwNjQ0DQo+Pj4+IC0t
LSBhL2RyaXZlcnMvdXNiL0tjb25maWcNCj4+Pj4gKysrIGIvZHJpdmVycy91c2IvS2NvbmZpZw0K
Pj4+PiBAQCAtMTEzLDYgKzExMyw4IEBAIHNvdXJjZSAiZHJpdmVycy91c2IvdXNiaXAvS2NvbmZp
ZyINCj4+Pj4NCj4+Pj4gIGVuZGlmDQo+Pj4+DQoNCjxzbmlwPg0KDQo+Pj4+ICsJcmVhbF9yb2xl
ID0gY2RzbjNfcmVhbF9yb2xlX3N3aXRjaF9nZXQoY2Rucy0+ZGV2KTsNCj4+Pj4gKw0KPj4+PiAr
CWN1cnJlbnRfcm9sZSA9IHJvbGU7DQo+Pj4+ICsJZGV2X2RiZyhjZG5zLT5kZXYsICJTd2l0Y2hp
bmcgcm9sZSIpOw0KPj4+PiArDQo+Pj4+ICsJcmV0ID0gY2RuczNfcm9sZV9zdGFydChjZG5zLCBy
ZWFsX3JvbGUpOw0KPj4+PiArCWlmIChyZXQpIHsNCj4+Pj4gKwkJLyogQmFjayB0byBjdXJyZW50
IHJvbGUgKi8NCj4+Pj4gKwkJZGV2X2VycihjZG5zLT5kZXYsICJzZXQgJWQgaGFzIGZhaWxlZCwg
YmFjayB0byAlZFxuIiwNCj4+Pj4gKwkJCXJvbGUsIGN1cnJlbnRfcm9sZSk7DQo+Pj4+ICsJCXJl
dCA9IGNkbnMzX3JvbGVfc3RhcnQoY2RucywgY3VycmVudF9yb2xlKTsNCj4+Pj4gKwkJaWYgKHJl
dCkNCj4+Pj4gKwkJCWRldl9lcnIoY2Rucy0+ZGV2LCAiYmFjayB0byAlZCBmYWlsZWQgdG9vXG4i
LA0KPj4+PiArCQkJCWN1cnJlbnRfcm9sZSk7DQo+Pj4+ICsJfQ0KPj4+PiArZXhpdDoNCj4+Pj4g
KwlwbV9ydW50aW1lX3B1dF9zeW5jKGNkbnMtPmRldik7DQo+Pj4+ICsJcmV0dXJuIHJldDsNCj4+
Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCB1c2Jfcm9sZV9zd2l0Y2hf
ZGVzYyBjZG5zM19zd2l0Y2hfZGVzYyA9IHsNCj4+Pj4gKwkuc2V0ID0gY2RuczNfcm9sZV9zd2l0
Y2hfc2V0LA0KPj4+PiArCS5nZXQgPSBjZHNuM19yZWFsX3JvbGVfc3dpdGNoX2dldCwNCj4+Pj4g
KwkuYWxsb3dfdXNlcnNwYWNlX2NvbnRyb2wgPSB0cnVlLA0KPj4+DQo+Pj4gaG93IGRvZXMgdXNl
ciBpbml0aWF0ZWQgY2RuczNfcm9sZV9zd2l0Y2hfc2V0KCkgdmlhIHN5c2ZzIGNvLWV4aXN0IHdp
dGggcm9sZQ0KPj4+IGNoYW5nZXMgZG9uZSBieSBoYXJkd2FyZSBldmVudHMuIGUuZy4gSUQvVkJV
Uz8NCj4+Pg0KPj4NCj4+IERvIHlvdSBleHBlY3QgYW55IGlzc3VlcyB3aGl0IHRoaXMsICBoYXZl
IHlvdSBzZWVuIGFueSBwcm9ibGVtIHdpdGggdGhpcw0KPj4gb24geW91ciAgcGxhdGZvcm0gPw0K
Pj4NCj4+IEkgYXNzdW1lIHRoYXQgaXQgc2hvdWxkIHdvcmsgaW4gdGhpcyB3YXk6DQo+PiAxLiB1
c2VyIGNoYW5nZSByb2xlIGJ5IHN5c2ZzDQo+PiAyLiBEcml2ZXIgY2hhbmdlIHRoZSByb2xlIGFj
Y29yZGluZyB3aXRoIHVzZXIgcmVxdWVzdC4NCj4+IDMuIElmIHdlIHJlY2VpdmUgY29ycmVjdCBJ
RC9WQlVTIHRoZW4gcm9sZSBzaG91bGQgbm90IGJlIGNoYW5nZWQNCj4+ICAgICBiZWNhdXNlIG5l
dyByb2xlIGlzIHRoZSBzYW1lIGFzIGN1cnJlbnQgc2V0IGluIHBvaW50IDIuDQo+Pg0KPg0KPkkg
aGF2ZSBub3QgdGVzdGVkIHRoaXMgc2VyaWVzIHlldC4NCj5NeSB1bmRlcnN0YW5kaW5nIGlzIHRo
YXQgaWYgdXNlciBzZXRzIHJvbGUgdG8gImhvc3QiIG9yICJkZXZpY2UiIHRoZW4gaXQgc2hvdWxk
DQo+cmVtYWluIGluIHRoYXQgcm9sZSBpcnJlc3BlY3RpdmUgb2YgSUQvVkJVUy4gT25jZSB1c2Vy
IHNldHMgaXQgdG8gIm5vbmUiIHRoZW4NCj5wb3J0IHNob3VsZCBzZXQgcm9sZSBiYXNlZCBvbiBJ
RC9WQlVTLg0KDQpBY2NvcmRpbmcgd2l0aCB5b3VyIHVuZGVyc3RhbmRpbmcgaXQgd29ya3MgdGhl
IHNhbWUgd2F5IGFzIGJ5IGRlYnVnZnMuIA0KTm93IEkgaGF2ZSBubyBkb3VidHMgdG8gcmVtb3Zl
IGRlYnVnZnMuYyBmaWxlIDopDQoNCj4NCj4+DQo+Pj4+ICt9Ow0KPj4+PiArDQo+Pj4+ICsvKioN
Cj4+Pj4gKyAqIGNkbnMzX3Byb2JlIC0gcHJvYmUgZm9yIGNkbnMzIGNvcmUgZGV2aWNlDQo+Pj4+
ICsgKiBAcGRldjogUG9pbnRlciB0byBjZG5zMyBjb3JlIHBsYXRmb3JtIGRldmljZQ0KPj4+PiAr
ICoNCj4+Pj4gKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG90aGVyd2lzZSBuZWdhdGl2ZSBlcnJu
bw0KPj4+PiArICovDQo+Pj4+ICtzdGF0aWMgaW50IGNkbnMzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQoNCjxzbmlwPg0KDQo+Pj4+ICsgKiBSZXR1cm5zIDAgb24gc3VjY2Vz
cyBvdGhlcndpc2UgbmVnYXRpdmUgZXJybm8NCj4+Pj4gKyAqLw0KPj4+PiAraW50IGNkbnMzX2Ry
ZF91cGRhdGVfbW9kZShzdHJ1Y3QgY2RuczMgKmNkbnMpDQo+Pj4+ICt7DQo+Pj4+ICsJaW50IHJl
dCA9IDA7DQo+Pj4+ICsNCj4+Pj4gKwlpZiAoY2Rucy0+ZGVzaXJlZF9kcl9tb2RlID09IGNkbnMt
PmN1cnJlbnRfZHJfbW9kZSkNCj4+Pj4gKwkJcmV0dXJuIHJldDsNCj4+Pj4gKw0KPj4+PiArCXN3
aXRjaCAoY2Rucy0+ZGVzaXJlZF9kcl9tb2RlKSB7DQo+Pj4+ICsJY2FzZSBVU0JfRFJfTU9ERV9Q
RVJJUEhFUkFMOg0KPj4+PiArCQlyZXQgPSBjZG5zM19zZXRfbW9kZShjZG5zLCBVU0JfRFJfTU9E
RV9QRVJJUEhFUkFMKTsNCj4+Pj4gKwkJYnJlYWs7DQo+Pj4+ICsJY2FzZSBVU0JfRFJfTU9ERV9I
T1NUOg0KPj4+PiArCQlyZXQgPSBjZG5zM19zZXRfbW9kZShjZG5zLCBVU0JfRFJfTU9ERV9IT1NU
KTsNCj4+Pj4gKwkJYnJlYWs7DQo+Pj4+ICsJY2FzZSBVU0JfRFJfTU9ERV9PVEc6DQo+Pj4+ICsJ
CXJldCA9IGNkbnMzX2luaXRfb3RnX21vZGUoY2Rucyk7DQo+Pj4+ICsJCWJyZWFrOw0KPj4+PiAr
CWRlZmF1bHQ6DQo+Pj4+ICsJCWRldl9lcnIoY2Rucy0+ZGV2LCAiVW5zdXBwb3J0ZWQgbW9kZSBv
ZiBvcGVyYXRpb24gJWRcbiIsDQo+Pj4+ICsJCQljZG5zLT5kcl9tb2RlKTsNCj4+Pj4gKwkJcmV0
dXJuIC1FSU5WQUw7DQo+Pj4+ICsJfQ0KPj4+PiArDQo+Pj4+ICsJcmV0dXJuIHJldDsNCj4+Pj4g
K30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIGlycXJldHVybl90IGNkbnMzX2RyZF90aHJlYWRfaXJx
KGludCBpcnEsIHZvaWQgKmRhdGEpDQo+Pj4+ICt7DQo+Pj4+ICsJc3RydWN0IGNkbnMzICpjZG5z
ID0gZGF0YTsNCj4+Pj4gKw0KPj4+PiArCXVzYl9yb2xlX3N3aXRjaF9zZXRfcm9sZShjZG5zLT5y
b2xlX3N3LCBjZG5zLT5yb2xlKTsNCj4+Pg0KPj4+IEhvdyB0byBlbnN1cmUgdGhhdCBIVyBldmVu
dHMgZG9uJ3Qgc3RlcCBvdmVyIHVzZXIgY2hvc2VuIHJvbGU/DQo+Pg0KPj4gSSBuZWVkIHRvIHRo
aW5rIGFib3V0IHRoaXMgYW5kIGZpbmQgb3V0IGhvdyB0byB0ZXN0IGl0IGFuZCBldmVudHVhbGx5
IGZvcmNlDQo+PiBzdWNoIGNhc2VzLg0KPj4NCj4+IEJ1dCBJIGFzc3VtZSB0aGF0IGFmdGVyIGF0
dGFjaGluZy9kZXRhY2hpbmcgcGx1ZyB0aGUgdXNlciBjaG9zZW4gcm9sZSBjYW4NCj4+IGJlIGZv
cmdvdHRlbi4NCj4+DQo+DQo+Tm8uIE9ubHkgd2hlbiB1c2VyIHNldHMgcm9sZSB0byBub25lIHRo
ZW4gcm9sZSBzaG91bGQgYmUgYmFzZWQgb24gSFcuDQoNCk9rLCBJIHdpbGwgdHJ5IHRvIHRlc3Qg
aXQgaW4gbmV4dCB3ZWVrLg0KDQo+Pj4NCj4NCj48c25pcD4NCg0KQ2hlZXJzLA0KUGF3ZWxsDQo=
