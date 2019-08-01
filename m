Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E47C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4911B2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWmru7+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbfHATOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:14:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39810 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388515AbfHATOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:14:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so34729703pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aK3LM/Rdl5glq1WJqKY1wThjemOWhqrdKxPBMtnC6Ak=;
        b=sWmru7+u8dY/Si4D//aVK07qTIqccDN//yt7xMDcJVuiOgUAOTOLxmw2svSllI/WTk
         Hhiy8FRK29MxHUtNzcGA3H0Y0Ngii/+2cl+bMYqpN+JL9r06jOh5HtuBp4XktMRJ7YTY
         VVGbLKjxPLHjAjNse8riyfgSpTEn5xcKlWho798DnsPljkKhJSBdlSQvQW2/dkiyESfq
         9zyE1eC/Qj+tFBRqVnlns9vSB+txc58TdgUsa29jivTGxPSIuJM4ifuaOFd1suSBHivp
         6OxdVT0KS1iLaSGKi3AVl3cfn7J/pSfrMGtSpUtBSNTSBnyLuatqUWPt6agjml3h6FEQ
         jw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aK3LM/Rdl5glq1WJqKY1wThjemOWhqrdKxPBMtnC6Ak=;
        b=JV526+6p3wUPTxj3U3kykqzBp3HJOxSo8SsSzXjLjccvNHsj1pIXwns19YSYXAh1fw
         gUTC714T0sGLS3OYnttqQU08eC0eOPe4Bv/kp8Ktd1Z8npXY77zz+UMgg+yKxB/HDBcH
         mrDgokG03DXRYjhW/nHpljxr29/Ju+Kml/Ou5eYIQcnm+9f9UA3csfjTvgzxNy4j7j4A
         2vmXiWFQAn0bKBgtj5aOszzFSQd2afj0V2knKSuQ//cS3TnKy1oxHFdUQwhcoTeazGhS
         KD34nysyoYsHcKaSGYnpD0M/a+4lB87LWbfsSvYEJHCPLTZpnFG3oGJ9E1WHZJU2wlEU
         9myA==
X-Gm-Message-State: APjAAAVKudFH3tkYBpJUzYmwzjI40J04XHrwWg7ACKCxhEDwavbnkK9u
        rNcXDME1+evZe2+C4niWUDY=
X-Google-Smtp-Source: APXvYqyRAwTd/79Ym4L6nyvHV3hBg+VluASFqaXizSC0vAymbNjv5+a3e7nM1tu0zpmhIAetJP5cWA==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr329362pjn.136.1564686860868;
        Thu, 01 Aug 2019 12:14:20 -0700 (PDT)
Received: from localhost.localdomain ([223.191.5.161])
        by smtp.gmail.com with ESMTPSA id bo20sm4625811pjb.23.2019.08.01.12.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:14:20 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/3] ppdev: add header include guard
Date:   Thu,  1 Aug 2019 20:14:07 +0100
Message-Id: <20190801191408.10977-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190801191408.10977-1-sudipm.mukherjee@gmail.com>
References: <20190801191408.10977-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 include/uapi/linux/ppdev.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ppdev.h b/include/uapi/linux/ppdev.h
index 8fe3c64d149e..eb895b83f2bd 100644
--- a/include/uapi/linux/ppdev.h
+++ b/include/uapi/linux/ppdev.h
@@ -15,6 +15,9 @@
  * Added PPGETMODES/PPGETMODE/PPGETPHASE, Fred Barnes <frmb2@ukc.ac.uk>, 03/01/2001
  */
 
+#ifndef _UAPI_LINUX_PPDEV_H
+#define _UAPI_LINUX_PPDEV_H
+
 #define PP_IOCTL	'p'
 
 /* Set mode for read/write (e.g. IEEE1284_MODE_EPP) */
@@ -97,4 +100,4 @@ struct ppdev_frob_struct {
 /* only masks user-visible flags */
 #define PP_FLAGMASK	(PP_FASTWRITE | PP_FASTREAD | PP_W91284PIC)
 
-
+#endif /* _UAPI_LINUX_PPDEV_H */
-- 
2.11.0

