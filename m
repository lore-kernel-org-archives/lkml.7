Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864EDC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4712072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGEAhmyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgAGSxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:53:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44597 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGSxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:53:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so588596wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvZJ720Ntxy1DpN4pN2aoXoPdDhQLkYtp2DhP6432eg=;
        b=mGEAhmyMJYGS9+pP7bsiOUUuI6die/6Q1s0PvPAEO4jfmAfmjoN4c+SQ3JofHfoWRt
         Mj+u5dItf1FA78RRRFhExIxMkm6qBWnPLf5d++6MmsSPO8EorQE4Ev6jE//L+TmwXaEA
         paNPLiiXlC1eD+dgg8+ZOKn/wfB2uC6Mdxat47lx9HoWQhgMtPdGIGTEA56nUB4C22bZ
         WHXXRNoZ9a7LSo23UP/pgd0tCuHBJS8GZs5DNUQq5GyyrnjOGDIVYOQlQy5OI7Om+srJ
         Y0N9LKLsY8vD0gkATgHgfL+UTFjmn1GIiP+EfxQH/UjZyrkpHqGuZQpZ1NJLG9fZaaac
         6KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvZJ720Ntxy1DpN4pN2aoXoPdDhQLkYtp2DhP6432eg=;
        b=AuHQ7BX75/a2l+maBNg49HwWGXrtjkyjy1KMTV1vdgeuE2udojxmEXl8//+4wjDP0n
         vrN4kAz69BHIZYP00ddXvM60Xm2cS6S00LQHjocWB2b9uD7GuCow5RixOEi+XpkEfd20
         b70fjoKTIv2GuzE4XVi+XI00qpJBOnuxDWp1tJD0p9vWApTAZ/No0g8gCcogL3bE2L+D
         I5yFw5APn3HdJuT1GKBeTe3JB5c5T/RJBGxX9v/tzvvEW3azsPo5p+0wjQDOPncPT6y5
         QWS9CmtrofZP5h9KT9lHAWXhCxfxJGIEJMLCIkq9107e4ZvOWuvbAZuPTDMe30MsGipS
         bZpQ==
X-Gm-Message-State: APjAAAXlL/I9N+AU7ziGpIUmS3TvJ2bSsgOKBA9lSNITGj8WRN+uF5M/
        A7k9WZviDevkCh6wdGTaBDEKvkPl2VC9+Q==
X-Google-Smtp-Source: APXvYqxFMSeCXRVjzVK6jaCYJ3GI7y8f1VONnxmyvQ8OoCjcpXw1xZWfW+baMarGWBn2HXWh+RB/1w==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr566255wrq.232.1578423202808;
        Tue, 07 Jan 2020 10:53:22 -0800 (PST)
Received: from localhost.localdomain ([37.152.140.242])
        by smtp.gmail.com with ESMTPSA id v17sm862423wrt.91.2020.01.07.10.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:53:22 -0800 (PST)
From:   carlosteniswarrior@gmail.com
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
Subject: [PATCH] Init: fixed an error caused by using __initdata instead of __initconst
Date:   Mon,  6 Jan 2020 02:02:17 +0000
Message-Id: <20200106020217.13234-1-carlosteniswarrior@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>

Fixed an error.

Signed-off-by: Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 2cd736059416..bcf8aa4f7cab 100644
--- a/init/main.c
+++ b/init/main.c
@@ -979,7 +979,7 @@ static initcall_entry_t *initcall_levels[] __initdata = {
 };
 
 /* Keep these in sync with initcalls in include/linux/init.h */
-static const char *initcall_level_names[] __initdata = {
+static const char *initcall_level_names[] __initconst = {
 	"pure",
 	"core",
 	"postcore",
-- 
2.24.0

