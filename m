Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A295C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C14218D9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962311;
	bh=XDO05OiU7HVVW90RgruyC+uNZMIoHSDsuY6yyzBQTYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2P8v1atdcPknh9ZMKwgAwciJ2E1mfaHVwADgL0tEf+VmoIDiQJs+lpCZLa7ZX15oX
	 WQIfbW/9B+WCW9RsDZVR8tqhGid4Q08qcpGAsb8W1nqXU95F7kt/gt7wPXqgdD7Am0
	 qdoF1rXCv+fDhlRw18gaviQNxJL5Llg6+Kicx54c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfDVTpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbfDVTpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7089A218D9;
        Mon, 22 Apr 2019 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962306;
        bh=XDO05OiU7HVVW90RgruyC+uNZMIoHSDsuY6yyzBQTYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Fj3Z3cl5kL/rI66iZzSBxf0OT21eYV47sGISHo0sfRV7xrjq6FzKuzSLRpE7NGct
         uI7th2t9b78wePJygmF1NZAkXZRnBy9LuDfO7+pLUOErYPU4+3IVD9SLFY4KyQgs0q
         qldrUZUHQK5Ouhkk9LqcxjRUVHZDbidbbmzzZM40=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 93/98] kconfig/[mn]conf: handle backspace (^H) key
Date:   Mon, 22 Apr 2019 15:42:00 -0400
Message-Id: <20190422194205.10404-93-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

[ Upstream commit 9c38f1f044080392603c497ecca4d7d09876ff99 ]

Backspace is not working on some terminal emulators which do not send the
key code defined by terminfo. Terminals either send '^H' (8) or '^?' (127).
But currently only '^?' is handled. Let's also handle '^H' for those
terminals.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 scripts/kconfig/lxdialog/inputbox.c | 3 ++-
 scripts/kconfig/nconf.c             | 2 +-
 scripts/kconfig/nconf.gui.c         | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 611945611bf8..1dcfb288ee63 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -113,7 +113,8 @@ do_resize:
 			case KEY_DOWN:
 				break;
 			case KEY_BACKSPACE:
-			case 127:
+			case 8:   /* ^H */
+			case 127: /* ^? */
 				if (pos) {
 					wattrset(dialog, dlg.inputbox.atr);
 					if (input_x == 0) {
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index a4670f4e825a..ac92c0ded6c5 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -1048,7 +1048,7 @@ static int do_match(int key, struct match_state *state, int *ans)
 		state->match_direction = FIND_NEXT_MATCH_UP;
 		*ans = get_mext_match(state->pattern,
 				state->match_direction);
-	} else if (key == KEY_BACKSPACE || key == 127) {
+	} else if (key == KEY_BACKSPACE || key == 8 || key == 127) {
 		state->pattern[strlen(state->pattern)-1] = '\0';
 		adj_match_dir(&state->match_direction);
 	} else
diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 7be620a1fcdb..77f525a8617c 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -439,7 +439,8 @@ int dialog_inputbox(WINDOW *main_window,
 		case KEY_F(F_EXIT):
 		case KEY_F(F_BACK):
 			break;
-		case 127:
+		case 8:   /* ^H */
+		case 127: /* ^? */
 		case KEY_BACKSPACE:
 			if (cursor_position > 0) {
 				memmove(&result[cursor_position-1],
-- 
2.19.1

