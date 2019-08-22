Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C7C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94134233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O86iUr41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbfHVJux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:50:53 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:48278
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731952AbfHVJux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:50:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTdB3T3jULebJZWCGAC6dTXpPbmDMnqSG3h7ezfcFOyPTF3l9lOOkmzHE8iKCvZSX7xll1gCUVBuXV2SE6rzrYq/TUpNX4lyEJhINU0rId4yD+xYJDH33UInDw8x+undvZoCJEhv0E7B7svjnZ53R5u2orErhs8Wevv9Z3UF/BrLTAcY11QsDRiTkm4tqaf/lWIXI6QoR8QVqOnrvtQraC310sEwQ5JerlI3hrgo/YQdfMLpAYQKjtBdO0ivFVGWXDC8AAE+y9vEbYpn5BVOCn4xyFlEZSNuwwthENz7LtnsOOkQ9DEGj0EGGOoopk1SpOl2M3U/T9LxZTe7ZOxATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPvVUob0c0d1S+fmQT9H6gkk2lxFy0seicc/ClTLuso=;
 b=VmoBLjz21G+HW2qF8nTvBclGYqLqtpRLkh+2J0QWFvIfa2UBdIYCeGI3AbdU9ptCMyroF2rTvIfs4l6pgI2273TVjqSA+UY7JeLWVdpvCmtxQ7HMQOl1P8Wsg5yctdIWWnRDjMft7b7DjFghPbv5IugDaLPFvFWnQtyl/XkLT/0b7mTuE0MdrNbqVHDAmBogycgFzT/gexR9Q6MsAthiHnsuSCHVJ4TWeCblL/LtU+c3vzyIKEMLDLnmVFsr9dW8WDpO8fuCQLP8qVvzV0+8B3NT/c7CQy9v6FdRhA7c0jtQUw/ysf5/Aw7n4/X0J4jRg4yl7FNSk3SNukRunAXiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPvVUob0c0d1S+fmQT9H6gkk2lxFy0seicc/ClTLuso=;
 b=O86iUr41jMg8hh3B94e30wt2jdtM3UfYAYNp2Qp5rccJMwR9P1DJIQpKf0O2snYtLPzDw2Q4ZtRVWpUqRA+4e/qbcVImWzjh/AAn9SusD4qnFW8npfy6tnM9F1qFwlHPPbAGEr22168uy/7MWJXR/31jNW/4QcAvyy+K4nzYxOw=
Received: from VI1PR08MB2782.eurprd08.prod.outlook.com (10.170.236.143) by
 VI1PR08MB5343.eurprd08.prod.outlook.com (52.133.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 09:50:50 +0000
Received: from VI1PR08MB2782.eurprd08.prod.outlook.com
 ([fe80::2969:e370:fb70:71a]) by VI1PR08MB2782.eurprd08.prod.outlook.com
 ([fe80::2969:e370:fb70:71a%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 09:50:50 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 0/3] rework netlink skb allocation
Thread-Topic: [PATCH 0/3] rework netlink skb allocation
Thread-Index: AQHVWM8Uc7CX8GVwdk2oKW/7+DjmdQ==
Date:   Thu, 22 Aug 2019 09:50:50 +0000
Message-ID: <1566467448-9550-1-git-send-email-jan.dakinevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0088.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::32) To VI1PR08MB2782.eurprd08.prod.outlook.com
 (2603:10a6:802:19::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b99930d-3613-4ea5-5947-08d726e636df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB5343;
x-ms-traffictypediagnostic: VI1PR08MB5343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB53438F3B3B1266965B8F70098AA50@VI1PR08MB5343.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39840400004)(396003)(346002)(376002)(199004)(189003)(44832011)(66556008)(66946007)(6436002)(14444005)(256004)(53936002)(52116002)(4326008)(25786009)(107886003)(6916009)(81166006)(99286004)(8936002)(81156014)(8676002)(71200400001)(71190400001)(2906002)(478600001)(6512007)(14454004)(36756003)(86362001)(54906003)(6486002)(2351001)(316002)(386003)(5640700003)(26005)(3846002)(186003)(102836004)(2616005)(476003)(6506007)(6116002)(5660300002)(4744005)(7736002)(50226002)(66066001)(486006)(305945005)(66476007)(2501003)(66446008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB5343;H:VI1PR08MB2782.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 03Je0UF3wrZKYMS+8wq/PXnlO2GxJTCKF5JOVFbLBlyu/RBbJNvygw+PzaYFdpW9S5Y8Y9b+Xx0z/PvHfrTU0oOvAMwgelsg9jXuwteSAdCRFbC4I+wIkoSVpWRwIKqK/V2rpN0zgCHgHsFb2aMDCgqtkmcfV3azsVJ/T5fHG4Rj9F7dRKijCY5f2w+ocD31PwXF9SIyQwXZoUNsNWx1FbRNJFxqkPXjU1RyctKkyE5qXdvJyHQwaOmY2Jks+hvridVSxy6Xyw7Df3rIwUgx83S7YAMuPoWRBCgyRiVOy3hutX2wmKpy62B3KMM5xg2bhCCIpdjwhb0CWIXwY7I4u4Ru46OpQihuMyHPThe3pV/p68KbDTn5Ivng38ePUBwVik8/OSuDcy2lr4d0vsjSDUUXNC202rnfuIz3pIGYo8o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b99930d-3613-4ea5-5947-08d726e636df
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 09:50:50.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VY2926KwlZhXsg4DO1Xk+KGh0uFRV5g2whVd3WC9YbVN+1EiQm2uKvNaiMYchpwJsrL4rSHMs6JZxHr1dl3zo9/VdtmttuWtJpZgevu6F0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, userspace is able to initiate costly high-order allocation in=20
kernel sending large broadcast netlink message, which is considered=20
undesirable. At the same time, unicast message are safe in this regard,=20
because they uses vmalloc-ed memory.

This series introduces changes, that allow broadcast messages to be=20
allocated with vmalloc() as well as unicast.

Jan Dakinevich (3):
  skbuff: use kvfree() to deallocate head
  netlink: always use vmapped memory for skb data
  netlink: use generic skb_set_owner_r()

 include/linux/netlink.h   | 16 ----------------
 net/core/skbuff.c         |  2 +-
 net/ipv4/fib_frontend.c   |  2 +-
 net/netfilter/nfnetlink.c |  2 +-
 net/netlink/af_netlink.c  | 39 +++++++--------------------------------
 5 files changed, 10 insertions(+), 51 deletions(-)

--=20
2.1.4

