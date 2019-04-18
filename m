Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CA7C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18D720821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BxZGv9iN";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="iaPpprwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfDREYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:24:55 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38632 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbfDREYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:24:55 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I4OpIO022151;
        Wed, 17 Apr 2019 21:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=cQ5IzbqdXc+9yplRjaBV/9SizOzTspjNujTCNcUgZfg=;
 b=BxZGv9iNYldfAXis+betvGr9Q/YhNTUGUvxegGgTgIrvDokqiAAK7ht+ZF8CSAkVFIBy
 SHqbjY24ke62FaU7QL6Nr8o3Po+EuPw19BNINRB9UaiqD3Qt1kz8q4oWQzS3WOoV1yCU
 fW/LR0WDvg5gLJxtBLN3+gjGUOH7269G1kLDddEJ9Hld3bGFIlHM2ECRB8DhsqWpThu8
 fDB0TeuxA1rzv0SkmPLzM5TbJQAw3zf3vmpiPpLWFgtwIOyDcSH6b6/9/XNb/xQlQmNF
 7CYS6ZxMha3C4VGJbGokJzdIgpIaNDaF1uxo//O88HT6p9gqtoGEEj335mm6TFIdUlxw Vw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rxh890673-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Apr 2019 21:24:51 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 17 Apr
 2019 21:24:49 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 17 Apr 2019 21:24:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ5IzbqdXc+9yplRjaBV/9SizOzTspjNujTCNcUgZfg=;
 b=iaPpprwngu6hUzv1/KIG2RmYyhfvBTr1jgMj+q9IxssaV5Flx93BiKhp1hOeOJsJpDhVV65MnGSdbg5tCUrAks0uMS3PLYABqt4m1A5Q5mg/oduoJkzDroq5bVy3tHqCI2K/l2G4NsE1NEAqASv6q5PFUO3GgXckUKOscEjTUgk=
Received: from BYAPR18MB2485.namprd18.prod.outlook.com (20.179.92.143) by
 BYAPR18MB2806.namprd18.prod.outlook.com (20.179.57.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 04:24:44 +0000
Received: from BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::a00b:9c29:35fb:4b7b]) by BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::a00b:9c29:35fb:4b7b%5]) with mapi id 15.20.1792.018; Thu, 18 Apr 2019
 04:24:44 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Colin King <colin.king@canonical.com>,
        "QLogic-Storage-Upstream@cavium.com" 
        <QLogic-Storage-Upstream@cavium.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: qedi: fix spelling mistake "oflload" -> "offload"
Thread-Topic: [PATCH] scsi: qedi: fix spelling mistake "oflload" -> "offload"
Thread-Index: AQHU9SOLXb7jnqyL60anZan+bF+P+6ZBUuhQ
Date:   Thu, 18 Apr 2019 04:24:44 +0000
Message-ID: <BYAPR18MB248594819C8CBA9EEA021EA1D8260@BYAPR18MB2485.namprd18.prod.outlook.com>
References: <20190417134304.10979-1-colin.king@canonical.com>
In-Reply-To: <20190417134304.10979-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b22d4d48-b5e7-4528-0e88-08d6c3b5c8cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR18MB2806;
x-ms-traffictypediagnostic: BYAPR18MB2806:
x-microsoft-antispam-prvs: <BYAPR18MB2806B9A5645F714213C30864D8260@BYAPR18MB2806.namprd18.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(13464003)(199004)(189003)(316002)(26005)(99286004)(25786009)(71200400001)(71190400001)(52536014)(33656002)(229853002)(6246003)(4326008)(66066001)(76176011)(6116002)(54906003)(55016002)(53936002)(110136005)(7696005)(3846002)(81166006)(14444005)(9686003)(68736007)(102836004)(8676002)(186003)(86362001)(6436002)(14454004)(97736004)(11346002)(53546011)(478600001)(5660300002)(8936002)(2906002)(446003)(2501003)(256004)(476003)(74316002)(6506007)(81156014)(486006)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2806;H:BYAPR18MB2485.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DgxC+qRC5WalpFW55h1nKunatn69Tn6uyWSzw1anaku4kBQ9/lmPChpmTCPW1Bf82bsfDHiOTGvUr6Tqus+PCKZCEHO5AQ8DChB04DKSZQNqhvyO0GwcUOtLCcOP8nV2fu3SKTHo15Fcf7WQYvRnBbRRfpxBjSDVtWdlkD5BTTAnfNEoLUR7rLJ8URqGge3SlV4sndbcIpNvaZ8TghEERKE0QX7l+5DPGYRa6TBMYYweGeUw9lodKncPObmX40KNMUkAOFqp1v0K+6Fj4CWHzWtYM7codm0IxH+KfbeQOgDA6y/dUxxbJL9Vg7QOrxpjWeGNagyK4X4kR0yKTFGepssn4XmCNyPdvp9yo93BTCginPKhd/DxwvyQipOwSM0TRxoEElU33NR5aqtkNq0W1xIuJQx2p+v5yE2I5AYj1TU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b22d4d48-b5e7-4528-0e88-08d6c3b5c8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 04:24:44.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2806
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENvbGluIEtpbmcgPGNvbGlu
LmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxNywgMjAxOSA3
OjEzIFBNDQo+IFRvOiBRTG9naWMtU3RvcmFnZS1VcHN0cmVhbUBjYXZpdW0uY29tOyBKYW1lcyBF
IC4gSiAuIEJvdHRvbWxleQ0KPiA8amVqYkBsaW51eC5pYm0uY29tPjsgTWFydGluIEsgLiBQZXRl
cnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+Ow0KPiBsaW51eC1zY3NpQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzoga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNjc2k6IHFlZGk6IGZpeCBz
cGVsbGluZyBtaXN0YWtlICJvZmxsb2FkIiAtPiAib2ZmbG9hZCINCj4gDQo+IEZyb206IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBUaGVyZSBhcmUgYSBj
b3VwbGUgb2Ygc3BlbGxpbmcgbWlzdGFrZXMgaW4gc29tZSBrZXJuZWwgYWxlcnQgbWVzc2FnZXMu
DQo+IEZpeCB0aGVzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xp
bi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zY3NpL3FlZGkvcWVkaV9p
c2NzaS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9xZWRpL3FlZGlfaXNj
c2kuYyBiL2RyaXZlcnMvc2NzaS9xZWRpL3FlZGlfaXNjc2kuYw0KPiBpbmRleCA2ZDZkNjAxM2Uz
NWIuLmU0MzkxZWUyYzI3YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL3FlZGkvcWVkaV9p
c2NzaS5jDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS9xZWRpL3FlZGlfaXNjc2kuYw0KPiBAQCAtNTc5
LDcgKzU3OSw3IEBAIHN0YXRpYyBpbnQgcWVkaV9jb25uX3N0YXJ0KHN0cnVjdCBpc2NzaV9jbHNf
Y29ubg0KPiAqY2xzX2Nvbm4pDQo+ICAJcnZhbCA9IHFlZGlfaXNjc2lfdXBkYXRlX2Nvbm4ocWVk
aSwgcWVkaV9jb25uKTsNCj4gIAlpZiAocnZhbCkgew0KPiAgCQlpc2NzaV9jb25uX3ByaW50ayhL
RVJOX0FMRVJULCBjb25uLA0KPiAtCQkJCSAgImNvbm5fc3RhcnQ6IEZXIG9mbGxvYWQgY29ubiBm
YWlsZWQuXG4iKTsNCj4gKwkJCQkgICJjb25uX3N0YXJ0OiBGVyBvZmZsb2FkIGNvbm4gZmFpbGVk
LlxuIik7DQo+ICAJCXJ2YWwgPSAtRUlOVkFMOw0KPiAgCQlnb3RvIHN0YXJ0X2VycjsNCj4gIAl9
DQo+IEBAIC01OTAsNyArNTkwLDcgQEAgc3RhdGljIGludCBxZWRpX2Nvbm5fc3RhcnQoc3RydWN0
IGlzY3NpX2Nsc19jb25uDQo+ICpjbHNfY29ubikNCj4gIAlydmFsID0gaXNjc2lfY29ubl9zdGFy
dChjbHNfY29ubik7DQo+ICAJaWYgKHJ2YWwpIHsNCj4gIAkJaXNjc2lfY29ubl9wcmludGsoS0VS
Tl9BTEVSVCwgY29ubiwNCj4gLQkJCQkgICJpc2NzaV9jb25uX3N0YXJ0OiBGVyBvZmxsb2FkIGNv
bm4NCj4gZmFpbGVkISFcbiIpOw0KPiArCQkJCSAgImlzY3NpX2Nvbm5fc3RhcnQ6IEZXIG9mZmxv
YWQgY29ubg0KPiBmYWlsZWQhIVxuIik7DQo+ICAJfQ0KPiANCj4gIHN0YXJ0X2VycjoNCj4gLS0N
Cj4gMi4yMC4xDQoNClRoYW5rcywNCkFja2VkLWJ5OiBNYW5pc2ggUmFuZ2Fua2FyIDxtcmFuZ2Fu
a2FyQG1hcnZlbGwuY29tPg0KDQo=
