Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9190C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FA320835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1NJQo4kD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfCRSZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:25:38 -0400
Received: from mail-eopbgr750079.outbound.protection.outlook.com ([40.107.75.79]:18354
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfCRSZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG/67XHgiK5x3k33A7hXO7432zlo+8j89UHsEE+MHu8=;
 b=1NJQo4kDQg/zUimCRr/hebgKZSKN7bRngxH6b6KLd//MxSyHOifDnFCDbD04G5Tj/4k2DhAmzwdtRaWYxdiZa9QxPwspPWJKX+GWIWMaOSix4a7L+L6QAqHdYQe7olsIVVJ9yJwJb0Uyk/uDzR3FmcKd1/KM1O6witrMwwcSJH4=
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (20.179.92.82) by
 BYAPR12MB3495.namprd12.prod.outlook.com (20.178.196.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 18:25:32 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::e073:d670:f97c:3eb8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::e073:d670:f97c:3eb8%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 18:25:32 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdkfd: Fix unchecked return value
Thread-Topic: [PATCH] drm/amdkfd: Fix unchecked return value
Thread-Index: AQHU3bUuVx0VTQtud0Cepyby0llNqqYRtHyA
Date:   Mon, 18 Mar 2019 18:25:32 +0000
Message-ID: <20ac3fa8-0889-60ba-f2c9-52ba91982c22@amd.com>
References: <20190318180525.GA13768@embeddedor>
In-Reply-To: <20190318180525.GA13768@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.72.62]
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
x-clientproxiedby: AM6P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:133::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebed0b95-f542-4320-1d05-08d6abcf1adb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:BYAPR12MB3495;
x-ms-traffictypediagnostic: BYAPR12MB3495:
x-microsoft-antispam-prvs: <BYAPR12MB349507C92FF4A360DA57C89792470@BYAPR12MB3495.namprd12.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(6116002)(3846002)(65826007)(65956001)(6246003)(53546011)(5660300002)(52116002)(64126003)(386003)(6506007)(102836004)(76176011)(26005)(31696002)(186003)(66066001)(65806001)(86362001)(229853002)(71190400001)(53936002)(5024004)(256004)(14444005)(6512007)(6486002)(6436002)(71200400001)(4326008)(446003)(25786009)(106356001)(99936001)(72206003)(31686004)(7736002)(36756003)(478600001)(81156014)(8676002)(81166006)(105586002)(14454004)(316002)(97736004)(58126008)(54906003)(110136005)(2906002)(486006)(305945005)(11346002)(2616005)(99286004)(476003)(68736007)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3495;H:BYAPR12MB3176.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S9pHbJ5/mLa2gIpmT8OZbtJWPJf0ll88Xj6SH9HVIiogdNDcGwSBp8Oq9WBQdATl+plf5a7MOoWBVoaSOMyZJwzGB6Vzc/lT6JBXAtA8oVW9mWh3v+cVvUGZYIBbwRLpjUFPe1e6CFH0BrZiBmL9zj56j+n3ec2Xr9bd+AirGUvPvvkkSbhGm3Uw2S+3lxlxB7o9l5G5ZGwZIDWjRPWy7L6Cc8H9Fz+JRvtVI1Vd5CD3DbazWqDYvVmGc391AJGaq9Ts9qlxj99zzrMoVEQ83Ti9ArTmuPIatqcmAKplC4kEvZM3SL1+ZMRRu3zpi/lJESvOekfFJ7hH1nzUixS+CReDoiULSkIHkva2W+YslXikyk02PJ9tkGaC3QG+z1Xj9TQRkwbVqVlY5jJK8eDo4M1aa+SDy3WVEyC0Rlf+gh8=
Content-Type: multipart/mixed;
        boundary="_002_20ac3fa8088960baf2c952ba91982c22amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebed0b95-f542-4320-1d05-08d6abcf1adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 18:25:32.1935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20ac3fa8088960baf2c952ba91982c22amdcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <E821A5C4D65D13488993704996BE7B28@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

QWxleCBhbHJlYWR5IGFwcGxpZWQgYW4gZXF1aXZhbGVudCBwYXRjaCBieSBDb2xpbiBLaW5nIChh
dHRhY2hlZCBmb3IgDQpyZWZlcmVuY2UpLg0KDQpSZWdhcmRzLA0KIMKgIEZlbGl4DQoNCk9uIDMv
MTgvMjAxOSAyOjA1IFBNLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOg0KPiBBc3NpZ24gcmV0
dXJuIHZhbHVlIG9mIGZ1bmN0aW9uIGFtZGdwdV9ib19zeW5jX3dhaXQoKSB0byB2YXJpYWJsZSBy
ZXQNCj4gZm9yIGl0cyBmdXJ0aGVyIGNoZWNrLg0KPg0KPiBBZGRyZXNzZXMtQ292ZXJpdHktSUQ6
IDE0NDM5MTQgKCJMb2dpY2FsbHkgZGVhZCBjb2RlIikNCj4gRml4ZXM6IGM2MGNkNTkwY2I3ZCAo
ImRybS9hbWRncHU6IFJlcGxhY2UgdHRtX2JvX3dhaXQgd2l0aCBhbWRncHVfYm9fc3luY193YWl0
IikNCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRl
ZG9yLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jIHwgMyArKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gaW5kZXggMTkyMWRlYzNkZjdhLi5mYjYyMWFiY2IwMDYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
X2dwdXZtLmMNCj4gQEAgLTkwNiw3ICs5MDYsOCBAQCBzdGF0aWMgaW50IGluaXRfa2ZkX3ZtKHN0
cnVjdCBhbWRncHVfdm0gKnZtLCB2b2lkICoqcHJvY2Vzc19pbmZvLA0KPiAgIAkJcHJfZXJyKCJ2
YWxpZGF0ZV9wdF9wZF9ib3MoKSBmYWlsZWRcbiIpOw0KPiAgIAkJZ290byB2YWxpZGF0ZV9wZF9m
YWlsOw0KPiAgIAl9DQo+IC0JYW1kZ3B1X2JvX3N5bmNfd2FpdCh2bS0+cm9vdC5iYXNlLmJvLCBB
TURHUFVfRkVOQ0VfT1dORVJfS0ZELCBmYWxzZSk7DQo+ICsJcmV0ID0gYW1kZ3B1X2JvX3N5bmNf
d2FpdCh2bS0+cm9vdC5iYXNlLmJvLCBBTURHUFVfRkVOQ0VfT1dORVJfS0ZELA0KPiArCQkJCSAg
ZmFsc2UpOw0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJZ290byB3YWl0X3BkX2ZhaWw7DQo+ICAgCWFt
ZGdwdV9ib19mZW5jZSh2bS0+cm9vdC5iYXNlLmJvLA0K

--_002_20ac3fa8088960baf2c952ba91982c22amdcom_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Mon, 18 Mar 2019 18:25:31 GMT";
	modification-date="Mon, 18 Mar 2019 18:25:31 GMT"
Content-ID: <12214C230145074C8EFDE74B97E0D988@namprd12.prod.outlook.com>

Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a02:ee::36)
 by BYAPR12MB3176.namprd12.prod.outlook.com with HTTPS via
 BYAPR02CA0023.NAMPRD02.PROD.OUTLOOK.COM; Mon, 4 Mar 2019 08:27:03 +0000
Received: from DM3PR12CA0073.namprd12.prod.outlook.com (2603:10b6:0:57::17) by
 BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.18; Mon, 4 Mar
 2019 08:27:01 +0000
Received: from BY2NAM03FT030.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::204) by DM3PR12CA0073.outlook.office365.com
 (2603:10b6:0:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Mon, 4 Mar 2019 08:27:01 +0000
Authentication-Results: spf=none (sender IP is 131.252.210.177)
 smtp.mailfrom=lists.freedesktop.org; amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=fail action=none
 header.from=canonical.com;compauth=none reason=406
Received-SPF: None (protection.outlook.com: lists.freedesktop.org does not
 designate permitted sender hosts)
Received: from gabe.freedesktop.org (131.252.210.177) by
 BY2NAM03FT030.mail.protection.outlook.com (10.152.84.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.13 via Frontend Transport; Mon, 4 Mar 2019 08:27:00 +0000
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7278999E;
	Mon,  4 Mar 2019 08:27:00 +0000 (UTC)
X-Original-To: amd-gfx@lists.freedesktop.org
Delivered-To: amd-gfx@lists.freedesktop.org
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7E389BAF;
 Sat,  2 Mar 2019 22:17:03 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.76) (envelope-from <colin.king@canonical.com>)
 id 1h0CwF-0006pf-87; Sat, 02 Mar 2019 22:16:59 +0000
From: Colin King <colin.king@canonical.com>
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher
	<alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie
	<airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH][drm-next] drm/amdgpu: fix missing assignment of error return
 code to variable ret
Date: Sat, 2 Mar 2019 22:16:58 +0000
Message-ID: <20190302221658.7536-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
X-Mailman-Approved-At: Mon, 04 Mar 2019 08:26:59 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
Return-Path: amd-gfx-bounces@lists.freedesktop.org
X-MS-Exchange-Organization-ExpirationStartTime: 04 Mar 2019 08:27:01.0633
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 2:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id:
 71ca7f0f-bfe5-4dff-a2bf-08d6a07b2caf
X-EOPAttributedMessage: 0
X-EOPTenantAttributedMessage: 3dd8961f-e488-4e60-8e11-a82d994e183d:0
X-MS-Exchange-Organization-MessageDirectionality: Incoming
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report:
 CIP:131.252.210.177;IPV:NLI;CTRY:US;EFV:NLI;SFV:SKN;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:BYAPR12MB3221;H:gabe.freedesktop.org;FPR:;SPF:None;LANG:en;
X-MS-Exchange-Organization-AuthSource:
 BY2NAM03FT030.eop-NAM03.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71ca7f0f-bfe5-4dff-a2bf-08d6a07b2caf
X-Microsoft-Antispam:
 BCL:1;PCL:0;RULEID:(2390118)(7020095)(4652040)(5600127)(711020)(4605104)(1401299)(1421009)(71702078);SRVR:BYAPR12MB3221;
X-MS-TrafficTypeDiagnostic: BYAPR12MB3221:
X-MS-Exchange-PUrlCount: 2
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Organization-SCL: -1
X-Microsoft-Exchange-Diagnostics:
 1;BYAPR12MB3221;20:LXvrRliS4loNNY259K2PXQkTEZFFdiNNiRGZZIlabhvOfbgpGhS159i3sR/4hIFsrBAZNak54U1mYJvz/rEQsWLme0anxDx0GIhsoJlb2zduomB/jV9fyIAihPZUdkup0tYik1JsRaAlkzuK+DzwhtpByryw8QE4Axux/hrHBwm9xik47zH3JcSVYb1BbLTmIV7OtQvhld6TVkVKW1Qb4jkCShjZqN7pAHVEX0iBAub2XOJ7lhmI2PlrTatOyUHXZmBVr0uwvGuBar7D8pdVQmIh62y6udn9Uwz67w3V72A10pvcQotDxr3CU6euX2nEds2N/umJ7rnd33hEMZrqiKwZWsxT1LcU6jCY4/SD6Yw+JIYsC7brUhrEbn1zdk9o4hRWHF8p41rYP6YrqQjIoMaKJ6PWKYZd/W9ekoFh4Lm5xxWeibMNQtT4YEXXndVSC0LLc+ZF/B9SF5Oe4pFHdy2zAO+VXd+0KtyAnQfAprZLaYO6upaZaD9R7qsAq7/OqQ+stVp5vSF0myw1NO1VIOXut6iNCy7PL+yBZsL27CAy2KFZg7lHDsz2dX9d7G9bZIWPm5buz1zFH7kQ7/icFrLhXHPpl4QJ3M/8FWUm/a8=;23:rLjjuJGSvIjnhaDphIhvdizZXz0c8r8jwbT+CPqeAkvBeqjQ+iqc5BXvT0NABJ3b/Dn7ACe9vQ/FYBDQehMm3Hh6itTb/YBoE9IV6cBhdEvxlvKaPxUYeVWGQTojElo1A2TYLQBOuwS4+PjzsrQZwQ==
X-Microsoft-Exchange-Diagnostics:
 1;BYAPR12MB3221;20:drlwKHVp7NhNctRdvGkhRfG7OAnWxQbE+OokP0zF3WahMhxMCIGFeV8OQi2a/pj3eRmEc9fTDCMu+x8stquFAqeN0ciA3nRIhgh6/zEpyUqkUq5m55PRhCrmeiqEk3WDT35GZCKM8e5gai7yQxh1QWsLh8vLZDKayrRsg0CcbsIsDZ0KDjnH74YL8fJROCigAZmS9MwfVkIaQenBvDDMknZuWqrfD8AQv/1if8w3rdv+GcI2pgm/L3czdeur+W5Y
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 08:27:00.8791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ca7f0f-bfe5-4dff-a2bf-08d6a07b2caf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3221
X-MS-Exchange-Transport-EndToEndLatency: 00:00:02.2097740
X-MS-Exchange-Processed-By-BccFoldering: 15.20.1665.000
X-Microsoft-Antispam-Mailbox-Delivery:
 ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(750119)(520011016);
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L0REcDhPcDRBMmNYSkVwaDRMNWJ2NUlUVUlhTm5zcm56ME9yb2tyRFQrallM?=
 =?utf-8?B?RTdRb1VpMUhkVkJCTHQ0VlJRNWgrVG8wblNiUUx4d2hXWFh1YWc2cGswSHY4?=
 =?utf-8?B?TVFRenNDMUNUb3JKZjg2a2QwcEhQbG5mcTJDNFlEUnNoUmlDWXZhcEhvZnRV?=
 =?utf-8?B?RTVvV1VkV3cvYzZNOTlzWnhYbGVIY29UTlE4NldmTjU4a0I2clpaMXdqam5m?=
 =?utf-8?B?cUpneFdsaEFJVVFvdUJJVGZNU2dJbjFsNjc4WkE2RFNDU0VEcld5TjAwNEZ6?=
 =?utf-8?B?M2ZQaG5tdVZSbEJmM3lna0RSNjJLRXF4MmIweGVUWUd3N0FyZkwrZXA2SzVF?=
 =?utf-8?B?bTNsVnJPYUdyWFJCemo3aVJCaUpKSEgzczMzZWhtcU1qK3krK1VFWFRkdU9p?=
 =?utf-8?B?Njk1ZTRtMlZrU2V1UG9lK2xUN1hyTDlQS3ZYSTUzSmMyclpHZEN6RS9ZSVhX?=
 =?utf-8?B?bFZBenpCekk0NlVIOGZEdWswZUI3N1VYNVV4OEN2TG5jNFEwTHJPZk91cmcx?=
 =?utf-8?B?aTY4Y2IxVjRhVVUxcWdPWUMwdEJ6TmdzcTZFT0NhZzA2U0FYQXVySks3OFlm?=
 =?utf-8?B?VmRvL3doaEp1M3ZSeHYzelBqTXRDVG04QWtsVjhuSmRPRXhwbXhaQTVDZW41?=
 =?utf-8?B?YmdsbVc5anJIcnBnVlNWck9DVzJ5cUxEanRBSzZoRTNYYkJaWWtnVUIvSzhW?=
 =?utf-8?B?ZHRySTlhakNkYnEyTUZLQXNBdWdpUkhrcHpVQUp4ekF5dksyclFxT0UxRk0r?=
 =?utf-8?B?Vnp6ZXd4ZDg5anlMSklkRkpaYkQzcDBKWWhjTHliS1VRM1FJMjl1T3NWK3Jz?=
 =?utf-8?B?ODRVaDJ2TUt6YjNlM2ZLYmd1OHJic05JM1JaTklIMDNLdTBjRWs0NFpVVUwx?=
 =?utf-8?B?dzE1WkR5Q3M3Q1dwSjJqeXFzYi9BMTR2bjBjbkIyNFd5NFplYmdOZ2ZRdmRz?=
 =?utf-8?B?YzhMZmhvYzZTcnE2L1FoZUpSSkRuSUgvSFRiUitKMzZ1b2Fja2ZZUUdaUXlh?=
 =?utf-8?B?WjRuNHZIQjljVzhTcGNNYXQrc1R6UGs1dEhkcllaVHFPYmkvblA5YlI1WFdl?=
 =?utf-8?B?YXZQL2lSdG1BTWJtLzROTmxjZjR4dFk2bVViTUljaWs3QWJubVpLaTNNUWpy?=
 =?utf-8?B?Rk5tckNHRzluWi84cmF1OHV3UFMxYU5TL1E3blFsNzRJVW9TMkhvdDFqakgr?=
 =?utf-8?B?cTFvM3BPU3N6TnlPOGZuYmtxNkVsRzR4MTFsT2hFci9kY3B4Y3FoN3luOHhF?=
 =?utf-8?B?Qk9FOFZwM3poUU5yM3hpWm90b2ZsVllYNkNUM2lzaUlNd2x0ZzVLYzErZjQx?=
 =?utf-8?B?Z0l2dDgvaE1BRS9wandlT1YwQVJXUDdlTXRmQnZUTDhqVDI5ZTJTOWhXU2FJ?=
 =?utf-8?B?dlJJWnF3M3NQUXNzdDhraXZsYnNyUVNCZjRyODdhdFhvbFd5dGxrcVQ5Y2ZX?=
 =?utf-8?Q?jPQ1wa8T?=
MIME-Version: 1.0

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KCkFuIGVhcmxp
ZXIgY29tbWl0IHJlcGxhY2VkIHR0bV9ib193YWl0IHdpdGggYW1kZ3B1X2JvX3N5bmNfd2FpdCBh
bmQKcmVtb3ZlZCB0aGUgZXJyb3IgcmV0dXJuIGFzc2lnbm1lbnQgdG8gdmFyaWFibGUgcmV0LiBG
aXggdGhpcyBieSBhZGRpbmcKdGhlIGFzc2lnbm1lbnQgYmFjay4gQWxzbyBicmVhayBsaW5lIHRv
IGNsZWFuIHVwIGNoZWNrcGF0Y2ggb3Zlcmx5CmxvbmcgbGluZSB3YXJuaW5nLgoKRGV0ZWN0ZWQg
YnkgQ292ZXJpdHlTY2FuLCBDSUQjMTQ3NzMyNyAoIkxvZ2ljYWxseSBkZWFkIGNvZGUiKQoKRml4
ZXM6IGM2MGNkNTkwY2I3ZCAoImRybS9hbWRncHU6IFJlcGxhY2UgdHRtX2JvX3dhaXQgd2l0aCBh
bWRncHVfYm9fc3luY193YWl0IikKU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGlu
LmtpbmdAY2Fub25pY2FsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dwdXZtLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYwppbmRleCAxOTIxZGVjM2RmN2EuLjkyOTkzYmFhYzkxYSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwpAQCAt
OTA2LDcgKzkwNiw4IEBAIHN0YXRpYyBpbnQgaW5pdF9rZmRfdm0oc3RydWN0IGFtZGdwdV92bSAq
dm0sIHZvaWQgKipwcm9jZXNzX2luZm8sCiAJCXByX2VycigidmFsaWRhdGVfcHRfcGRfYm9zKCkg
ZmFpbGVkXG4iKTsKIAkJZ290byB2YWxpZGF0ZV9wZF9mYWlsOwogCX0KLQlhbWRncHVfYm9fc3lu
Y193YWl0KHZtLT5yb290LmJhc2UuYm8sIEFNREdQVV9GRU5DRV9PV05FUl9LRkQsIGZhbHNlKTsK
KwlyZXQgPSBhbWRncHVfYm9fc3luY193YWl0KHZtLT5yb290LmJhc2UuYm8sCisJCQkJICBBTURH
UFVfRkVOQ0VfT1dORVJfS0ZELCBmYWxzZSk7CiAJaWYgKHJldCkKIAkJZ290byB3YWl0X3BkX2Zh
aWw7CiAJYW1kZ3B1X2JvX2ZlbmNlKHZtLT5yb290LmJhc2UuYm8sCi0tIAoyLjIwLjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

--_002_20ac3fa8088960baf2c952ba91982c22amdcom_--
