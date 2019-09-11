Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3AC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE0D2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XeDBKLtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfIKLMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:12:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:23936 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbfIKLMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:12:18 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BB9tdc009362;
        Wed, 11 Sep 2019 04:12:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=7e/kmq6PeKN0kg8l520cTFqzqFDNE073GJBAN6dDQrY=;
 b=XeDBKLtk2AppGvPgyD48T0tktJXz+uTfKf1vy7/rrWA4+ggU5XuHZYONHLOZYz+Tmboq
 7k8Awfjbf0p9VV808aqLWPKkke/oaxhZQ1xC4cm9d0u+so/B0E/RYcpd1bhxr23Xg+xt
 2K3SNWohaEyryvWDUWn3mUps1udJMwhiEDl/DzUZE2gKUM7BMp2GKPJEfcqQrY+x8U37
 83Sh2jy3j+vtKZ/wn6CZn7hAE4wutFg99XUIvzRzurGHXZQZ5wcZgWrhvki+l9XNFsr9
 KPPqGzVnDN0AZesQiyzRQHMPv7MoE2y4kk6zIxiTzJDoFKvvG8aVpjZlcjbgclZcmRJV Ug== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2uva38857m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 04:12:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbpznErVPh5OKyo1H7KnhXuK7yQKjrwnI1BUKxkQYTE3ty/5kC4fWPs+R2cQwyBf0UQV6Q9UxmP16cDo1Ax+WRLbWB6ghvakbgnuHyQ6EB9nahWZI4MWLXFxWd2oWV3j+L7GK2D8noGjDNOO6S5n457K+03WhCjQ1cNkLDvyGrrsCENylxVHJvr1yEzemjrSi9+Id/gDMuQbdxeUymFtZnAnQNHTyfB/mEz+Re1sv+hMwWdXG2GsSKsZs4U69h3dt8Ltu4LDuTcYHdTrC0gZxPe1ba6an+OYiWOi+O2Padcd2nYkdgRZN54h9nCgrkCdK50c+1uruHoGcUqNj0cU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e/kmq6PeKN0kg8l520cTFqzqFDNE073GJBAN6dDQrY=;
 b=lSUf3wlpqfWItBF5Duu+F5vFOmxNKSaeLjCO+vGCKAu2mX+miq7Z5mkdqNdbyC7vAHPPfkuAKZe+yp/yL9LmSOEq+U4DhL9HoEUYUDe6H5b9sQdy+qnaRFwFVPUUwqn+Dsk9pi8fU0TbSu+KDed5Vs2br6eSOqOUoyWvbxDH2YSq4u6WpZG3ateO84K/yfssZ9OG5EGHz3YsbNoJlO+/3c7JbMRhrIewpbu4t0uDhJkqQ8Ggukz/bU4eTOBjNYgMbyGYy5K4/zZuHvIJ36x1PuPTMIB+Vnf7pSkYtHtUjcyquScTZ52DEV0NvvL/QnrZHv3N4o2aDIukkC8rfBZzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com (52.132.98.38) by
 CY4PR0201MB3475.namprd02.prod.outlook.com (52.132.99.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Wed, 11 Sep 2019 11:12:12 +0000
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737]) by CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737%6]) with mapi id 15.20.2199.027; Wed, 11 Sep 2019
 11:12:12 +0000
From:   Florian Schmidt <florian.schmidt@nutanix.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>
Subject: [PATCH v2 1/2] trace-vmscan-postprocess: sync with tracepoints
 updates
Thread-Topic: [PATCH v2 1/2] trace-vmscan-postprocess: sync with tracepoints
 updates
Thread-Index: AQHVaJHCcRUKuYJfIUSdh4VKaEt33A==
Date:   Wed, 11 Sep 2019 11:12:12 +0000
Message-ID: <20190911111146.14799-2-florian.schmidt@nutanix.com>
References: <20190911111146.14799-1-florian.schmidt@nutanix.com>
In-Reply-To: <20190911111146.14799-1-florian.schmidt@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:207:1::19) To CY4PR0201MB3588.namprd02.prod.outlook.com
 (2603:10b6:910:8b::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e7a594c-724f-4749-af51-08d736a8e530
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR0201MB3475;
x-ms-traffictypediagnostic: CY4PR0201MB3475:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0201MB347598CEA45101783EF85721F7B10@CY4PR0201MB3475.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(6512007)(6506007)(386003)(256004)(446003)(44832011)(2616005)(66476007)(81156014)(81166006)(66946007)(64756008)(66446008)(66556008)(14444005)(11346002)(66066001)(476003)(8936002)(50226002)(102836004)(486006)(8676002)(186003)(71200400001)(54906003)(26005)(4326008)(71190400001)(478600001)(107886003)(6436002)(1076003)(316002)(52116002)(36756003)(15650500001)(6486002)(99286004)(5660300002)(305945005)(2906002)(14454004)(76176011)(53936002)(6916009)(25786009)(7736002)(3846002)(6116002)(86362001)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0201MB3475;H:CY4PR0201MB3588.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X12LCki4bH/bH2JFvi7QmK16pT5/db4OiKrmyeY56eCgbsRmBevqQxMTdBCUzMzo4joRP4o3D/Luu23ijjgT71FkjZx3ADooQXcH1AL8xk7H2Z1rjPss67VtKC8WcvdrFvYuaiNeI21kawz440AhXrEMkHuS7Ts72Oa2PEBgdb9YNNOFy9FYCu/mW7awTZRypbUeKSvtXcW6iYVSqSzI+Z0/NTUf4D+lLZIBZ4Fay1OCOycjZKJUkhnjw/WZ/dyr7IargC7RDbsqpBQRgS/wUcW71NULCtKp7fYGaK/iBt2XAN9pSZvnBc4uwWOUsm0QI99TJFvqobKjiaeDFi+GtkuVCxRxoxn2/GQ0SMtL84e+4FY77N+JI/UtiNfSjmICUC5kYGXw37djfjxpLsmiaTkukN/CFn7DifRmLkQ5+es=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7a594c-724f-4749-af51-08d736a8e530
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 11:12:12.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0y+cQYRLPdg0OPj31qHhO2Lu+t3CZl/30TWaAUj7kKWNKIARBsd1FWSMl7lzRTXfseTZfrZG5lq3ONvTS23exsxtu/3NoJ+rGbrK4kp898=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3475
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_07:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bW1fdm1zY2FuX3tkaXJlY3RfcmVjbGFpbV9iZWdpbix3YWtldXBfa3N3YXBkLGxydV9pc29sYXRl
LGxydV9zaHJpbmtfYWN0aXZlfQ0KY2hhbmdlZCB0aGVpciBvdXRwdXQgdG8gdGhlIHBvaW50IHdo
ZXJlIHRoZSBzY3JpcHQgdGhyb3dzIHdhcm5pbmdzIGFuZA0KZXJyb3JzLiBVcGRhdGUgaXQgdG8g
YmUgcHJvcGVybHkgaW4gbGluZSB3aXRoIHRob3NlIGNoYW5nZXMuDQoNCkZpeGVzOiAzNDgxYzM3
ZmZhMWQgKCJtbS92bXNjYW46IGRyb3AgbWF5X3dyaXRlcGFnZSBhbmQgY2xhc3N6b25lX2lkeCBm
cm9tIGRpcmVjdCByZWNsYWltIGJlZ2luIHRlbXBsYXRlIikNCkZpeGVzOiAzYjc3NTk5OGVjYTcg
KCJpbmNsdWRlL3RyYWNlL2V2ZW50cy92bXNjYW4uaDogZHJvcCB6b25lIGlkIGZyb20ga3N3YXBk
IHRyYWNlcG9pbnRzIikNClNpZ25lZC1vZmYtYnk6IEZsb3JpYW4gU2NobWlkdCA8Zmxvcmlhbi5z
Y2htaWR0QG51dGFuaXguY29tPg0KLS0tDQogLi4uL3Bvc3Rwcm9jZXNzL3RyYWNlLXZtc2Nhbi1w
b3N0cHJvY2Vzcy5wbCAgIHwgMjMgKysrKysrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vdHJhY2UvcG9zdHByb2Nlc3MvdHJhY2Utdm1zY2FuLXBvc3Rwcm9jZXNzLnBsIGIv
RG9jdW1lbnRhdGlvbi90cmFjZS9wb3N0cHJvY2Vzcy90cmFjZS12bXNjYW4tcG9zdHByb2Nlc3Mu
cGwNCmluZGV4IDk5NWRhMTViMTZjYS4uNmM0ZTNmZGU5NDQ3IDEwMDY0NA0KLS0tIGEvRG9jdW1l
bnRhdGlvbi90cmFjZS9wb3N0cHJvY2Vzcy90cmFjZS12bXNjYW4tcG9zdHByb2Nlc3MucGwNCisr
KyBiL0RvY3VtZW50YXRpb24vdHJhY2UvcG9zdHByb2Nlc3MvdHJhY2Utdm1zY2FuLXBvc3Rwcm9j
ZXNzLnBsDQpAQCAtMTA3LDE0ICsxMDcsMTQgQEAgR2V0T3B0aW9ucygNCiApOw0KIA0KICMgRGVm
YXVsdHMgZm9yIGR5bmFtaWNhbGx5IGRpc2NvdmVyZWQgcmVnZXgncw0KLW15ICRyZWdleF9kaXJl
Y3RfYmVnaW5fZGVmYXVsdCA9ICdvcmRlcj0oWzAtOV0qKSBtYXlfd3JpdGVwYWdlPShbMC05XSop
IGdmcF9mbGFncz0oW0EtWl98XSopJzsNCitteSAkcmVnZXhfZGlyZWN0X2JlZ2luX2RlZmF1bHQg
PSAnb3JkZXI9KFswLTldKikgZ2ZwX2ZsYWdzPShbQS1aX3xdKiknOw0KIG15ICRyZWdleF9kaXJl
Y3RfZW5kX2RlZmF1bHQgPSAnbnJfcmVjbGFpbWVkPShbMC05XSopJzsNCiBteSAkcmVnZXhfa3N3
YXBkX3dha2VfZGVmYXVsdCA9ICduaWQ9KFswLTldKikgb3JkZXI9KFswLTldKiknOw0KIG15ICRy
ZWdleF9rc3dhcGRfc2xlZXBfZGVmYXVsdCA9ICduaWQ9KFswLTldKiknOw0KLW15ICRyZWdleF93
YWtldXBfa3N3YXBkX2RlZmF1bHQgPSAnbmlkPShbMC05XSopIHppZD0oWzAtOV0qKSBvcmRlcj0o
WzAtOV0qKSBnZnBfZmxhZ3M9KFtBLVpffF0qKSc7DQotbXkgJHJlZ2V4X2xydV9pc29sYXRlX2Rl
ZmF1bHQgPSAnaXNvbGF0ZV9tb2RlPShbMC05XSopIGNsYXNzem9uZV9pZHg9KFswLTldKikgb3Jk
ZXI9KFswLTldKikgbnJfcmVxdWVzdGVkPShbMC05XSopIG5yX3NjYW5uZWQ9KFswLTldKikgbnJf
c2tpcHBlZD0oWzAtOV0qKSBucl90YWtlbj0oWzAtOV0qKSBscnU9KFthLXpfXSopJzsNCitteSAk
cmVnZXhfd2FrZXVwX2tzd2FwZF9kZWZhdWx0ID0gJ25pZD0oWzAtOV0qKSBvcmRlcj0oWzAtOV0q
KSBnZnBfZmxhZ3M9KFtBLVpffF0qKSc7DQorbXkgJHJlZ2V4X2xydV9pc29sYXRlX2RlZmF1bHQg
PSAnaXNvbGF0ZV9tb2RlPShbMC05XSopIGNsYXNzem9uZT0oWzAtOV0qKSBvcmRlcj0oWzAtOV0q
KSBucl9yZXF1ZXN0ZWQ9KFswLTldKikgbnJfc2Nhbm5lZD0oWzAtOV0qKSBucl9za2lwcGVkPShb
MC05XSopIG5yX3Rha2VuPShbMC05XSopIGxydT0oW2Etel9dKiknOw0KIG15ICRyZWdleF9scnVf
c2hyaW5rX2luYWN0aXZlX2RlZmF1bHQgPSAnbmlkPShbMC05XSopIG5yX3NjYW5uZWQ9KFswLTld
KikgbnJfcmVjbGFpbWVkPShbMC05XSopIG5yX2RpcnR5PShbMC05XSopIG5yX3dyaXRlYmFjaz0o
WzAtOV0qKSBucl9jb25nZXN0ZWQ9KFswLTldKikgbnJfaW1tZWRpYXRlPShbMC05XSopIG5yX2Fj
dGl2YXRlX2Fub249KFswLTldKikgbnJfYWN0aXZhdGVfZmlsZT0oWzAtOV0qKSBucl9yZWZfa2Vl
cD0oWzAtOV0qKSBucl91bm1hcF9mYWlsPShbMC05XSopIHByaW9yaXR5PShbMC05XSopIGZsYWdz
PShbQS1aX3xdKiknOw0KLW15ICRyZWdleF9scnVfc2hyaW5rX2FjdGl2ZV9kZWZhdWx0ID0gJ2xy
dT0oW0EtWl9dKikgbnJfc2Nhbm5lZD0oWzAtOV0qKSBucl9yb3RhdGVkPShbMC05XSopIHByaW9y
aXR5PShbMC05XSopJzsNCitteSAkcmVnZXhfbHJ1X3Nocmlua19hY3RpdmVfZGVmYXVsdCA9ICdu
aWQ9KFswLTldKikgbnJfYWN0aXZlPShbMC05XSopIG5yX2RlYWN0aXZhdGVkPShbMC05XSopIG5y
X3JlZmVyZW5jZWQ9KFswLTldKikgcHJpb3JpdHk9KFswLTldKikgZmxhZ3M9KFtBLVpfXSopJzsN
CiBteSAkcmVnZXhfd3JpdGVwYWdlX2RlZmF1bHQgPSAncGFnZT0oWzAtOWEtZl0qKSBwZm49KFsw
LTldKikgZmxhZ3M9KFtBLVpffF0qKSc7DQogDQogIyBEeWFuaWNhbGx5IGRpc2NvdmVyZWQgcmVn
ZXgNCkBAIC0xODQsOCArMTg0LDcgQEAgc3ViIGdlbmVyYXRlX3RyYWNlZXZlbnRfcmVnZXggew0K
ICRyZWdleF9kaXJlY3RfYmVnaW4gPSBnZW5lcmF0ZV90cmFjZWV2ZW50X3JlZ2V4KA0KIAkJCSJ2
bXNjYW4vbW1fdm1zY2FuX2RpcmVjdF9yZWNsYWltX2JlZ2luIiwNCiAJCQkkcmVnZXhfZGlyZWN0
X2JlZ2luX2RlZmF1bHQsDQotCQkJIm9yZGVyIiwgIm1heV93cml0ZXBhZ2UiLA0KLQkJCSJnZnBf
ZmxhZ3MiKTsNCisJCQkib3JkZXIiLCAiZ2ZwX2ZsYWdzIik7DQogJHJlZ2V4X2RpcmVjdF9lbmQg
PSBnZW5lcmF0ZV90cmFjZWV2ZW50X3JlZ2V4KA0KIAkJCSJ2bXNjYW4vbW1fdm1zY2FuX2RpcmVj
dF9yZWNsYWltX2VuZCIsDQogCQkJJHJlZ2V4X2RpcmVjdF9lbmRfZGVmYXVsdCwNCkBAIC0yMDEs
MTEgKzIwMCwxMSBAQCAkcmVnZXhfa3N3YXBkX3NsZWVwID0gZ2VuZXJhdGVfdHJhY2VldmVudF9y
ZWdleCgNCiAkcmVnZXhfd2FrZXVwX2tzd2FwZCA9IGdlbmVyYXRlX3RyYWNlZXZlbnRfcmVnZXgo
DQogCQkJInZtc2Nhbi9tbV92bXNjYW5fd2FrZXVwX2tzd2FwZCIsDQogCQkJJHJlZ2V4X3dha2V1
cF9rc3dhcGRfZGVmYXVsdCwNCi0JCQkibmlkIiwgInppZCIsICJvcmRlciIsICJnZnBfZmxhZ3Mi
KTsNCisJCQkibmlkIiwgIm9yZGVyIiwgImdmcF9mbGFncyIpOw0KICRyZWdleF9scnVfaXNvbGF0
ZSA9IGdlbmVyYXRlX3RyYWNlZXZlbnRfcmVnZXgoDQogCQkJInZtc2Nhbi9tbV92bXNjYW5fbHJ1
X2lzb2xhdGUiLA0KIAkJCSRyZWdleF9scnVfaXNvbGF0ZV9kZWZhdWx0LA0KLQkJCSJpc29sYXRl
X21vZGUiLCAiY2xhc3N6b25lX2lkeCIsICJvcmRlciIsDQorCQkJImlzb2xhdGVfbW9kZSIsICJj
bGFzc3pvbmUiLCAib3JkZXIiLA0KIAkJCSJucl9yZXF1ZXN0ZWQiLCAibnJfc2Nhbm5lZCIsICJu
cl9za2lwcGVkIiwgIm5yX3Rha2VuIiwNCiAJCQkibHJ1Iik7DQogJHJlZ2V4X2xydV9zaHJpbmtf
aW5hY3RpdmUgPSBnZW5lcmF0ZV90cmFjZWV2ZW50X3JlZ2V4KA0KQEAgLTIxOCw5ICsyMTcsOSBA
QCAkcmVnZXhfbHJ1X3Nocmlua19pbmFjdGl2ZSA9IGdlbmVyYXRlX3RyYWNlZXZlbnRfcmVnZXgo
DQogJHJlZ2V4X2xydV9zaHJpbmtfYWN0aXZlID0gZ2VuZXJhdGVfdHJhY2VldmVudF9yZWdleCgN
CiAJCQkidm1zY2FuL21tX3Ztc2Nhbl9scnVfc2hyaW5rX2FjdGl2ZSIsDQogCQkJJHJlZ2V4X2xy
dV9zaHJpbmtfYWN0aXZlX2RlZmF1bHQsDQotCQkJIm5pZCIsICJ6aWQiLA0KLQkJCSJscnUiLA0K
LQkJCSJucl9zY2FubmVkIiwgIm5yX3JvdGF0ZWQiLCAicHJpb3JpdHkiKTsNCisJCQkibmlkIiwN
CisJCQkibnJfdGFrZW4iLCAibnJfYWN0aXZlIiwgIm5yX2RlYWN0aXZhdGVkIiwgIm5yX3JlZmVy
ZW5jZWQiLA0KKwkJCSJwcmlvcml0eSIsICJmbGFncyIpOw0KICRyZWdleF93cml0ZXBhZ2UgPSBn
ZW5lcmF0ZV90cmFjZWV2ZW50X3JlZ2V4KA0KIAkJCSJ2bXNjYW4vbW1fdm1zY2FuX3dyaXRlcGFn
ZSIsDQogCQkJJHJlZ2V4X3dyaXRlcGFnZV9kZWZhdWx0LA0KQEAgLTM3MSw3ICszNzAsNyBAQCBF
VkVOVF9QUk9DRVNTOg0KIAkJCQlwcmludCAiICAgICAgICAgJHJlZ2V4X3dha2V1cF9rc3dhcGRc
biI7DQogCQkJCW5leHQ7DQogCQkJfQ0KLQkJCW15ICRvcmRlciA9ICQzOw0KKwkJCW15ICRvcmRl
ciA9ICQyOw0KIAkJCSRwZXJwcm9jZXNzcGlkeyRwcm9jZXNzX3BpZH0tPntNTV9WTVNDQU5fV0FL
RVVQX0tTV0FQRF9QRVJPUkRFUn1bJG9yZGVyXSsrOw0KIAkJfSBlbHNpZiAoJHRyYWNlcG9pbnQg
ZXEgIm1tX3Ztc2Nhbl9scnVfaXNvbGF0ZSIpIHsNCiAJCQkkZGV0YWlscyA9ICQ2Ow0KLS0gDQoy
LjIzLjANCg0K
