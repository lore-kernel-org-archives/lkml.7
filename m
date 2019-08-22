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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1336BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53C92133F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DWcwa5mL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389148AbfHVO6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:58:49 -0400
Received: from mout.web.de ([212.227.17.11]:37869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbfHVO6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566485580;
        bh=laNrLcoKOC6PZfIKvLc6tR9UiABDlygov3ZDtuLoQQI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=DWcwa5mLl5fSG10ckxJkhEo6B9jwpIlCp/gG1in27OpFLRJfg05pB7vL0rkN+4XKQ
         v2yrIEbcEbMM6aP8q3//3OQ45/yY5bvB0tL72zd7X5ssFxqBT/ye8AP+PNrY/cgdmK
         sdF2YBwy/nwMRsiznJQs5vdXFNHJGzrYiVkXUk0A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.181.43]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MK1s1-1hzz6v1mLt-001ToU; Thu, 22
 Aug 2019 16:53:00 +0200
Subject: =?UTF-8?Q?=5bPATCH_1/2=5d_ipc/mqueue=3a_Delete_an_unnecessary_check?=
 =?UTF-8?B?IGJlZm9yZSB0aGUgbWFjcm8gY2FsbCDigJxkZXZfa2ZyZWVfc2ti4oCd?=
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
Message-ID: <07477187-63e5-cc80-34c1-32dd16b38e12@web.de>
Date:   Thu, 22 Aug 2019 16:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6e9378d1-3b9b-e138-53f6-bc5683ac8b8c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ksz9lXlJzzprN4y/6kTggolQWTokRX2QsM0w5W/uuh0PUbOaLVn
 uNB5O5yrOFPJFMNVIMFRPLsDe9xjomG/1Z514oeUTy0At0a1CqkJlzFKHCWkA1cAofpirvd
 uIiinS6LnDk8383z87n0+OmrfYGU9l9Zsh9NCLh4RMXWv+1jHG3byKG9moVHXyQRIP2Zk+9
 A15mfmsCc1z9LrrIlMF+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yc+tx7ueFS0=:c3RHU8gAZ14TkvPlbHBTPp
 GzD/Ek9Un+z7nAO01SUI8PCuVbHWpS8iaznppDRmQYsKJORFiYum0z9ZEs8BLVm1zZh+NAH7u
 A+SS4hdZHyUYpu8nzX85Jo1A9l18m/H+K7iwZCVcCZrZqermHPKXOYgUQaZgsAsgJTsJNxq4D
 QG0LlYeQQaf5vBsmfBrmU4/1IGdrLd/vJMA7PVTJhqy9BpBvyY75Vx/Ua8jRNtYQwbTSNkOXB
 E+fNcIm8GqPLiEjgVJQ+nkBmdYbr1aB3yCi7KeGVc0Ktjbrje8jQu9We1dtfLQJV2RtwUPUiH
 WoqlcBbz07Snm+FilysPzloQrTKCzFZ95v4D20BN7vOpu84ZFuNglSGhS6C9Qotco4xGfsBL5
 SNiVhCRLMZhOAMfuwMr9n28m4KM9n6UrSsHn/0TiIVZQNS08SizXzJ3hJV8atbZJ2C1XLnpqP
 9R/hYtyr0lvg3jpToOaVDuI36BzQG7hYLGv000uwbNW4DndsKUuc7+zOpWD6zpAYgmLkHdlMK
 6TUAoR2KA6+GvLBSDB3iWA45DrF1x/xehdb2Fs5yfBXnborUka3SrP6ETOW+/mVUd/PMvkJVA
 nbybZgo5rkvryqqF7llU7liVCoDUQKuL0YTtsSNQZKZDzrqQLKte6OTeod4hsz6FETOiqOwYD
 iSTcreJZdSiTJP5DiSvKYf/sqhwd7nRpwqCzdmkWdik5tnBM+G0jr0iHHsdcdGTMSz9X223MR
 MS5U6o5aGvA0aap94lFSfvPbovmdiTx/LY626M+1iLp0TECcYvq9/qRdYe4vUvLNfHG942lRT
 8BMSYSA6spMRQ1Z/25Df3oSigzZnhpyslhRNXl5QHnzUpbXAXrT+epQGnzhGON04Aft5fPO5K
 VVH9tAjX+VXRUEifeDWSXXWomvWoVWq2NUYvoBlNR8dRrCj54uro0s/fwFkPZVfVwhdQaZtgE
 4q4ngJyVi68l42NM3kajP7Qc1MKDyjJ7yR8LukGyJKelQwycdO02pEQNDinp88H7b2oXlZm3a
 ikznf5q5gv2tIlde8qsoFEUYc38RkRGPpP66zArXfcuq6f9rInaVR8J5n+ahKH7ZgRunWLqf6
 UcroG0Q37+LyV2hGqbtYONseW+o4Y8F/k8L6bnlR+Msr5k6jVL/oOunQ2dNDSsqw3mPj+zhdB
 s3I8nKAVlsquQdswlFw1C5C5TvuwH0gMliQv8D0Duufmz6iQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 22 Aug 2019 14:07:57 +0200

The dev_kfree_skb() function performs also input parameter validation.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 7a5a8edc3de3..494ab78863f4 100644
=2D-- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1334,7 +1334,7 @@ static int do_mq_notify(mqd_t mqdes, const struct si=
gevent *notification)
 out:
 	if (sock)
 		netlink_detachskb(sock, nc);
-	else if (nc)
+	else
 		dev_kfree_skb(nc);

 	return ret;
=2D-
2.23.0

