Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE880C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D68C21783
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfFSNZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:25:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfFSNZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:25:29 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mbies-1iBHAs3HME-00dBxG; Wed, 19 Jun 2019 15:24:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Max Kellermann <max.kellermann@gmail.com>,
        Wolfgang Rohdewald <wolfgang@rohdewald.de>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND^2] media: don't drop front-end reference count for ->detach
Date:   Wed, 19 Jun 2019 15:24:17 +0200
Message-Id: <20190619132447.2224228-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CeUekxDC6JO6ENQ4SJIuNU0QYix/S5DqkpwK/WxHovTZuGEQkmL
 qV32Chr0BRTxPamU1i+xY+s3Kup/Cbj53EURKJ+dS/EhNeOLMxUbzxd/EtxMh1XxZivSbtc
 o2FXbLY8t9WYX2YnZhzNNLjMsfTBJEy1fEJzFRgsnJ2ewnHsQyeZWHtyOnyihK0UZ1nW5Nn
 jL832bEXJwOBD/A+SeeZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g5EO8Qvn5Ng=:f8/swMhK+LfLyGQS2Iu+wP
 BcGqJvK/cwJpevUDOHIoSCc4cVtItCIRhiN+TRxbkrOZLPLPf9nwwFNNXpQmi2RSm4ys18GFh
 18Jb7vw4KK6HYRFGOpZkr//pdNmUj17c0iAH60nmEl7PDw0N+LN1GDgHaQpRr8W/MMZxIlNkp
 tLGa/CbmrlD8pERSQXvCfqlO0LUOHKNEFHDN5e+C2828lwT9k49HVVFd1REY8XsadAA7BgbMs
 V7weDlxPxsoXmbAJWqo3U5rMtLYB+9YdIlVd50jRr204rpOJMYYiCd2H8sriV2/4zrFZWhQOz
 wIvlxQMmsP4bOMCRqUfg6sEFpLxjh/zcjqhePraRLpPHalZs9OGIP2JDcvqmIpf767orgaj7J
 96TjtjrEF8eYzZBYb+tIRfMRmpwN/pA1ikCQ60lSan8wI02K4bbEwsS2o6WtobHJZjhl3eb7n
 Mt49J3blfhwoR/IBvJ1KwLJDrWuoL83HvBfMxlf1rQkIgQlJE/SVDQQn9jDlvV6GBiNMH7kOY
 qqrO1U0uws8/t34l6bYaftI2ifTcKNV2bS+6MuO6n82QNq8Gj0AArhqtQWEswgaNQNJD3jgEp
 U+e27d0+gFMlXKv9ZSg4U6UjhBIpJRnTRZaMtA5xlRYVyEWYQS3Hbksb72xwCMiqVRFO8ZDZn
 eRetHON58GNSmtOj7dAJKEpJfBs6VhTYNqibfnH+nGuNlHFTd1fTfcJNdXpApmtkJbzl8Nu5V
 vHYnv8GNL1ncfmWfAbgKrIPOnALKjdllV/MdEw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bugfix introduce a link failure in configurations without CONFIG_MODULES:

In file included from drivers/media/usb/dvb-usb/pctv452e.c:20:0:
drivers/media/usb/dvb-usb/pctv452e.c: In function 'pctv452e_frontend_attach':
drivers/media/dvb-frontends/stb0899_drv.h:151:36: error: weak declaration of 'stb0899_attach' being applied to a already existing, static definition

The problem is that the !IS_REACHABLE() declaration of stb0899_attach()
is a 'static inline' definition that clashes with the weak definition.

I further observed that the bugfix was only done for one of the five users
of stb0899_attach(), the other four still have the problem.  This reverts
the bugfix and instead addresses the problem by not dropping the reference
count when calling '->detach()', instead we call this function directly
in dvb_frontend_put() before dropping the kref on the front-end.

I first submitted this in early 2018, and after some discussion it
was apparently discarded.  While there is a long-term plan in place,
that plan is obviously not nearing completion yet, and the current
kernel is still broken unless this patch is applied.

Cc: Max Kellermann <max.kellermann@gmail.com>
Cc: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Cc: stable@vger.kernel.org
Fixes: f686c14364ad ("[media] stb0899: move code to "detach" callback")
Fixes: 6cdeaed3b142 ("media: dvb_usb_pctv452e: module refcount changes were unbalanced")
Link: https://patchwork.kernel.org/patch/10140175/
Link: https://patchwork.linuxtv.org/patch/54831/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
resending again, after nobody commented on the resending in March.
---
 drivers/media/dvb-core/dvb_frontend.c | 4 +++-
 drivers/media/usb/dvb-usb/pctv452e.c  | 8 --------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index cc31c2bf0483..202f0ba5819c 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -152,6 +152,9 @@ static void dvb_frontend_free(struct kref *ref)
 
 static void dvb_frontend_put(struct dvb_frontend *fe)
 {
+	/* call detach before dropping the reference count */
+	if (fe->ops.detach)
+		fe->ops.detach(fe);
 	/*
 	 * Check if the frontend was registered, as otherwise
 	 * kref was not initialized yet.
@@ -3040,7 +3043,6 @@ void dvb_frontend_detach(struct dvb_frontend *fe)
 	dvb_frontend_invoke_release(fe, fe->ops.release_sec);
 	dvb_frontend_invoke_release(fe, fe->ops.tuner_ops.release);
 	dvb_frontend_invoke_release(fe, fe->ops.analog_ops.release);
-	dvb_frontend_invoke_release(fe, fe->ops.detach);
 	dvb_frontend_put(fe);
 }
 EXPORT_SYMBOL(dvb_frontend_detach);
diff --git a/drivers/media/usb/dvb-usb/pctv452e.c b/drivers/media/usb/dvb-usb/pctv452e.c
index d6b36e4f33d2..441d878fc22c 100644
--- a/drivers/media/usb/dvb-usb/pctv452e.c
+++ b/drivers/media/usb/dvb-usb/pctv452e.c
@@ -909,14 +909,6 @@ static int pctv452e_frontend_attach(struct dvb_usb_adapter *a)
 						&a->dev->i2c_adap);
 	if (!a->fe_adap[0].fe)
 		return -ENODEV;
-
-	/*
-	 * dvb_frontend will call dvb_detach for both stb0899_detach
-	 * and stb0899_release but we only do dvb_attach(stb0899_attach).
-	 * Increment the module refcount instead.
-	 */
-	symbol_get(stb0899_attach);
-
 	if ((dvb_attach(lnbp22_attach, a->fe_adap[0].fe,
 					&a->dev->i2c_adap)) == NULL)
 		err("Cannot attach lnbp22\n");
-- 
2.20.0

