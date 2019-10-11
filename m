Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D80C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B55820659
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIio2u/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfJKGDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:03:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40124 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfJKGDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:03:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id d26so5145320pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 23:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78A7v/fFdhcM+C5XDuRJJKeqGNkh4U2EwVbQjxNiiy4=;
        b=TIio2u/GyvX/4+US8sREUzM6Z3hhenOMPV+381jep+sjhxKO4duKvimQMh/WPE0REM
         vQ+hdZk6PiDEiiEI5UMiLw/ELIodqrpT+mMyC4BMOpNwqbEijlZRR2UvLGuqF2TIfk/E
         m72QSO8KEWaevDMZk1br1k5QbLZAl8VWvHZcAZsEJqnh/kvm6aU3y4x1u92gjAauMcJx
         52kH3N0IiXPMGRJ+7CQs70UYTu0oBw38cAR1iLYvYDuypvyDYmmYbidP53/YVZAdmPVX
         uIK1IPLS5uI3Z7/lGmjddnqWztt0vd7rZGNO01P/gZR7v2LfI8uvp9pfluKIfS5gSwga
         yr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78A7v/fFdhcM+C5XDuRJJKeqGNkh4U2EwVbQjxNiiy4=;
        b=sZxIrTXdY1+7o3nuqTZMzrBAy/m60tAOwoxSr1n0ETJfINOokMKZsH1LBcjSMLOLDT
         /As7UeXF41QQJn4SAgD9bGmqc1iYJPUL+/QJTSeD5wtRSnbSk+YCtNCpFkM8sR6kozeM
         zCUBErSxB1f7+7BRtFu5rQBGuRD2AzbMbn6iYWAG7+x6I3Fy/T+uMcSXzmuifckHbC6J
         BY8Lf9joy8GX6y+t49vc1etDbdTHH1WpGOzY8j/4kn6f215fvuBNDV95NmxGJOqffS+u
         58sVdSNh0qEYJt9CghMu3Zxn7pW+GIb9mqqC3Bjgb302gIRWfmHN7ED1wocJ8rWMoQP7
         yzgw==
X-Gm-Message-State: APjAAAW9CnDwRDSB55t9oTdherJIC2DgQXu2j1BNODt02HuLc1RItyCO
        wDG1d+lpE4fCOfnbk5TQhHY=
X-Google-Smtp-Source: APXvYqxAbeDhratVFVpqAgrqEEyvL459IUn6tvSiUjmOrTT0qhi5OdkDFtTTk4rrCFl8KFbdt0RVOg==
X-Received: by 2002:a62:6411:: with SMTP id y17mr14803815pfb.158.1570773827623;
        Thu, 10 Oct 2019 23:03:47 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p11sm9395715pgb.1.2019.10.10.23.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 23:03:47 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH 5/5] staging: octeon: remove typedef declaration for cvmx_fau_op_size_t
Date:   Fri, 11 Oct 2019 09:02:42 +0300
Message-Id: <777c55e3bb9f2f4804765bb0daca1720d8aa5085.1570773209.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570773209.git.wambui.karugax@gmail.com>
References: <cover.1570773209.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove addition of new typedef for enum cvmx_fau_op_size_t
in drivers/staging/octeon/octeon-stubs.h.
Issue found by checkpatch.pl

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 06e6a0223416..a0aa99e7b757 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -205,12 +205,12 @@ enum cvmx_fau_reg_32_t {
 	CVMX_FAU_REG_32_START	= 0,
 };
 
-typedef enum {
+enum cvmx_fau_op_size_t {
 	CVMX_FAU_OP_SIZE_8 = 0,
 	CVMX_FAU_OP_SIZE_16 = 1,
 	CVMX_FAU_OP_SIZE_32 = 2,
 	CVMX_FAU_OP_SIZE_64 = 3
-} cvmx_fau_op_size_t;
+};
 
 typedef enum {
 	CVMX_SPI_MODE_UNKNOWN = 0,
-- 
2.23.0

