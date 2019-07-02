Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFCAC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FA22184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UQ0RKQQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGBSdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:33:35 -0400
Received: from mout.web.de ([212.227.17.11]:42069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBSde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562092404;
        bh=XBXlgdxq8oVU2ycoKygvKHdH4LF9bMOOCgFO6zi/iHg=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=UQ0RKQQTWpVyhCluuNXEd5kiC1n/iJjZ6y7qUs3Yl9B2jd1FEsxanjygbU3oPTxZN
         yyXwl6WHkX4c2ISt3BEfuoYVr8gTeJoJmTQRNFMQ7qjv2KtdiFx3Gz5Yq4FqYcKgDy
         iAWDDxBFPxK5AuRqKKz83+cXzfpIGQ7QwTZK0rd8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqUPN-1iCmWb1zAv-00e8em; Tue, 02
 Jul 2019 20:33:24 +0200
To:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] apparmor: Replace two seq_printf() calls by seq_puts() in
 aa_label_seq_xprint()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9dd6c122-89f5-70e8-acfc-d6d6596e1261@web.de>
Date:   Tue, 2 Jul 2019 20:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QYM2+DbNCRM7QoxJl09IOfAxvkii5ttI0N5dO3/pJgg7rpJLVyT
 i1m+pQrE5LJIL+tIsXaFww3uJ8r36rMk4AU7kJnWvTUJ2tc7EMl3DxPmVfgVtQu9Xmx72lX
 Q3C/XsELupenEdY/FA6C/AG3JTZnM+9MB0NNE7vcoJlB5MIInIzVVbFQZ8KS1oXkp6w7g67
 LobsUdsYu4hC+AD6GkFGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:INLRb3NmPrY=:4SrYQ7JB7D3x8vZh92IS75
 bKy1PnRDmMXRuAE7vLnDMalzDGCoQ0krHOxIm6Bf4bhAENtKy0zzVncNlweRy0uvFr7nru7ah
 BhDXUBHLLr/KmH/00fWLcORYAre9ayvTF5A8z8MepcMpd9/xQznWXCChl0XbRYtmD9CQ8KFeb
 SAzEhgWbBkXlDRWqYCBmIwuonFlk30FHXDrC94+btLt0H4gqcGYI4VxXaY2QEa6xumINU7rhg
 Ze1/ykZoxiO6Ehi/IG7VgpFzTy2DFCoZYMeWBc2OlDlxg0yEoY7lvu84F8iY9EpsuBzl2P576
 JY29U/ZPE6YRgwmvCv1ty9QxX4ewmBWlJf8WeYvP/871vx4YEjkQ3cz7N8f5bYpcQFnHWm6VF
 Dl/wzAZVjxcY7bxlXSYii8dUBkgPYyIotrhyfgZe8Gbcs7AJcV8QmBSdafG9DhlBfO0/7MXrZ
 jLOHsyEnqio23LAHs3tK+CrlpqAeVde2BAH/3MiZDWj9pRrbZMhO6xnB6crDFqfTiJxAm5JBh
 oXYxt5foyLHXpPvoFFwwKo0ntJf2S6TgS/eAJgbm/DBJyEka7WQIWk5Lx4CAan1mJ4U9bhtpx
 DmrD06qXTVrv/QHj2xnCcR/F9Mr/8VnXWJnbEL4TxpUB2FXRV02CrJ5U03sZ9yRKfMDEk77jY
 W/MUg7j4nLcnLzriYeRmjesa7CSvmuoYxN2a5VPExdInxK38ODwJQ2DFISACKtl3O5S1FYfcL
 7n+CwbkDXvMrfcY6TBLdM6ECRAYngYrjQgntWe/nQEksdlI6OMDttuDs38JNmh8Yi+LIyMCtZ
 V3dfdCeL/XW+3UkLGuNRWA3xPKsbnf0YayhhvcrF/ffIoqWTGLqufflpgOugkXyadlkLbHIPC
 i26wKjdDWHsM4U4C3zCiUX3y9qHBjxvkhmSOyYc2GN34Uj/oR7rZNsuQUJmLjLkriFJpZ+gRx
 D/G7yJj9rqDXOVE912TbJo7ca+fWNHxIEupu2x79g1+20dJnQiU1N9cTfsab0/020uXmJaf9Y
 MfiI6krkX74SY3hJIMjohpRQQh+Z1Pn/uy4Y/MgsG+qtFbo7rm8sk3ZThpkskmWqmxqaiwhem
 H+w17tflmomg+B6heiBQDp/7Bkn41Rm5+Od
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jul 2019 20:27:32 +0200

Two strings which did not contain a data format specification should be pu=
t
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 security/apparmor/label.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 59f1cc2557a7..20acc1f3112e 100644
=2D-- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1747,13 +1747,13 @@ void aa_label_seq_xprint(struct seq_file *f, struc=
t aa_ns *ns,
 			AA_DEBUG("label print error");
 			return;
 		}
-		seq_printf(f, "%s", str);
+		seq_puts(f, str);
 		kfree(str);
 	} else if (display_mode(ns, label, flags))
 		seq_printf(f, "%s (%s)", label->hname,
 			   label_modename(ns, label, flags));
 	else
-		seq_printf(f, "%s", label->hname);
+		seq_puts(f, label->hname);
 }

 void aa_label_xprintk(struct aa_ns *ns, struct aa_label *label, int flags=
,
=2D-
2.22.0

