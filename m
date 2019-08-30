Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EFFC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2332189D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567127509;
	bh=5HAhAebBZoeewPB0vmMb1b3bjdyfMmVXggFjC4H9i48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZUOLsd/Vi96vxIMD4FNI/+duyBH2mw/Q54IAg5XRGM4PiLMQ27+2ihI3b0iEvcCaq
	 LWa5RceixNbSBuU2l4aBgVlOlUXXe7EPmVCtsioMD0B8owaz337iuDxCkkUrW1QQU4
	 CVfTihxnfTEBqFecQCPG3rMh9SXIM4Dxc+SDkaGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfH3BLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfH3BLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:11:45 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28EE21874;
        Fri, 30 Aug 2019 01:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567127505;
        bh=5HAhAebBZoeewPB0vmMb1b3bjdyfMmVXggFjC4H9i48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2J6PcC8e79OFab3YEmrV3qAF9SJ3JTApZff9yXIJW2J/f7Vo6nfaSL2d5K7r+puP
         MtWlBAuP0XqFDX2mxphnhKU02DK5AStmiQVfUURHe26lvAs7JXHVgIF08TnGgG0PqT
         qybtA2OQvNRhL+vp866fz0dWEuqmeuhluNC9SfAk=
From:   Andy Lutomirski <luto@kernel.org>
To:     Theodore Tso <tytso@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/7] random: Don't wake crng_init_wait when crng_init == 1
Date:   Thu, 29 Aug 2019 18:11:36 -0700
Message-Id: <5f729c0feb4aa105e6440124de099e0cf903d024.1567126741.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1567126741.git.luto@kernel.org>
References: <cover.1567126741.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crng_init_wait is only used to wayt for crng_init to be set to 2, so
there's no point to waking it when crng_init is set to 1.  Remove the
unnecessary wake_up_interruptible() call.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..d152612e08fc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -946,7 +946,6 @@ static int crng_fast_load(const char *cp, size_t len)
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
 		crng_init = 1;
-		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: fast init done\n");
 	}
 	return 1;
-- 
2.21.0

