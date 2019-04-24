Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86779C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C702089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Huq0c2n9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LW2MK7gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfDXFbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:31:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53468 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbfDXFbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:31:02 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O5T8TO024047;
        Tue, 23 Apr 2019 22:30:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=facebook;
 bh=LXP2yQoUKDR5cbzYqDvXKEUBqAPNPhQmyojY9h15FhA=;
 b=Huq0c2n9dUdXIq+6i4S3EuwC3aXUuWwD3arT2ZqGdNzvxZfUItM17ix4eeuUkzF0y2VK
 EhhK9WOp4xR0bE7KwG4KkldqLXxdKfhJg84sVhIEDRGm0CHaWzWH16Sqm2qFdwLFwHvU
 MerzlVbu+bbVrHeKYh1yQRiQiKKUqpkpIVw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s293gsu2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Apr 2019 22:30:41 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 22:30:40 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 23 Apr 2019 22:30:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXP2yQoUKDR5cbzYqDvXKEUBqAPNPhQmyojY9h15FhA=;
 b=LW2MK7gi5uH0/iR8BQCAjGBPtWVENR14RM9mGTAYbr5BVqcccT6BAJbxJ0SvvGbTf7YjMEPSor25O+lqJ4XEC2P6Bx/E7GJj7Lh87Rcm6HJKSLDdWoBYngDGYpvUJS42EJZ9U4dWIKMI/1dJfDPc5KA/QaNcd3WRNdQVxTmhfsM=
Received: from DM5PR15MB1211.namprd15.prod.outlook.com (10.173.210.138) by
 DM5PR15MB1276.namprd15.prod.outlook.com (10.173.209.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 05:30:38 +0000
Received: from DM5PR15MB1211.namprd15.prod.outlook.com
 ([fe80::656d:a562:c522:fdce]) by DM5PR15MB1211.namprd15.prod.outlook.com
 ([fe80::656d:a562:c522:fdce%3]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 05:30:38 +0000
From:   Tao Ren <taoren@fb.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net v2 2/2] net/ncsi: handle overflow when incrementing
 mac address
Thread-Topic: [PATCH net v2 2/2] net/ncsi: handle overflow when incrementing
 mac address
Thread-Index: AQHU+l7Z6GEOruNl1UmSvCmZV4B56g==
Date:   Wed, 24 Apr 2019 05:30:38 +0000
Message-ID: <F686273E-C5DC-441D-BF10-2BAB93481FE8@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.14.0.181208
x-originating-ip: [2620:10d:c090:180::4567]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75a79409-fa78-4106-3082-08d6c875fc29
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1276;
x-ms-traffictypediagnostic: DM5PR15MB1276:
x-microsoft-antispam-prvs: <DM5PR15MB12767AEA54EF4CC3920822DCB23C0@DM5PR15MB1276.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(73956011)(8936002)(99286004)(186003)(81156014)(81166006)(8676002)(102836004)(6506007)(97736004)(6116002)(2501003)(53546011)(2906002)(25786009)(110136005)(58126008)(316002)(36756003)(6512007)(6436002)(6246003)(53936002)(478600001)(486006)(46003)(66446008)(66556008)(476003)(7736002)(2616005)(86362001)(83716004)(6486002)(76116006)(7416002)(4744005)(91956017)(14454004)(71200400001)(71190400001)(68736007)(33656002)(5660300002)(82746002)(256004)(64756008)(305945005)(229853002)(14444005)(66946007)(66476007)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1276;H:DM5PR15MB1211.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q/L/ePleGAnA52FYgpyDL1ys/Ssty+wDWT/cJBpx+tYsC7j8KsCYAXAnlCFzVjbPuMcShav9rJfu/GL/C9d9ZdiePVfWDGcOtvnfpvepVqK1uYvj2K/V2Nx68YBhaFCn9Il4Z2BWnyg+uYUFbFuR/DQpJNUCb+BrCZxCVYCZwq9d14Zfih0djBKpjMCk/FzOQ9UIJOQSGO6N3q2OZMpGupVPxDrC2VKku4IVag1Pl61vq1b0cv6RvQ/nP3pouS2uvQCbYnSenToEM/RB9LSSxKjnCGHVZ0Iv/1JJdoq4/bYD16/lMZh+hBEb54d60ucSNZIbConSF89Up+SrBlhwDP+0FRfcunkNEHiGnlE3mem3SDY1w+3CORgYIiSd7sU3P6JuFMwOqRoAb5Lj2qVZ7bKaofEOL35Y4YrtZDWHIu8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C75967B4E8A3646B286DDFC118C10F9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a79409-fa78-4106-3082-08d6c875fc29
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 05:30:38.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1276
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGlnbm9yZSB0aGlzIGVtYWlsLiBTb21ldGhpbmcgd2FzIHdyb25nIHdpdGggbXkgZW1h
aWwgY2xpZW50OiB0aGUgZW1haWwgd2FzIHN1cHBvc2VkIHRvIGJlIGRlbGl2ZXJlZCA4IGhvdXJz
IGFnbyBidXQgc3VycHJpc2luZ2x5IGl0IGFycml2ZWQgbm93LiBTb3JyeSBhYm91dCB0aGUgbm9p
c2UuLg0KDQotIFRhbw0KDQpPbiA0LzIzLzE5LCA5OjQxIFBNLCAib3BlbmJtYyBvbiBiZWhhbGYg
b2YgVGFvIFJlbiIgPG9wZW5ibWMtYm91bmNlcyt0YW9yZW49ZmIuY29tQGxpc3RzLm96bGFicy5v
cmcgb24gYmVoYWxmIG9mIHRhb3JlbkBmYi5jb20+IHdyb3RlOg0KPiBQcmV2aW91c2x5IEJNQydz
IE1BQyBhZGRyZXNzIGlzIGNhbGN1bGF0ZWQgYnkgc2ltcGx5IGFkZGluZyAxIHRvIHRoZQ0KPiBs
YXN0IGJ5dGUgb2YgbmV0d29yayBjb250cm9sbGVyJ3MgTUFDIGFkZHJlc3MsIGFuZCBpdCBwcm9k
dWNlcyBpbmNvcnJlY3QNCj4gcmVzdWx0IHdoZW4gbmV0d29yayBjb250cm9sbGVyJ3MgTUFDIGFk
ZHJlc3MgZW5kcyB3aXRoIDB4RkYuDQo+ICANCj4gVGhlIHByb2JsZW0gY2FuIGJlIGZpeGVkIGJ5
IGNhbGxpbmcgIm5ldF9hZGRyX2luYyIgZnVuY3Rpb24gdG8gaW5jcmVtZW50DQo+IE1BQyBhZGRy
ZXNzOyBiZXNpZGVzLCB0aGUgTUFDIGFkZHJlc3MgaXMgYWxzbyB2YWxpZGF0ZWQgYmVmb3JlIGFz
c2lnbmluZw0KPiB0byBCTUMuDQo+ICANCj4gRml4ZXM6IGNiMTBjN2MwZGZkOSAoIm5ldC9uY3Np
OiBBZGQgTkNTSSBCcm9hZGNvbSBPRU0gY29tbWFuZCIpDQo+IFNpZ25lZC1vZmYtYnk6IFRhbyBS
ZW4gPHRhb3JlbkBmYi5jb20+DQogDQoNCg==
