Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D29CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A31B21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4LngvYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406959AbfJYHdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:33:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406916AbfJYHdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:33:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so1061139wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q37OwpiVtbI5u9x13AdojV2Y5xWX2cctv9qNpKud8OE=;
        b=P4LngvYmSq6jPBLO+72WALO/I5hwPb8wBo/iX++QaE/PGzClMjrelf5trymgeACiL/
         YTUcpEXbRYV250IAVK0n1KrbZZ2vDTGOOZ/DFhC10ZjdmHu4t+mfdEEAc8U3RLQOgvpf
         eTDeWOTe5ETiE4h/Srpkwxp763K0Vjr6b/J51TJzPuHZr1ZBOS3B+hi4ZzCV/MgcQBm1
         9Zwm79mjbRVCsi3HBCz5KRqA8fTXJ/NieqY03Zso65gOZJQOeLFaPj7Cmbc+szocGMSD
         vab+i02s06FO9zY9qYJ2h2W8lCbMo7HLapAZFtjGnfqUuNJYuDVfs+KKClYXNEudclg9
         7rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q37OwpiVtbI5u9x13AdojV2Y5xWX2cctv9qNpKud8OE=;
        b=fjuNQ30hC+bWqixlDuh51JjYYfXncAiri9QxSk3IhjlOpYLHtkd6Ux7pJshGu/eUTn
         eb8UrtUhXDL/1wn4E64y20bxEH1ONse+NoHkh0BibTXRGdbf0fTvAELDqUth9rhsFfT4
         o9ojAnFTFSXJLEZt4jZbNCRio1KyKxjTMD4ECWiP1zq4NBjeEMFGz47fMAiBLu9qcdy/
         t7efeOGG+Tzy1ogIwDio9HNwp2eVrGe1pO4zi0dPmINpZEBOoglls6sfJPN36nCiaKnT
         QGMDRlH5zirNKmeFZPFjYa0h1A1H/mIxIQSBnj2nIbXMEmJ/IJQM3uYF6wjI1354/IPv
         AjMA==
X-Gm-Message-State: APjAAAU0I2wf+w8WzDLjTCq7QSdfQrH3XeBgvhnwyGEbgiIlN1VsqYM8
        QW+m1r/CLupbcOmlIrQ5/n6l2A==
X-Google-Smtp-Source: APXvYqxVdg6EGKxAbF8m2sxB498qF0UJFQZ60UmPuvIvhtWcaHsRZj1iamepXusCBxdTqf7khttU6Q==
X-Received: by 2002:adf:c402:: with SMTP id v2mr1570013wrf.323.1571988828803;
        Fri, 25 Oct 2019 00:33:48 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a11sm1586602wmh.40.2019.10.25.00.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:33:47 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v4 5/5] kdb: Tweak escape handling for vi users
Date:   Fri, 25 Oct 2019 08:33:28 +0100
Message-Id: <20191025073328.643-6-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025073328.643-1-daniel.thompson@linaro.org>
References: <20191025073328.643-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if sequences such as "\ehelp\r" are delivered to the console then
the h gets eaten by the escape handling code. Since pressing escape
becomes something of a nervous twitch for vi users (and that escape doesn't
have much effect at a shell prompt) it is more helpful to emit the 'h' than
the '\e'.

We don't simply choose to emit the final character for all escape sequences
since that will do odd things for unsupported escape sequences (in
other words we retain the existing behaviour once we see '\e[').

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index f794c0ca4557..8bcdded5d61f 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -163,8 +163,8 @@ char kdb_getchar(void)
 
 		*pbuf++ = key;
 		key = kdb_handle_escape(buf, pbuf - buf);
-		if (key < 0) /* no escape sequence; return first character */
-			return buf[0];
+		if (key < 0) /* no escape sequence; return best character */
+			return buf[pbuf - buf == 2 ? 1 : 0];
 		if (key > 0)
 			return key;
 	}
-- 
2.21.0

