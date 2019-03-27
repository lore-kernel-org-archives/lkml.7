Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E363C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91FA20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EpRbaIUo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Fkyf4EJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfC0RqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:46:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727731AbfC0RqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:46:04 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RHcR5v009539;
        Wed, 27 Mar 2019 10:45:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=facebook;
 bh=yIzMDVl62L9AzFYwPsyJGmgF4Jeg3UBiFLvB9vn0ryU=;
 b=EpRbaIUobgbNNdfy+kXTSMiNeGw0tGpE3EGnWUgH+fQu5pH1GHalyfHeazAiKkKB6ELo
 Oade3I6AzEBU6ElXtw9T8D0cAZAZBLXMWcHQ9jYcrXlwYGeQNsLtoenQ9NmZOAK5y3ba
 hc3BiH6dZ8K1pOelO3OxE00vnr68LBmuchQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rgdekr524-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Mar 2019 10:45:44 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 27 Mar 2019 10:45:24 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 27 Mar 2019 10:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIzMDVl62L9AzFYwPsyJGmgF4Jeg3UBiFLvB9vn0ryU=;
 b=Fkyf4EJxC7WPGJX5cURbWFODEYPtI13YA9/0qs5RPYXYnAnAFuo7Oyq/YzMBWpYEQJOBGhUAYZd/R4vjuiC4yGHJch8O5Y19SnASskzBRfArHSiDqOMq/TLa+RK5xs5rfB89GIv6mcIECAR0nVJa5s0q0nlDK4TOVZGJPw4jPM8=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1782.namprd15.prod.outlook.com (10.174.53.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Wed, 27 Mar 2019 17:45:21 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::adbc:85e5:68d3:ac2d]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::adbc:85e5:68d3:ac2d%3]) with mapi id 15.20.1730.017; Wed, 27 Mar 2019
 17:45:21 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH] ARM: dts:
 aspeed: tiogapass: Enable VUART
Thread-Topic: [Potential Spoof] Re: [Potential Spoof] Re: [PATCH] ARM: dts:
 aspeed: tiogapass: Enable VUART
Thread-Index: AQHU5MTZZK3U5teJfEiVbTLpr/Bn8A==
Date:   Wed, 27 Mar 2019 17:45:21 +0000
Message-ID: <24375A52-CC8E-4CFE-A683-0720B60D1201@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3:e9a1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9ad20f9-30e6-41ba-1b47-08d6b2dbfc39
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1782;
x-ms-traffictypediagnostic: CY4PR15MB1782:
x-microsoft-antispam-prvs: <CY4PR15MB1782E7769910837851274CA7DD580@CY4PR15MB1782.namprd15.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(8936002)(82746002)(36756003)(81156014)(81166006)(6116002)(46003)(5660300002)(2906002)(6436002)(6512007)(2501003)(14454004)(486006)(8676002)(229853002)(68736007)(476003)(6486002)(305945005)(7736002)(53546011)(102836004)(99286004)(316002)(2616005)(86362001)(53936002)(186003)(2201001)(6506007)(4744005)(71190400001)(25786009)(97736004)(83716004)(105586002)(6246003)(33656002)(478600001)(106356001)(71200400001)(110136005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1782;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b3VFbQnRPvRJqCzsiB+BJvZ0fHvgULcbh0uphPQBTqRzj+9epk4rmrueCfZTNbRbjMn4YfRwF+RLNaEWi5t3K9/FCsgzf4ggihYpD9o62V55AwHbHMqy7yQCkEjEmwX90U4G+yiGH31aJsa1qLO1fvqAYpJ5CHA5IYlBWwONIJLDqllRg+wXcoessOl+COE/rf+tX5PiNT9NF5VfMCS+C3SWkBZMjk7tvZwwvJ+qN5fj+14/cCqoaar+Z1BcOLVdpRujkvmA1SmkKIDx96GzE742cdgdjoQGJyYj7lRdhR6ZZ8Xw3K4+gdnkzLGLhGRGpNe3IAK9zKrXbBin4Hpbhtbj5+/Xk2ESCVYmXdUNQEc0mlYLjbi8j48+Q0YgHyAtJJOhUkw1QGNjCIP96MqBRRtm/NVHTbh9t0vpVAbVGuA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <872759AB1137044AA3F96E1009D90452@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ad20f9-30e6-41ba-1b47-08d6b2dbfc39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 17:45:21.8286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1782
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lbCwNClBsZWFzZSBhcHBseSB0aGlzIHBhdGNoLg0KDQpSZWdhcmRzDQotVmlqYXkNCg0K
77u/T24gMy8xOC8xOSwgMTI6NDYgUE0sICJvcGVuYm1jIG9uIGJlaGFsZiBvZiBWaWpheSBLaGVt
a2EiIDxvcGVuYm1jLWJvdW5jZXMrdmlqYXlraGVta2E9ZmIuY29tQGxpc3RzLm96bGFicy5vcmcg
b24gYmVoYWxmIG9mIHZpamF5a2hlbWthQGZiLmNvbT4gd3JvdGU6DQoNCiAgICBIaSBKb2VsLA0K
ICAgIFBsZWFzZSBhcHBseSB0aGlzIHBhdGNoLg0KICAgIA0KICAgIFJlZ2FyZHMNCiAgICAtVmlq
YXkNCiAgICANCiAgICBPbiAzLzUvMTksIDEyOjA2IFBNLCAib3BlbmJtYyBvbiBiZWhhbGYgb2Yg
VmlqYXkgS2hlbWthIiA8b3BlbmJtYy1ib3VuY2VzK3ZpamF5a2hlbWthPWZiLmNvbUBsaXN0cy5v
emxhYnMub3JnIG9uIGJlaGFsZiBvZiB2aWpheWtoZW1rYUBmYi5jb20+IHdyb3RlOg0KICAgIA0K
ICAgICAgICBQbGVhc2UgcmV2aWV3IGJlbG93IHBhdGNoLg0KICAgICAgICANCiAgICAgICAgUmVn
YXJkcw0KICAgICAgICAtVmlqYXkNCiAgICAgICAgDQogICAgICAgIE9uIDEvMzAvMTksIDEwOjE0
IEFNLCAiVmlqYXkgS2hlbWthIiA8dmlqYXlraGVta2FAZmIuY29tPiB3cm90ZToNCiAgICAgICAg
DQogICAgICAgICAgICBFbmFibGluZyB2dWFydCBmb3IgRmFjZWJvb2sgdGlvZ2FwYXNzDQogICAg
ICAgICAgICANCiAgICAgICAgICAgIFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlr
aGVta2FAZmIuY29tPg0KICAgICAgICAgICAgLS0tDQogICAgICAgICAgICAgYXJjaC9hcm0vYm9v
dC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay10aW9nYXBhc3MuZHRzIHwgNSArKysrKw0KICAgICAg
ICAgICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCiAgICAgICAgICAgIA0KICAg
ICAgICAgICAgZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJv
b2stdGlvZ2FwYXNzLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2st
dGlvZ2FwYXNzLmR0cw0KICAgICAgICAgICAgaW5kZXggNDJlMGQ3YThlOGQwLi5hMDU4ZmIyOTg1
ZjcgMTAwNjQ0DQogICAgICAgICAgICAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYm1j
LWZhY2Vib29rLXRpb2dhcGFzcy5kdHMNCiAgICAgICAgICAgICsrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stdGlvZ2FwYXNzLmR0cw0KICAgICAgICAgICAgQEAgLTY0
LDYgKzY0LDExIEBADQogICAgICAgICAgICAgCXN0YXR1cyA9ICJva2F5IjsNCiAgICAgICAgICAg
ICB9Ow0KICAgICAgICAgICAgIA0KICAgICAgICAgICAgKyZ2dWFydCB7DQogICAgICAgICAgICAr
CS8vIFZVQVJUIEhvc3QgQ29uc29sZQ0KICAgICAgICAgICAgKwlzdGF0dXMgPSAib2theSI7DQog
ICAgICAgICAgICArfTsNCiAgICAgICAgICAgICsNCiAgICAgICAgICAgICAmdWFydDEgew0KICAg
ICAgICAgICAgIAkvLyBIb3N0IENvbnNvbGUNCiAgICAgICAgICAgICAJc3RhdHVzID0gIm9rYXki
Ow0KICAgICAgICAgICAgLS0gDQogICAgICAgICAgICAyLjE3LjENCiAgICAgICAgICAgIA0KICAg
ICAgICAgICAgDQogICAgICAgIA0KICAgICAgICANCiAgICANCiAgICANCg0K
