Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35ACC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83810206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XRV0uHxz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="arGRdhqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKMW7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:59:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfKMW7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:59:24 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADMtWl6014021;
        Wed, 13 Nov 2019 14:58:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sWku2HQde+2xPxJtI7NazfMpnw+2ozok3mx/ix3FcDY=;
 b=XRV0uHxzVljYNyHfBxvQ/k6yl+SjeLCrE47CjJU7d3wRygiUL3zZ2ZliGcFV1oNqllSU
 pvBGh7BidG7nZsBN/NFULwIKUj/HtcRtEbp4QehIFzfK3Bkw88Cu1pk6foXM1hy41Eqa
 VdMa7ckqg6DvFRfh42fYoAQ5sMC3M6m3sq4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8u0t80uv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Nov 2019 14:58:51 -0800
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 14:58:49 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 14:58:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xfa80p8OV3UgdnUWJu6EcABCTQ85JTg88SajWBsd/OOLi3abYm/0+5CSfLiPfkasybCSuhIQEdXT6BujU5hk26yjiz3MIV5UhgbKQnHZllHwDAR1Okn7iyp2drodDB8GTXUny0zJl/x5kxmi3W8wUG1qo5rB6DA/yO5zRsGgX3tZh8zsdvb6jcvwhwq3PGqoaKTLBMBUJKdgIHuup3poquxrh140Y8hz4GWEr8Laut+e1yuUXVGj2HYoXpWXlHI2KvRIg+3B9QKqZyUw1yfwAebEaIXPFhUubNJTxoxx/RB0N9Zod5tq7hE/jOso7/SuokaZ87AIPx49YC+vYsLVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWku2HQde+2xPxJtI7NazfMpnw+2ozok3mx/ix3FcDY=;
 b=HATncn6rs6T3VICbG+7IGL1KbNYcxt78I7fQBzf0lUnsguZQ6VaJ60ww+7L/u1gMLnXgsZceKC+tSWwYjzxoKDd/GkYj2g9W+XGOAMjF3Pf1cIrRRuk+mCUzM1QI8rJ1eC1iE9yjq20klLrePhqb+RjggabmE+WvWSZ8hmHZjtu7S1fHGjICX8SBmVTX/iNM+UIClBDIfFeEircXRtE/ZO/umJytluCh5NxYjaEmdSkzuKcd+UPjoS5luoUbCpIZ7jYSm1/tQuMX1uDhwtM2WCCbnqNQ9FEgKe9A4PiIGy93fHWIysnH5Uh51VGC47sqa8zJ+PUksJXQnP0NHaV2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWku2HQde+2xPxJtI7NazfMpnw+2ozok3mx/ix3FcDY=;
 b=arGRdhqC1PNbt/8QmWWvMPktrBlEAGLGIBYiajcCf9QVMhQunhwVwr7oQjMG4Y52+dLzpZg1MxBSmGIcnHdVwxlAe8b0gZlD5WZLoP3x2marUXVum0dOGPal9unOjMAomn6LjTuG+J241FtTFuvu8qNvHty9Si6+3Pzbp5LbI6E=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3650.namprd15.prod.outlook.com (52.133.253.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 22:58:46 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 22:58:46 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     Asmaa Mnebhi <Asmaa@mellanox.com>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>
Subject: Re: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmlgx5hC93vJeUkW0xORXbQm1S6eJjmCA//+JUQCAAIuHgP//jckA
Date:   Wed, 13 Nov 2019 22:58:46 +0000
Message-ID: <00D9E632-E2D5-413B-BFF8-6791D599943D@fb.com>
References: <20191113192325.2821207-1-vijaykhemka@fb.com>
 <DB6PR0501MB2712FAF45EE8CB2D513465A9DA760@DB6PR0501MB2712.eurprd05.prod.outlook.com>
 <AC2A7BB8-52D0-4CAF-9C72-58C9CF5A4F55@fb.com>
 <20191113214733.GO2882@minyard.net>
In-Reply-To: <20191113214733.GO2882@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::63b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7aa811c-cf1b-4309-05cf-08d7688d0a53
x-ms-traffictypediagnostic: BY5PR15MB3650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB365082814710D9CDC584AE5EDD760@BY5PR15MB3650.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(366004)(346002)(189003)(199004)(13464003)(76176011)(66946007)(14444005)(5660300002)(486006)(2501003)(81156014)(4326008)(81166006)(6506007)(6436002)(66446008)(66476007)(53546011)(66556008)(54906003)(25786009)(6512007)(186003)(2616005)(64756008)(86362001)(6246003)(14454004)(446003)(476003)(102836004)(36756003)(8936002)(11346002)(2906002)(46003)(6116002)(256004)(6916009)(5640700003)(76116006)(99286004)(316002)(1730700003)(2351001)(229853002)(33656002)(7736002)(7416002)(478600001)(71190400001)(71200400001)(6486002)(305945005)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3650;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwPalWqJ3FflpSrS1up1OeIVUUpWPSuqts9Nft6QdBnrenlM3D4N69Zt+7W3DOJXjGck04iKS2uBohYwsLUJC/xitR221+p2mMzXzH7Sz3RFdegCQxoPi4eRGPwoFFb4biRo420o+fYLgBxlohyIy6rrx7/98+VZYn8dn2dycQ2MkdkaD4kMkbJPQfAELN0Iv/kJFRE4R6MBMVvvBUM3/Sl4lzHFFlv2SvgtPRVYHbAMb6pq89qi1SLes+p/+6ndE60nARnlNPVjkTltKwiPQS+cUQzrzxYxQLrmAv7K457+yUCkRhOgQzkbwQL8yX+UmKChTKG8V86mYBVCEHi/Y43jPEZvdA+P6LLuPpeP2VZtAtbIPgqxvHQSY+vYtFjf3S/oz9ummrif3pRHj49Fil9/JKkl3qTLEPWZtEd34lGoRHfKVD7uytMLiCct/k7W
Content-Type: text/plain; charset="utf-8"
Content-ID: <5190B80E9D3A23458CE1D7AE036B414C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d7aa811c-cf1b-4309-05cf-08d7688d0a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:58:46.8535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/iC+vehmeOdjJ6U19ZK99YeFj0rXGjzP/hWY1s0c2Jqr1PLs+Z+leNTNPd4RwKBCDbs6FqNBgaDhvS4d/FeNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3650
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_05:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911130191
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzEzLzE5LCAxOjQ3IFBNLCAiQ29yZXkgTWlueWFyZCIgPHRjbWlueWFyZEBn
bWFpbC5jb20gb24gYmVoYWxmIG9mIG1pbnlhcmRAYWNtLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBX
ZWQsIE5vdiAxMywgMjAxOSBhdCAwOToyODoxMFBNICswMDAwLCBWaWpheSBLaGVta2Egd3JvdGU6
DQogICAgPiANCiAgICA+IA0KICAgID4gT24gMTEvMTMvMTksIDEyOjMzIFBNLCAiQXNtYWEgTW5l
YmhpIiA8QXNtYWFAbWVsbGFub3guY29tPiB3cm90ZToNCiAgICA+IA0KICAgID4gICAgIElubGlu
ZSByZXNwb25zZToNCiAgICA+ICAgICANCiAgICA+ICAgICAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KICAgID4gICAgIEZyb206IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPiAN
CiAgICA+ICAgICBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDE5IDI6MjMgUE0NCiAg
ICA+ICAgICBUbzogQ29yZXkgTWlueWFyZCA8bWlueWFyZEBhY20ub3JnPjsgQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+OyBvcGVuaXBtaS1kZXZlbG9wZXJAbGlzdHMuc291cmNlZm9yZ2UubmV0OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQogICAgPiAgICAgQ2M6IHZpamF5a2hlbWthQGZiLmNv
bTsgY21pbnlhcmRAbXZpc3RhLmNvbTsgQXNtYWEgTW5lYmhpIDxBc21hYUBtZWxsYW5veC5jb20+
OyBqb2VsQGptcy5pZC5hdTsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IHNkYXNhcmlA
ZmIuY29tDQogICAgPiAgICAgU3ViamVjdDogW1BBVENIIHYzXSBkcml2ZXJzOiBpcG1pOiBTdXBw
b3J0IHJhdyBpMmMgcGFja2V0IGluIElQTUINCiAgICA+ICAgICANCiAgICA+ICAgICBNYW55IElQ
TUIgZGV2aWNlcyBkb2Vzbid0IHN1cHBvcnQgc21idXMgcHJvdG9jb2wgYW5kIGN1cnJlbnQgZHJp
dmVyIHN1cHBvcnQgb25seSBzbWJ1cyBkZXZpY2VzLiBBZGRlZCBzdXBwb3J0IGZvciByYXcgaTJj
IHBhY2tldHMuDQogICAgPiAgICAgDQogICAgPiAgICAgVXNlciBjYW4gZGVmaW5lIHVzZS1pMmMt
YmxvY2sgaW4gZGV2aWNlIHRyZWUgdG8gdXNlIGkyYyByYXcgdHJhbnNmZXIuDQogICAgPiAgICAg
DQogICAgPiAgICAgQXNtYWE+PiBGaXggdGhlIGRlc2NyaXB0aW9uOiAiVGhlIGlwbWJfZGV2X2lu
dCBkcml2ZXIgb25seSBzdXBwb3J0cyB0aGUgc21idXMgcHJvdG9jb2wgYXQgdGhlIG1vbWVudC4g
QWRkIHN1cHBvcnQgZm9yIHRoZSBpMmMgcHJvdG9jb2wgYXMgd2VsbC4gVGhlcmUgd2lsbCBiZSBh
IHZhcmlhYmxlIHBhc3NlZCBieSB0aG91Z2ggdGhlIGRldmljZSB0cmVlIG9yIEFDUEkgdGFibGUg
d2hpY2ggc2V0cyB0aGUgY29uZmlndXJlcyB0aGUgcHJvdG9jb2wgYXMgZWl0aGVyIGkyYyBvciBz
bWJ1cy4iDQogICAgPiAgICAgDQogICAgPiAgICAgU2lnbmVkLW9mZi1ieTogVmlqYXkgS2hlbWth
IDx2aWpheWtoZW1rYUBmYi5jb20+DQogICAgPiAgICAgLS0tDQogICAgPiAgICAgIGRyaXZlcnMv
Y2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCiAgICA+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKykNCiAgICA+
ICAgICANCiAgICA+ICAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZf
aW50LmMgYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gICAgIGluZGV4
IGFlM2JmYmEyNzUyNi4uMTZkNWQ0YjYzNmE5IDEwMDY0NA0KICAgID4gICAgIC0tLSBhL2RyaXZl
cnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jDQogICAgPiAgICAgKysrIGIvZHJpdmVycy9jaGFy
L2lwbWkvaXBtYl9kZXZfaW50LmMNCiAgICA+ICAgICBAQCAtNjMsNiArNjMsNyBAQCBzdHJ1Y3Qg
aXBtYl9kZXYgew0KICAgID4gICAgICAJc3BpbmxvY2tfdCBsb2NrOw0KICAgID4gICAgICAJd2Fp
dF9xdWV1ZV9oZWFkX3Qgd2FpdF9xdWV1ZTsNCiAgICA+ICAgICAgCXN0cnVjdCBtdXRleCBmaWxl
X211dGV4Ow0KICAgID4gICAgICsJYm9vbCB1c2VfaTJjOw0KICAgID4gICAgICB9Ow0KICAgID4g
ICAgICANCiAgICA+ICAgICBBc21hYT4+IHJlbmFtZSB0aGlzIHZhcmlhYmxlIDogaXNfaTJjX3By
b3RvY29sDQogICAgPiBEb25lLg0KICAgID4gICAgIA0KICAgID4gICAgICBzdGF0aWMgaW5saW5l
IHN0cnVjdCBpcG1iX2RldiAqdG9faXBtYl9kZXYoc3RydWN0IGZpbGUgKmZpbGUpIEBAIC0xMTIs
NiArMTEzLDM5IEBAIHN0YXRpYyBzc2l6ZV90IGlwbWJfcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwg
Y2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGNvdW50LA0KICAgID4gICAgICAJcmV0dXJuIHJldCA8
IDAgPyByZXQgOiBjb3VudDsNCiAgICA+ICAgICAgfQ0KICAgID4gICAgICANCiAgICA+ICAgICAr
c3RhdGljIGludCBpcG1iX2kyY193cml0ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCB1OCAq
bXNnKSB7DQogICAgPiAgICAgKwl1bnNpZ25lZCBjaGFyICppMmNfYnVmOw0KICAgID4gICAgICsJ
c3RydWN0IGkyY19tc2cgaTJjX21zZzsNCiAgICA+ICAgICArCXNzaXplX3QgcmV0Ow0KICAgID4g
ICAgICsJdTggbXNnX2xlbjsNCiAgICA+ICAgICArDQogICAgPiAgICAgKwkvKg0KICAgID4gICAg
ICsJICogc3VidHJhY3QgMSBieXRlIChycV9zYSkgZnJvbSB0aGUgbGVuZ3RoIG9mIHRoZSBtc2cg
cGFzc2VkIHRvDQogICAgPiAgICAgKwkgKiByYXcgaTJjX3RyYW5zZmVyDQogICAgPiAgICAgKwkg
Ki8NCiAgICA+ICAgICArCW1zZ19sZW4gPSBtc2dbSVBNQl9NU0dfTEVOX0lEWF0gLSAxOw0KICAg
ID4gICAgICsNCiAgICA+ICAgICArCWkyY19idWYgPSBremFsbG9jKG1zZ19sZW4sIEdGUF9LRVJO
RUwpOw0KICAgID4gICAgIA0KICAgID4gICAgIEFzbWFhID4+IFdlIGRvIG5vdCB3YW50IHRvIHVz
ZSBremFsbG9jIGV2ZXJ5IHRpbWUgeW91IGV4ZWN1dGUgdGhpcyB3cml0ZSBmdW5jdGlvbi4gSXQg
d291bGQgY3JlYXRlIHNvIG11Y2ggZnJhZ21lbnRhdGlvbi4NCiAgICA+ICAgICBZb3UgZG9uJ3Qg
cmVhbGx5IG5lZWQgdG8gdXNlIGt6YWxsb2MgYW55d2F5cy4gDQogICAgPiBXZSBuZWVkIHRvIGFs
bG9jYXRlIG1lbW9yeSB0byBwYXNzIHRvIGkyY190cmFuc2Zlci4gVGhhdCdzIHdoYXQgYmVpbmcg
ZG9uZSBpbiBpMmNfc21idXNfeGZlciBmdW5jdGlvbiBhcyB3ZWxsLg0KICAgID4gICAgIA0KICAg
ID4gICAgIEFsc28sIHRoaXMgY29kZSBjaHVuayBpcyBzaG9ydCwgc28geW91IGNhbiBjYWxsIGl0
IGRpcmVjdGx5IGZyb20gdGhlIHdyaXRlIGZ1bmN0aW9uLiBJIGRvbid0IHRoaW5rIHlvdSBuZWVk
IGEgc2VwYXJhdGUgZnVuY3Rpb24gZm9yIGl0Lg0KICAgID4gSSB3YW50ZWQgdG8ga2VlcCB0aGlz
IGNoYW5nZSBhcyBjbGVhbiBhcyBwb3NzaWJsZS4NCiAgICANCiAgICBJJ2QgYWdyZWUuICBGcmFn
bWVudGF0aW9uIGlzIG5vdCBhIGJpZyBkZWFsIGhlcmUuDQogICAgDQogICAgSG93ZXZlciwgd2h5
IG5vdCBqdXN0IHBhc3MgaW4gbXNnICsgMj8gIFRoYXQgd291bGQgYmUgY2xlYW5lciwgZmFzdGVy
LA0KICAgIGFuZCBsZXNzIHdhc3RlZnVsLg0KICAgIA0KICAgID4gICAgIA0KICAgID4gICAgICsJ
aWYgKCFpMmNfYnVmKQ0KICAgID4gICAgICsJCXJldHVybiAtRUZBVUxUOw0KICAgIA0KICAgIC1F
Tk9NRU0/ICAoQXNzdW1pbmcgeW91IGtlZXAgdGhlIG1hbGxvYykNCkRvbmUuDQogICAgDQogICAg
PiAgICAgKw0KICAgID4gICAgICsJLyogQ29weSBtZXNzYWdlIHRvIGJ1ZmZlciBleGNlcHQgZmly
c3QgMiBieXRlcyAobGVuZ3RoIGFuZCBhZGRyZXNzKSAqLw0KICAgID4gICAgICsJbWVtY3B5KGky
Y19idWYsIG1zZysyLCBtc2dfbGVuKTsNCiAgICA+ICAgICArDQogICAgPiAgICAgKwlpMmNfbXNn
LmFkZHIgPSBHRVRfN0JJVF9BRERSKG1zZ1tSUV9TQV84QklUX0lEWF0pOw0KICAgID4gICAgICsJ
aTJjX21zZy5mbGFncyA9IGNsaWVudC0+ZmxhZ3MgJg0KICAgID4gICAgICsJCQkoSTJDX01fVEVO
IHwgSTJDX0NMSUVOVF9QRUMgfCBJMkNfQ0xJRU5UX1NDQ0IpOw0KICAgID4gICAgIEFzbWFhPj4g
SSBkb24ndCB0aGluayBpcG1iIHN1cHBvcnRzIDEwIGJpdCBhZGRyZXNzZXMuIFRoZSBtYXggbnVt
YmVyIG9mIGJpdHMgaW4gdGhlIElQTUIgYWRkcmVzcyBmaWVsZCBpcyA4Lg0KICAgID4gRG9uZS4N
CiAgICA+ICAgICANCiAgICA+ICAgICArCWkyY19tc2cubGVuID0gbXNnX2xlbjsNCiAgICA+ICAg
ICArCWkyY19tc2cuYnVmID0gaTJjX2J1ZjsNCiAgICA+ICAgICArDQogICAgPiAgICAgKwlyZXQg
PSBpMmNfdHJhbnNmZXIoY2xpZW50LT5hZGFwdGVyLCAmaTJjX21zZywgMSk7DQogICAgPiAgICAg
KwlrZnJlZShpMmNfYnVmKTsNCiAgICA+ICAgICArDQogICAgPiAgICAgKwlyZXR1cm4gcmV0Ow0K
ICAgID4gICAgICsNCiAgICA+ICAgICArfQ0KICAgID4gICAgICsNCiAgICA+ICAgICAgc3RhdGlj
IHNzaXplX3QgaXBtYl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIg
KmJ1ZiwNCiAgICA+ICAgICAgCQkJc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQogICAgPiAg
ICAgIHsNCiAgICA+ICAgICBAQCAtMTMzLDYgKzE2NywxMiBAQCBzdGF0aWMgc3NpemVfdCBpcG1i
X3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLA0KICAgID4g
ICAgICAJcnFfc2EgPSBHRVRfN0JJVF9BRERSKG1zZ1tSUV9TQV84QklUX0lEWF0pOw0KICAgID4g
ICAgICAJbmV0Zl9ycV9sdW4gPSBtc2dbTkVURk5fTFVOX0lEWF07DQogICAgPiAgICAgIA0KICAg
ID4gICAgICsJLyogQ2hlY2sgaTJjIGJsb2NrIHRyYW5zZmVyIHZzIHNtYnVzICovDQogICAgPiAg
ICAgKwlpZiAoaXBtYl9kZXYtPnVzZV9pMmMpIHsNCiAgICA+ICAgICArCQlyZXQgPSBpcG1iX2ky
Y193cml0ZShpcG1iX2Rldi0+Y2xpZW50LCBtc2cpOw0KICAgID4gICAgICsJCXJldHVybiAocmV0
ID09IDEpID8gY291bnQgOiByZXQ7DQogICAgPiAgICAgKwl9DQogICAgPiAgICAgKw0KICAgID4g
ICAgICAJLyoNCiAgICA+ICAgICAgCSAqIHN1YnRyYWN0IHJxX3NhIGFuZCBuZXRmX3JxX2x1biBm
cm9tIHRoZSBsZW5ndGggb2YgdGhlIG1zZyBwYXNzZWQgdG8NCiAgICA+ICAgICAgCSAqIGkyY19z
bWJ1c194ZmVyDQogICAgPiAgICAgQEAgLTI3Nyw2ICszMTcsNyBAQCBzdGF0aWMgaW50IGlwbWJf
cHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCiAgICA+ICAgICAgCQkJY29uc3Qgc3Ry
dWN0IGkyY19kZXZpY2VfaWQgKmlkKQ0KICAgID4gICAgICB7DQogICAgPiAgICAgIAlzdHJ1Y3Qg
aXBtYl9kZXYgKmlwbWJfZGV2Ow0KICAgID4gICAgICsJc3RydWN0IGRldmljZV9ub2RlICpucDsN
CiAgICA+ICAgICAgCWludCByZXQ7DQogICAgPiAgICAgIA0KICAgID4gICAgICAJaXBtYl9kZXYg
PSBkZXZtX2t6YWxsb2MoJmNsaWVudC0+ZGV2LCBzaXplb2YoKmlwbWJfZGV2KSwgQEAgLTMwMiw2
ICszNDMsMTMgQEAgc3RhdGljIGludCBpcG1iX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQsDQogICAgPiAgICAgIAlpZiAocmV0KQ0KICAgID4gICAgICAJCXJldHVybiByZXQ7DQogICAg
PiAgICAgIA0KICAgID4gICAgICsJLyogQ2hlY2sgaWYgaTJjIGJsb2NrIHhtaXQgbmVlZHMgdG8g
dXNlIGluc3RlYWQgb2Ygc21idXMgKi8NCiAgICA+ICAgICArCW5wID0gY2xpZW50LT5kZXYub2Zf
bm9kZTsNCiAgICA+ICAgICArCWlmIChucCAmJiBvZl9nZXRfcHJvcGVydHkobnAsICJ1c2UtaTJj
LWJsb2NrIiwgTlVMTCkpDQogICAgPiAgICAgQXNtYWE+PiBSZW5hbWUgdGhpcyB2YXJpYWJsZSBp
MmMtcHJvdG9jb2wuIEFuZCBhbHNvLCBhcHBseSB0aGlzIHRvIEFDUEkgYXMgd2VsbC4NCiAgICA+
IERvbmUuDQogICAgDQogICAgSSBkb24ndCB0aGluayBBQ1BJIGlzIHRoYXQgaW1wb3J0YW50IGF0
IHRoZSBtb21lbnQuICBSZW5hbWUgaXMgZ29vZC4NCiAgICANCiAgICA+ICAgICArCQlpcG1iX2Rl
di0+dXNlX2kyYyA9IHRydWU7DQogICAgPiAgICAgKwllbHNlDQogICAgPiAgICAgKwkJaXBtYl9k
ZXYtPnVzZV9pMmMgPSBmYWxzZTsNCiAgICANCiAgICBUaGUgYWJvdmUgdHdvIGxpbmVzIGFyZSB1
bm5lY2Vzc2FyeS4NCkRvbmUsIHdpbGwgc2VuZCB2NCBzb29uLg0KICAgIA0KICAgIC1jb3JleQ0K
ICAgIA0KICAgID4gICAgICsNCiAgICA+ICAgICAgCWlwbWJfZGV2LT5jbGllbnQgPSBjbGllbnQ7
DQogICAgPiAgICAgIAlpMmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBpcG1iX2Rldik7DQogICAg
PiAgICAgIAlyZXQgPSBpMmNfc2xhdmVfcmVnaXN0ZXIoY2xpZW50LCBpcG1iX3NsYXZlX2NiKTsN
CiAgICA+ICAgICAtLQ0KICAgID4gICAgIDIuMTcuMQ0KICAgID4gICAgIA0KICAgID4gICAgIA0K
ICAgID4gDQogICAgDQoNCg==
