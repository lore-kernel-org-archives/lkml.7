Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662EA20684
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="Jq6CjdVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfCDXDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:03:05 -0500
Received: from tomli.me ([153.92.126.73]:44234 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCDXDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:03:04 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 35d58dcf;
        Mon, 4 Mar 2019 23:03:02 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Mar 2019 23:03:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=80yglazwl3UL+DZyu+wSlOx1EjgHcRsO49j0Mo81qIE=; b=Jq6CjdVvCSzwVM/fKXoHPpoO1tJc4LC3l9jtqPoF+8PJEcnY5Q5z7Ohlu/udCSfmJjtezAX757H+BYmFtpUYpSUoBQ16z++NNQ2GsmdyzuFlZ1JjUXg8/T4lHd9ZtC76wyT1p/mljqh/QvrVAf1mPmXTgqtBb4BYmYktIx5vudh7oLikkdMn6OPmd/wZPRQPXu/tD9Oza8zZbBt+XJtypTBgKebjnD3Cum0lASXyjFyF8sjCk9hF5h1R+/3fAzKOIsXTdZ8PWlmlmGa0zDWU13EeWkgOj+3sThG1EordVcDQdQknNTG4lx05GLv8dI0tt6O+QmQDwQ1uonx6lQsWlw==
From:   Yifeng Li <tomli@tomli.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Mike Frysinger <vapier@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH RESEND] tty: vt.c: Fix TIOCL_BLANKSCREEN console blanking if blankinterval == 0
Date:   Tue,  5 Mar 2019 07:02:49 +0800
Message-Id: <20190304230249.26143-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in the userspace, it was possible to use the "setterm" command
from util-linux to blank the VT console by default, using the following
command.

According to the man page,

> The force option keeps the screen blank even if a key is pressed.

It was implemented by calling TIOCL_BLANKSCREEN.

	case BLANKSCREEN:
		ioctlarg = TIOCL_BLANKSCREEN;
		if (ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg))
			warn(_("cannot force blank"));
		break;

However, after Linux 4.12, this command ceased to work anymore, which is
unexpected. By inspecting the kernel source, it shows that the issue was
triggered by the side-effect from commit a4199f5eb809 ("tty: Disable
default console blanking interval").

The console blanking is implemented by function do_blank_screen() in vt.c:
"blank_state" will be initialized to "blank_normal_wait" in con_init() if
AND ONLY IF ("blankinterval" > 0). If "blankinterval" is 0, "blank_state"
will be "blank_off" (== 0), and a call to do_blank_screen() will always
abort, even if a forced blanking is required from the user by calling
TIOCL_BLANKSCREEN, the console won't be blanked.

This behavior is unexpected from a user's point-of-view, since it's not
mentioned in any documentation. The setterm man page suggests it will
always work, and the kernel comments in uapi/linux/tiocl.h says

> /* keep screen blank even if a key is pressed */
> #define TIOCL_BLANKSCREEN 14

To fix it, we simply remove the "blank_state != blank_off" check, as
pointed out by Nicolas Pitre, this check doesn't logically make sense
and it's safe to remove.

Suggested-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Fixes: a4199f5eb809 ("tty: Disable default console blanking interval")
Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/tty/vt/vt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 41ec8e5010f3..279f5b2ac44a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4168,8 +4168,6 @@ void do_blank_screen(int entering_gfx)
 		return;
 	}
 
-	if (blank_state != blank_normal_wait)
-		return;
 	blank_state = blank_off;
 
 	/* don't blank graphics */
-- 
2.20.1

