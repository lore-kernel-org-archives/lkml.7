Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F337C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE02C22CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sxlbizqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfHUMIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:08:18 -0400
Received: from mout.web.de ([212.227.15.3]:49701 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHUMIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566389289;
        bh=Gs6tfVTCl3a0CpV3ijzDB0oxKOCcKryN1lapcjxRyZ0=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=sxlbizqDGNOXr+VyQo7Y6Uf/10jAEV2k6mOVrYsYmGk+IcG15rA5ZsgeKA2vqFS2u
         2QovwTx5Txl4cA4o5AVYfBMlvdZSjkXSWiuvgq9mAzvpnrB3zZMvotkn6iyE72EOED
         NvY69tHHt5XYzPguOi2PgrtN9ikg6IkQUJlpuU98=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.9.44]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LegAQ-1ibLiZ10Ry-00qTWS; Wed, 21
 Aug 2019 14:08:09 +0200
To:     devel@driverdev.osuosl.org,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5bPATCH=5d_staging=3a_vt6656=3a_Delete_an_unnecessary_ch?=
 =?UTF-8?B?ZWNrIGJlZm9yZSB0aGUgbWFjcm8gY2FsbCDigJxkZXZfa2ZyZWVfc2ti4oCd?=
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <ff6e12fb-f144-351b-25e9-a864b58d7acf@web.de>
Date:   Wed, 21 Aug 2019 14:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u4mBGVc+GTyiCCvK3dEEboNXwRxsps4OXWKIYCQbut5U5EUC9Al
 MTzKvrrobzjZcIES61TgkzB/6a8LJp7kdkzM/1Y4DbmybWlBzoS/zoGCEX+vlPyJJmDGBsU
 we44eodBeeu/fZ/662+a4UepLY4Dp8GdqZGCLlt5ptgZSICl6Khew7l70seSjAzi+F1VQVj
 vK5TTKaD4cmepUlHgYFjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zlteFMvEabA=:IYeMQksexDIZkUKlppTv2U
 ABiS0nYz5C+my5RjZgzYfOd7NMp7BYMww//Zt1D98Lpoo/ceNSdZhHt6uS/HVc9t78iar11+n
 tpOE4zsTTVyZ3clD00jDsvxOvaazAOStv4JU/MU27u+5SIL0ryiiNhR8cEwSYBF8Mf7AkbT/o
 QZha0JVKfz6W9YVLR71xnkhbHhW7UnYNga1+6bgrkKYsg2RBLcdZ9q2ffmSxX2ej1yMaPU8Nl
 KfDBC2kdf8eAJ+nP3oa98w12/wCW0ZDde9ZOweJfu9eDP7xt5ehUMrNIedxyly6N/8niZRnmi
 8GrGBK/YGqo8cVQ424h81gHvHHM/wb2Z1k6T+O7GT7vpxlfOZFtbNW8zjYxYEzhIS6bHSFHTw
 yG0ot41Ne3rNC+h2LUJBi5knkSUWD/WV7ljwpEyOjjYBdn1DoibJdYZ+SxIONa1gH9aZ/EXHX
 18LTt/Y9jc+Y5Q4DBLci14SHBjJwpBtDHSnLcCxbpUl9tnkjWgVzp7ZTl0Hsn6aZOMC7GT4Ek
 XFY6tXiBDn83s82OTZTJZyzXAh9KcmlbhxhTJdCEP1nNzW0wixaX2nS5wJPudXrDA+BhOlJu7
 e0cyPB2DTLbf7n598tOziDO1LKwrRC/pPcflLqSF2a1jTv1qL6lXRJgcWyQph3ajWkcviP+/o
 nQkEvKtSEHuNOY3dFmtiDcljuVA3xjfW+7c8KHw1m+iwX/B6XOWWYVXa0YVvR5o00NppZkPza
 6+95vCURDRjxV9G50m70QKrpiGtq/hBwgvMkaofVYHUOFCsy0XwXAhENJjdlk2BXcaoexqoA5
 56wighaJGh2rUXOMcyEQxoTqd538SLcgbA8L7h6Pr70FtwvxzXRfV0v0gH1uTKkwPLqNUEbWk
 /sHT0lxNHJF+NZhK43lago9NSwbKs3VLBpGL+PAvc6AjgbtUuTdOPtUUnVuzLOwuh3MeWk0sg
 xsu3cZ9ShXqpuP8TK4BUvIl3cds+2mwmV+djR1owkaswZ0OHPeBeyV6DOP8ztiFYCZwx67wIe
 tplotPUMgy14BM6r+/Ru2B1+aU0o4ORpFHTUhIZrtTnrLEmfYcl1uyKo4l8Ih6ZBnjcQYmM5k
 8B++YTwULAiSZvF7s0xAW0ThFlGunxbYcnFmmtX0VJRNWK0swLlF8cABXugn8XZ2KQayu6EQ1
 DDSGUsgBPpURbgTC22W+Too0b5mXckAoS4itNccasZO+mvIA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 21 Aug 2019 13:56:35 +0200

The dev_kfree_skb() function performs also input parameter validation.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/vt6656/main_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/ma=
in_usb.c
index 856ba97aec4f..f57e890659aa 100644
=2D-- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -422,8 +422,7 @@ static void vnt_free_rx_bufs(struct vnt_private *priv)
 		}

 		/* deallocate skb */
-		if (rcb->skb)
-			dev_kfree_skb(rcb->skb);
+		dev_kfree_skb(rcb->skb);

 		kfree(rcb);
 	}
=2D-
2.23.0

