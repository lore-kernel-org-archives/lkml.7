Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0840ECA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D216A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzujxKXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfJ3TFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:05:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45626 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfJ3TFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:05:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id x21so4695811qto.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAvEaeqENeVb/DhAt46H1R5niz9Z9sNvfAe5diIhyRY=;
        b=IzujxKXSgNjj59kmAYNbKT0SSfdChyjtPWZ2sJwrOEH51SwU2cBWkfZUWI0hQnZpKe
         jMpkMqc0zdX7q/KUwN1GRKfwJlmxUFBW2fA9sardmsm0vL5DHNFbd6aRdfVzruu6b1N6
         sQeznqjWOgdo1MTLAL7I0CtwP/ysHiK/KlFQt/FqtfCLdtbfT2dtPh8Q08rN9Wob/j4n
         5DuX85chQnsqjWBXRRCUnA/GNXE73s3aqhCySv3skHX6hNizAPFsV9YMQTWnYFmiNAAR
         Msg9PU5PS0uHWrmnOG26tF42Qr43REAvPp5mKug3f2cJvRXaQkixmtRtjSyRmPxC57qF
         p20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAvEaeqENeVb/DhAt46H1R5niz9Z9sNvfAe5diIhyRY=;
        b=RPXEwO0tz6//ygj/UwQoo+GFkKN12SXTXrqUMdrHF4ziZaaLf0V5M6n3VMY3Er89yH
         +qKq+TZ99yoghwulSzwxkGXvb30P1YAZXwNUs1mw743KxXvXTMAj3hG+pr1MUrN1eYXE
         J2aiNn1i/6V0rOMqR2a1VcsBJzCEeMlofugh6exEDWyQn0K3JV9+Sc6YNR5t5MHowfSr
         AVgVizzLODwHMucrSJFmx91P9T/g18RsIxqlkdq4x0lybaScTPZzwUnXlblFDWTT5/Au
         +q5bHhGvdwZednlCJIbZ6EqvKAjBBzZbKzxxxsfX9jl5qQfUMdul/lVZtj9PWPSggjc1
         OQyg==
X-Gm-Message-State: APjAAAUjm7eHgryjKcawyzV8siF+tfl9ULCAraHcBjua70iSkt6sfd5Q
        JKiw4sQxoE/bQO/iCMdF7nM=
X-Google-Smtp-Source: APXvYqwR+OhOFisMFYt9YqxA3G+Exbch5krdJua8Ux+40DWju9AX4MTFUgR8p6Bk392z8tMhMkFmfQ==
X-Received: by 2002:ac8:450b:: with SMTP id q11mr1670768qtn.7.1572462333540;
        Wed, 30 Oct 2019 12:05:33 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-136.wifi.ic.unicamp.br. [177.220.85.136])
        by smtp.gmail.com with ESMTPSA id o28sm690544qtk.4.2019.10.30.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:05:32 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        nishkadg.linux@gmail.com, kim.jamie.bradley@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v3 3/3] staging: rts5208: Eliminate the use of Camel Case in file sd.h
Date:   Wed, 30 Oct 2019 16:05:14 -0300
Message-Id: <20191030190514.10011-4-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030190514.10011-1-gabrielabittencourt00@gmail.com>
References: <20191030190514.10011-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file sd.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/sd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.h b/drivers/staging/rts5208/sd.h
index dc9e8cad7a74..f4ff62653b56 100644
--- a/drivers/staging/rts5208/sd.h
+++ b/drivers/staging/rts5208/sd.h
@@ -232,7 +232,7 @@
 #define DCM_LOW_FREQUENCY_MODE   0x01
 
 #define DCM_HIGH_FREQUENCY_MODE_SET  0x0C
-#define DCM_Low_FREQUENCY_MODE_SET   0x00
+#define DCM_LOW_FREQUENCY_MODE_SET   0x00
 
 #define MULTIPLY_BY_1    0x00
 #define MULTIPLY_BY_2    0x01
-- 
2.20.1

