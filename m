Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31521C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9125233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GxWBQ7fR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfHVJu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:50:57 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com ([40.107.8.99]:47585
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731952AbfHVJuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:50:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6Lm7mLfk8IRlXmv0AjLdqFLNVI6ny8pHEVc63e0gKnt4X7fNxtOc16IdN6p+lrdvn1g2KGLTTuwafWBsszunr/ZwyMm/lvJd2qEm8gzFyRwWsDrhzqjN16hVyVLiHj+nnxSCMncMZf3UkcjR8TtuZXwXp/ho0HUHtGfYKSri+7tXZL6sHIXMt7mC41q+eZVNNXyuOfvFJs/tlbnLg3F4XrKJxvzPPfo+5Fml6Yi2GyUg9n4LkkRUlVYt22NiNqcuXIytL/OHibV9RG9nETjdhMqbN2vQ4qLfzOqByHXc9V6kyk3lSiUxM3dDzgDmkuH/ZxZrBJsQQ3A2FslJE9pzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8061+pWOAWMG/aEWCfTKVajft5j6ws/czcxe2ntfIE=;
 b=AAQZmr7F2iVUlBQiQqp17Vb3yAJ3ygEnEO0zWqtZ9w9FZRf94qLXr5X/XnR8NiiciLi/SB6pBQ8p1tiedBquSegtx6QGN70dbqqRoxiTcMKmSqdxpXgW1Cmsva5jPzJoDoLPW7Peq0/m/RMyddl8gLZCGOm4KuUfeDPrx0oxoqCo6LkR36Z7E1EncCY2DaBXXdiuxJHK96T7DSB7O8cB8YqJxsVPNSwgoRm4lCDaWty2Q7i38WENZNvag36oiKOFXysA8JGwHFu9b76x4njqFWL3Jgd99rFiFFxOLUC2P2T+UbXDI+rRpTRs/NpH9JvuFvOrC1k8GheJHlkz9B4V/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8061+pWOAWMG/aEWCfTKVajft5j6ws/czcxe2ntfIE=;
 b=GxWBQ7fRapZNe3WMCq0EfGn9dU/ze15dCkM8zKjMM2YEsSQU67udTmhOWRmrgLOO9oSfsfMEntPVxDeL1ibLxCkdvnyYEDuwYa+VvcvYhnjEq66duS2U3rLv9UCdDqVJJ1O8vIfeDj2NCzPftFODjW0g672440Chron7i02RfHs=
Received: from VI1PR08MB2782.eurprd08.prod.outlook.com (10.170.236.143) by
 VI1PR08MB3808.eurprd08.prod.outlook.com (20.178.14.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 09:50:52 +0000
Received: from VI1PR08MB2782.eurprd08.prod.outlook.com
 ([fe80::2969:e370:fb70:71a]) by VI1PR08MB2782.eurprd08.prod.outlook.com
 ([fe80::2969:e370:fb70:71a%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 09:50:52 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 3/3] netlink: use generic skb_set_owner_r()
Thread-Topic: [PATCH 3/3] netlink: use generic skb_set_owner_r()
Thread-Index: AQHVWM8Vva8u3ocdLEKshhTEdM6/RQ==
Date:   Thu, 22 Aug 2019 09:50:52 +0000
Message-ID: <1566467448-9550-4-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1566467448-9550-1-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1566467448-9550-1-git-send-email-jan.dakinevich@virtuozzo.com>
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
x-ms-office365-filtering-correlation-id: 257d951d-dc61-490c-6f26-08d726e6380f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB3808;
x-ms-traffictypediagnostic: VI1PR08MB3808:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB380829E568C7749ECB24336B8AA50@VI1PR08MB3808.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39830400003)(346002)(366004)(376002)(199004)(189003)(86362001)(14454004)(2616005)(476003)(446003)(316002)(44832011)(486006)(11346002)(6436002)(6512007)(5660300002)(4326008)(66066001)(53936002)(256004)(478600001)(3846002)(71200400001)(81166006)(5024004)(107886003)(8676002)(99286004)(36756003)(71190400001)(7736002)(81156014)(64756008)(6116002)(2906002)(66556008)(305945005)(50226002)(8936002)(5640700003)(6486002)(2351001)(25786009)(66946007)(6916009)(66446008)(54906003)(66476007)(26005)(76176011)(2501003)(386003)(6506007)(52116002)(186003)(102836004)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3808;H:VI1PR08MB2782.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bMpbjcqFIXPoZSy18X+E1p2rH/BIGqoZwDITswRfjGy0ysLA0cjqguWY0T7pPkgUAe074kvYPLy9px3OQDAu7rQkrF5I+X25P1IEQXmkVXYHq0CJtUit9OH+MVmLkf34lVcec6CTNRfFFXJhl+U5PSyPyYDw2dQOV8EZlBxk89PzZsvrd0jVfOcfWNVtoD7Adi726+3NZ05UFri2FfDl5u1odWaaq8cOObr8cEUohbheLLmbi66MSO2PcLu1jg0KxvM0BrAIynOi4mtuTxXeC3n79YvgvQ10wl3HpOouL7UeNZtdPpArNKflgk6ILmYm1mm3ZexXP0JnsbPwi9Ac45TFvcqZKkj29CIIw2EVjUlOVV/87V9AcODbHaw6GKwIz85RwLDjU3HUt8Ov2a/QldbRkYP3eeFDx/aRJZ2NzyM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257d951d-dc61-490c-6f26-08d726e6380f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 09:50:52.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faRUzBwNkH7sbsbegGSJhw6gPcZ+Xxxa19LthOvEeHmLolkxK3wdQG4HetaR3/9JNgfSb6oaGJHN1zEZRfTinTWGJGZdSSt6memyImJkAPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since skb destructor is not used for data deallocating,
netlink_skb_set_owner_r() almost completely repeates generic
skb_set_owner_r(). Thus, both netlink_skb_set_owner_r() and
netlink_skb_destructor() are not required anymore.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 net/netlink/af_netlink.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 04a3457..b0c2eb2 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -358,21 +358,6 @@ static void netlink_rcv_wake(struct sock *sk)
 		wake_up_interruptible(&nlk->wait);
 }
=20
-static void netlink_skb_destructor(struct sk_buff *skb)
-{
-	if (skb->sk !=3D NULL)
-		sock_rfree(skb);
-}
-
-static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
-{
-	WARN_ON(skb->sk !=3D NULL);
-	skb->sk =3D sk;
-	skb->destructor =3D netlink_skb_destructor;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
-	sk_mem_charge(sk, skb->truesize);
-}
-
 static void netlink_sock_destruct(struct sock *sk)
 {
 	struct netlink_sock *nlk =3D nlk_sk(sk);
@@ -1225,7 +1210,7 @@ int netlink_attachskb(struct sock *sk, struct sk_buff=
 *skb,
 		}
 		return 1;
 	}
-	netlink_skb_set_owner_r(skb, sk);
+	skb_set_owner_r(skb, sk);
 	return 0;
 }
=20
@@ -1286,7 +1271,7 @@ static int netlink_unicast_kernel(struct sock *sk, st=
ruct sk_buff *skb,
 	ret =3D -ECONNREFUSED;
 	if (nlk->netlink_rcv !=3D NULL) {
 		ret =3D skb->len;
-		netlink_skb_set_owner_r(skb, sk);
+		skb_set_owner_r(skb, sk);
 		NETLINK_CB(skb).sk =3D ssk;
 		netlink_deliver_tap_kernel(sk, ssk, skb);
 		nlk->netlink_rcv(skb);
@@ -1367,7 +1352,7 @@ static int netlink_broadcast_deliver(struct sock *sk,=
 struct sk_buff *skb)
=20
 	if (atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
-		netlink_skb_set_owner_r(skb, sk);
+		skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
 		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
 	}
@@ -2227,7 +2212,7 @@ static int netlink_dump(struct sock *sk)
 	 * single netdev. The outcome is MSG_TRUNC error.
 	 */
 	skb_reserve(skb, skb_tailroom(skb) - alloc_size);
-	netlink_skb_set_owner_r(skb, sk);
+	skb_set_owner_r(skb, sk);
=20
 	if (nlk->dump_done_errno > 0) {
 		cb->extack =3D &extack;
--=20
2.1.4

