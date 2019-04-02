Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C5220651
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhYK+ZvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfDBIn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:43:59 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:33998 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfDBIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:43:56 -0400
Received: by mail-yw1-f74.google.com with SMTP id x66so9339327ywx.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YPtcyQ7zvWu5qLoy1iT9x8FgtOoN/QVtwb/lGHQIFAs=;
        b=ZhYK+ZvQuFFnK2fI2HOOixkuXTnBdgvis/wIXzSZ6kJPs21SgK16EwAYEul6CuOxuQ
         TkgS3LieWlcMAwyUsRpUKmjvkVoU10bQMT9QaX3ANTPpExRf76h+FCavaunIO5OIBeOs
         ccU82WKvSO+a4N6b7FLkqwlMhdBjvU1Z9JXQSwQc6K0LDWfmcF74yY4UXYwjxgt4Yupe
         V7WmdnP2p+jdVfRUkmcmvf922r1NpHiwr/DsQvdTOSq5KMEmqzY2G/XuMHVTvNdzIlhw
         TrMn0i+hDTUWKVL4Ks54nrv1wm/X2J7GZldEBqCq5nf1Tvq8GOMgsjxhPB9WnkHH+/aD
         I9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YPtcyQ7zvWu5qLoy1iT9x8FgtOoN/QVtwb/lGHQIFAs=;
        b=cpPJFPL/mLWpvYgibxTsDsZgp3y6r4M4fepf2aSSJYNLZC72JEusNX1fH44JLkmMiX
         JNK2OYTpxx47kmrSsZeTT8F/AHwAUl77PtYucNPo4vRw2bbay3L+8TIvWZmhL7Vaut7U
         fVofsqyp4gp+siCdPlxOwCSSOD5H0Yuj8izNaZsAueROHobo7QXkCMlF3X3K4E3sAAyI
         Ac84gJgDwreWJ9fEN89/knGxindKiaUJ9jV7LQlWotTZ2YALepVrY7aDKDDoZ6Qbyraa
         dU79iyTiLWIOzNtR35zZer82vf6LEiAyPjo5efeEkDcz9BspAf4dp89EIPYj6MdXzKjz
         zbsg==
X-Gm-Message-State: APjAAAUTVc/LyxPLCiz5w1HzJGnc6Z0pdEiLHkNGvyrkpTuwfWWZPzo1
        oCNR5zIEbc64QS2P6DrCbGyPpVydOZCV
X-Google-Smtp-Source: APXvYqyt/aSFUefKp76qZ5kXNCV7KkBU5eMZGzkj0UdIEelmLMMCfZLvnHO04/nlB+N194BRWnqEY5qsN7Qz
X-Received: by 2002:a25:911:: with SMTP id 17mr7338435ybj.67.1554194635745;
 Tue, 02 Apr 2019 01:43:55 -0700 (PDT)
Date:   Tue,  2 Apr 2019 10:43:32 +0200
Message-Id: <20190402084332.88965-1-dwalter@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH]  um: Do not unlock mutex that is not hold.
From:   Daniel Walter <dwalter@google.com>
To:     richard@nod.at, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Daniel Walter <dwalter@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Return error instead of trying to unlock a mutex that is not hold.

Signed-off-by: Daniel Walter <dwalter@google.com>
---
 arch/um/drivers/ubd_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index aca09be2373e..33c1cd6a12ac 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -276,14 +276,14 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 		str++;
 		if(!strcmp(str, "sync")){
 			global_openflags = of_sync(global_openflags);
-			goto out1;
+			return err;
 		}
 
 		err = -EINVAL;
 		major = simple_strtoul(str, &end, 0);
 		if((*end != '\0') || (end == str)){
 			*error_out = "Didn't parse major number";
-			goto out1;
+			return err;
 		}
 
 		mutex_lock(&ubd_lock);
-- 
2.21.0.392.gf8f6787159e-goog

