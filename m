Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9586AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB2208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UoGKeviS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="W+D6r3T6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfFUQ5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:57:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbfFUQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:57:12 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LGuO3i031913;
        Fri, 21 Jun 2019 09:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nOz4yEEg/kgUDUJuQ050ZUgUW73/SizsP+Jk6293bDs=;
 b=UoGKeviSQGK7cMY0AV5WG6z2wkCCGmjzlMqX8n461L4SGSZlo1N0Zsxo3OVdLkhCPysx
 7trlCDJQwbhMXkyIV/Yk5Jf6pCs73kA0tPMrnIcZ+SjowaO7kTCHSL4FxVvVskO3yc57
 4geEte1Lg++C1oY86e14z/EzH6aj012wxpY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t90esrq2h-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 09:56:53 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 09:56:50 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 09:56:50 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Jun 2019 09:56:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOz4yEEg/kgUDUJuQ050ZUgUW73/SizsP+Jk6293bDs=;
 b=W+D6r3T6PMg+g4gk8NBpK9qNYPdaI8oiA1NF9ZDAYQlvqT5Fz9sIIPmNnMHYcZBaqfr8siw1vRW0xuYjM6CqeRq/txOKduWj0lF6QlsZrbGDzS08DlsniRNW7xweV98zzTNUwt8aupZZHaBVW4KhnsQuh++XY2ygn7xALVOTpKU=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1112.namprd15.prod.outlook.com (10.172.175.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 16:56:49 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 16:56:49 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: aspeed: lpc-ctrl: Fix probe error handling
Thread-Topic: [PATCH] soc: aspeed: lpc-ctrl: Fix probe error handling
Thread-Index: AQHVJ0kMmuyJyuwsuUy9kr/Lb8/oYKal4LeA
Date:   Fri, 21 Jun 2019 16:56:49 +0000
Message-ID: <D327ABC9-2B43-473C-AD1C-080EEB067E62@fb.com>
References: <20190620091738.14683-1-joel@jms.id.au>
In-Reply-To: <20190620091738.14683-1-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3:63f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e209785-a20e-4ec0-32bd-08d6f66973f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR15MB1112;
x-ms-traffictypediagnostic: CY4PR15MB1112:
x-microsoft-antispam-prvs: <CY4PR15MB111299B3ED828962CEBE9E1DDDE70@CY4PR15MB1112.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(8936002)(66556008)(102836004)(305945005)(91956017)(76116006)(66476007)(186003)(7736002)(33656002)(6246003)(6506007)(14454004)(316002)(6116002)(66446008)(64756008)(5660300002)(81166006)(6916009)(54906003)(73956011)(66946007)(478600001)(36756003)(8676002)(6436002)(81156014)(6512007)(71200400001)(2616005)(256004)(6486002)(76176011)(2906002)(229853002)(86362001)(4326008)(476003)(11346002)(53936002)(68736007)(446003)(99286004)(486006)(46003)(71190400001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1112;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4hRDdvsPI9e2Rpwq5Jr+AZ3t2lUiwMxtV4Bx1vhANEXOtYofziMcvKOd4+t2NF8vJcjlKrA1QASdkGfXAOMyODkIab3kLBM8Pba2DrHtkROjW1VQK3wDQOUGsmHqwOWyMOlA0G4g9b2eWmpAhRJPW1R55Ksav8UhpQpBRcxYGWStGbmWQde0hnlp3JmkgqF0cWEH/eHQsPNYD23GoyW7S4AjwcwjtzrBAvHDb2BBDt4JvMZ+s22H1mKx3X6e+942uGVbo+owCISxlNvhSu7QjN2Uc1EAov9XItkGqFSDyhtqZ7rnFF7XJKAf7a+Wn4Q0B6GrAijdVs5YLVKHNtrSYhgM6LoyYI6EEIQ960j4a/tBo12z5foroZa6ZnXb2qL+xBIThev5487mddzarDhUw6a3+rlUjhHv6khLTeQtLH0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EFFF40975291F49A91279F03DE69502@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e209785-a20e-4ec0-32bd-08d6f66973f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 16:56:49.6677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vijaykhemka@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1112
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDYvMjAvMTksIDI6MTcgQU0sICJqb2VsLnN0YW5AZ21haWwuY29tIG9uIGJlaGFs
ZiBvZiBKb2VsIFN0YW5sZXkiIDxqb2VsLnN0YW5AZ21haWwuY29tIG9uIGJlaGFsZiBvZiBqb2Vs
QGptcy5pZC5hdT4gd3JvdGU6DQoNCiAgICBnY2Mgd2FybnMgdGhhdCBhIG1pc2luZyAiZmxhc2gi
IHBoYW5kbGUgbm9kZSBsZWFkcyB0byB1bmRlZmluZWQNCiAgICBiZWhhdmlvciBsYXRlcjoNCiAg
ICANCiAgICBkcml2ZXJzL3NvYy9hc3BlZWQvYXNwZWVkLWxwYy1jdHJsLmM6IEluIGZ1bmN0aW9u
ICdhc3BlZWRfbHBjX2N0cmxfcHJvYmUnOg0KICAgIGRyaXZlcnMvc29jL2FzcGVlZC9hc3BlZWQt
bHBjLWN0cmwuYzoyMDE6MTg6IGVycm9yOiAnKigodm9pZCAqKSZyZXNtKzgpJyBtYXkgYmUgdXNl
ZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFs
aXplZF0NCiAgICANCiAgICBPbmx5IHNldCB0aGUgZmxhc2ggYmFzZSBhbmQgc2l6ZSBpZiB3ZSBm
aW5kIGEgcGhhbmRsZSBpbiB0aGUgZGV2aWNlDQogICAgdHJlZS4NCiAgICANClRoYW5rcyBmb3Ig
Zml4aW5nIHRoaXMuDQpSZXZpZXdlZC1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5j
b20+DQoNCiAgICBSZXBvcnRlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCiAg
ICBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KICAgIC0tLQ0K
ICAgICBkcml2ZXJzL3NvYy9hc3BlZWQvYXNwZWVkLWxwYy1jdHJsLmMgfCA1ICsrKy0tDQogICAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQogICAgDQog
ICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2FzcGVlZC9hc3BlZWQtbHBjLWN0cmwuYyBiL2Ry
aXZlcnMvc29jL2FzcGVlZC9hc3BlZWQtbHBjLWN0cmwuYw0KICAgIGluZGV4IGFjYTEzNzc5NzY0
YS4uZWVlMjZjMmQ4YjUyIDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvc29jL2FzcGVlZC9hc3Bl
ZWQtbHBjLWN0cmwuYw0KICAgICsrKyBiL2RyaXZlcnMvc29jL2FzcGVlZC9hc3BlZWQtbHBjLWN0
cmwuYw0KICAgIEBAIC0yMjMsMTAgKzIyMywxMSBAQCBzdGF0aWMgaW50IGFzcGVlZF9scGNfY3Ry
bF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KICAgICAJCQlkZXZfZXJyKGRl
diwgIkNvdWxkbid0IGFkZHJlc3MgdG8gcmVzb3VyY2UgZm9yIGZsYXNoXG4iKTsNCiAgICAgCQkJ
cmV0dXJuIHJjOw0KICAgICAJCX0NCiAgICArDQogICAgKwkJbHBjX2N0cmwtPnBub3Jfc2l6ZSA9
IHJlc291cmNlX3NpemUoJnJlc20pOw0KICAgICsJCWxwY19jdHJsLT5wbm9yX2Jhc2UgPSByZXNt
LnN0YXJ0Ow0KICAgICAJfQ0KICAgICANCiAgICAtCWxwY19jdHJsLT5wbm9yX3NpemUgPSByZXNv
dXJjZV9zaXplKCZyZXNtKTsNCiAgICAtCWxwY19jdHJsLT5wbm9yX2Jhc2UgPSByZXNtLnN0YXJ0
Ow0KICAgICANCiAgICAgCWRldl9zZXRfZHJ2ZGF0YSgmcGRldi0+ZGV2LCBscGNfY3RybCk7DQog
ICAgIA0KICAgIC0tIA0KICAgIDIuMjAuMQ0KICAgIA0KICAgIA0KDQo=
