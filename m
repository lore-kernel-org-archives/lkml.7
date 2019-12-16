Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4962AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069F32176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfLPWKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:10:07 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35470 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfLPWKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:10:06 -0500
Received: by mail-qv1-f66.google.com with SMTP id d17so3402710qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46QQbf/7xY0XXnmz2tYswXMRkkq1sq4i40/0AAKflts=;
        b=QSiOU+pfI4f+UJm2z1CzpcpKmqj26ZlNgOcYQ3KjSysXN5CKNkxQKs+xvlMtWz0/Zj
         EOGJjNfKii+RJriaqUvQDf78DcuafWd6FalNHrGquX6O9t9+5bca5QP2Zq1Cpg81Ck82
         f+rTn0mjzALJ5BW7X46ErHxIH/T0c6GR9uczHBXgiLcpWHO9iNqZIJ/jnxg7p4R4ChTZ
         vB2/WeFFKlCvZXX0a/OuhtRlAC1bMskckFz/sSMlE9xpkajek+LEZPIStFBX2/H6pJNG
         hcfMZjiylbyM5ouODaL4s1gi9ZU1EUlROChG71/Dihl5tAXElKon2Vi2KbQczi6GDq1m
         Cb9A==
X-Gm-Message-State: APjAAAUwesKtwV6JUv4aEzAM5VAafAH+sl8Rl/LYDSyD3PE2cFUWliMW
        zB1XzkXIAjPHOi/VcHuAhxzrWN6S
X-Google-Smtp-Source: APXvYqytMlnnar7QuVPkVRQVszjjwk6cMDWOgFJ3w/bKs4JskQxoBNFifPVjqkR3vqHWOoJXI0o/0g==
X-Received: by 2002:a05:6214:1348:: with SMTP id b8mr1671598qvw.137.1576534205387;
        Mon, 16 Dec 2019 14:10:05 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o17sm7125900qtq.93.2019.12.16.14.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 14:10:04 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sparc/console: kill off obsolete declarations
Date:   Mon, 16 Dec 2019 17:10:04 -0500
Message-Id: <20191216221004.3476562-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 09d3f3f0e02c ("sparc: Kill PROM console driver.") missed removing
the declarations of the deleted prom_con structure and prom_con_init
function from console.h. Kill them off now.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 include/linux/console.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d09951d5a94e..f33016b3a401 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -101,7 +101,6 @@ extern const struct consw *conswitchp;
 extern const struct consw dummy_con;	/* dummy console buffer */
 extern const struct consw vga_con;	/* VGA text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
-extern const struct consw prom_con;	/* SPARC PROM console */
 
 int con_is_bound(const struct consw *csw);
 int do_unregister_con_driver(const struct consw *csw);
@@ -201,7 +200,6 @@ extern void suspend_console(void);
 extern void resume_console(void);
 
 int mda_console_init(void);
-void prom_con_init(void);
 
 void vcs_make_sysfs(int index);
 void vcs_remove_sysfs(int index);
-- 
2.24.1

