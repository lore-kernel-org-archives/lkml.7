Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E0CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756B22196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alertlogic.onmicrosoft.com header.i=@alertlogic.onmicrosoft.com header.b="nVqbxNQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKLRlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:41:01 -0500
Received: from mail-eopbgr760123.outbound.protection.outlook.com ([40.107.76.123]:48259
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfKLRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:41:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9LiG8/uktkl/A/oYX7UwGbSZvwO8KhXvnnNw39DiS+CgmIvc1xfKFbUsgRVxdhA9Uc8vpNvkJeOrWiHjvkOXYqX0rzQVFxmUsR95hRbCYsdNB93NgtGpeZoCHPgi93ZBgH+rwrhNMmY7OeZ3YkoVdnll9ZRC4WWZhtDBDYeJ00snH4d8MatdMd1Zf5/N6Nw27M60UJP5Dyi8votWM9aE6lqSQ6cz4W2AvA9zV7M8I74fKOr14slTG1phZ+znyOe1z7ZuVJHMbYIKM3tQV+ROlJD6TY9DvXknHG9qLx51BslWGT7RFOosTN0W5xQxAs/fkwRESqONO78YzZanT/ibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgruqcHvVD8E01cUJLFYzJpbA7g1PtW4tmTV2KRZhho=;
 b=HtIEzX1c6demt8AMNU8cPUGs69qtImIDKdfzmvKRKS2OcoewipJ8+NQekt/DrEha6dfDiGycgfDEZiJzy9+sBCPT1wwrHDJSPOyHnN/6O4lmaw81O1txt0F8U1CiXEsxWCQBQv4gqhCaaqDj55L4Ry0YulwkPQuuE7gxWakKZH19oNgKDNpFA8wxrQ6E0pM/bbGX9mcS/yzZE1yX/qBUAej2SJmFCFA54wZ2XhM9Iu7I5IBdYmnNFjVpNZzGeVeUJYPgdPw7N9IKRKBOiYHq1h+7sNkpt4nq86K9MDSFbWBDSP5iSPjIDeGu7lV6lJRr1x0cIgWA+XG0fcaJz64AZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alertlogic.com; dmarc=pass action=none
 header.from=alertlogic.com; dkim=pass header.d=alertlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alertlogic.onmicrosoft.com; s=selector2-alertlogic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgruqcHvVD8E01cUJLFYzJpbA7g1PtW4tmTV2KRZhho=;
 b=nVqbxNQZiPYWkdr7XWG9kVxXFGyw9XTnFuxHaZV1/3dMYZdAvTRMYmbeChlfvOxe2uX1tJKj0xdLOgZ4fDT45W2PRz6jnfvaMvvYORh+4cWfl8ChQ8OM4dviJ9jm1Rv1fWvXzPkUaSrlL6K0so2yQDwX8yU8P5Dcx6mljO54k8s=
Received: from BYAPR20MB2726.namprd20.prod.outlook.com (20.178.238.150) by
 BYAPR20MB2245.namprd20.prod.outlook.com (20.179.155.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Tue, 12 Nov 2019 17:40:55 +0000
Received: from BYAPR20MB2726.namprd20.prod.outlook.com
 ([fe80::b1ef:70a1:4100:26a4]) by BYAPR20MB2726.namprd20.prod.outlook.com
 ([fe80::b1ef:70a1:4100:26a4%3]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 17:40:55 +0000
From:   "Harris, Robert" <robert.harris@alertlogic.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Harris, Robert" <robert.harris@alertlogic.com>
Subject: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns EPERM
Thread-Topic: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns
 EPERM
Thread-Index: AQHVmYBWNvZci+jLJUqod1Huijtj9w==
Date:   Tue, 12 Nov 2019 17:40:55 +0000
Message-ID: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.harris@alertlogic.com; 
x-originating-ip: [165.225.81.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5863aed9-66c7-4753-a0b0-08d7679778a9
x-ms-traffictypediagnostic: BYAPR20MB2245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR20MB2245ACDD446CEDC86A7742C594770@BYAPR20MB2245.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39850400004)(396003)(366004)(346002)(199004)(189003)(478600001)(102836004)(6506007)(36756003)(5660300002)(99286004)(54906003)(55236004)(6486002)(8676002)(66066001)(33656002)(6116002)(3846002)(25786009)(476003)(2616005)(486006)(2906002)(186003)(8936002)(26005)(6436002)(2201001)(76116006)(66946007)(110136005)(4326008)(66476007)(64756008)(81166006)(81156014)(66446008)(91956017)(316002)(66556008)(71200400001)(86362001)(14454004)(107886003)(305945005)(5024004)(71190400001)(14444005)(256004)(7736002)(2501003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR20MB2245;H:BYAPR20MB2726.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: alertlogic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkzuYyFoe2/iwDh3WnFchPivlxqcaTmXywQOItFKFeoZb+Ui7Xb3uX7GUpezPq6gzith4AZ1PRNeOK3zbSN7DNPolFOOfBZPRlXMnW7B2Gv5lFOwfGYzGhmfVbkILxrIa55wOGlFMq6JKU5h8fQM+fIXxHNy82vlDiSLz7UNeLzWRHSGdMBtZX4VgGvF4SJIymj0iL9CIKR/qhPGnGOhJBzcaQUpv2RHApwryCmworToEWLD/X3sNqL3xMO3kZYNEcpvo+cEPvSXuvtTVIYntV0siuYqIOakG1lxd04NsZ3yIsXuWj1GWUUzApRVD9DreKD4dPZ6DHAZDtpuMh8skZqCmliFiVM1BtmPDAXNNdb/MysvlmDcVpjzgNmyZWE93LQqwAKv+LUoBEcmVpuiaUIc6uHq034Buq7+FJRBu7+7Dp7HZoGi2cwJBkSnM3lO
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA28362B3B347E4AB25AF9DCB04CCA1F@namprd20.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alertlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5863aed9-66c7-4753-a0b0-08d7679778a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 17:40:55.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04151827-cb2a-4231-9c24-1ef5ffc408eb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cicr87e9LYyAK6F0gsBgSIP85mYmXwfl7AaHcpt3GtfBPD+JNMCzIRy76bqvs0Vk+ilJqEH5Xt+UWdBVeoP5mzO69l33nV/CJESZmEFvGwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR20MB2245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am investigating an issue on 4.9.184 in which futex() returns EPERM
intermittently for

futex(uaddr, FUTEX_WAIT_PRIVATE, val, &timeout, NULL, 0)

The failure affects an application in an AWS lambda;  traditional
debugging approaches vary from difficult to impossible.  I cannot
reproduce the problem at will, instrument the kernel, install a new
kernel or get an application core dump.

Understanding the circumstances under which EPERM can be returned for
FUTEX_WAIT_PRIVATE would be useful but it is not a documented failure
mode.  I have spent some time looking through futex.c but have not
found anything yet.  I would be grateful for a hint from someone more
knowledgeable.

Please address/cc me on any reply.

Thanks,

Robert Harris
Confidentiality Notice | This email and any included attachments may be pri=
vileged, confidential and/or otherwise protected from disclosure. Access to=
 this email by anyone other than the intended recipient is unauthorized. If=
 you believe you have received this email in error, please contact the send=
er immediately and delete all copies. If you are not the intended recipient=
, you are notified that disclosing, copying, distributing or taking any act=
ion in reliance on the contents of this information is strictly prohibited.
