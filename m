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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8042133F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DeGTzMvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfHVPA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:00:56 -0400
Received: from mout.web.de ([212.227.17.12]:43209 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfHVPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566485699;
        bh=eQcMl+avN3kIGGjB3h5pSL5Jp/iss5fD7c3NsD0te/A=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=DeGTzMvsX/JvLHOCiLwrrjeocg8CgDi1Zh08eA0JaVL72hh0DJ0nfkJi+v4JHjASv
         3prpr62k4w4DgZpww8iSVqC0CB3CbDoxrAQMKTV54pvI+evPrykGdJ6Qa4t8lt/YGa
         P22aG1OP6EEL+1OWGttmcQThXULSuEJI5BHtaJ/U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.181.43]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4ZTk-1iAeD83J6q-00yeHS; Thu, 22
 Aug 2019 16:54:58 +0200
Subject: [PATCH 2/2] ipc/mqueue: Improve exception handling in do_mq_notify()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Li Rongqing <lirongqing@baidu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <6e9378d1-3b9b-e138-53f6-bc5683ac8b8c@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <592ef10e-0b69-72d0-9789-fc48f638fdfd@web.de>
Date:   Thu, 22 Aug 2019 16:54:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6e9378d1-3b9b-e138-53f6-bc5683ac8b8c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nihP1aXNcItu2XmdTNy2sYhpRwgN6spV+s1mfBOGQqQ6ee7b1v+
 g7UHRlM6M/g4QG5Aen/rExoklC7oU0A4UDGCqqlSHwrtxFmz0MULnswpoIJEnwy+md8WQAc
 jIT8lx3jAUc+n3JnYNvlzy/+qEMOd3K4Ip/4ffK+AMXSxXm+4fqSw+nV12iOY715Lo2srKH
 SGwjF1DjPgsEZZZY6/UGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jpFVYdL4I0c=:OYor+BDZoYyK8cDVBopyUk
 kxHeMe+5g/bP4NJz4B1ZLYNlCKEluHJyxGtI8L9VybEME9zjwB46i8IV7mN/H7VGGX9wcW+wC
 73d3WuitvYHNPCUmn4YPRcjRNlFJJAAqUXwz/ZLhkAMUIGjsPwJDZgeE4zz8steQPQCYvJcat
 WzA7oTshh4uaDXuFL/YMpuc/KX3VvHTQ16eEB9X5G3ph/VEdtsMrXNRj41OX5THkFDxpEIpk/
 kw+hUaHNcvZqOE9F9VvGbOW8BFH+s0brO0fYROhHH1kjBUQtdA2yjzrhmXVAG6s8HUhbnpyyk
 9q1l5TbzTHyZ3S4+LuUn+0S4R8Y59eG0BtdvTksDHXSrbFGvt6ZTMiJozp/EsZaBFc2VL0NK6
 2gfocTxTI1rqegFZhnYhBKE1s/gWvX8r/t0N5kayvgXH1enSn6LaVFiMWn047FWgxmbfY7MRL
 W54muRI9GGzdn6ri6zi9PsAX5pTSek+KWHPh9f1WgLziQYNBZdieSNR4k6phOU3dszLcAngqE
 tqsiLDjzUWgHZ/OOyAAF/3432G2Yd+r9HMD7i7KQ98fdvAwkJZhr0NvJhcJlRN+HFmygusWqN
 oH2FzKxLNRaX/LlRxqhWS9GDeDw2yX9o8g9kUEyKDXJ9em0IopU8+c0NdaviSVJzkSSvzz7K+
 NKyhi7dkREsmutgGbjn3sx0l0QGdVNRLVjNfwRs0UXzRUW2A4CO/SVJrGd44ssXfyN7dLKc9s
 s4RH6EOQDz2sWaFCNWkg6I8ioRK3ZNkKW0n3aPrhg6k3MEzjm7cmEznyAWzyF+V1AGZmdeY1G
 vAXDfXwaiXQTqfpb7AVkZJfZQBbTfHGkKuZeYpbxfKf72zk7fxdsk6WyT4DPy3DdJvsDrHGQt
 AbimASSIs7//sQoAmfY/B9ir50PA6ddMz56gKpHXGy8IG5HQ7WhmpDnWjzIV1jVdKGjvPijEr
 +SdMyxryz3N3hoJ7i+h95iipYYP7bRLWjGDhIdfacOqMsml6bCnji/fobaN4YvYAzUPNey647
 9mp3IWvtZpGZw6/e/ECnBSVcjgWQQlMDmUwtta9mvyQZCE5pjy00lPdRuXinGv4m1RWRFsQ9T
 aSCDFUt9GabfepvFbZV/q1grQQmC7/a/vAUgrvQMg/74LhurHKk9msTY+RAgUh5c2a5lAzx0o
 IvjYI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 22 Aug 2019 16:21:17 +0200

Null pointers were assigned to local variables in a few cases
as exception handling. The jump target =E2=80=9Cout=E2=80=9D was used wher=
e no meaningful
data processing actions should eventually be performed by branches of
an if statement then.
Use an additional jump target for calling dev_kfree_skb() directly.

Return also directly after error conditions were detected when no extra
clean-up is needed by this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 ipc/mqueue.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 494ab78863f4..ad6c475eb370 100644
=2D-- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1241,15 +1241,14 @@ static int do_mq_notify(mqd_t mqdes, const struct =
sigevent *notification)

 			/* create the notify skb */
 			nc =3D alloc_skb(NOTIFY_COOKIE_LEN, GFP_KERNEL);
-			if (!nc) {
-				ret =3D -ENOMEM;
-				goto out;
-			}
+			if (!nc)
+				return -ENOMEM;
+
 			if (copy_from_user(nc->data,
 					notification->sigev_value.sival_ptr,
 					NOTIFY_COOKIE_LEN)) {
 				ret =3D -EFAULT;
-				goto out;
+				goto free_skb;
 			}

 			/* TODO: add a header? */
@@ -1265,8 +1264,7 @@ static int do_mq_notify(mqd_t mqdes, const struct si=
gevent *notification)
 			fdput(f);
 			if (IS_ERR(sock)) {
 				ret =3D PTR_ERR(sock);
-				sock =3D NULL;
-				goto out;
+				goto free_skb;
 			}

 			timeo =3D MAX_SCHEDULE_TIMEOUT;
@@ -1275,11 +1273,8 @@ static int do_mq_notify(mqd_t mqdes, const struct s=
igevent *notification)
 				sock =3D NULL;
 				goto retry;
 			}
-			if (ret) {
-				sock =3D NULL;
-				nc =3D NULL;
-				goto out;
-			}
+			if (ret)
+				return ret;
 		}
 	}

@@ -1335,6 +1330,7 @@ static int do_mq_notify(mqd_t mqdes, const struct si=
gevent *notification)
 	if (sock)
 		netlink_detachskb(sock, nc);
 	else
+free_skb:
 		dev_kfree_skb(nc);

 	return ret;
=2D-
2.23.0

