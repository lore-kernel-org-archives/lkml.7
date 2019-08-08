Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DDCC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4357A2186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VAO1wqru";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Uc3TlNv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfHHEMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 00:12:42 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31786 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbfHHEMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 00:12:41 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7848ucY019609;
        Wed, 7 Aug 2019 21:12:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=L3gs/j4Jcpv1HZNzpGwBQS5sQR1epb7EIU2kQBQ1Gvw=;
 b=VAO1wqruEeOz7EBwyOsFEngsss7Tqcvl1MkWTm4cHiMTjBpNMjm+ver+VnbSqZ175C5/
 vH921GfH+uXqXMDb6IWhw4+Tt5oHygcLQxTjg+i+Wix1M14KTNIMAZF74XKaeOykVcIn
 juV6mmRHoIrgCS9n4YZ8Mj989d9aGijsWreioo3kk4Mghhevfi1RRCaT4VGQQW6iWfoF
 VrxPiMe4QFBvAKt6TCA8EIjKgfQsZsEW0h2xMDxAsELkR2Nyq6F3lKhcfSbw5poAproY
 j1EDYiCumoLcNUWPt9409I1SDhCnNf++OUPKFAz3+wfdZ/rh6fwMiHbN62NwZB1E57JT Qg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2057.outbound.protection.outlook.com [104.47.49.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2u55ux4fra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 21:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ick2meJAVzK15J07rh5+D3zK4dziTFNRYSaMA5ospLQjI88D2Lk4QUP+w0JoeQuSzNhpK2LMhAEP31eYyVq5yqpz6BitUDtt5C4aVHBVNHu16CcqY2irjNXIy6NwE7C7ZP+sMTfouuTsf7u49Lo+kJpz5NiKF4lYV2300OaD+LolYFV3tL08y1t7eD5nhWcCTFgx7n8HRTpEPpZu5KRrEfmEQZ70bmjfRJePqY7y5VWzqMTOqaCFfB/XnpDFLUEHeMU4FdcexSmJ3PSZvN3hl8/fNDwBSsNa31kjiox2uHnn1snJXbkhT+83TvMMq+LXYbuPpzAEHyGV5Od6bsm+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3gs/j4Jcpv1HZNzpGwBQS5sQR1epb7EIU2kQBQ1Gvw=;
 b=idL3Uno7NAGXdpjs0xDEV2BAY4AEN1yqK36wel3V2E1RNkugro4BEww3MUlhKqDkmtugB6crLFAAWdDcHQEMoMbUMJpHwWg20xgs9z3VQoplwnLC8XRqJbvPlwVeFtINgBzyhK0GO/qwQlsPZFSvpEyHbSJPBxycc/IvV7ijMknZn3Z0oWdKJRz0SCJYkk8GIB8fR25nSnellxQCyrsUe23y8UKoKz2IpGtII80MEWt5V5kUXSb/PzKNRfLeaw6vLh51PdaKCGXaat0QG9eM/W6cFkh9F4YAc+LF4rXZS8ZQ0kfu/N/xXBPNpQz9/UkGYpNzHqRgG4TlAMxo8L25gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3gs/j4Jcpv1HZNzpGwBQS5sQR1epb7EIU2kQBQ1Gvw=;
 b=Uc3TlNv3M4wUDq/uDxawtiYm2Il5eMqaIaLR8cEdKVzGEugANFEt3hg7vIfE0krj9eLEi22/SxLFhz7eEiSTIo9WWDfrEXlXHnepB+QbaahS9bTGAO53XW5aymT0obfEIaMqTz1pVL5PyZJrhzY9GNQi2BYjYTcLRR2iiueRnfE=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4424.namprd07.prod.outlook.com (52.135.224.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Thu, 8 Aug 2019 04:12:09 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.018; Thu, 8 Aug 2019
 04:12:09 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>, Pavel Machek <pavel@denx.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: RE: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Thread-Topic: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Thread-Index: AQHVP/K3++/PZvX91EKpHiAZrLktoabVbhiAgAD3BZCAACHLgIAAAkOAgACX4oCAAH1soIAYAaGAgAETlEA=
Date:   Thu, 8 Aug 2019 04:12:09 +0000
Message-ID: <BYAPR07MB47095895491CFD211EE9E051DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190722114839.GA10515@kroah.com> <20190722115644.GA12069@amd>
 <20190722210021.GA25235@amd>
 <BYAPR07MB470966850323EE3003B3097ADDC70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <93b4a702-227b-0410-a414-76873088ad72@ti.com>
In-Reply-To: <93b4a702-227b-0410-a414-76873088ad72@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOGFhZmM4NWItYjk5Mi0xMWU5LTg3NDQtMWM0ZDcwMWRmYmExXGFtZS10ZXN0XDhhYWZjODVjLWI5OTItMTFlOS04NzQ0LTFjNGQ3MDFkZmJhMWJvZHkudHh0IiBzej0iMzc4MiIgdD0iMTMyMDk3MTEwNjY1MDk4NjYzIiBoPSIrbDJwMy9mOWRUYVBhOUJ2a0FEbFU3TFZENkE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17f3e09c-4f28-446a-c0e6-08d71bb694f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR07MB4424;
x-ms-traffictypediagnostic: BYAPR07MB4424:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR07MB4424E96E5FFE1C7C6064AFFBDDD70@BYAPR07MB4424.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(51444003)(189003)(199004)(36092001)(305945005)(229853002)(66556008)(71200400001)(76116006)(81166006)(14454004)(66946007)(66066001)(966005)(76176011)(81156014)(66446008)(64756008)(478600001)(6436002)(5660300002)(8936002)(52536014)(25786009)(6246003)(316002)(74316002)(3846002)(53936002)(186003)(55016002)(7736002)(66476007)(71190400001)(33656002)(9686003)(99286004)(8676002)(4326008)(14444005)(256004)(6306002)(54906003)(6116002)(2906002)(6506007)(110136005)(11346002)(102836004)(7696005)(86362001)(26005)(446003)(107886003)(476003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4424;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gw4RvNuWoyxJ1yOVUk+M2LtldahbPNEK960w5k2DJvKTRB4XaY+rjbC80wemFdrGDO0yfN4JQVrwnO5Jb2Xe6Q3/atucu4Uj3uvB9HZmhvuUYC1J9ZmhGIh+gDezuGOqcNdBqpUaUjNCbNVk51OtZYoZUPB/bbMyMvVkHYpNk/IuPvL9M0XwPL+jqdxSHXoQjzHbE9NwHE0VrDFgj4ECBEO0nzU+wJ32fMsoPLV++SURdZhjEtXD2r/zNUbgp+mp+bzigfdQCYwl7xIgoUaXOtSn9RdLK8heCfxyGiczP8nKntBfpN6Ptl+pzMlMweRdD5D7yii4b/UzIqMFvTLE0LgO2rM1jeNX10mo5Dtj13dzXp2InDjHTGUv8jBfZDQAAaPClTiiL/r8eFc9hMuCbtdRtP41HFJH1aSZFkDsmOQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f3e09c-4f28-446a-c0e6-08d71bb694f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 04:12:09.2055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4424
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=753 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9nZXIsDQoNCj4NCj4NCj5PbiAyMy8wNy8yMDE5IDA3OjMyLCBQYXdlbCBMYXN6Y3phayB3
cm90ZToNCj4NCj4+IEhpLA0KPg0KPj4NCj4NCj4+PiBPbiBNb24gMjAxOS0wNy0yMiAxMzo1Njo0
NCwgUGF2ZWwgTWFjaGVrIHdyb3RlOg0KPg0KPj4+PiBIaSENCj4NCj4+Pj4NCj4NCj4+Pj4+Pj4+
IFRoaXMgcGF0Y2ggaW50cm9kdWNlIG5ldyBDYWRlbmNlIFVTQlNTIERSRCBkcml2ZXIgdG8gbGlu
dXgga2VybmVsLg0KPg0KPj4+Pj4+Pj4NCj4NCj4+Pj4+Pj4+IFRoZSBDYWRlbmNlIFVTQlNTIERS
RCBDb250cm9sbGVyIGlzIGEgaGlnaGx5IGNvbmZpZ3VyYWJsZSBJUCBDb3JlIHdoaWNoDQo+DQo+
Pj4+Pj4+PiBjYW4gYmUgaW5zdGFudGlhdGVkIGFzIER1YWwtUm9sZSBEZXZpY2UgKERSRCksIFBl
cmlwaGVyYWwgT25seSBhbmQNCj4NCj4+Pj4+Pj4+IEhvc3QgT25seSAoWEhDSSljb25maWd1cmF0
aW9ucy4NCj4NCj4+Pj4+Pj4NCj4NCj4+Pj4+Pj4gSSBzZWUgeW91IGFyZSB1c2luZyBkZWJ1Z2Zz
IHRvIHNlbGVjdCBiZXR3ZWVuIERSRCwgcGVyaXBoZXJhbC1vbmx5aCBhbmQgWEhDSS4uLg0KPg0K
Pj4+Pj4+Pg0KPg0KPj4+Pj4+PiBJcyB0aGF0IGdvb2QgaWRlYT8NCj4NCj4+Pj4+Pg0KPg0KPj4+
Pj4+IFllcyBkcml2ZXIgYWxsb3dzIHNlbGVjdGluZyBkcl9tb2RlIGJ5IGRlYnVnZnMuIENvbnRy
b2xsZXIgYWxzbyBzdXBwb3J0IHN1Y2ggZnVuY3Rpb25hbGl0eQ0KPg0KPj4+Pj4+IHNvIEkgZG9u
J3QgdW5kZXJzdGFuZCB3aHkgd291bGQgaXQgbm90IGJlIGEgZ29vZCBpZGVhLg0KPg0KPj4+Pj4+
DQo+DQo+Pj4+Pj4gSSBwZXJzb25hbGx5IHVzZSB0aGlzIGZvciB0ZXN0aW5nIGJ1dCBpdCBjYW4g
YmUgdXNlZCB0byBsaW1pdCBjb250cm9sbGVyIGZ1bmN0aW9uYWxpdHkgd2l0aG91dA0KPg0KPj4+
Pj4+IHJlY29tcGlsaW5nIGtlcm5lbC4NCj4NCj4+Pj4+DQo+DQo+Pj4+PiBkZWJ1Z2ZzIGlzIE9O
TFkgZm9yIGRlYnVnZ2luZywgbmV2ZXIgcmVseSBvbiBpdCBiZWluZyBlbmFibGVkLCBvcg0KPg0K
Pj4+Pj4gbW91bnRlZCwgb24gYSBzeXN0ZW0gaW4gb3JkZXIgdG8gaGF2ZSBhbnkgbm9ybWFsIG9w
ZXJhdGlvbiBoYXBwZW4uDQo+DQo+Pj4+Pg0KPg0KPj4+Pj4gU28gZm9yIHRlc3RpbmcsIHllcywg
dGhpcyBpcyBmaW5lLiAgSWYgdGhpcyBpcyBnb2luZyB0byBiZSB0aGUgbm9ybWFsDQo+DQo+Pj4+
PiBhcGkvaW50ZXJmYWNlIGZvciBob3cgdG8gY29udHJvbCB0aGlzIGRyaXZlciwgbm8sIHRoYXQg
aXMgbm90IGFjY2VwdGFibGUNCj4NCj4+Pj4+IGF0IGFsbC4NCj4NCj4+Pj4NCj4NCj4+Pj4gSXQg
bWFrZXMgYSBsb3Qgb2Ygc2Vuc2UgZm9yIGVuZC11c2VyIHRvIHRvZ2dsZSB0aGlzLi4uIGZvciBl
eGFtcGxlDQo+DQo+Pj4+IHdoZW4gaGUgaXMgbGFja2luZyByaWdodCBjYWJsZSBmb3IgcHJvcGVy
IG90ZyBkZXRlY3Rpb24uIEFzIGl0IGlzDQo+DQo+Pj4+IHRoaXJkIGRyaXZlciBvZmZlcmluZyB0
aGlzIGZ1bmN0aW9uYWxpdHksIEkgYmVsaWV2ZSB3ZSBzaG91bGQgc3RvcA0KPg0KPj4+PiB0cmVh
dGluZyBpdCBhcyBkZWJ1Z2dpbmcuDQo+DQo+Pj4NCj4NCj4+PiBBdCBsZWFzdCByZW5lc2FzIHVz
YiBjb250cm9sbGVyIHNlZW1zIHRvIGhhdmUgdmFyaWFibGVzIGluIHN5c2ZzOg0KPg0KPj4+IGRy
aXZlcnMvcGh5L3JlbmVzYXMvcGh5LXJjYXItZ2VuMy11c2IyLmMgOiBmdW5jdGlvbnMgcm9sZV9z
aG93IGFuZA0KPg0KPj4+IHJvbGVfc3RvcmUuIFNlZSBhbHNvDQo+DQo+Pj4gRG9jdW1lbnRhdGlv
bi9BQkkvdGVzdGluZy9zeXNmcy1wbGF0Zm9ybS1waHktcmNhci1nZW4zLXVzYjIgLg0KPg0KPj4+
DQo+DQo+Pj4gSSBiZWxpZXZlIHRoaXMgZHJpdmVyIHNob3VsZCBkbyBzYW1lLg0KPg0KPj4+DQo+
DQo+Pg0KPg0KPj4gQ0ROUzMgZHJpdmVyIHVzZSB0aGUgcm9sZSBmcmFtZXdvcmsgYW5kIGFsc28g
aGFzIHN1Y2ggdmFyaWFibGUgZGVmaW5lZA0KPg0KPj4gaW4gcm9sZSBzd2l0Y2ggZnJhbWV3b3Jr
Lg0KPg0KPj4NCj4NCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/
dT1odHRwcy0NCj4zQV9fZWxpeGlyLmJvb3RsaW4uY29tX2xpbnV4X2xhdGVzdF9zb3VyY2VfZHJp
dmVyc191c2Jfcm9sZXNfY2xhc3MuYyZkPUR3SUNhUSZjPWFVcTk4M0wycHVlMkZxS0ZvUDZQR0hN
SlF5b0o3a2wzczNHWi0NCj5faGFYcVkmcj1lMU9neGZ2a0wwcW85WE82ZlgxZ3NjdmEtdzAzdVNZ
QzFuSXl4bDg5LXJJJm09X2pCc0VPQjNndG9RVnZzVms4azJQejhkcDl6aHpaYmJMNE0wdElOSkxS
OCZzPW1xNWNlLWQ0VGQtDQo+bGMzT3ZjdmVrdGZTSGhYUEFMMkdvMmdXUC1xOVF3VFkmZT0NCj4N
Cg0KVGhlIG1lYW5pbmcgaXMgbGl0dGxlIGRpZmZlcmVudC4gUm9sZSBzd2l0Y2ggZnJhbWV3b3Jr
IGFsbG93IHRvIGNoYW5naW5nIHJvbGUgWyBob3N0IC0+IGRldmljZSwgZGV2aWNlIC0+IGhvc3Qg
XQ0KDQpUaGUgZGVidWdmcy5jIGFsbG93cyB0byBsaW1pdCBkcl9tb2RlLiANCg0KPg0KPkNhbiB3
ZSBnZXQgcmlkIG9mIHRoZSBkZWJ1Z2ZzIGludGVyZmFjZSBmb3IgdXNlciBpbml0aWF0ZWQgcm9s
ZSBjaGFuZ2UgYW5kIGp1c3QNCj4NCj5yZWx5IG9uIHJvbGUgc3dpdGNoIGZyYW1ld29yayB2aWEg
c3lzZnM/DQo+DQo+DQo+DQo+V2UgZG8gbmVlZCB1c2VyIGluaXRpYXRlZCByb2xlIGNoYW5nZXMg
aW4gcHJvZHVjdGlvbiBzeXN0ZW1zLiBTbyB3ZSBjYW4ndA0KPg0KPnJlbHkgb24gZGVidWdmcyBm
b3IgdGhpcy4NCg0KQnV0IEkgYXNzdW1lIHRoYXQgaW4gcHJvZHVjdGlvbiBzeXN0ZW1zIHRoaXMg
d2lsbCBiZSBkaXNhYmxlZC4gDQpjZG5zMy0kKENPTkZJR19ERUJVR19GUykJCSs9IGRlYnVnZnMu
bw0KDQpJIHRoaW5rIHRoYXQgSSB1bmRlcnN0YW5kIHlvdXIgY29uY2VybnMuIE15IGlkZWEgd2Fz
IG5vdCB0byBleHBhbmQgdGhlIHN1cHBvcnRlZCANCmRyX21vZGUuIFJhdGhlciBJIHdhbnRlZCB0
byBoYXZlIHBvc3NpYmlsaXR5IHRvIGxpbWl0IHRoaXMgKG9ubHkgZm9yIHRlc3RpbmcpLiANCg0K
RWcuIA0KSWYgIGNkbnMtPmRyX21vZGUgPSBVU0JfRFJfTU9ERV9PVEcNCnRoZW4gd2UgY2FuIGxp
bWl0IG1vZGUgdG8gSE9TVCBvciBERVZJQ0Ugb3IgRFJEDQppZiBjZG5zLT5kcl9tb2RlID09IFVT
Ql9EUl9NT0RFX0hPU1QgfHwgDQogICBjZG5zLT5kcl9tb2RlID09IFVTQl9EUl9NT0RFX1BFUklQ
SEVSQUwpIA0KdGhlbiBkcml2ZXIgY2FuJ3QgY2hhbmdlIGFueXRoaW5nDQoNCkl0IGFsbG93cyBt
ZSBmb3IgdGVzdGluZyBzb21lIGZ1bmN0aW9uYWxpdHkgdXNpbmcgb25seSBzaW5nbGUgYm9hcmQg
DQphbmQgZXZlbiB3aXRoIGxhY2tpbmcgcmlnaHQgY2FibGUgZm9yIHByb3BlciBvdGcgZGV0ZWN0
aW9uLiANCg0KU28sIHJlbW92aW5nIHRoaXMgY2FuIGNhdXNlIHRoYXQgdGVzdGluZyBzb21lIGZ1
bmN0aW9uYWxpdHkgDQp3aWxsICBiZSBsaW1pdGVkIG9uIG15IGJvYXJkcy4NCg0KSWYgeW91IHJl
bHkgd2FudCB0byByZW1vdmUgdGhpcywgbWF5YmUgd2UgY291bGQgZG8gdGhpcyANCmFmdGVyIHB1
dHRpbmcgdGhpcyBkcml2ZXIgdG8ga2VybmVsID8uICANCg0KTWFpbnRhaW5pbmcgdGhpcyBhcyBt
eSBpbnRlcm5hbCBjb2RlIGJlZm9yZSBwdXR0aW5nIHRoaXMgZHJpdmVyIA0KdG8ga2VybmVsIHdp
bGwgYmUgcHJvYmxlbWF0aWMuDQoNClJlZ2FyZHMsDQpQYXdlbGwNCg0KDQo=
