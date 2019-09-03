Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ECB22CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="iUBYVF03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfICLgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:36:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:45154 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbfICLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:36:12 -0400
X-Greylist: delayed 1313 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 07:36:11 EDT
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83B9tLv025014;
        Tue, 3 Sep 2019 04:14:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=8gtaYTJc3RqkPk1V+PqvxhZ+TAGj2m9OGdWs3ukyz1o=;
 b=iUBYVF03V3aN1/u/j9/zMojDJvq/unL+q664xllS3qsyHNkp7uTRlFBOtAIeJTpz5YFG
 tv/T39blcjY0fYps7j7uQKWf+U05o1BN11pvP/UqC7NNHJLBPgVH3FL4yMleqtLLz17V
 8KVIK8JbzyBQYOR0dCt41EfF51Z8OdXBdALcyeCWFx1MIa29pwgbVC7/OkTAId2cjTDJ
 b8bti++1lNe0FmSqTD4Rh3W8+skm0P8HPQQHE7VpHc3Tp+yX/FJ2V3AfjXco9ycMIdRx
 oN2Pr5/xQn+r2zna3XKx5n+p5VKdQt3eJfAyMbcrQ/t1Iv/ChxG0CqqsacdwPH1x+jnb +A== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2055.outbound.protection.outlook.com [104.47.34.55])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2uqrexmqu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 04:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYPGC2+Fni+HQvl4AKjazs+NoAdXEerrkYXO6EM2jL2gSZbnweqV/VbzBc6GFahlKYpRaVvA0p3hEGJpSi41fcTAAesVaZM8YlRXHYSpc547fB4oWe5AGAbX6uAfV6w9HwKLhYWruPDF3ExnRnNnUbRSs3S8hdOjXrfxSPN3wH1wUi+JZsphhobsQjnXY+KWpDLHz3Cp2ZkObSh8m/WHB/A8ED6zz0SXNZ2uXa4Va28zt0VbGI6DuLWOxg42YC4dKVIM4jGHS7SCfWmUhdSJr7EprgT8rrv/eWY4qjCKnwd6+IBb3xjXohNR/i/M05GPuhLVCS64cKwHvQ0TMWLSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gtaYTJc3RqkPk1V+PqvxhZ+TAGj2m9OGdWs3ukyz1o=;
 b=kxruKM1BuUqOmqMiUCFq2ieQ+zS+8PiBe1n/21JAYX9QsluwDiSlu/EumSPqM1oOr81/IgLj3B1c7KTgNOuOHPjqXSzRqATWSrD2u/POPvteWezVFCAJxtMPoknfmMKd8BtWt59BaP6EFaisjA3YahF8rJdJ6Pw8ZfTasxIwFUmRZzFnzTgaEOp2N73WaxBPxW6S6dj1atmo0gaP2cw6KG2AkddXbb6RMc80oYTrCIrHPQ5XKlFGHyA9Ew/eHE4GcNDKKHs8oIQUtrKdmlnKw2nSKGmknO4sOcG91aELFZgVYnheQEPb1PqontH3KX4OdF1koom6cJur1Vgt/SQXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com (52.132.98.38) by
 CY4PR0201MB3409.namprd02.prod.outlook.com (52.132.98.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 3 Sep 2019 11:14:12 +0000
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737]) by CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737%6]) with mapi id 15.20.2199.021; Tue, 3 Sep 2019
 11:14:12 +0000
From:   Florian Schmidt <florian.schmidt@nutanix.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>
Subject: [PATCH 1/2] trace-vmscan-postprocess: sync with tracepoints updates
Thread-Topic: [PATCH 1/2] trace-vmscan-postprocess: sync with tracepoints
 updates
Thread-Index: AQHVYki3Tm9nzAyXjk2sNXBveXCZqQ==
Date:   Tue, 3 Sep 2019 11:14:12 +0000
Message-ID: <20190903111342.17731-2-florian.schmidt@nutanix.com>
References: <20190903111342.17731-1-florian.schmidt@nutanix.com>
In-Reply-To: <20190903111342.17731-1-florian.schmidt@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To CY4PR0201MB3588.namprd02.prod.outlook.com
 (2603:10b6:910:8b::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6764e21-9776-4ee2-111c-08d7305fd956
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR0201MB3409;
x-ms-traffictypediagnostic: CY4PR0201MB3409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0201MB340940D00CEF517A7770907BF7B90@CY4PR0201MB3409.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(366004)(376002)(396003)(189003)(199004)(1076003)(36756003)(305945005)(476003)(6512007)(186003)(71190400001)(71200400001)(50226002)(107886003)(81166006)(66066001)(14454004)(52116002)(81156014)(8676002)(86362001)(7736002)(6486002)(54906003)(5660300002)(102836004)(66946007)(3846002)(6116002)(4326008)(66476007)(66556008)(316002)(8936002)(478600001)(76176011)(6916009)(26005)(2906002)(486006)(53936002)(44832011)(25786009)(446003)(6506007)(386003)(11346002)(15650500001)(64756008)(99286004)(2616005)(14444005)(256004)(6436002)(66446008)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0201MB3409;H:CY4PR0201MB3588.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TUBJfIvqSYIU+NDMHnr4tpa3COXDdbiJy1KFcJ1Co2uFg6a+PWp84wt7rLBDP5WJEbX/oBPhAxMYV1HZmphEnLgP3M3ZDdL8ctmVlDweQh3CkSjtCksswnMUJNjAyx88Bt/7qWk0rh9IKEmiTAM2wNmf8yg2FlhpLA2JgTN2JMfvHsZ9QyDK2KhCc2g8ckr1l0LOdZInjOf5LXJOwSXPKI/DClODh2Zj1lmlaD/JvN0/u4W6HqhGf4lLqgYlXRq4waIP+Sq8Lx1DpJKGlCJ0UHntB4Qtl8PDoez6Q0O0jX9dqQfR3yoyDjyukHtsXzP0dK7LCjnbXd7sdK9d1NLudMVY5cGqnPz7VNrONeXxd3+dcw8fvDdeiBGcbZkjE6JxadXHxa4JD9LVrrqiaBiRvKRbUR6SK2xXkai/635jyM4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6764e21-9776-4ee2-111c-08d7305fd956
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 11:14:12.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Urfc+feGtT2MmYokExg5Unt2sUaYvHtn98io3O+M6QqB39KEZZVp+eNNwvfhV002/EAst7U2wuCZF20P3kaeMIMEN28bzZDR6+t/lpUm/0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3409
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bW1fdm1zY2FuX3tkaXJlY3RfcmVjbGFpbV9iZWdpbix3YWtldXBfa3N3YXBkLGxydV9pc29sYXRl
LGxydV9zaHJpbmtfYWN0aXZlfQ0KY2hhbmdlZCB0aGVpciBvdXRwdXQgdG8gdGhlIHBvaW50IHdo
ZXJlIHRoZSBzY3JpcHQgdGhyb3dzIHdhcm5pbmdzIGFuZA0KZXJyb3JzLiBVcGRhdGUgaXQgdG8g
YmUgcHJvcGVybHkgaW4gbGluZSB3aXRoIHRob3NlIGNoYW5nZXMuDQoNClNpZ25lZC1vZmYtYnk6
IEZsb3JpYW4gU2NobWlkdCA8Zmxvcmlhbi5zY2htaWR0QG51dGFuaXguY29tPg0KLS0tDQogLi4u
L3Bvc3Rwcm9jZXNzL3RyYWNlLXZtc2Nhbi1wb3N0cHJvY2Vzcy5wbCAgIHwgMjMgKysrKysrKysr
LS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhY2UvcG9zdHByb2Nlc3MvdHJh
Y2Utdm1zY2FuLXBvc3Rwcm9jZXNzLnBsIGIvRG9jdW1lbnRhdGlvbi90cmFjZS9wb3N0cHJvY2Vz
cy90cmFjZS12bXNjYW4tcG9zdHByb2Nlc3MucGwNCmluZGV4IDk5NWRhMTViMTZjYS4uNmM0ZTNm
ZGU5NDQ3IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFjZS9wb3N0cHJvY2Vzcy90cmFj
ZS12bXNjYW4tcG9zdHByb2Nlc3MucGwNCisrKyBiL0RvY3VtZW50YXRpb24vdHJhY2UvcG9zdHBy
b2Nlc3MvdHJhY2Utdm1zY2FuLXBvc3Rwcm9jZXNzLnBsDQpAQCAtMTA3LDE0ICsxMDcsMTQgQEAg
R2V0T3B0aW9ucygNCiApOw0KIA0KICMgRGVmYXVsdHMgZm9yIGR5bmFtaWNhbGx5IGRpc2NvdmVy
ZWQgcmVnZXgncw0KLW15ICRyZWdleF9kaXJlY3RfYmVnaW5fZGVmYXVsdCA9ICdvcmRlcj0oWzAt
OV0qKSBtYXlfd3JpdGVwYWdlPShbMC05XSopIGdmcF9mbGFncz0oW0EtWl98XSopJzsNCitteSAk
cmVnZXhfZGlyZWN0X2JlZ2luX2RlZmF1bHQgPSAnb3JkZXI9KFswLTldKikgZ2ZwX2ZsYWdzPShb
QS1aX3xdKiknOw0KIG15ICRyZWdleF9kaXJlY3RfZW5kX2RlZmF1bHQgPSAnbnJfcmVjbGFpbWVk
PShbMC05XSopJzsNCiBteSAkcmVnZXhfa3N3YXBkX3dha2VfZGVmYXVsdCA9ICduaWQ9KFswLTld
Kikgb3JkZXI9KFswLTldKiknOw0KIG15ICRyZWdleF9rc3dhcGRfc2xlZXBfZGVmYXVsdCA9ICdu
aWQ9KFswLTldKiknOw0KLW15ICRyZWdleF93YWtldXBfa3N3YXBkX2RlZmF1bHQgPSAnbmlkPShb
MC05XSopIHppZD0oWzAtOV0qKSBvcmRlcj0oWzAtOV0qKSBnZnBfZmxhZ3M9KFtBLVpffF0qKSc7
DQotbXkgJHJlZ2V4X2xydV9pc29sYXRlX2RlZmF1bHQgPSAnaXNvbGF0ZV9tb2RlPShbMC05XSop
IGNsYXNzem9uZV9pZHg9KFswLTldKikgb3JkZXI9KFswLTldKikgbnJfcmVxdWVzdGVkPShbMC05
XSopIG5yX3NjYW5uZWQ9KFswLTldKikgbnJfc2tpcHBlZD0oWzAtOV0qKSBucl90YWtlbj0oWzAt
OV0qKSBscnU9KFthLXpfXSopJzsNCitteSAkcmVnZXhfd2FrZXVwX2tzd2FwZF9kZWZhdWx0ID0g
J25pZD0oWzAtOV0qKSBvcmRlcj0oWzAtOV0qKSBnZnBfZmxhZ3M9KFtBLVpffF0qKSc7DQorbXkg
JHJlZ2V4X2xydV9pc29sYXRlX2RlZmF1bHQgPSAnaXNvbGF0ZV9tb2RlPShbMC05XSopIGNsYXNz
em9uZT0oWzAtOV0qKSBvcmRlcj0oWzAtOV0qKSBucl9yZXF1ZXN0ZWQ9KFswLTldKikgbnJfc2Nh
bm5lZD0oWzAtOV0qKSBucl9za2lwcGVkPShbMC05XSopIG5yX3Rha2VuPShbMC05XSopIGxydT0o
W2Etel9dKiknOw0KIG15ICRyZWdleF9scnVfc2hyaW5rX2luYWN0aXZlX2RlZmF1bHQgPSAnbmlk
PShbMC05XSopIG5yX3NjYW5uZWQ9KFswLTldKikgbnJfcmVjbGFpbWVkPShbMC05XSopIG5yX2Rp
cnR5PShbMC05XSopIG5yX3dyaXRlYmFjaz0oWzAtOV0qKSBucl9jb25nZXN0ZWQ9KFswLTldKikg
bnJfaW1tZWRpYXRlPShbMC05XSopIG5yX2FjdGl2YXRlX2Fub249KFswLTldKikgbnJfYWN0aXZh
dGVfZmlsZT0oWzAtOV0qKSBucl9yZWZfa2VlcD0oWzAtOV0qKSBucl91bm1hcF9mYWlsPShbMC05
XSopIHByaW9yaXR5PShbMC05XSopIGZsYWdzPShbQS1aX3xdKiknOw0KLW15ICRyZWdleF9scnVf
c2hyaW5rX2FjdGl2ZV9kZWZhdWx0ID0gJ2xydT0oW0EtWl9dKikgbnJfc2Nhbm5lZD0oWzAtOV0q
KSBucl9yb3RhdGVkPShbMC05XSopIHByaW9yaXR5PShbMC05XSopJzsNCitteSAkcmVnZXhfbHJ1
X3Nocmlua19hY3RpdmVfZGVmYXVsdCA9ICduaWQ9KFswLTldKikgbnJfYWN0aXZlPShbMC05XSop
IG5yX2RlYWN0aXZhdGVkPShbMC05XSopIG5yX3JlZmVyZW5jZWQ9KFswLTldKikgcHJpb3JpdHk9
KFswLTldKikgZmxhZ3M9KFtBLVpfXSopJzsNCiBteSAkcmVnZXhfd3JpdGVwYWdlX2RlZmF1bHQg
PSAncGFnZT0oWzAtOWEtZl0qKSBwZm49KFswLTldKikgZmxhZ3M9KFtBLVpffF0qKSc7DQogDQog
IyBEeWFuaWNhbGx5IGRpc2NvdmVyZWQgcmVnZXgNCkBAIC0xODQsOCArMTg0LDcgQEAgc3ViIGdl
bmVyYXRlX3RyYWNlZXZlbnRfcmVnZXggew0KICRyZWdleF9kaXJlY3RfYmVnaW4gPSBnZW5lcmF0
ZV90cmFjZWV2ZW50X3JlZ2V4KA0KIAkJCSJ2bXNjYW4vbW1fdm1zY2FuX2RpcmVjdF9yZWNsYWlt
X2JlZ2luIiwNCiAJCQkkcmVnZXhfZGlyZWN0X2JlZ2luX2RlZmF1bHQsDQotCQkJIm9yZGVyIiwg
Im1heV93cml0ZXBhZ2UiLA0KLQkJCSJnZnBfZmxhZ3MiKTsNCisJCQkib3JkZXIiLCAiZ2ZwX2Zs
YWdzIik7DQogJHJlZ2V4X2RpcmVjdF9lbmQgPSBnZW5lcmF0ZV90cmFjZWV2ZW50X3JlZ2V4KA0K
IAkJCSJ2bXNjYW4vbW1fdm1zY2FuX2RpcmVjdF9yZWNsYWltX2VuZCIsDQogCQkJJHJlZ2V4X2Rp
cmVjdF9lbmRfZGVmYXVsdCwNCkBAIC0yMDEsMTEgKzIwMCwxMSBAQCAkcmVnZXhfa3N3YXBkX3Ns
ZWVwID0gZ2VuZXJhdGVfdHJhY2VldmVudF9yZWdleCgNCiAkcmVnZXhfd2FrZXVwX2tzd2FwZCA9
IGdlbmVyYXRlX3RyYWNlZXZlbnRfcmVnZXgoDQogCQkJInZtc2Nhbi9tbV92bXNjYW5fd2FrZXVw
X2tzd2FwZCIsDQogCQkJJHJlZ2V4X3dha2V1cF9rc3dhcGRfZGVmYXVsdCwNCi0JCQkibmlkIiwg
InppZCIsICJvcmRlciIsICJnZnBfZmxhZ3MiKTsNCisJCQkibmlkIiwgIm9yZGVyIiwgImdmcF9m
bGFncyIpOw0KICRyZWdleF9scnVfaXNvbGF0ZSA9IGdlbmVyYXRlX3RyYWNlZXZlbnRfcmVnZXgo
DQogCQkJInZtc2Nhbi9tbV92bXNjYW5fbHJ1X2lzb2xhdGUiLA0KIAkJCSRyZWdleF9scnVfaXNv
bGF0ZV9kZWZhdWx0LA0KLQkJCSJpc29sYXRlX21vZGUiLCAiY2xhc3N6b25lX2lkeCIsICJvcmRl
ciIsDQorCQkJImlzb2xhdGVfbW9kZSIsICJjbGFzc3pvbmUiLCAib3JkZXIiLA0KIAkJCSJucl9y
ZXF1ZXN0ZWQiLCAibnJfc2Nhbm5lZCIsICJucl9za2lwcGVkIiwgIm5yX3Rha2VuIiwNCiAJCQki
bHJ1Iik7DQogJHJlZ2V4X2xydV9zaHJpbmtfaW5hY3RpdmUgPSBnZW5lcmF0ZV90cmFjZWV2ZW50
X3JlZ2V4KA0KQEAgLTIxOCw5ICsyMTcsOSBAQCAkcmVnZXhfbHJ1X3Nocmlua19pbmFjdGl2ZSA9
IGdlbmVyYXRlX3RyYWNlZXZlbnRfcmVnZXgoDQogJHJlZ2V4X2xydV9zaHJpbmtfYWN0aXZlID0g
Z2VuZXJhdGVfdHJhY2VldmVudF9yZWdleCgNCiAJCQkidm1zY2FuL21tX3Ztc2Nhbl9scnVfc2hy
aW5rX2FjdGl2ZSIsDQogCQkJJHJlZ2V4X2xydV9zaHJpbmtfYWN0aXZlX2RlZmF1bHQsDQotCQkJ
Im5pZCIsICJ6aWQiLA0KLQkJCSJscnUiLA0KLQkJCSJucl9zY2FubmVkIiwgIm5yX3JvdGF0ZWQi
LCAicHJpb3JpdHkiKTsNCisJCQkibmlkIiwNCisJCQkibnJfdGFrZW4iLCAibnJfYWN0aXZlIiwg
Im5yX2RlYWN0aXZhdGVkIiwgIm5yX3JlZmVyZW5jZWQiLA0KKwkJCSJwcmlvcml0eSIsICJmbGFn
cyIpOw0KICRyZWdleF93cml0ZXBhZ2UgPSBnZW5lcmF0ZV90cmFjZWV2ZW50X3JlZ2V4KA0KIAkJ
CSJ2bXNjYW4vbW1fdm1zY2FuX3dyaXRlcGFnZSIsDQogCQkJJHJlZ2V4X3dyaXRlcGFnZV9kZWZh
dWx0LA0KQEAgLTM3MSw3ICszNzAsNyBAQCBFVkVOVF9QUk9DRVNTOg0KIAkJCQlwcmludCAiICAg
ICAgICAgJHJlZ2V4X3dha2V1cF9rc3dhcGRcbiI7DQogCQkJCW5leHQ7DQogCQkJfQ0KLQkJCW15
ICRvcmRlciA9ICQzOw0KKwkJCW15ICRvcmRlciA9ICQyOw0KIAkJCSRwZXJwcm9jZXNzcGlkeyRw
cm9jZXNzX3BpZH0tPntNTV9WTVNDQU5fV0FLRVVQX0tTV0FQRF9QRVJPUkRFUn1bJG9yZGVyXSsr
Ow0KIAkJfSBlbHNpZiAoJHRyYWNlcG9pbnQgZXEgIm1tX3Ztc2Nhbl9scnVfaXNvbGF0ZSIpIHsN
CiAJCQkkZGV0YWlscyA9ICQ2Ow0KLS0gDQoyLjIzLjAucmMxDQoNCg==
