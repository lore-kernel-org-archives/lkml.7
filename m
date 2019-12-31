Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B165C2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B95A206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2E0eSG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfLaTLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:11:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45842 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLaTLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:11:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so19840762pgk.12;
        Tue, 31 Dec 2019 11:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7NsGFyL6ByjBH13eAXZBut56mwO2xt3ZeGeMcb+Hlk=;
        b=f2E0eSG3VPeN1Itxwp9OiDcbMBPFeXFrp6ejxUcR0RkjQIFjoFziKemsGuZH/1cyMt
         X0bfUbxzDlxEMZzlN6pfA1ZF2b0eW9nIvfYIO8FbQ62UT7nzhgvt5+u6Lf9A7m/s7QNM
         EdsqCWy6kNb2FVJvJCds8Du7MwicmEhhSVpUOJ0CutvU9CbNKak65z5YJPSp+IPZMyHa
         ZBp6Wdiw1VMwCpdXE75Jb1fX0POMy0VSVSygCsxiPFsJyQMDI8lkMgZmVEIxudTlUfqw
         SlMqMybXsl5NtLUloXuI+XkuKANsI3rDO+krPa3GI6sNH9qQHvg4RF3sJ23+v6Fln5X3
         knHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7NsGFyL6ByjBH13eAXZBut56mwO2xt3ZeGeMcb+Hlk=;
        b=iX+uU4biUusZh2omV9ShMtE+k2gNttOHI+32414XrzNj4LTvzsa6sSdSaBDvPpyQsP
         HK6x3Yv5xRwEbkh3OG6fxxonumfSKbgs52idLmLCuKVN03JdfkQtXQKhvBeB2/QpKpRG
         b2yfCA5CEeD/RBgRj6GM0/WuraOVatbPuW3YsvmYevVOLasjnYjYItlfT2qUo4hNrcK+
         UgXRmyffCbm7jeh7Jjf+kXoOMNlG/qCG0QKAeAREjDmolovI1lcuPwZ+kJYUPCHMkhpn
         0vQktxH3alTJiZ9VR65Dl/B/+4RsOggTrC+ibsMHdZhhDElCLs27PXwnbq1so1d0Ym2A
         KEOQ==
X-Gm-Message-State: APjAAAVn7/FvHnrjhmku/gjM4oR7+giwompycWTbLfL9vTb37KjARjFi
        MjByK2niJhzO+I5Q4S00mMA=
X-Google-Smtp-Source: APXvYqx5y1vzawjtwVueYppF+V0vbzdFcCD9/8ei8Oup39lR4dzKiCzp/e1weIe0JQq76mIxic9NVA==
X-Received: by 2002:a63:d249:: with SMTP id t9mr81411546pgi.263.1577819509949;
        Tue, 31 Dec 2019 11:11:49 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id s24sm4366134pjp.17.2019.12.31.11.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 11:11:49 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] media: dvb_dummy_fe: change printk to pr_warn
Date:   Tue, 31 Dec 2019 16:11:23 -0300
Message-Id: <c6be59de9adeb9586be82bff56c951257c371fab.1577819245.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577819245.git.dwlsalmeida@gmail.com>
References: <cover.1577819245.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Replaces printk with pr_err to fix warnings from checkpatch.pl

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/media/dvb-frontends/dvb_dummy_fe.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/dvb_dummy_fe.h b/drivers/media/dvb-frontends/dvb_dummy_fe.h
index 1c82338e0c8a..9e974397a246 100644
--- a/drivers/media/dvb-frontends/dvb_dummy_fe.h
+++ b/drivers/media/dvb-frontends/dvb_dummy_fe.h
@@ -18,17 +18,17 @@ struct dvb_frontend *dvb_dummy_fe_qam_attach(void);
 #else
 static inline struct dvb_frontend *dvb_dummy_fe_ofdm_attach(void)
 {
-	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __func__);
+	pr_warn( "%s: driver disabled by Kconfig\n", __func__);
 	return NULL;
 }
 static inline struct dvb_frontend *dvb_dummy_fe_qpsk_attach(void)
 {
-	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __func__);
+	pr_warn("%s: driver disabled by Kconfig\n", __func__);
 	return NULL;
 }
 static inline struct dvb_frontend *dvb_dummy_fe_qam_attach(void)
 {
-	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __func__);
+	pr_warn("%s: driver disabled by Kconfig\n", __func__);
 	return NULL;
 }
 #endif /* CONFIG_DVB_DUMMY_FE */
-- 
2.24.1

