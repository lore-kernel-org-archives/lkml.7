Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387022071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SDNz/di/";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZfpD0SBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKNSGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:06:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbfKNSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:06:11 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEI5gNH010144;
        Thu, 14 Nov 2019 10:05:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=G7Y8lB/h5P8PrysgUfJiGoEsGhjsLjwD47hJDSIMnXA=;
 b=SDNz/di/7e/ZXI4HAoIDhCgKB0Ge69kf0td2ui5A5zt+XWOy1fHXYTteYEO94Hs0TnwF
 +CdJ3FS4kMQKSP5yStvZvi9H86lVHYH9uJ9RDW2d7rT1gn8KstOamtyproajD0zp4faW
 LBFDEgodUsq/TWLIJt1ykoei5Ivlt005f+0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8n9s6b0q-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 10:05:48 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 14 Nov 2019 10:05:35 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Nov 2019 10:05:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq/Bl+GB7fYqsvCaQ+b/uuiC/+gnBOMZxLmw+6t+SgJ5btzULAjmo/NUwlY3lTnqTuat3zASeBVYuJhXwCQWPZEGL91dwBf4UaPf2QZXgqIp3aHmJTkK8Ukzcd7KdSXvJ+JH1MBRZJzvrwvQJrGCGw9+I2PpZyT86GSHV860M8W0zMzF+oA5651Y1wxdvgkwVL/xGZYhdm7jr3xDPJMQNFboSXCflQGMqi+cyX8vLZdpru1Th6BVVxNKu0fcsVjzo6m5NCq5daUYvjZ3Lpt36xh6PxCZHzVSPd1aD2nRYvCtMRzK6qo+N2VjJ1u+XfAXeCzlNcD7FZXcUH5fT9ESrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7Y8lB/h5P8PrysgUfJiGoEsGhjsLjwD47hJDSIMnXA=;
 b=H5cRPTShELEc/g5LIQqRhYKCiAKgW/3W+DYK+TBf8XKK6nF8Fj7fXfALRSQx16JxfkwSotfwuPu1asdhaxvYiehmZr8Jks4Z2nVFPrslKtz3Vb1dzrXyC9s8hVZ2IPEwU+osVnpuCCywts6WppJIhDCu0E2gw9/0C0MPOo28B/oflAvocY7gJ3rY+orYb+bhoSF59K70vCJceC4tC8gJYeQLvu3vvjwWyhdYbx6XsJTK6Y+LCCIvIyFCwkQRfUTADgGiOvSoyRwvHadvxbBmHCD8WAsz37jKQbxzSvEcqFN47L+v+AMrPPcfSiwd+YxF4i9pQD23e1F9eewwx7wRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7Y8lB/h5P8PrysgUfJiGoEsGhjsLjwD47hJDSIMnXA=;
 b=ZfpD0SBtld0HJ0RrCLjJdnTr8UR3VLoP9QTIHv6erC8fI5y57n0GvLM2l8SGUlmtfNVCc3SKPvl8A59ZtR0SM2UHvAkQDxXgb1hm7OQYobiUgajmLXzxzfRxM6m7h4OMl5BDmj/g+PAl8CLpog2dcGmIbGeqgb0/vCZ2fVnTKac=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3587.namprd15.prod.outlook.com (52.133.252.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Thu, 14 Nov 2019 18:05:34 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 18:05:34 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "asmaa@mellanox.com" <asmaa@mellanox.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmnw2JTo54xh3Oky71cdINa8VKqeKtZqA//+7iIA=
Date:   Thu, 14 Nov 2019 18:05:34 +0000
Message-ID: <41C671FB-20B4-40F5-94AB-1E750FD91B90@fb.com>
References: <20191113234133.3790374-1-vijaykhemka@fb.com>
 <20191114141037.GP2882@minyard.net>
In-Reply-To: <20191114141037.GP2882@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2860]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e99d924-9a18-42a8-0435-08d7692d3ef2
x-ms-traffictypediagnostic: BY5PR15MB3587:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3587D0607FF39340D97F8614DD710@BY5PR15MB3587.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(2351001)(7736002)(11346002)(476003)(99286004)(305945005)(478600001)(2616005)(6116002)(46003)(14454004)(256004)(14444005)(54906003)(5660300002)(446003)(486006)(36756003)(71190400001)(6916009)(71200400001)(81156014)(66476007)(81166006)(5640700003)(2501003)(102836004)(76176011)(6486002)(8936002)(6436002)(66946007)(66446008)(25786009)(2906002)(316002)(64756008)(33656002)(66556008)(186003)(86362001)(4326008)(8676002)(6512007)(229853002)(6506007)(76116006)(6246003)(1730700003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3587;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLVAT1x5VQBQhjCdNupkuH625aJ+6whdc/TtoXLZH44TvHTNDZ9zz/MehC/r0KTehLHZqC9R1j2EkL68UeT4PdaKhLHlvTQKLYOU8FOoMPbHH69O7ojvSq/mhKzI7RCDJrlwfHK4usCNwNXTT9gfXfq7vjoOlacdtX9rgUENeTLYvYeMPApD7L45U1QXgzmMULAPsXnjirTu8nIewc+RVjzRV14DT0XAeUF5Opwr0eSWu0J4jbao/oIVnqxP38eRKFo9WLaPUdXJl1LNd28tTgrz4+SK0FMSaT/BXrbErOwTfWciB7D20+vd0sabIhV0YiKXYEvMZmw8OUdBtWokqOfEqi/9BP3qswUzCNDWgLHRFo86WlTaKDzN4a8F7DblNjim5C4S4TD1RJbjmxUEgIyRdiE19trCSK7AOJd57eo+3OweOUOSWWBswBUEUMIv
Content-Type: text/plain; charset="utf-8"
Content-ID: <163327B111BDCD459D229805E2064A93@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e99d924-9a18-42a8-0435-08d7692d3ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:05:34.4368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmR4GvjozXlkHzUSd+JJrPTRhZJ2ZwlxO+U5Xliqpo5b728vCZdt3IxHdLfXday4VH9khBhwL8m2UvVCMhQwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3587
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_05:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911140155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzE0LzE5LCA2OjExIEFNLCAiQ29yZXkgTWlueWFyZCIgPHRjbWlueWFyZEBn
bWFpbC5jb20gb24gYmVoYWxmIG9mIG1pbnlhcmRAYWNtLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBX
ZWQsIE5vdiAxMywgMjAxOSBhdCAwMzo0MTozM1BNIC0wODAwLCBWaWpheSBLaGVta2Egd3JvdGU6
DQogICAgPiBNYW55IElQTUIgZGV2aWNlcyBkb2Vzbid0IHN1cHBvcnQgc21idXMgcHJvdG9jb2wg
YW5kIGN1cnJlbnQgZHJpdmVyDQogICAgPiBzdXBwb3J0IG9ubHkgc21idXMgZGV2aWNlcy4gQWRk
ZWQgc3VwcG9ydCBmb3IgcmF3IGkyYyBwYWNrZXRzLg0KICAgID4gDQogICAgPiBVc2VyIGNhbiBk
ZWZpbmUgaTJjLXByb3RvY29sIGluIGRldmljZSB0cmVlIHRvIHVzZSBpMmMgcmF3IHRyYW5zZmVy
Lg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWth
QGZiLmNvbT4NCiAgICANCiAgICBXaXRoIEFhc21hJ3MgcmVzcG9uc2UsIEkgYW0gb2sgd2l0aCB0
aGlzLg0KICAgIA0KICAgIE9uZSB0aGluZywgdGhvdWdoLiAgVGhpcyBpcyB0aGUgc2xhdmUgZGV2
aWNlIG9uIHRoZSBJMkMsIG5vdCB0aGUgbWFzdGVyDQogICAgZGV2aWNlIHRoYXQgaGFzIHRoZSBp
c3N1ZSwgcmlnaHQ/ICBTbyBpdCdzIGF0IGxlYXN0IHRoZW9yZXRpY2FsbHkNCiAgICBwb3NzaWJs
ZSB0byBoYXZlIG9uZSBTTUJ1cyBhbmQgb25lIEkyQyBJUE1CIGRldmljZSBvbiB0aGUgc2FtZSBt
YXN0ZXIsDQogICAgcmlnaHQ/DQogICAgDQogICAgRm9yIG5vcm1hbCBJMkMsIGRldmljZXMgYXJl
IGluIHRoZSBkZXZpY2UgdHJlZSBhbmQgZ2V0IGFkZGVkIHRvIHRoZQ0KICAgIGtlcm5lbCBkZXZp
Y2UgaGFuZGxpbmcuICBJdCBsb29rcyBsaWtlIHRoYXQgaXMgbm90IGJlaW5nIGRvbmUgaW4geW91
cg0KICAgIGNhc2UuICBCdXQgcmVhbGx5LCB0aGUgInJpZ2h0IiB3YXkgdG8gZG8gdGhpcyBpcyB0
byBoYXZlIHRoZSBJUE1CIHNsYXZlcw0KICAgIGFkZGVkIGFzIExpbnV4IGRldmljZXMgYW5kIGFk
ZHJlc3MgdGhlbSB0aGF0IHdheS4gIEknbSBub3Qgc3VyZSB0aGlzDQogICAgd2lsbCBldmVyIGJl
IGEgcmVhbCBpc3N1ZSwgYnV0IGlmIGl0IGlzLCB0aGVyZSB3aWxsIGJlIHNvbWUgd29yayB0byBk
bw0KICAgIHRvIGZpeCBpdC4NCg0KSSB3aWxsIGJlIGhhcHB5IHRvIGFkZHJlc3MgdGhpcyBpbiBm
b2xsb3cgdXAgcGF0Y2ggYW5kIG5lZWQgc29tZSBtb3JlIGluZm8uDQogICAgDQogICAgLWNvcmV5
DQogICAgDQogICAgPiAtLS0NCiAgICA+ICBkcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQu
YyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogICAgPiAgMSBmaWxlIGNo
YW5nZWQsIDMyIGluc2VydGlvbnMoKykNCiAgICA+IA0KICAgID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZf
aW50LmMNCiAgICA+IGluZGV4IGFlM2JmYmEyNzUyNi4uMTA5MDRiZWMxZGUwIDEwMDY0NA0KICAg
ID4gLS0tIGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMNCiAgICA+ICsrKyBiL2Ry
aXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jDQogICAgPiBAQCAtNjMsNiArNjMsNyBAQCBz
dHJ1Y3QgaXBtYl9kZXYgew0KICAgID4gIAlzcGlubG9ja190IGxvY2s7DQogICAgPiAgCXdhaXRf
cXVldWVfaGVhZF90IHdhaXRfcXVldWU7DQogICAgPiAgCXN0cnVjdCBtdXRleCBmaWxlX211dGV4
Ow0KICAgID4gKwlib29sIGlzX2kyY19wcm90b2NvbDsNCiAgICA+ICB9Ow0KICAgID4gIA0KICAg
ID4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IGlwbWJfZGV2ICp0b19pcG1iX2RldihzdHJ1Y3QgZmls
ZSAqZmlsZSkNCiAgICA+IEBAIC0xMTIsNiArMTEzLDI1IEBAIHN0YXRpYyBzc2l6ZV90IGlwbWJf
cmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGNvdW50LA0K
ICAgID4gIAlyZXR1cm4gcmV0IDwgMCA/IHJldCA6IGNvdW50Ow0KICAgID4gIH0NCiAgICA+ICAN
CiAgICA+ICtzdGF0aWMgaW50IGlwbWJfaTJjX3dyaXRlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQsIHU4ICptc2cpDQogICAgPiArew0KICAgID4gKwlzdHJ1Y3QgaTJjX21zZyBpMmNfbXNnOw0K
ICAgID4gKw0KICAgID4gKwkvKg0KICAgID4gKwkgKiBzdWJ0cmFjdCAxIGJ5dGUgKHJxX3NhKSBm
cm9tIHRoZSBsZW5ndGggb2YgdGhlIG1zZyBwYXNzZWQgdG8NCiAgICA+ICsJICogcmF3IGkyY190
cmFuc2Zlcg0KICAgID4gKwkgKi8NCiAgICA+ICsJaTJjX21zZy5sZW4gPSBtc2dbSVBNQl9NU0df
TEVOX0lEWF0gLSAxOw0KICAgID4gKw0KICAgID4gKwkvKiBBc3NpZ24gbWVzc2FnZSB0byBidWZm
ZXIgZXhjZXB0IGZpcnN0IDIgYnl0ZXMgKGxlbmd0aCBhbmQgYWRkcmVzcykgKi8NCiAgICA+ICsJ
aTJjX21zZy5idWYgPSBtc2cgKyAyOw0KICAgID4gKw0KICAgID4gKwlpMmNfbXNnLmFkZHIgPSBH
RVRfN0JJVF9BRERSKG1zZ1tSUV9TQV84QklUX0lEWF0pOw0KICAgID4gKwlpMmNfbXNnLmZsYWdz
ID0gY2xpZW50LT5mbGFncyAmIEkyQ19DTElFTlRfUEVDOw0KICAgID4gKw0KICAgID4gKwlyZXR1
cm4gaTJjX3RyYW5zZmVyKGNsaWVudC0+YWRhcHRlciwgJmkyY19tc2csIDEpOw0KICAgID4gK30N
CiAgICA+ICsNCiAgICA+ICBzdGF0aWMgc3NpemVfdCBpcG1iX3dyaXRlKHN0cnVjdCBmaWxlICpm
aWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLA0KICAgID4gIAkJCXNpemVfdCBjb3VudCwgbG9m
Zl90ICpwcG9zKQ0KICAgID4gIHsNCiAgICA+IEBAIC0xMzMsNiArMTUzLDEyIEBAIHN0YXRpYyBz
c2l6ZV90IGlwbWJfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpi
dWYsDQogICAgPiAgCXJxX3NhID0gR0VUXzdCSVRfQUREUihtc2dbUlFfU0FfOEJJVF9JRFhdKTsN
CiAgICA+ICAJbmV0Zl9ycV9sdW4gPSBtc2dbTkVURk5fTFVOX0lEWF07DQogICAgPiAgDQogICAg
PiArCS8qIENoZWNrIGkyYyBibG9jayB0cmFuc2ZlciB2cyBzbWJ1cyAqLw0KICAgID4gKwlpZiAo
aXBtYl9kZXYtPmlzX2kyY19wcm90b2NvbCkgew0KICAgID4gKwkJcmV0ID0gaXBtYl9pMmNfd3Jp
dGUoaXBtYl9kZXYtPmNsaWVudCwgbXNnKTsNCiAgICA+ICsJCXJldHVybiAocmV0ID09IDEpID8g
Y291bnQgOiByZXQ7DQogICAgPiArCX0NCiAgICA+ICsNCiAgICA+ICAJLyoNCiAgICA+ICAJICog
c3VidHJhY3QgcnFfc2EgYW5kIG5ldGZfcnFfbHVuIGZyb20gdGhlIGxlbmd0aCBvZiB0aGUgbXNn
IHBhc3NlZCB0bw0KICAgID4gIAkgKiBpMmNfc21idXNfeGZlcg0KICAgID4gQEAgLTI3Nyw2ICsz
MDMsNyBAQCBzdGF0aWMgaW50IGlwbWJfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwN
CiAgICA+ICAJCQljb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCAqaWQpDQogICAgPiAgew0KICAg
ID4gIAlzdHJ1Y3QgaXBtYl9kZXYgKmlwbWJfZGV2Ow0KICAgID4gKwlzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wOw0KICAgID4gIAlpbnQgcmV0Ow0KICAgID4gIA0KICAgID4gIAlpcG1iX2RldiA9IGRl
dm1fa3phbGxvYygmY2xpZW50LT5kZXYsIHNpemVvZigqaXBtYl9kZXYpLA0KICAgID4gQEAgLTMw
Miw2ICszMjksMTEgQEAgc3RhdGljIGludCBpcG1iX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQsDQogICAgPiAgCWlmIChyZXQpDQogICAgPiAgCQlyZXR1cm4gcmV0Ow0KICAgID4gIA0K
ICAgID4gKwkvKiBDaGVjayBpZiBpMmMgYmxvY2sgeG1pdCBuZWVkcyB0byB1c2UgaW5zdGVhZCBv
ZiBzbWJ1cyAqLw0KICAgID4gKwlucCA9IGNsaWVudC0+ZGV2Lm9mX25vZGU7DQogICAgPiArCWlm
IChucCAmJiBvZl9nZXRfcHJvcGVydHkobnAsICJpMmMtcHJvdG9jb2wiLCBOVUxMKSkNCiAgICA+
ICsJCWlwbWJfZGV2LT5pc19pMmNfcHJvdG9jb2wgPSB0cnVlOw0KICAgID4gKw0KICAgID4gIAlp
cG1iX2Rldi0+Y2xpZW50ID0gY2xpZW50Ow0KICAgID4gIAlpMmNfc2V0X2NsaWVudGRhdGEoY2xp
ZW50LCBpcG1iX2Rldik7DQogICAgPiAgCXJldCA9IGkyY19zbGF2ZV9yZWdpc3RlcihjbGllbnQs
IGlwbWJfc2xhdmVfY2IpOw0KICAgID4gLS0gDQogICAgPiAyLjE3LjENCiAgICA+IA0KICAgIA0K
DQo=
