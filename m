Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0841BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CAD2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNQrZ5zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCYPQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:16:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33598 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYPQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:16:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so6609372pfd.0;
        Mon, 25 Mar 2019 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=faTpefi6bfE1Gy0bAl165z7iWn5Zc8VEPB2MEZzT/UA=;
        b=HNQrZ5zfEkiRkdncHiE7Xeb6mSgFB5dUVk3rE6RxUrkBz7mW7Qu651MRJ8xupugVqg
         F21NjyuQ6lmZQbeL0mPbsoBGRxIQZNiWRvQhzEgVdURGTwKMpPzpklzSvF9qQmfxPVfK
         zbk7LclusXEFx3S5/p70FW5ftkT8cITxeqa5nA86TS1EniFIr9N9KuaP47WIE/Zzu8tt
         FvblGk/jnZfU9OfJ5ko2IBAKS0hwsT4ftT7PUjYZfXe9HVorjDyka9Q/wENezaSF/7cn
         AkO0hxmLEJdPcJVQI5UwoPsCWTNRAcT34nvvgxpuPex+QYpmC+2a5h75cfL1GE/rEhQe
         YSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=faTpefi6bfE1Gy0bAl165z7iWn5Zc8VEPB2MEZzT/UA=;
        b=ic7flZUBr0q9omXh+sEl9Pnzkq9GP9i8GFLs/MsLFTDmAczZ8S/DmmEMqoBoeE+7d9
         HPqDp9zmptHd4bk9fhh0WgG8yRsoQl6pbEnrwYVEzO1LPp/ZHe81kQO3q+IF77tW8uUP
         wlLFlqLY4XhYv4dtN/OagR0PjMM3hzABg0gEL+6oTvVOEHW2hm/mCzXpNv605sZ2hyUw
         v1ZZfzNA7W7Jq8GHZAEg8ElvZWMExEMye2qcRTp02A375NxnvVSRGYILgOrxYaa3A+H0
         Gbto8OoaOkv8mLqgUu9jNYd0dKRMFOP2WIyB7H3QfRnVkpLN78qJUJhvS7+KpCeS2ww3
         Ge9w==
X-Gm-Message-State: APjAAAWuPf7S20+ikR4tot9dgH1QWmyfkbhhJ+53s6xJOae1IMQ5wcXf
        sOwaB21Fop/LEjDi6aENMy0=
X-Google-Smtp-Source: APXvYqwnrw2/DINkuE2kqeNyEqG1PUpsxvVH70kmak6sCMiZlo/XfaRAL/gXXmoJ9TtBJ7lJpJnS8w==
X-Received: by 2002:a62:e911:: with SMTP id j17mr24527336pfh.107.1553527011777;
        Mon, 25 Mar 2019 08:16:51 -0700 (PDT)
Received: from vultr.guest ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id a7sm19776728pfc.45.2019.03.25.08.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 08:16:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     sam@ravnborg.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] kconfig/[mn]conf: handle backspace (^H) key
Date:   Mon, 25 Mar 2019 15:16:47 +0000
Message-Id: <20190325151647.11581-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backspace is not working on some terminal emulators which do not send the
key code defined by terminfo. Terminals either send '^H' (8) or '^?' (127).
But currently only '$?' is handled. Let's also handle '^H' for those
terminals.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 scripts/kconfig/lxdialog/inputbox.c | 3 ++-
 scripts/kconfig/nconf.c             | 2 +-
 scripts/kconfig/nconf.gui.c         | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 611945611bf8..1dcfb288ee63 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -113,7 +113,8 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
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
2.17.1

