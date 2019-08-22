Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC69C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5595D2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="K0w5fAkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbfHVJEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:04:50 -0400
Received: from mout.web.de ([212.227.15.4]:56781 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732071AbfHVJEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566464684;
        bh=8b9z/k1fNRAvtB/9f0FZJWDubRHccgphnERnIfxDYYc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=K0w5fAktxD1uiU5B/TTCHIi0yfjIX2/RL5WMQ/2/mvekOWJbXwbmdh5UX9oFVnbTQ
         ajU9ncqx+fzSuJabnZ9gxNHOMlh639fED5b8/8sdRhhp9Vqio+tvZq4+YdX2o13ZGW
         cn4Y7nrfGGsTvKbJhObWl0KIpY/KJwZhA2j72mOg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.181.43]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgOQQ-1hczdq1nRG-00NjkV; Thu, 22
 Aug 2019 11:04:44 +0200
To:     linux-s390@vger.kernel.org,
        =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5bPATCH=5d_s390/ctcm=3a_Delete_unnecessary_checks_before?=
 =?UTF-8?B?IHRoZSBtYWNybyBjYWxsIOKAnGRldl9rZnJlZV9za2LigJ0=?=
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <84733436-46d1-8f43-780e-7b3ab9f2a0ae@web.de>
Date:   Thu, 22 Aug 2019 11:04:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9/9bKPWT4eGRfPZ/nBcpfy2qv9tq1X/tGC7Wv3N7lrOkRQXb01L
 bMgEmxGvfwqiHP0J+H+IvRjxdJQvCYtjQVu46d+EYrmfZ1iBAMmlDCYMYzDrLyA1tApxs18
 MThQ9aSnt4pzkIDhusy+cxdRVn51qYrBSVNPqhe7jjHEOdctzAJm6z2ij6dAFjCVxTBxfKL
 HKvaafE+HDg6rhz1AWT3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M4KnS41kbK4=:9Wy5mN4MxSY3NsojYmxPcy
 E7qHRPjStG8nDVhLZEfDIITX4/Ov3AIjr+v+84UogRQll4hltTXrLeXIUTw6cteakEx8e+Gs3
 QHqDURbxNn6KTBM9m5ShOsvWWBZSny/QtULZt6qnX8tr0w+WHh1GnBPjF/+uhYDqU6/2XlL4v
 UdZYexpwqr8aAMdVmkql2sBwQat7G7eqTAnZlwOzzOdf8V4lJ131F1SbC4vJcogCMPHmS+D/b
 VLYN3Vv86a19AWZ8nevyT4YozeDoK/KFFvJNIc0m0PUncB/9MExEOsiTt7RtWS+LXWKDc+9YD
 g5xa5Gwkl3+L6qQyCvAUPaqKv2dipcI17GxIKW0A736+rYTx5cpdrcJyH4psdfA3ak5jfGRvx
 JaTexEgiw7lKYuxck7w4u3miCURhIHADQUDxfVb+sXg6tiuX4iSNLW2zgU98LyfI9ATwizVFh
 r95F0fnH60Qm7IkIp1gHUl3HnEaYUEuZvKvaHroIVnvuuXFlICYcsuBhgsBvvsuOOlzUcrZB7
 vv5gueYXK6BbFRhI10Azf5pTT6mUdUWUeckimlevAhzFmjVvSEBXGPOb7vlBRkj1s0goIaDBT
 z5rmtZusQxbudAvQJXcSWTnfP1ybpiQiC5vzp/WQMYOgteB1Kvk+k4wGeffzEVvI9CyW1RFlh
 bvI5UiMKnWVUDj3hFuj6ev1nGI3x3raWS01P5t5juDOdiEdT/zPwRLAdP+MhzcNDUS16vsx4U
 5ILEpDyCmXV6qK7cYgT/0ZUe4S1raOcn7aEngy55zJuvvGOoSdAaG7yqQQsdA5ovqdM6n64cj
 h8VZIGd/BJLEE9It2pncDe4C+ZlyfhwrGl25sHAZ9fOtg4Nj8DK20dtKHjHMALW6rGIRWlJM8
 R3TJ3ctyUQw2t/glSOsoSvQDhECOlw3H9G0lypGh6mFT3N3eLqMgdn572OpnqXFAaoUomYRlY
 UMdErn0UKKhXU805CmGLg62nMcLioyRfvOteMoA0YkDOiLuUj7w+c8ZHLke1p2nTlPBYZ2RZW
 ZGrwSgz3sb9ixISKf9CwA0DyT/JAEXxSmI1sJowJATYWWpsCK3GDqetN21XYdNmZ80aG/SUx3
 lePBlTKWExYfMqxIXJKDIgxJu0BWt0R88F1mxZD7LFtM3kM3pXlmOeX4/yk2qe79b6t08smUf
 cONBQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 22 Aug 2019 10:55:33 +0200

The dev_kfree_skb() function performs also input parameter validation.
Thus the test around the shown calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/s390/net/ctcm_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index f63c5c871d3d..90025d1923d2 100644
=2D-- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1074,10 +1074,8 @@ static void ctcm_free_netdevice(struct net_device *=
dev)
 		if (grp) {
 			if (grp->fsm)
 				kfree_fsm(grp->fsm);
-			if (grp->xid_skb)
-				dev_kfree_skb(grp->xid_skb);
-			if (grp->rcvd_xid_skb)
-				dev_kfree_skb(grp->rcvd_xid_skb);
+			dev_kfree_skb(grp->xid_skb);
+			dev_kfree_skb(grp->rcvd_xid_skb);
 			tasklet_kill(&grp->mpc_tasklet2);
 			kfree(grp);
 			priv->mpcg =3D NULL;
=2D-
2.23.0

