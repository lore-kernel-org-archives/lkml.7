Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10B6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929FB214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AhoisSeR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PViDJt6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKGVWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:22:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbfKGVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:22:00 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xA7LFoBK005045;
        Thu, 7 Nov 2019 13:21:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YFznXx/OTSpQanu7eZXSSmi1X4Gn001NNLDJPjbkDks=;
 b=AhoisSeRy3TaPa5ypCs4mZtHDNeevZyA8Iqv3o4qlY4FHGo3pPqcIbuR5Bf5csXxsoHh
 ubylkp3btJCrPQHh08k0WF7fl+EdZNK6DijId7ttANKgYRAcus49+h6ZssymiqJBJgCV
 jYqul9+qN2FbAhKJniptVdJvTsqo2fJymBE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2w41w1qewe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 Nov 2019 13:21:28 -0800
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 13:21:27 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 13:21:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqgBmJNK0is3y1IA+hzscy9TTetwhAXjiCBShRQZndJLXoaIHb3yTfdmXGqGwyMn525dP53PZlsnNEqN2VzddBEfyGmFOJ43BsvaeSpyJ2bDJzvuVXHaDvcg0/HxsfQw/gzSSzpLgVm7zzLK5EyvMPZWAsdt7EJR1wyI3InURu/2RUlUAnzrnGRHCqWgZQdUgpdIA9IN/sdsE6txDzEYuNS/b/dQ4iKYJ8h5kiPk+JQjit6PzLbWpaN5LjHpaSTllIgvbB6YsWWa9xPWr0HjrMX8LYqWzhbGixPLW1+SLTQvHetnUqnge928xbo1O8vt+Eb/hK4j3OZIGR/YyCdQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFznXx/OTSpQanu7eZXSSmi1X4Gn001NNLDJPjbkDks=;
 b=k/Xbdc1KjBibN8kukFU4h4gU/t8RARZfPWXICu98LbTIvgCB8fg8mI6mtmIqaYGmsTdpHiGrLDVZM1KmHVUHdeoXRWW5bEijVr2D5zLCgKolNU2jufvFqme0nsaREQMOhTzPfNLgqrza8NpiRcObMv62P6LhC6P8HonIoAwpZaNnyn0ZNoVnJL4oAdhnA/pwqRGsQyW8d60hyMfD1wilYzDmWews8+qoEM4YdFihf8QWr+bG4MU9dpAHDxISCgRXnXfpg7ZmT1WBqMqeKSjnRrJc7yfln03XTNTwaoX3lK3px7eoQfindRou0fERq3os1zN5+eYDQ9Ji0YzAGYOnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFznXx/OTSpQanu7eZXSSmi1X4Gn001NNLDJPjbkDks=;
 b=PViDJt6X/taP+09xmS+QPGujuCkG1rp14kzPx9mJG0WZ1uykXoUNNirWeMKtUtXaY/AYZoSb60ubeTWl8c3sOiCxcokliR1hBleFvTk0QQoquiXeFAwT346z1VDYhyp9MiQM0WXBRkKuL2xd5gNu7oLc3xHyNtjPAAFX0b6ASq4=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3665.namprd15.prod.outlook.com (52.133.252.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 21:21:24 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 21:21:24 +0000
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
Subject: Re: [PATCH v2] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Topic: [PATCH v2] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Index: AQHVlNCV9B7yba6coEmH1BeeZGobl6d/toOA///8W4A=
Date:   Thu, 7 Nov 2019 21:21:24 +0000
Message-ID: <0D4A68FC-E829-4890-B720-F9A6110A5038@fb.com>
References: <20191106182921.1086795-1-vijaykhemka@fb.com>
 <20191107133425.GA10276@minyard.net>
In-Reply-To: <20191107133425.GA10276@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3:8f6e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1952e154-56a1-4d8c-5661-08d763c8718e
x-ms-traffictypediagnostic: BY5PR15MB3665:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3665FB3D8157374AF57EBB8FDD780@BY5PR15MB3665.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(305945005)(6512007)(7736002)(6116002)(478600001)(25786009)(64756008)(99286004)(66446008)(4326008)(81166006)(229853002)(33656002)(66556008)(2501003)(6246003)(81156014)(91956017)(66946007)(76116006)(86362001)(66476007)(14454004)(1730700003)(46003)(8676002)(8936002)(256004)(14444005)(2616005)(486006)(2351001)(476003)(316002)(54906003)(11346002)(446003)(102836004)(5640700003)(36756003)(71200400001)(6916009)(6436002)(186003)(71190400001)(6506007)(5660300002)(2906002)(6486002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3665;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/vuXFQWMaRc5B9LJobIWYHek8kQNLX3Vli8jF700alKnNVEPooHPapIkPUm4ohSa6LigZcpKR2oTYg7jqGpuk4YXLpLqK7KZ1173UCGOJYud8lq+pOiYF9olRC4udiBjVIXJtK+/ahKhgxMWXdpulMN2eSojar9TsBfXa90e+/mGwd8SwcHcgZUu0ccSxkZLkz38x/2U7ZDewyQyGgTZVM9iVMo1FkjIE1L2Ilni2UTD114m0At06Y1SziGyiQZUXtPrWK6dU33g+EBw2a2oyL838Rre2QPoSc/S6NMv8h9l3Yk9QnZKVAi8EIqcggNuf5VvHr+VvvxzaZ/01SjvuWAELNdTG4ZPqaP0AXjp1W9L602c2eX3WPZrOnGwny2mvucowxabDCN0Ovq75bSe8qJ8DlT8/W1S+x8PbpGPslLsW5Vej/ur1nrGx2PxdGZ
Content-Type: text/plain; charset="utf-8"
Content-ID: <971F65F3C4EE7B468544A26E6B458498@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1952e154-56a1-4d8c-5661-08d763c8718e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 21:21:24.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1O6XcEHL3NAUINPmpXNxIgb6UkUfNg7xyJgaxpBKpXCTJt8+uw4LsCuqxZTtR85jQDw/DxDwBVsFHN/cvDpaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3665
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_06:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911070197
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzcvMTksIDU6MzUgQU0sICJDb3JleSBNaW55YXJkIiA8dGNtaW55YXJkQGdt
YWlsLmNvbSBvbiBiZWhhbGYgb2YgbWlueWFyZEBhY20ub3JnPiB3cm90ZToNCg0KICAgIE9uIFdl
ZCwgTm92IDA2LCAyMDE5IGF0IDEwOjI5OjIxQU0gLTA4MDAsIFZpamF5IEtoZW1rYSB3cm90ZToN
CiAgICA+IFJlbW92ZWQgY2hlY2sgZm9yIHJlcXVlc3Qgb3IgcmVzcG9uc2UgaW4gSVBNQiBwYWNr
ZXRzIGNvbWluZyBmcm9tDQogICAgPiBkZXZpY2UgYXMgd2VsbCBhcyBmcm9tIGhvc3QuIE5vdyBp
dCBzdXBwb3J0cyBib3RoIHdheSBjb21tdW5pY2F0aW9uDQogICAgPiB0byBkZXZpY2UgdmlhIElQ
TUIuIEJvdGggcmVxdWVzdCBhbmQgcmVzcG9uc2Ugd2lsbCBiZSBwYXNzZWQgdG8NCiAgICA+IGFw
cGxpY2F0aW9uLg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZp
amF5a2hlbWthQGZiLmNvbT4NCiAgICANCiAgICBUaGFua3MsIHRoaXMgaXMgaW4gbXkgZm9yLW5l
eHQgdHJlZSBub3cuICBBc25hYW0sIEkgdG9vayB5b3VyIHByZXZpb3VzDQogICAgY29tbWVudHMg
YXMgYSAiUmV2aWV3ZWQtYnkiLCBpZiB0aGF0IGlzIG9rLg0KDQpUaGFua3MgQ29yZXkNCiAgICAN
CiAgICAtY29yZXkNCiAgICANCiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMvY2hhci9pcG1pL2lw
bWJfZGV2X2ludC5jIHwgMzEgKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAgID4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KICAgID4g
DQogICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMgYi9k
cml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gaW5kZXggMjg1ZTBiOGY5YTk3
Li5hZTNiZmJhMjc1MjYgMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1i
X2Rldl9pbnQuYw0KICAgID4gKysrIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMN
CiAgICA+IEBAIC0xMzMsOSArMTMzLDYgQEAgc3RhdGljIHNzaXplX3QgaXBtYl93cml0ZShzdHJ1
Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwNCiAgICA+ICAJcnFfc2EgPSBH
RVRfN0JJVF9BRERSKG1zZ1tSUV9TQV84QklUX0lEWF0pOw0KICAgID4gIAluZXRmX3JxX2x1biA9
IG1zZ1tORVRGTl9MVU5fSURYXTsNCiAgICA+ICANCiAgICA+IC0JaWYgKCEobmV0Zl9ycV9sdW4g
JiBORVRGTl9SU1BfQklUX01BU0spKQ0KICAgID4gLQkJcmV0dXJuIC1FSU5WQUw7DQogICAgPiAt
DQogICAgPiAgCS8qDQogICAgPiAgCSAqIHN1YnRyYWN0IHJxX3NhIGFuZCBuZXRmX3JxX2x1biBm
cm9tIHRoZSBsZW5ndGggb2YgdGhlIG1zZyBwYXNzZWQgdG8NCiAgICA+ICAJICogaTJjX3NtYnVz
X3hmZXINCiAgICA+IEBAIC0yMDMsMjUgKzIwMCwxNiBAQCBzdGF0aWMgdTggaXBtYl92ZXJpZnlf
Y2hlY2tzdW0xKHN0cnVjdCBpcG1iX2RldiAqaXBtYl9kZXYsIHU4IHJzX3NhKQ0KICAgID4gIAkJ
aXBtYl9kZXYtPnJlcXVlc3QuY2hlY2tzdW0xKTsNCiAgICA+ICB9DQogICAgPiAgDQogICAgPiAt
c3RhdGljIGJvb2wgaXNfaXBtYl9yZXF1ZXN0KHN0cnVjdCBpcG1iX2RldiAqaXBtYl9kZXYsIHU4
IHJzX3NhKQ0KICAgID4gKy8qDQogICAgPiArICogVmVyaWZ5IGlmIG1lc3NhZ2UgaGFzIHByb3Bl
ciBpcG1iIGhlYWRlciB3aXRoIG1pbmltdW0gbGVuZ3RoDQogICAgPiArICogYW5kIGNvcnJlY3Qg
Y2hlY2tzdW0gYnl0ZS4NCiAgICA+ICsgKi8NCiAgICA+ICtzdGF0aWMgYm9vbCBpc19pcG1iX21z
ZyhzdHJ1Y3QgaXBtYl9kZXYgKmlwbWJfZGV2LCB1OCByc19zYSkNCiAgICA+ICB7DQogICAgPiAt
CWlmIChpcG1iX2Rldi0+bXNnX2lkeCA+PSBJUE1CX1JFUVVFU1RfTEVOX01JTikgew0KICAgID4g
LQkJaWYgKGlwbWJfdmVyaWZ5X2NoZWNrc3VtMShpcG1iX2RldiwgcnNfc2EpKQ0KICAgID4gLQkJ
CXJldHVybiBmYWxzZTsNCiAgICA+ICsJaWYgKChpcG1iX2Rldi0+bXNnX2lkeCA+PSBJUE1CX1JF
UVVFU1RfTEVOX01JTikgJiYNCiAgICA+ICsJICAgKCFpcG1iX3ZlcmlmeV9jaGVja3N1bTEoaXBt
Yl9kZXYsIHJzX3NhKSkpDQogICAgPiArCQlyZXR1cm4gdHJ1ZTsNCiAgICA+ICANCiAgICA+IC0J
CS8qDQogICAgPiAtCQkgKiBDaGVjayB3aGV0aGVyIHRoaXMgaXMgYW4gSVBNQiByZXF1ZXN0IG9y
DQogICAgPiAtCQkgKiByZXNwb25zZS4NCiAgICA+IC0JCSAqIFRoZSA2IE1TQiBvZiBuZXRmbl9y
c19sdW4gYXJlIGRlZGljYXRlZCB0byB0aGUgbmV0Zm4NCiAgICA+IC0JCSAqIHdoaWxlIHRoZSBy
ZW1haW5pbmcgYml0cyBhcmUgZGVkaWNhdGVkIHRvIHRoZSBsdW4uDQogICAgPiAtCQkgKiBJZiB0
aGUgTFNCIG9mIHRoZSBuZXRmbiBpcyBjbGVhcmVkLCBpdCBpcyBhc3NvY2lhdGVkDQogICAgPiAt
CQkgKiB3aXRoIGFuIElQTUIgcmVxdWVzdC4NCiAgICA+IC0JCSAqIElmIHRoZSBMU0Igb2YgdGhl
IG5ldGZuIGlzIHNldCwgaXQgaXMgYXNzb2NpYXRlZCB3aXRoDQogICAgPiAtCQkgKiBhbiBJUE1C
IHJlc3BvbnNlLg0KICAgID4gLQkJICovDQogICAgPiAtCQlpZiAoIShpcG1iX2Rldi0+cmVxdWVz
dC5uZXRmbl9yc19sdW4gJiBORVRGTl9SU1BfQklUX01BU0spKQ0KICAgID4gLQkJCXJldHVybiB0
cnVlOw0KICAgID4gLQl9DQogICAgPiAgCXJldHVybiBmYWxzZTsNCiAgICA+ICB9DQogICAgPiAg
DQogICAgPiBAQCAtMjczLDggKzI2MSw3IEBAIHN0YXRpYyBpbnQgaXBtYl9zbGF2ZV9jYihzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KICAgID4gIA0KICAgID4gIAljYXNlIEkyQ19TTEFWRV9T
VE9QOg0KICAgID4gIAkJaXBtYl9kZXYtPnJlcXVlc3QubGVuID0gaXBtYl9kZXYtPm1zZ19pZHg7
DQogICAgPiAtDQogICAgPiAtCQlpZiAoaXNfaXBtYl9yZXF1ZXN0KGlwbWJfZGV2LCBHRVRfOEJJ
VF9BRERSKGNsaWVudC0+YWRkcikpKQ0KICAgID4gKwkJaWYgKGlzX2lwbWJfbXNnKGlwbWJfZGV2
LCBHRVRfOEJJVF9BRERSKGNsaWVudC0+YWRkcikpKQ0KICAgID4gIAkJCWlwbWJfaGFuZGxlX3Jl
cXVlc3QoaXBtYl9kZXYpOw0KICAgID4gIAkJYnJlYWs7DQogICAgPiAgDQogICAgPiAtLSANCiAg
ICA+IDIuMTcuMQ0KICAgID4gDQogICAgDQoNCg==
