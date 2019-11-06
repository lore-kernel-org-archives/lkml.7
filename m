Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B40C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4478217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WpfHHHps";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TwQR+CTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfKFG6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:58:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5838 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbfKFG6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:58:24 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA66s4SY022740;
        Tue, 5 Nov 2019 22:57:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gSXzJX8VrT659pQQXjC4UigFFRqeLmalhxFwci48Slw=;
 b=WpfHHHpsbKTRHOwBAMF2aUd6Y/BzUqWTB18SkuZTwyZfM/IgCo6JIhyZ2UbMvRbVE6ya
 tYfJI0/B1NDjpBg4a7xj2+aGOFr6YzMgTNi2+BJ9MonbZy/DYfzDkZXMj7su6ZaL0XlL
 DjT9guauEyxBQ5modeIP8o8/LuMxJTtCMDQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w34c1eask-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 22:57:45 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Nov 2019 22:57:44 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 22:57:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5ky7vsKrS8xXYGlciSNjVpf479+4nT/P3Z7bqU305DHTGQpE8++Yn2uI7rWVxAPq9BEEjaYjCojG7W6VEvBzchgRROfv7ih2RC+Nlp9iFiS5vhEC1nJrdtVm2p2/pFvxk+p0NGUmj3e5ej6N08mcIAgUn8O2/OR2Zn0yzaWzFJaO0JD7M+xJ+RRsTSmeGcO2YNUsLtGIYz3sU+zkTlVNwTYRs0MuN3OOO2RgG8+8Js6zYeTXsWEpjD9bHP50fE5rGtsLaMJeMnMcekCqtS3OitiljQeUtZMsC8GTCIrRLF+gTfYgGqo517YFp8hSkitbMyZ7M35GCv8TQ+RNxMJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSXzJX8VrT659pQQXjC4UigFFRqeLmalhxFwci48Slw=;
 b=TtpU9qZO8zywzYUqk2lmcOqO7SZGR8erR8T1UARAu4oqE8gxH0z2vxHddpMrlh0BWqabTJLMt0aprfWGDdq9j61X0piNlfaS6MUKMbpA7+vIyrk3UtKU8gdbb7GpLM3oo1qcNjskljTdFO3Llr8PA+072iMaDocWj6OaKO/uzSBP5cjvLURt2G8/RlJFxv+qEClpl59903l6otyZkoWjYAlcH1yBzDTVkLfC7rWiVLsssSC9aG1PGeB/pXX7XDLz+D1EoR66FGhqK7D+/z/xBdfTrzhma/r0zsQuSDaL3gURmpBhqDyXiYYuRlU+7pMJXbZPVrE8M67mH98VACWXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSXzJX8VrT659pQQXjC4UigFFRqeLmalhxFwci48Slw=;
 b=TwQR+CTf+OkjZRDyVUg6RN+Yfo/wht5Ji+9PixCS5VTFRWPmWr3TETWEXwFBxz9w2E3D2FGiy9g4JlrfvqlJ8gj+07Gx9j1bF0qI9aGBManFKEQkKmQm2ruPy4ewldFe80sjaPkHL14TD2CIDIpfS2UL9W0vQkQoc4X8GSvlIrA=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3652.namprd15.prod.outlook.com (52.133.253.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 06:57:42 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 06:57:42 +0000
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
Subject: Re: [PATCH] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Topic: [PATCH] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Index: AQHVlBIxmnW6XN3w/UGGMK9IULGPI6d9URQA///fowA=
Date:   Wed, 6 Nov 2019 06:57:42 +0000
Message-ID: <63FB7A84-EF61-45CA-9CA7-9564F28B5D42@fb.com>
References: <20191105194732.1521963-1-vijaykhemka@fb.com>
 <20191106005332.GA2754@minyard.net>
In-Reply-To: <20191106005332.GA2754@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4b00:fd70:18e2:66b5:5e3d:3d1a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f6c2885-1d85-4e69-97c5-08d762869ef0
x-ms-traffictypediagnostic: BY5PR15MB3652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3652737C3930D07D58032FEEDD790@BY5PR15MB3652.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(6486002)(81166006)(76176011)(2906002)(2351001)(2501003)(6916009)(6246003)(316002)(5640700003)(71200400001)(229853002)(71190400001)(54906003)(14454004)(486006)(256004)(6512007)(8676002)(1730700003)(81156014)(14444005)(6506007)(6436002)(102836004)(478600001)(86362001)(25786009)(36756003)(446003)(2616005)(46003)(11346002)(99286004)(66946007)(476003)(76116006)(8936002)(66556008)(66476007)(66446008)(305945005)(5660300002)(4326008)(6116002)(33656002)(64756008)(7736002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3652;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXzkzkVV5mnEVKWSlV7uZtJVznFxqEwYy5Uel2tw/e8J8X6KqVFlfJj/2Dsyic9WWRfTtbaGWU/vs+FHFCCrRsdGKZjvAxaO3BcKp0695Mh28wjDx7W73/09UREjutZZhcRbe/3bOEtSrDpr+KLtD2esA/mdxySfmCRTQwTJwmuR1WfpiPSG3MG/7Uhhv5sD++/lCzbYvDM9TSL3uBE9UqC+mELffRZCnfiGloVFGHcUhoQ5doXrKd74ejzpWbMle48XHtCrN2yGNwlscvtB2iXTZiCX34OcvvYcwBGwIS8z9pdXk7Bv9lS3EFAJImAYhFyyrv/CO+c9Bw0fsYgb0sjDHBrbhd5kmLtMDUv/l5pkdqg3ErnwYl4jfUWaaZDOe/gIICxhhb93z78dPVyRHeSguYJSr1Anib3AhqvkrJ7VCTcLdCi/9p36It9CQoWE
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEBCD57AFBDACC4FA9FE3AEDD41F2C13@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6c2885-1d85-4e69-97c5-08d762869ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 06:57:42.6242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhdNosqb89lQZqHMBvMa0sveRa8kf55CstaLRjovR4fTtI/9MURoihjJUB4kI2cyIY1NtzpYeWTCiQqmejHjZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3652
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_01:2019-11-05,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911060072
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzUvMTksIDQ6NTQgUE0sICJDb3JleSBNaW55YXJkIiA8dGNtaW55YXJkQGdt
YWlsLmNvbSBvbiBiZWhhbGYgb2YgbWlueWFyZEBhY20ub3JnPiB3cm90ZToNCg0KICAgIE9uIFR1
ZSwgTm92IDA1LCAyMDE5IGF0IDExOjQ3OjMxQU0gLTA4MDAsIFZpamF5IEtoZW1rYSB3cm90ZToN
CiAgICA+IFJlbW92ZWQgY2hlY2sgZm9yIHJlcXVlc3Qgb3IgcmVzcG9uc2UgaW4gSVBNQiBwYWNr
ZXRzIGNvbWluZyBmcm9tDQogICAgPiBkZXZpY2UgYXMgd2VsbCBhcyBmcm9tIGhvc3QuIE5vdyBp
dCBzdXBwb3J0cyBib3RoIHdheSBjb21tdW5pY2F0aW9uDQogICAgPiB0byBkZXZpY2UgdmlhIElQ
TUIuIEJvdGggcmVxdWVzdCBhbmQgcmVzcG9uc2Ugd2lsbCBiZSBwYXNzZWQgdG8NCiAgICA+IGFw
cGxpY2F0aW9uLg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZp
amF5a2hlbWthQGZiLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMvY2hhci9pcG1pL2lw
bWJfZGV2X2ludC5jIHwgMjkgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDI4IGRlbGV0aW9ucygtKQ0KICAgID4gDQog
ICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMgYi9kcml2
ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gaW5kZXggMjg1ZTBiOGY5YTk3Li43
MjAxZmRiNTMzZDggMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rl
dl9pbnQuYw0KICAgID4gKysrIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMNCiAg
ICA+IEBAIC0xMzMsOSArMTMzLDYgQEAgc3RhdGljIHNzaXplX3QgaXBtYl93cml0ZShzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwNCiAgICA+ICAJcnFfc2EgPSBHRVRf
N0JJVF9BRERSKG1zZ1tSUV9TQV84QklUX0lEWF0pOw0KICAgID4gIAluZXRmX3JxX2x1biA9IG1z
Z1tORVRGTl9MVU5fSURYXTsNCiAgICA+ICANCiAgICA+IC0JaWYgKCEobmV0Zl9ycV9sdW4gJiBO
RVRGTl9SU1BfQklUX01BU0spKQ0KICAgID4gLQkJcmV0dXJuIC1FSU5WQUw7DQogICAgPiAtDQog
ICAgPiAgCS8qDQogICAgPiAgCSAqIHN1YnRyYWN0IHJxX3NhIGFuZCBuZXRmX3JxX2x1biBmcm9t
IHRoZSBsZW5ndGggb2YgdGhlIG1zZyBwYXNzZWQgdG8NCiAgICA+ICAJICogaTJjX3NtYnVzX3hm
ZXINCiAgICA+IEBAIC0yMDMsMjggKzIwMCw2IEBAIHN0YXRpYyB1OCBpcG1iX3ZlcmlmeV9jaGVj
a3N1bTEoc3RydWN0IGlwbWJfZGV2ICppcG1iX2RldiwgdTggcnNfc2EpDQogICAgPiAgCQlpcG1i
X2Rldi0+cmVxdWVzdC5jaGVja3N1bTEpOw0KICAgID4gIH0NCiAgICA+ICANCiAgICA+IC1zdGF0
aWMgYm9vbCBpc19pcG1iX3JlcXVlc3Qoc3RydWN0IGlwbWJfZGV2ICppcG1iX2RldiwgdTggcnNf
c2EpDQogICAgPiAtew0KICAgID4gLQlpZiAoaXBtYl9kZXYtPm1zZ19pZHggPj0gSVBNQl9SRVFV
RVNUX0xFTl9NSU4pIHsNCiAgICA+IC0JCWlmIChpcG1iX3ZlcmlmeV9jaGVja3N1bTEoaXBtYl9k
ZXYsIHJzX3NhKSkNCiAgICA+IC0JCQlyZXR1cm4gZmFsc2U7DQogICAgDQogICAgWW91IHN0aWxs
IG5lZWQgdG8gY2hlY2sgdGhlIG1lc3NhZ2UgbGVuZ3RoIGFuZCBjaGVja3N1bSwgeW91IGp1c3Qg
bmVlZA0KICAgIHRvIGlnbm9yZSB0aGUgcmVxL3Jlc3AgYml0Lg0KWWVzIHlvdSBhcmUgcmlnaHQs
IEkgd2FzIGxvb2tpbmcgZm9yIGNoZWNrc3VtIGNvZGUgYWZ0ZXIgcmVtb3ZpbmcgaXQgX18uIEkg
d2lsbCBtb2RpZnkgaXQuDQogICAgDQogICAgLWNvcmV5DQogICAgDQogICAgPiAtDQogICAgPiAt
CQkvKg0KICAgID4gLQkJICogQ2hlY2sgd2hldGhlciB0aGlzIGlzIGFuIElQTUIgcmVxdWVzdCBv
cg0KICAgID4gLQkJICogcmVzcG9uc2UuDQogICAgPiAtCQkgKiBUaGUgNiBNU0Igb2YgbmV0Zm5f
cnNfbHVuIGFyZSBkZWRpY2F0ZWQgdG8gdGhlIG5ldGZuDQogICAgPiAtCQkgKiB3aGlsZSB0aGUg
cmVtYWluaW5nIGJpdHMgYXJlIGRlZGljYXRlZCB0byB0aGUgbHVuLg0KICAgID4gLQkJICogSWYg
dGhlIExTQiBvZiB0aGUgbmV0Zm4gaXMgY2xlYXJlZCwgaXQgaXMgYXNzb2NpYXRlZA0KICAgID4g
LQkJICogd2l0aCBhbiBJUE1CIHJlcXVlc3QuDQogICAgPiAtCQkgKiBJZiB0aGUgTFNCIG9mIHRo
ZSBuZXRmbiBpcyBzZXQsIGl0IGlzIGFzc29jaWF0ZWQgd2l0aA0KICAgID4gLQkJICogYW4gSVBN
QiByZXNwb25zZS4NCiAgICA+IC0JCSAqLw0KICAgID4gLQkJaWYgKCEoaXBtYl9kZXYtPnJlcXVl
c3QubmV0Zm5fcnNfbHVuICYgTkVURk5fUlNQX0JJVF9NQVNLKSkNCiAgICA+IC0JCQlyZXR1cm4g
dHJ1ZTsNCiAgICA+IC0JfQ0KICAgID4gLQlyZXR1cm4gZmFsc2U7DQogICAgPiAtfQ0KICAgID4g
LQ0KICAgID4gIC8qDQogICAgPiAgICogVGhlIElQTUIgcHJvdG9jb2wgb25seSBzdXBwb3J0cyBJ
MkMgV3JpdGVzIHNvIHRoZXJlIGlzIG5vIG5lZWQNCiAgICA+ICAgKiB0byBzdXBwb3J0IEkyQ19T
TEFWRV9SRUFEKiBldmVudHMuDQogICAgPiBAQCAtMjczLDkgKzI0OCw3IEBAIHN0YXRpYyBpbnQg
aXBtYl9zbGF2ZV9jYihzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KICAgID4gIA0KICAgID4g
IAljYXNlIEkyQ19TTEFWRV9TVE9QOg0KICAgID4gIAkJaXBtYl9kZXYtPnJlcXVlc3QubGVuID0g
aXBtYl9kZXYtPm1zZ19pZHg7DQogICAgPiAtDQogICAgPiAtCQlpZiAoaXNfaXBtYl9yZXF1ZXN0
KGlwbWJfZGV2LCBHRVRfOEJJVF9BRERSKGNsaWVudC0+YWRkcikpKQ0KICAgID4gLQkJCWlwbWJf
aGFuZGxlX3JlcXVlc3QoaXBtYl9kZXYpOw0KICAgID4gKwkJaXBtYl9oYW5kbGVfcmVxdWVzdChp
cG1iX2Rldik7DQogICAgPiAgCQlicmVhazsNCiAgICA+ICANCiAgICA+ICAJZGVmYXVsdDoNCiAg
ICA+IC0tIA0KICAgID4gMi4xNy4xDQogICAgPiANCiAgICANCg0K
