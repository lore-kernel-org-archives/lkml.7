Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1156C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89BE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963032;
	bh=dUt48SvcsNXqMHEdFA9vb3C7DasH3qtdBP2Nq+5dWuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nmTaQMfxsQ6cCa+veanK6hf/kwDHMNwV5ZGGp4gxq8uSWZMhjIL5FyBFxH0ZnQ0em
	 1s1P+fPrRoZ9gJQnIqj30ZR97nl9vObrcmd+lE64H24cnnYvz6sazAiVCFwwNYjtN3
	 UO6NUMt39YbFpKOn3WBjh4jpzSnehwmTW8pFKPZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfDVT5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbfDVTsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11ECD2190B;
        Mon, 22 Apr 2019 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962522;
        bh=dUt48SvcsNXqMHEdFA9vb3C7DasH3qtdBP2Nq+5dWuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0il28tIjHQkmHSGCSoJQk5FKQIyeHF5IcZr/to/x0mek0U47p9wr8KZevg/mJ8loj
         PbUuoqJDKMVQa5ZNME1tFJoWo6SxQxtMBtq3JhJsRW8k1pOMSyCQML3og+JDs9HlQo
         xUJbE3Mp0kpdi1BFA8lzvUgzTeNIf+/VkFL0FfZ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 40/43] kconfig/[mn]conf: handle backspace (^H) key
Date:   Mon, 22 Apr 2019 15:47:24 -0400
Message-Id: <20190422194727.12495-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
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
index d58de1dc5360..510049a7bd1d 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -126,7 +126,8 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
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
index 003114779815..e8e1944fa09b 100644
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
index a64b1c31253e..0b63357f1d33 100644
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

