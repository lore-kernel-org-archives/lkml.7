Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7281BC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F6120727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rXHH06jD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Iy7a+k77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKZSNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:13:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40630 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfKZSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:13:16 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQIAGtO029108;
        Tue, 26 Nov 2019 10:12:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YskEH9GCavvkgoTHph3/mZdOjLljfnFV6BKLapx5MQQ=;
 b=rXHH06jDxDAfKG51+Va9jq+Ue5HSmXShS/dQcLJDGdMU/RzsEG+qcC3hHqKDtiRqKwP5
 CSkCcU5QQeSyfTwEy5kHT+1fH2FSb+HaOSpTa+CcwVFy1Y773vXbdaOYjtArDqB/K9MH
 SU1bryTTew8Iq/G/4PUHjw1fV64FBTdmeHY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wfnbg5cku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 10:12:52 -0800
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 26 Nov 2019 10:12:51 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 26 Nov 2019 10:12:51 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 26 Nov 2019 10:12:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPitP6BUKobQ6BIi21msAUNtWRpBhZmhUxru5t50ZZsCp+SDyGsCDGzAQ3SVCB0Z4Vi20U8XoLynDHceqEDmVggJsDuyO0HAzHJkJQRWEEtJoU/4INyxkipWKpwKmabymNvJpwP+A/sae4LJjjzcODAs1ElMQCFRnYI7EFHa1qB+yqCp3NlHOd5wDuLWD9FYVePS+0abRbJ47WOS14CBQQ3t+qjMRATCDUzYu3Qfy7icxa8XgPvEtd+/8V6le5CMzRjfKZo8Ay/bnhK1FUax0UrnHmNR9owk1k3njFNZijG535hWzZpFQ4BHztkPae7pb4EAKRml5j3OOB4YHbqOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YskEH9GCavvkgoTHph3/mZdOjLljfnFV6BKLapx5MQQ=;
 b=j9noG9/Ttws/N4m+JK6oPOtNDKIBxcC4330WaPuErucemsb06ktxgZx8nLtMVxWlx/fIele7ZPJPM2h6OCrxIYI6zz5fjzcK88uIMED10hbCKaFVGl5AMdupwUqJin/nrbIXmPtpPPkExflQugSZ68oA5BdBG+BKLAOjpFKyK4rylMKknibzcOUVYhGGymuiX0N3EGrXwTzbMSvfXVIUg7zQsLjT8OJtUwzvOlrw4EgBP7VNJ3QRcDNJdIS1xcDjH1meIN4QpI8Axo1EDgRftTDx0o1wDC/YuwmmLMsA34O4qfa60CFeMIWEajpQS43yoQFwSOj7cKG0atoPtmYYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YskEH9GCavvkgoTHph3/mZdOjLljfnFV6BKLapx5MQQ=;
 b=Iy7a+k77PZY1iTCX17MhUkuCgfW9sP5d836EE/Q+nS3aLyzMub0D0f+CwMFvLhKFGGimF5cY285jJCLUWeyPDKmvplrZWWHDpL0F/HVQb2DKSv/KOsKUAD+IboljUDRtiA+D5RtHFmAg+MJY2UzJiwb60hxtNvdKvNa1JipoFIQ=
Received: from MWHPR15MB1597.namprd15.prod.outlook.com (10.173.234.137) by
 MWHPR15MB1775.namprd15.prod.outlook.com (10.174.255.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 18:12:50 +0000
Received: from MWHPR15MB1597.namprd15.prod.outlook.com
 ([fe80::2c43:c44b:2c95:e376]) by MWHPR15MB1597.namprd15.prod.outlook.com
 ([fe80::2c43:c44b:2c95:e376%11]) with mapi id 15.20.2474.023; Tue, 26 Nov
 2019 18:12:50 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Manikandan <manikandan.hcl.ers.epl@gmail.com>
CC:     "andrew@aj.id.au" <andrew@aj.id.au>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "manikandan.e@hcl.com" <manikandan.e@hcl.com>
Subject: Re: [PATCH v3] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Topic: [PATCH v3] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Index: AQHVo5DnGMuyb8H++Equ2o+XkOK6yqebvmaAgAG3vwD//8bVgA==
Date:   Tue, 26 Nov 2019 18:12:50 +0000
Message-ID: <BF7BF1A3-00F8-49FE-83CB-7EF585448D03@fb.com>
References: <20191125130420.GA24018@cnn>
 <7F15A2E0-14C7-4C86-B589-35619A390B72@fb.com> <20191126133726.GA2578@cnn>
In-Reply-To: <20191126133726.GA2578@cnn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:1462]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c30ec7b8-a418-40d3-2d98-08d7729c3f9f
x-ms-traffictypediagnostic: MWHPR15MB1775:
x-microsoft-antispam-prvs: <MWHPR15MB17753531E0C8403154E663C7DD450@MWHPR15MB1775.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:451;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(47680400002)(189003)(199004)(316002)(66556008)(76176011)(66476007)(6916009)(81166006)(8936002)(4326008)(305945005)(5660300002)(76116006)(33656002)(64756008)(81156014)(6436002)(66446008)(229853002)(66946007)(25786009)(14454004)(102836004)(14444005)(6512007)(8676002)(53546011)(2616005)(86362001)(6116002)(6506007)(478600001)(71190400001)(46003)(36756003)(6246003)(54906003)(99286004)(186003)(7736002)(2906002)(256004)(6486002)(446003)(11346002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1775;H:MWHPR15MB1597.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGPGIDTB4AMbCUacDlQzbjZ/C9ep6D33eQwfrn6aCQk6gAAavWukzeTgQ9CGRy5EZj3Rj7v4q81ujK+T2tv+PQZ+YmcJpZnMM9u0t1Uk7pndj2fcidK5VcWOz/rWEuhqkSpFjLb6YyPC+imhZoEZkjsScG/8wnspGYhIiagrCppllAQYq7nf+kY0PscPlL3yDARoISe0STFJ2oL7I7o8DM6J2/K4FGmBREFJXb9WSTcTYpu48W64qzrMuC0IHkhoaUCjpvCFIFmjlNmjjHrNNkgP6Rxiy4BtAEhOPJFwIRh3xZ4au/Pr0k345bJnQH6Blxhz+bK54UgR9p5exyN6kh5tygPkIEuaSwiwpkv5qmh22j57gpjfA+PSlHa85JyKWBtF6SKkK3PLSOf5RDeykClVtXeUlvnJ18XYgjcreoUrFduuRuY5eg232eAPLlVE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <63EBE3342FDE5E45BCA1A1F033A0080F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c30ec7b8-a418-40d3-2d98-08d7729c3f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 18:12:50.3066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISqZCgp65icZlg0A2DaCU7YPREnYX7l94V3xHq0zS5zKzu7dDrz3FkV9zihD6kqPkODZDY6APKXYmomJ5ku1FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1775
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_05:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=972
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260153
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzI2LzE5LCA1OjM4IEFNLCAiTWFuaWthbmRhbiIgPG1hbmlrYW5kYW4uaGNs
LmVycy5lcGxAZ21haWwuY29tPiB3cm90ZToNCg0KICAgIE9uIE1vbiwgTm92IDI1LCAyMDE5IGF0
IDA3OjIzOjMyUE0gKzAwMDAsIFZpamF5IEtoZW1rYSB3cm90ZToNCiAgICA+IA0KICAgID4gT24g
MTEvMjUvMTksIDU6MDQgQU0sICJtYW5pa2FuZGFuLWUiIDxtYW5pa2FuZGFuLmhjbC5lcnMuZXBs
QGdtYWlsLmNvbT4gd3JvdGU6DQogICAgPiANCiAgICA+ICAgICBUaGUgWW9zZW1pdGUgVjIgaXMg
YSBmYWNlYm9vayBtdWx0aS1ub2RlIHNlcnZlcg0KICAgID4gICAgIHBsYXRmb3JtIHRoYXQgaG9z
dCBmb3VyIE9DUCBzZXJ2ZXIuIFRoZSBCTUMNCiAgICA+ICAgICBpbiB0aGUgWW9zZW1pdGUgVjIg
cGxhdG9ybSBiYXNlZCBvbiBBU1QyNTAwIFNvQy4NCiAgICA+ICAgICANCiAgICA+ICAgICBUaGlz
IHBhdGNoIGFkZHMgbGludXggZGV2aWNlIHRyZWUgZW50cnkgcmVsYXRlZCB0bw0KICAgID4gICAg
IFlvc2VtaXRlIFYyIHNwZWNpZmljIGRldmljZXMgY29ubmVjdGVkIHRvIEJNQyBTb0MuDQogICAg
PiBOaXQ6IGNvbW1lbnRzIGlubGluZS4gT3RoZXJ3aXNlDQogICAgPiBSZXZpZXdlZC1ieTogVmlq
YXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+DQogICAgPiAgICAgDQogICAgPiANCiAgICA+
ICAgICBTaWduZWQtb2ZmLWJ5OiBtYW5pa2FuZGFuLWUgPG1hbmlrYW5kYW4uaGNsLmVycy5lcGxA
Z21haWwuY29tPg0KICAgID4gICAgIC0tLQ0KICAgID4gICAgICAuLi4vYm9vdC9kdHMvYXNwZWVk
LWJtYy1mYWNlYm9vay15b3NlbWl0ZXYyLmR0cyAgICB8IDE1MSArKysrKysrKysrKysrKysrKysr
KysNCiAgICA+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDE1MSBpbnNlcnRpb25zKCspDQogICAgPiAg
ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vi
b29rLXlvc2VtaXRldjIuZHRzDQogICAgPiAgICAgDQogICAgPiAgICAgZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2Mi5kdHMgYi9hcmNo
L2FybS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRldjIuZHRzDQogICAgPiAg
ICAgbmV3IGZpbGUgbW9kZSAxMDA2NDQNCiAgICA+ICAgICBpbmRleCAwMDAwMDAwLi4wOWJmZmNk
DQogICAgPiAgICAgLS0tIC9kZXYvbnVsbA0KICAgID4gICAgICsrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGV2Mi5kdHMNCiAgICA+ICAgICBAQCAtMCww
ICsxLDE1MSBAQA0KICAgID4gICAgICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MCsNCiAgICA+ICAgICArLy8gQ29weXJpZ2h0IChjKSAyMDE4IEZhY2Vib29rIEluYy4NCiAgICA+
ICAgICArL2R0cy12MS87DQogICAgPiAgICAgKw0KICAgID4gICAgICsjaW5jbHVkZSAiYXNwZWVk
LWc1LmR0c2kiDQogICAgPiAgICAgKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2FzcGVlZC1n
cGlvLmg+DQogICAgPiAgICAgKw0KICAgID4gICAgICsvIHsNCiAgICA+ICAgICArCW1vZGVsID0g
IkZhY2Vib29rIFlvc2VtaXRldjIgQk1DIjsNCiAgICA+ICAgICArCWNvbXBhdGlibGUgPSAiZmFj
ZWJvb2sseW9zZW1pdGV2Mi1ibWMiLCAiYXNwZWVkLGFzdDI1MDAiOw0KICAgID4gICAgICsJYWxp
YXNlcyB7DQogICAgPiAgICAgKwkJc2VyaWFsNCA9ICZ1YXJ0NTsNCiAgICA+ICAgICArCX07DQog
ICAgPiAgICAgKwljaG9zZW4gew0KICAgID4gICAgICsJCXN0ZG91dC1wYXRoID0gJnVhcnQ1Ow0K
ICAgID4gICAgICsJCWJvb3RhcmdzID0gImNvbnNvbGU9dHR5UzQsMTE1MjAwIGVhcmx5cHJpbnRr
IjsNCiAgICA+IGJvb3RhcmdzIGFyZSBub3QgcmVxdWlyZWQgYXMgaXQgaXMgb3ZlcndyaXR0ZW4g
YnkgdWJvb3QuIEFuZCBiYXVkIHJhdGUgaXMgNTc2MDANCiAgICAgICAgICAgICAgIA0KICAgICAg
ICAgICAgICBBcyBvZiBub3cgU1BMIGFuZCBVLWJvb3QgQmF1ZHJhdGUgYmFzZWQgMTE1MjAwIGJh
dWRyYXRlLiBEbyB3ZSBuZWVkIHRvIGNoYW5nZSBpdCB0aGVyZS4gSSB1bmRlcnN0YW5kIHRoYXQg
d2UgY2FuIHVzZSBTRVJJQUxfQ09OU09MRVMgICAgICAgICAgIGluIG1ldGEtZmFjZWJvb2suDQog
ICAgICAgICAgICAgRG8gaSBuZWVkIHRvIHJlbW92ZSAnY29uc29sZT10dHlTNC4xMTUyMDAnIG9y
IGNvbXBsZXRlIGJvb3RhcmdzIC4gSWYgd2UgcmVtb3ZlIGJvb3RhcmdzLCBob3cgY2FuIGFkZCBh
bnkgYm9vdGFyZ3MgcGFyYW1zIGluIGZ1dHVyZS4NCkJvb3RhcmdzIGFyZSBvdmVyd3JpdHRlbiBi
eSB1LWJvb3QgYW5kIGhhdmUgbm8gaW1wYWN0IHdoYXRldmVyIHlvdSBjaG9vc2UgaGVyZS4gU28g
eW91IGNhbiByZW1vdmUgYm9vdGFyZ3MuIA0KICAgIA0KICAgID4gICAgICsJfTsNCiAgICA+ICAg
ICArDQogICAgPiAgICAgKwltZW1vcnlAODAwMDAwMDAgew0KICAgID4gICAgICsJCXJlZyA9IDww
eDgwMDAwMDAwIDB4MjAwMDAwMDA+Ow0KICAgID4gICAgICsJfTsNCiAgICA+ICAgICArDQogICAg
PiAgICAgKwlpaW8taHdtb24gew0KICAgID4gICAgICsJCS8vIFZPTEFUQUdFIFNFTlNPUg0KICAg
ID4gICAgICsJCWNvbXBhdGlibGUgPSAiaWlvLWh3bW9uIjsNCiAgICA+ICAgICArCQlpby1jaGFu
bmVscyA9IDwmYWRjIDA+ICwgPCZhZGMgMT4gLCA8JmFkYyAyPiAsICA8JmFkYyAzPiAsDQogICAg
PiAgICAgKwkJPCZhZGMgND4gLCA8JmFkYyA1PiAsIDwmYWRjIDY+ICwgIDwmYWRjIDc+ICwNCiAg
ICA+ICAgICArCQk8JmFkYyA4PiAsIDwmYWRjIDk+ICwgPCZhZGMgMTA+LCA8JmFkYyAxMT4gLA0K
ICAgID4gICAgICsJCTwmYWRjIDEyPiAsIDwmYWRjIDEzPiAsIDwmYWRjIDE0PiAsIDwmYWRjIDE1
PiA7DQogICAgPiAgICAgKwl9Ow0KICAgID4gICAgICt9Ow0KICAgID4gICAgICsNCiAgICA+ICAg
ICArJmZtYyB7DQogICAgPiAgICAgKwlzdGF0dXMgPSAib2theSI7DQogICAgPiAgICAgKwlmbGFz
aEAwIHsNCiAgICA+ICAgICArCQlzdGF0dXMgPSAib2theSI7DQogICAgPiAgICAgKwkJbTI1cCxm
YXN0LXJlYWQ7DQogICAgPiAgICAgKyNpbmNsdWRlICJvcGVuYm1jLWZsYXNoLWxheW91dC5kdHNp
Ig0KICAgID4gICAgICsJfTsNCiAgICA+ICAgICArfTsNCiAgICA+ICAgICArDQogICAgPiAgICAg
KyZzcGkxIHsNCiAgICA+ICAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICAgICArCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogICAgPiAgICAgKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxf
c3BpMV9kZWZhdWx0PjsNCiAgICA+ICAgICArCWZsYXNoQDAgew0KICAgID4gICAgICsJCXN0YXR1
cyA9ICJva2F5IjsNCiAgICA+ICAgICArCQltMjVwLGZhc3QtcmVhZDsNCiAgICA+ICAgICArCQls
YWJlbCA9ICJwbm9yIjsNCiAgICA+ICAgICArCX07DQogICAgPiAgICAgK307DQogICAgPiAgICAg
Kw0KICAgID4gICAgICsmdWFydDUgew0KICAgID4gICAgICsJLy8gQk1DIENvbnNvbGUNCiAgICA+
ICAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICAgICArfTsNCiAgICA+ICAgICArDQogICAg
PiAgICAgKyZtYWMwIHsNCiAgICA+ICAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICAgICAr
CXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogICAgPiAgICAgKwlwaW5jdHJsLTAgPSA8JnBp
bmN0cmxfcm1paTFfZGVmYXVsdD47DQogICAgPiAgICAgKwl1c2UtbmNzaTsNCiAgICA+ICAgICAr
fTsNCiAgICA+ICAgICArDQogICAgPiAgICAgKyZhZGMgew0KICAgID4gICAgICsJc3RhdHVzID0g
Im9rYXkiOw0KICAgID4gICAgICsgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQog
ICAgPiBVc2UgdGFiIGZvciBhbGlnbm1lbnQNCiAgICANCiAgICANCiAgICBDaGVja3BhdGNoIGRp
ZG4ndCBzaG93biBhbnkgaXNzdWUgd2FybmluZyAuQXMgaSBjaGVja2VkIGluIG1hbnkgZHRzIGZp
bGUgLCBmb3JtYXQgaXMgc2FtZS4NCiAgICBJdCB3aWxsIGhlbHBmdWwgaWYgaSBnZXQgbW9yZSBj
bGFyaWZpY2F0aW9uLiANCklmIHlvdSBzZWUgaW4gYWJvdmUgbGluZSwgc3BhY2VzIGFyZSBiZWlu
ZyB1c2VkIGluc3RlYWQgb2YgdGFiLiBUaGlzIGlzIG9ubHkgb25lIA0KbGluZSB3aGVyZSBzcGFj
ZXMgYXJlIGJlaW5nIHVzZWQgaW5zdGVhZCBvZiB0YWIuDQogICAgDQogICAgPiAgICAgKwlwaW5j
dHJsLTAgPSA8JnBpbmN0cmxfYWRjMF9kZWZhdWx0DQogICAgPiAgICAgKwkJCSZwaW5jdHJsX2Fk
YzFfZGVmYXVsdA0KICAgID4gICAgICsJCQkmcGluY3RybF9hZGMyX2RlZmF1bHQNCiAgICA+ICAg
ICArCQkJJnBpbmN0cmxfYWRjM19kZWZhdWx0DQogICAgPiAgICAgKwkJCSZwaW5jdHJsX2FkYzRf
ZGVmYXVsdA0KICAgID4gICAgICsJCQkmcGluY3RybF9hZGM1X2RlZmF1bHQNCiAgICA+ICAgICAr
CQkJJnBpbmN0cmxfYWRjNl9kZWZhdWx0DQogICAgPiAgICAgKwkJCSZwaW5jdHJsX2FkYzdfZGVm
YXVsdA0KICAgID4gICAgICsJCQkmcGluY3RybF9hZGM4X2RlZmF1bHQNCiAgICA+ICAgICArCQkJ
JnBpbmN0cmxfYWRjOV9kZWZhdWx0DQogICAgPiAgICAgKwkJCSZwaW5jdHJsX2FkYzEwX2RlZmF1
bHQNCiAgICA+ICAgICArCQkJJnBpbmN0cmxfYWRjMTFfZGVmYXVsdA0KICAgID4gICAgICsJCQkm
cGluY3RybF9hZGMxMl9kZWZhdWx0DQogICAgPiAgICAgKwkJCSZwaW5jdHJsX2FkYzEzX2RlZmF1
bHQNCiAgICA+ICAgICArCQkJJnBpbmN0cmxfYWRjMTRfZGVmYXVsdA0KICAgID4gICAgICsJCQkm
cGluY3RybF9hZGMxNV9kZWZhdWx0PjsNCiAgICA+ICAgICArfTsNCiAgICA+ICAgICArDQogICAg
PiAgICAgKyZpMmM4IHsNCiAgICA+ICAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICAgICAr
CS8vRlJVIEVFUFJPTQ0KICAgID4gICAgICsJZWVwcm9tQDUxIHsNCiAgICA+ICAgICArCQljb21w
YXRpYmxlID0gImF0bWVsLDI0YzY0IjsNCiAgICA+ICAgICArCQlyZWcgPSA8MHg1MT47DQogICAg
PiAgICAgKwkJcGFnZXNpemUgPSA8MzI+Ow0KICAgID4gICAgICsJfTsNCiAgICA+ICAgICArfTsN
CiAgICA+ICAgICArDQogICAgPiAgICAgKyZpMmM5IHsNCiAgICA+ICAgICArCXN0YXR1cyA9ICJv
a2F5IjsNCiAgICA+ICAgICArCXRtcDQyMUA0ZSB7DQogICAgPiAgICAgKwkvL0lOTEVUIFRFTVAN
CiAgICA+ICAgICArCQljb21wYXRpYmxlID0gInRpLHRtcDQyMSI7DQogICAgPiAgICAgKwkJcmVn
ID0gPDB4NGU+Ow0KICAgID4gICAgICsJfTsNCiAgICA+ICAgICArCS8vT1VUTEVUIFRFTVANCiAg
ICA+ICAgICArCXRtcDQyMUA0ZiB7DQogICAgPiAgICAgKwkJY29tcGF0aWJsZSA9ICJ0aSx0bXA0
MjEiOw0KICAgID4gICAgICsJCXJlZyA9IDwweDRmPjsNCiAgICA+ICAgICArCX07DQogICAgPiAg
ICAgK307DQogICAgPiAgICAgKw0KICAgID4gICAgICsmaTJjMTAgew0KICAgID4gICAgICsJc3Rh
dHVzID0gIm9rYXkiOw0KICAgID4gICAgICsJLy9IU0MNCiAgICA+ICAgICArCWFkbTEyNzhANDAg
ew0KICAgID4gICAgICsJCWNvbXBhdGlibGUgPSAiYWRpLGFkbTEyNzgiOw0KICAgID4gICAgICsJ
CXJlZyA9IDwweDQwPjsNCiAgICA+ICAgICArCX07DQogICAgPiAgICAgK307DQogICAgPiAgICAg
Kw0KICAgID4gICAgICsmaTJjMTEgew0KICAgID4gICAgICsJc3RhdHVzID0gIm9rYXkiOw0KICAg
ID4gICAgICsJLy9NRVpaX1RFTVBfU0VOU09SDQogICAgPiAgICAgKwl0bXA0MjFAMWYgew0KICAg
ID4gICAgICsJCWNvbXBhdGlibGUgPSAidGksdG1wNDIxIjsNCiAgICA+ICAgICArCQlyZWcgPSA8
MHgxZj47DQogICAgPiAgICAgKwl9Ow0KICAgID4gICAgICt9Ow0KICAgID4gICAgICsNCiAgICA+
ICAgICArJmkyYzEyIHsNCiAgICA+ICAgICArCXN0YXR1cyA9ICJva2F5IjsNCiAgICA+ICAgICAr
CS8vTUVaWl9GUlUNCiAgICA+ICAgICArCWVlcHJvbUA1MSB7DQogICAgPiAgICAgKwkJY29tcGF0
aWJsZSA9ICJhdG1lbCwyNGM2NCI7DQogICAgPiAgICAgKwkJcmVnID0gPDB4NTE+Ow0KICAgID4g
ICAgICsJCXBhZ2VzaXplID0gPDMyPjsNCiAgICA+ICAgICArCX07DQogICAgPiAgICAgK307DQog
ICAgPiAgICAgKw0KICAgID4gICAgICsmcHdtX3RhY2hvIHsNCiAgICA+ICAgICArCXN0YXR1cyA9
ICJva2F5IjsNCiAgICA+ICAgICArCS8vRlNDDQogICAgPiAgICAgKwlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KICAgID4gICAgICsJcGluY3RybC0wID0gPCZwaW5jdHJsX3B3bTBfZGVmYXVs
dCAmcGluY3RybF9wd20xX2RlZmF1bHQ+Ow0KICAgID4gICAgICsJZmFuQDAgew0KICAgID4gICAg
ICsJCXJlZyA9IDwweDAwPjsNCiAgICA+ICAgICArCQlhc3BlZWQsZmFuLXRhY2gtY2ggPSAvYml0
cy8gOCA8MHgwMD47DQogICAgPiAgICAgKwl9Ow0KICAgID4gICAgICsJZmFuQDEgew0KICAgID4g
ICAgICsJCXJlZyA9IDwweDAxPjsNCiAgICA+ICAgICArCQlhc3BlZWQsZmFuLXRhY2gtY2ggPSAv
Yml0cy8gOCA8MHgwMj47DQogICAgPiAgICAgKwl9Ow0KICAgID4gICAgICt9Ow0KICAgID4gICAg
IC0tIA0KICAgID4gICAgIDIuNy40DQogICAgPiAgICAgDQogICAgPiAgICAgDQogICAgPiANCiAg
ICANCg0K
