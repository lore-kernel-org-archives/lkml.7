Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28748C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5482233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ob15dvIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbfHVJvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:51:01 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com ([40.107.1.99]:57622
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732391AbfHVJu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cko9Lr6Xw7qoU68CW/c6kvMbr+hsNXZbvEYtu3zbQMJbaNMMb+L7f8lm7NNC63kMbDLxDbXJ6tN+SK27bLOGt8b/fTm18/a2I7UIuOAgRfbuikzMAe7tifkV7AexppYbriPfofI/f+GZM7jkcCVyuo4KoC8Z++pFArqferAwoh7/5o+f3H/9k2yj07Wx8wydhJRn+ArhuG0j/O8soSIph4dxITcZa6v2v7+a1xq7KMR4J7XUe1qPJlRPY2oTDWw/svBGyzffyhWTnX2HeXyhMUrDTOT829RlqS5X/vhtZJg+6KVirNvgwcfcP+EKOYnLDcUrdIHYJTNqjh0OgwqdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfTa33g5ZatRTEUQyX5Vl2JhKhlNI6d1gj0uhhdwg9A=;
 b=MFOa9JwsJE5Rja/GtipYlrgBTCfTGC6fyF4vMfC64uGuRz2VmjACGtxme6m3P4JQw49XMU/6mfiBUKWVeaq251gx5sCMpOcPIbI+QFHI6dUp2hP/5fBmOLl+pEtvMb9XgDyJ7hhJK2ky5DZ82NazICG8gtp+YbgsDvIMGqT9jjPLVkLBLUx5f6TgXPOWS0l/NPj9+aLNDzHTDQ7s5TSFGFpAybp/3IQKSiL1xSsfOukeFqK7sW7/d1U7bCIDAmxZzuHKgqBElQdHIxeaLdRqHBpNkHv3IelluNliQtgV71x923CXPp+7lnxvQoeULrCf2+EkvXgrx+B5cqDcwxCxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfTa33g5ZatRTEUQyX5Vl2JhKhlNI6d1gj0uhhdwg9A=;
 b=ob15dvIz/H7DuhdQzkiyQN5jvABq3DHd8xoZjBvrYx67X9t45yZOU6CaI6xXn5Uc324k6bwITo0kHVO4jY8SRD6euI0oiUt+SS618m9GPQOUiBX2s7vreoWYnTk0+mAb2vS4MMNh2+UX+E+xKveKJXQCldYnfrB0pYKWko+0nAg=
Received: from VI1PR08MB2782.eurprd08.prod.outlook.com (10.170.236.143) by
 VI1PR08MB5343.eurprd08.prod.outlook.com (52.133.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 09:50:51 +0000
Received: from VI1PR08MB2782.eurprd08.prod.outlook.com
 ([fe80::2969:e370:fb70:71a]) by VI1PR08MB2782.eurprd08.prod.outlook.com
 ([fe80::2969:e370:fb70:71a%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 09:50:51 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 2/3] netlink: always use vmapped memory for skb data
Thread-Topic: [PATCH 2/3] netlink: always use vmapped memory for skb data
Thread-Index: AQHVWM8VQf9Dy4ajsUaRj1N9/B2WxA==
Date:   Thu, 22 Aug 2019 09:50:51 +0000
Message-ID: <1566467448-9550-3-git-send-email-jan.dakinevich@virtuozzo.com>
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
x-ms-office365-filtering-correlation-id: 91cfd55b-d9bd-4605-1aa9-08d726e637b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB5343;
x-ms-traffictypediagnostic: VI1PR08MB5343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB5343878219554BE43A99597A8AA50@VI1PR08MB5343.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39840400004)(396003)(346002)(376002)(199004)(189003)(44832011)(66556008)(66946007)(6436002)(14444005)(256004)(53936002)(52116002)(4326008)(25786009)(76176011)(107886003)(6916009)(81166006)(99286004)(8936002)(81156014)(8676002)(71200400001)(71190400001)(2906002)(478600001)(6512007)(14454004)(36756003)(86362001)(54906003)(6486002)(2351001)(316002)(386003)(5640700003)(26005)(3846002)(186003)(102836004)(446003)(2616005)(476003)(6506007)(11346002)(6116002)(5024004)(5660300002)(7736002)(50226002)(66066001)(486006)(305945005)(66476007)(2501003)(66446008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB5343;H:VI1PR08MB2782.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qgpwW7MP4qqTdgrJhF1RVTay7y0479ehJrp1wy3r9IcuR5VEDLKcHAOkETW2QOtJH9kw5D8byGZUROBUZOJ5q8goN80GDsZTaLLUlmhAVHiARD9+hdXYypOCERJ0Z2d81lr9ODQNl9DmlFEbH3iF+tQOw3xy+i3BARXx0lZvwRYleL8xvG+Pa8avltqEvOz4BwPXWI27dLxS++jDR3uvURhpWQjz3utvLXBPFhQUMknbhYhZ18WWP2ImIGQG2yLfSY/BFM6BvLKwmwGhpk50qPVdY9b6tIighH3psjb/IZ9BW4E5YX83Xh+n2U4zovqOj41dRahT6P6e+PDNbni4uayArfE1wqDoKX/9xKadW2b/tRdryZ2dD5GE2VoNQZlX12iJrOuo9n9r3EBwYGG7MIpiWIn7Byhc4gGnkriPre4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cfd55b-d9bd-4605-1aa9-08d726e637b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 09:50:51.6606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aucPHluwDhbTkSxsF8LOE4SyWUsLe0mBklaC95T0DvjjsmtJptKw/xZov8JUgUi2PejzSuOk6ko3XltY1macZMy23PmfH2n4z+fi/M/raUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't make an exception for broadcast skb and allocate buffer for it in
the same way as for unicast skb.

 - this makes needless calling of special destructor to free memory
   under ->head,

 - ...then, there is no need to reassign this destructor to cloned skb,

 - ...then, netlink_skb_clone() become equal to generic skb_clone()
   and can be dropped.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 include/linux/netlink.h   | 16 ----------------
 net/ipv4/fib_frontend.c   |  2 +-
 net/netfilter/nfnetlink.c |  2 +-
 net/netlink/af_netlink.c  | 16 +++-------------
 4 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 205fa7b..daacffc 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -146,22 +146,6 @@ int netlink_attachskb(struct sock *sk, struct sk_buff =
*skb,
 void netlink_detachskb(struct sock *sk, struct sk_buff *skb);
 int netlink_sendskb(struct sock *sk, struct sk_buff *skb);
=20
-static inline struct sk_buff *
-netlink_skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
-{
-	struct sk_buff *nskb;
-
-	nskb =3D skb_clone(skb, gfp_mask);
-	if (!nskb)
-		return NULL;
-
-	/* This is a large skb, set destructor callback to release head */
-	if (is_vmalloc_addr(skb->head))
-		nskb->destructor =3D skb->destructor;
-
-	return nskb;
-}
-
 /*
  *	skb should fit one page. This choice is good for headerless malloc.
  *	But we should limit to 8K so that userspace does not have to
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index e8bc939..cbbd75d 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1371,7 +1371,7 @@ static void nl_fib_input(struct sk_buff *skb)
 	    nlmsg_len(nlh) < sizeof(*frn))
 		return;
=20
-	skb =3D netlink_skb_clone(skb, GFP_KERNEL);
+	skb =3D skb_clone(skb, GFP_KERNEL);
 	if (!skb)
 		return;
 	nlh =3D nlmsg_hdr(skb);
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 4abbb45..6ae22c9c 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -311,7 +311,7 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, st=
ruct nlmsghdr *nlh,
 replay:
 	status =3D 0;
=20
-	skb =3D netlink_skb_clone(oskb, GFP_KERNEL);
+	skb =3D skb_clone(oskb, GFP_KERNEL);
 	if (!skb)
 		return netlink_ack(oskb, nlh, -ENOMEM, NULL);
=20
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 90b2ab9..04a3457 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -360,13 +360,6 @@ static void netlink_rcv_wake(struct sock *sk)
=20
 static void netlink_skb_destructor(struct sk_buff *skb)
 {
-	if (is_vmalloc_addr(skb->head)) {
-		if (!skb->cloned ||
-		    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
-			vfree(skb->head);
-
-		skb->head =3D NULL;
-	}
 	if (skb->sk !=3D NULL)
 		sock_rfree(skb);
 }
@@ -1164,13 +1157,12 @@ struct sock *netlink_getsockbyfilp(struct file *fil=
p)
 	return sock;
 }
=20
-static struct sk_buff *netlink_alloc_large_skb(unsigned int size,
-					       int broadcast)
+static struct sk_buff *netlink_alloc_large_skb(unsigned int size)
 {
 	struct sk_buff *skb;
 	void *data;
=20
-	if (size <=3D NLMSG_GOODSIZE || broadcast)
+	if (size <=3D NLMSG_GOODSIZE)
 		return alloc_skb(size, GFP_KERNEL);
=20
 	size =3D SKB_DATA_ALIGN(size) +
@@ -1183,8 +1175,6 @@ static struct sk_buff *netlink_alloc_large_skb(unsign=
ed int size,
 	skb =3D __build_skb(data, size);
 	if (skb =3D=3D NULL)
 		vfree(data);
-	else
-		skb->destructor =3D netlink_skb_destructor;
=20
 	return skb;
 }
@@ -1889,7 +1879,7 @@ static int netlink_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t len)
 	if (len > sk->sk_sndbuf - 32)
 		goto out;
 	err =3D -ENOBUFS;
-	skb =3D netlink_alloc_large_skb(len, dst_group);
+	skb =3D netlink_alloc_large_skb(len);
 	if (skb =3D=3D NULL)
 		goto out;
=20
--=20
2.1.4

