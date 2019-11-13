Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA5CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D996207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alertlogic.onmicrosoft.com header.i=@alertlogic.onmicrosoft.com header.b="QMqE8x82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKMH3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:29:38 -0500
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:27621
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfKMH3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:29:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhPUTDo5p64h6IucY7ZS6o/UGPnoFbwZbIsnL9qOKASJGmhSFEDuY84mUY+SMheEVfzYGm+yOtXrR1x1yVNffoQA0tMw+l0Ihgy+xyZn8KvyYfW6Y+tTcObq/R1aj9HYvEP7inbDWXb6OOEUQZIuIqEWCKFjDF8TTmTcLADmbPmiVDgPw9BzuakQ9HyfO+KYUw0kDjL/uNiyf5zL410ynWBSc3XtmySs0gQ3mSq5eFakgseEL54qpnpYo6ZdLET+R8LFN+NmzVlmPUyYswIKhYgVdAz4REv1brrT2MxPfBHa9Kaivr1vipvdH0iHfJeXyykOIQDW301wTZ972RXUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcrK36+ewixZOqFtTOR7hTWVsZPnN/PTT+1crPsWITA=;
 b=df5n6JdtUJ1KjJxaw5Mtv3noWWmTpuh8Z6LN+jrvVtWpUbO+S9NMMvEWZTghi1d45lvS3gk9AFbw/To4uq1EhKcg6+oQRNY0LPKA4IgEcNBDWIJLQGdOLtDw8KD5/O/mFnZawjqPKnQNcQcEjJjh7hES94ysWjLUpvP5x9/uNoHf6WIkEDyQShux037nagSq5e65ybJ3s1EYclKBZBp1w6B9u2r9mv061SNayM5wekb3OBFjUKB2Pafs4PerS1mKzSzV45xZCToYFgNmCxvE4iGDVKtp4ACpBYPIJNBUrcUxfjB0Mq8jCNq/4hSeFYXNyanZuFgTKlyEp+0Nkdmkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alertlogic.com; dmarc=pass action=none
 header.from=alertlogic.com; dkim=pass header.d=alertlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alertlogic.onmicrosoft.com; s=selector2-alertlogic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcrK36+ewixZOqFtTOR7hTWVsZPnN/PTT+1crPsWITA=;
 b=QMqE8x82PLBcLWEH97WcZ9RX2eiuIILaZU+jLzSs1VzXfrl3qXM9OmCP6rbfdBK4fzA1V8IDXy0nLBsc5koymql7Kd58WBBSkL9Q/HkGo1ei18NTljj3hl8PVIksOl2TSOhpLSABcsK/yS0pidxQObCkpLqnytSYw07X5Uj5hM0=
Received: from BYAPR20MB2726.namprd20.prod.outlook.com (20.178.238.150) by
 BYAPR20MB2662.namprd20.prod.outlook.com (20.178.237.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 07:29:34 +0000
Received: from BYAPR20MB2726.namprd20.prod.outlook.com
 ([fe80::b1ef:70a1:4100:26a4]) by BYAPR20MB2726.namprd20.prod.outlook.com
 ([fe80::b1ef:70a1:4100:26a4%3]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 07:29:34 +0000
From:   "Harris, Robert" <robert.harris@alertlogic.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns EPERM
Thread-Topic: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns
 EPERM
Thread-Index: AQHVmYBWfg0+aL4WQEeFFOC3OWpiUqeItS+A
Date:   Wed, 13 Nov 2019 07:29:33 +0000
Message-ID: <0FFCBE3B-65D0-493F-9DB6-D4D64218EB0D@alertlogic.com>
References: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
In-Reply-To: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.harris@alertlogic.com; 
x-originating-ip: [165.225.81.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1f086fa-7e45-4f5a-4fb8-08d7680b3b1f
x-ms-traffictypediagnostic: BYAPR20MB2662:
x-microsoft-antispam-prvs: <BYAPR20MB26625FD7152C90CF15A7381494760@BYAPR20MB2662.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39850400004)(189003)(199004)(305945005)(14454004)(66446008)(14444005)(66946007)(5024004)(71200400001)(76176011)(26005)(446003)(25786009)(110136005)(11346002)(91956017)(256004)(64756008)(36756003)(66476007)(2616005)(2501003)(486006)(476003)(71190400001)(86362001)(66556008)(7736002)(53546011)(6506007)(2201001)(99286004)(478600001)(3846002)(8936002)(6116002)(81166006)(6246003)(66066001)(4326008)(102836004)(55236004)(6512007)(8676002)(81156014)(33656002)(2906002)(76116006)(6486002)(5660300002)(229853002)(316002)(186003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR20MB2662;H:BYAPR20MB2726.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: alertlogic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0QLY090c53ewFVJAZZM5z0LSAfQUUVUTZi0/xih6xQQgMFftvyGSJa1qxrYKikg6l3FKaTh737I/hIYn3RcovXZROUQC6L6Nr++C20p5JQACxxDrWC+guU6HrKutPbiu6QIQQSvi97Hytfh5gVFggJnG4ZbFrL4TWWcDp03+gMVdi71hCspvp4l2fTfq8U/PfggTA6B9AdVDrE/BophxnHgdUB6n3EV6yX155aGbnpsJpl16wyNVEKv0QwL5ru0mTLrEFYabaGaebm3VrqXk+j6V6rxhGBvhJCn+QlAASN7Kh7gK1O5v9TzrV8E3P3NmomWaXWSpglh1CDpIyP4idF++OfQsKx41EwPdylXd87URLiG0yGLCIdFWmDIcLuqThiclU7EaszTqWJZR1zvFjFv5kUJoXPmv+nopxXZ2H7rt6UqOyJJ05LryeCy+3sO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A394135A6E41AF42913111ADEBEDF147@namprd20.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alertlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f086fa-7e45-4f5a-4fb8-08d7680b3b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:29:34.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04151827-cb2a-4231-9c24-1ef5ffc408eb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuLJ5oPFSNbvU2HtPAL7w0tRaLwVav+xoXBz5WQceMiHvO39DK5jHUoGUTlPUQ+iMhwRBTTwEYisnnMaW7WqbYtA8LmPO1ClgEhEjve8FXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR20MB2662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 12 Nov 2019, at 17:40, Harris, Robert <robert.harris@alertlogic.com> w=
rote:
>
> I am investigating an issue on 4.9.184 in which futex() returns EPERM
> intermittently for
>
> futex(uaddr, FUTEX_WAIT_PRIVATE, val, &timeout, NULL, 0)
>
> The failure affects an application in an AWS lambda;  traditional
> debugging approaches vary from difficult to impossible.  I cannot
> reproduce the problem at will, instrument the kernel, install a new
> kernel or get an application core dump.
>
> Understanding the circumstances under which EPERM can be returned for
> FUTEX_WAIT_PRIVATE would be useful but it is not a documented failure
> mode.  I have spent some time looking through futex.c but have not
> found anything yet.  I would be grateful for a hint from someone more
> knowledgeable.
>
> Please address/cc me on any reply.

To be clear, I do mean that futex() is returning -1 and setting errno
to EPERM.

Robert
Confidentiality Notice | This email and any included attachments may be pri=
vileged, confidential and/or otherwise protected from disclosure. Access to=
 this email by anyone other than the intended recipient is unauthorized. If=
 you believe you have received this email in error, please contact the send=
er immediately and delete all copies. If you are not the intended recipient=
, you are notified that disclosing, copying, distributing or taking any act=
ion in reliance on the contents of this information is strictly prohibited.
