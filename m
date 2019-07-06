Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CE7C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 05:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05552089C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 05:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dAkN4F6u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ac3q7uyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfGFFW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 01:22:56 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38654 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbfGFFW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 01:22:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 292BC8EE1F7;
        Fri,  5 Jul 2019 22:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562390575;
        bh=8jmEOU50I7YWCZs78zwZmgKTRzKugItrfou5fNlhW1g=;
        h=Subject:From:To:Cc:Date:From;
        b=dAkN4F6u2tVoHUkaYx9ZGWuiRKx6uZ4Gw85Z+hvli3hDl4g4c5oE0jmrHjkEqrU4v
         QxUvfvPpr419emydHeaD4rQdDsEvksiAq56twZPWpqNxBFtlsoOOkxLyHpFuQCiSpw
         N+RjnQKM67ygjQ+Lyikh/lcZ1Xrpxb1XaL3Gb8Gk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aUCthC6yLCvf; Fri,  5 Jul 2019 22:22:55 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AD4738EE0CF;
        Fri,  5 Jul 2019 22:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562390574;
        bh=8jmEOU50I7YWCZs78zwZmgKTRzKugItrfou5fNlhW1g=;
        h=Subject:From:To:Cc:Date:From;
        b=ac3q7uyz9KL8F5dR3yxgQ9/uOvfatrH65g8I00o5JQC/yUgY+h5wd2ePM9Szx4ntv
         0lEzON9VXWAnQQNrz5WLuPUCFVN6s8c59q/NmYgtJZwotGLv9LtBGg67NJN2neSkPf
         QcU8HzWzHQ9VMPYdqRJ2tE6DsrOvB85hvdKbnu0s=
Message-ID: <1562390573.10899.20.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.2-rc7
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 05 Jul 2019 22:22:53 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two iscsi fixes.  One for an oops in the client which can be triggered
by the server authentication protocol and the other in the target code
which causes data corruption.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Maurizio Lombardi (1):
      scsi: iscsi: set auth_protocol back to NULL if CHAP_A value is not supported

Roman Bolshakov (1):
      scsi: target/iblock: Fix overrun in WRITE SAME emulation

And the diffstat:

 drivers/target/iscsi/iscsi_target_auth.c | 16 ++++++++--------
 drivers/target/target_core_iblock.c      |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

With full diff below.

James

---

diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index 4e680d753941..e2fa3a3bc81d 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -89,6 +89,12 @@ static int chap_check_algorithm(const char *a_str)
 	return CHAP_DIGEST_UNKNOWN;
 }
 
+static void chap_close(struct iscsi_conn *conn)
+{
+	kfree(conn->auth_protocol);
+	conn->auth_protocol = NULL;
+}
+
 static struct iscsi_chap *chap_server_open(
 	struct iscsi_conn *conn,
 	struct iscsi_node_auth *auth,
@@ -126,7 +132,7 @@ static struct iscsi_chap *chap_server_open(
 	case CHAP_DIGEST_UNKNOWN:
 	default:
 		pr_err("Unsupported CHAP_A value\n");
-		kfree(conn->auth_protocol);
+		chap_close(conn);
 		return NULL;
 	}
 
@@ -141,19 +147,13 @@ static struct iscsi_chap *chap_server_open(
 	 * Generate Challenge.
 	 */
 	if (chap_gen_challenge(conn, 1, aic_str, aic_len) < 0) {
-		kfree(conn->auth_protocol);
+		chap_close(conn);
 		return NULL;
 	}
 
 	return chap;
 }
 
-static void chap_close(struct iscsi_conn *conn)
-{
-	kfree(conn->auth_protocol);
-	conn->auth_protocol = NULL;
-}
-
 static int chap_server_compute_md5(
 	struct iscsi_conn *conn,
 	struct iscsi_node_auth *auth,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index b5ed9c377060..efebacd36101 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -515,7 +515,7 @@ iblock_execute_write_same(struct se_cmd *cmd)
 
 		/* Always in 512 byte units for Linux/Block */
 		block_lba += sg->length >> SECTOR_SHIFT;
-		sectors -= 1;
+		sectors -= sg->length >> SECTOR_SHIFT;
 	}
 
 	iblock_submit_bios(&list);
