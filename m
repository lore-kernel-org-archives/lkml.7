Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DB8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7405206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9El2qqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCQSbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36123 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfCQSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so2086417wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Wf+bmNv345I/2uwkHlStaw5YKsDPQ+gtBUvmRGoCFLA=;
        b=r9El2qqderLJqFjvmZfNygAuPOmzHxwJSTRNKiK0ADSw4eUR1/3xlpO8VAlhSztqMs
         tjsnh362ko+c/4JhMc32C4T0XK1uDcKEZ01KR30S47JfzgOXb36MZ0aU1Adm/dPJq+jS
         tkIbkauEga173asKzD3gVxGqSBCcFDiZ+VS0A7LAQPHbyZC0lq30fh36iP7SVtg/ANhX
         3Qr79NyooM74pv8yzNW2m80XqNytXvpadNMFghzHu7bYQBUh+RfpO+E9j+ZWerEJWEmz
         p/lALy6mybSuhhgTRbJPxgDw4L58UZO8LcQZ15p/gbNsrRvVPLq8jFlP0X+zQ7aQXIeY
         exdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Wf+bmNv345I/2uwkHlStaw5YKsDPQ+gtBUvmRGoCFLA=;
        b=AZ6/qXtmUNqYMwrm2YGzVZin7GT6H2qOM5dAQn5eZ+oKX5sb2MpUQb/idt9msqPxrl
         lCU3+hCM9ibWMc35yNJzLVDEsmqbOIDwGngG/MhYlIrUsiCIt0KDUunZWtTyXL1kSV8U
         Ub/van/fS9Wgw3mizVJdc+X9yBRn3Wdz7O8N1/elgzTef5dYUv2rxPQNA2NLitsx38gO
         Add0xG4TjT0QydRXfEcKp/mBzKvBJH6KUlTa9DVhGdXLIkYoMXvB8HIuNu9dnRV7TEON
         Pu5d6n2oR9SswZpl7wtS/sVDr5YycGvUtUL4jU22I6M0oPsUB2C0DSnnCmrHVnR8NCZP
         D1cA==
X-Gm-Message-State: APjAAAUJ2Fk6SQXS9HkoV+V4Is5BRXyw0+mlLHmvxtqbSMZJktNUw6zG
        IHHFqdpVp5ZTm9F9tLbxDI7i5UWRMSs=
X-Google-Smtp-Source: APXvYqzfkSA7e9GgdAcwnt+hW5ut8nzSbarXX/EbJqqtSQlOV75+5c2cp1rm2FATm35eMU0zrQPfmQ==
X-Received: by 2002:a1c:4d:: with SMTP id 74mr8349491wma.1.1552847509845;
        Sun, 17 Mar 2019 11:31:49 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:49 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 09/10] staging: rtl8723bs: Remove Dead Functions in os_dep/ioctl_linux.c
Date:   Sun, 17 Mar 2019 19:31:12 +0100
Message-Id: <20190317183115.32393-9-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190317183115.32393-1-benniciemanuel78@gmail.com>
References: <20190317183115.32393-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Functions `static int rtw_widi_set()` and
`static int rtw_widi_set_probe_request()` part of dead code due to
CONFIG_INTEL_WIDI.
The fix removes the deadcode.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 36 -------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index f1a1baf72488..4fcd404f0dfc 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4514,42 +4514,6 @@ static int rtw_tdls_get(struct net_device *dev,
 
 
 
-#ifdef CONFIG_INTEL_WIDI
-static int rtw_widi_set(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
-{
-	int ret = 0;
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	process_intel_widi_cmd(padapter, extra);
-
-	return ret;
-}
-
-static int rtw_widi_set_probe_request(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
-{
-	int	ret = 0;
-	u8 *pbuf = NULL;
-	struct adapter	*padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	pbuf = rtw_malloc(sizeof(l2_msg_t));
-	if (pbuf) {
-		if (copy_from_user(pbuf, wrqu->data.pointer, wrqu->data.length))
-			ret = -EFAULT;
-		/* memcpy(pbuf, wrqu->data.pointer, wrqu->data.length); */
-
-		if (wrqu->data.flags == 0)
-			intel_widi_wk_cmd(padapter, INTEL_WIDI_ISSUE_PROB_WK, pbuf, sizeof(l2_msg_t));
-		else if (wrqu->data.flags == 1)
-			rtw_set_wfd_rds_sink_info(padapter, (l2_msg_t *)pbuf);
-	}
-	return ret;
-}
-#endif /*  CONFIG_INTEL_WIDI */
-
 static int rtw_test(
 	struct net_device *dev,
 	struct iw_request_info *info,
-- 
2.19.1

