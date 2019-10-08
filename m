Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AECC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2614A2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDdyofzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfJHRcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:32:09 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43862 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:32:09 -0400
Received: by mail-pf1-f202.google.com with SMTP id i187so14233886pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CPJ4WvmAJyyzE+ZwNMMLcNRFnx5t024x8AdCYAdjqqg=;
        b=NDdyofzKiCWppxENWKYuJsGPdFfx5Fmui0sZkF+fkb/xjlrCZqK+GE2DbvyD+XZAdl
         s49OKtPn9bO749Asu6LmhV0LEjQ+fMu1rFmr6jO5MoqfIaIY4G2XXFsnoWs4RBSnQtD1
         /a2vsqdfwKlYrEeEkCm/0l/9kZJuRsCPcwamFYZepQEYR58yP4Tkg+Xw39oZuxkiipQ+
         E1smu61ctzNJ2o3MJ/xiVurlrZoILTbDnwfbJwLXFytSUSp3sFP/OQHd5GdRw7kXV0Bv
         RFCOoTtp+k2ZZT6MzTThkKY6O6lRT2HvNTHwb0SCiljjHx7GP3r+TMHYbtQQw2U0uDj3
         xEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CPJ4WvmAJyyzE+ZwNMMLcNRFnx5t024x8AdCYAdjqqg=;
        b=ffJvG1rw0j3OWnnIEkBXjMahwDkTTW+NbxlAg6dGu8mcCy9R5zDqZJhWGafcySLJBi
         nfDt94Y0R3bYjN8XUt0BTI4BPZxFr2aLF74owONNbPgKnuMRW7ee8ReeX9fJ0HIMjUjg
         fFtyRPwwrlfZBK0jvt7A/FtKu1CT+xfXIPgl8DimjBMhhDmpi5CawqXFAyZOCgO1vYbE
         AzEqPUIuB9zETS8K9PvfJbB6P2FsYCyYIw9eT2jZjxZaJsR3GsZUDqbA3n4kq7LSJn9s
         RxJMfWl6qDfBUDMc1qfyQl0Fzi6O1cQzRNf+Yg9dYpqo4WqyZroJrW0QpuSdG5Khzl0I
         EJcw==
X-Gm-Message-State: APjAAAVxsX2x6/sKQid3D/sPRE6Q/Jfu1A9ePWjrzEcdk/qeLuPMOks6
        DHGjqxiHgXu9NWViXiUHKwUDbjhaQZiCwA==
X-Google-Smtp-Source: APXvYqy5uMOPKWIAO+/Bue6a9g1tVO1gIX/ommfDt2vJycqWPA3kfcRCvG/hB/Y4DKNQUUG5rez+LaaqougwSw==
X-Received: by 2002:a63:dd0c:: with SMTP id t12mr36376305pgg.82.1570555928123;
 Tue, 08 Oct 2019 10:32:08 -0700 (PDT)
Date:   Tue,  8 Oct 2019 10:32:04 -0700
Message-Id: <20191008173204.180879-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] hrtimer: annotate lockless access to timer->base
From:   Eric Dumazet <edumazet@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Julien Grall <julien.grall@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to commit dd2261ed45aa ("hrtimer: Protect lockless access
to timer->base")

lock_hrtimer_base() fetches timer->base without lock exclusion.

Compiler is allowed to read timer->base twice (even if considered dumb)
and we could end up trying to lock migration_base and
return &migration_base.

  base = timer->base;
  if (likely(base != &migration_base)) {

       /* compiler reads timer->base again, and now (base == &migration_base)

       raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
       if (likely(base == timer->base))
            return base; /* == &migration_base ! */

Similarly the write sides should use WRITE_ONCE() to avoid
store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Julien Grall <julien.grall@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0d4dc241c0fb498036c91a571e65cb00f5d19ba6..65605530ee349c9682690c4fccb43aa9284d4287 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -164,7 +164,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 	struct hrtimer_clock_base *base;
 
 	for (;;) {
-		base = timer->base;
+		base = READ_ONCE(timer->base);
 		if (likely(base != &migration_base)) {
 			raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
 			if (likely(base == timer->base))
@@ -244,7 +244,7 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 			return base;
 
 		/* See the comment in lock_hrtimer_base() */
-		timer->base = &migration_base;
+		WRITE_ONCE(timer->base, &migration_base);
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
@@ -253,10 +253,10 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
-			timer->base = base;
+			WRITE_ONCE(timer->base, base);
 			goto again;
 		}
-		timer->base = new_base;
+		WRITE_ONCE(timer->base, new_base);
 	} else {
 		if (new_cpu_base != this_cpu_base &&
 		    hrtimer_check_target(timer, new_base)) {
-- 
2.23.0.581.g78d2f28ef7-goog

