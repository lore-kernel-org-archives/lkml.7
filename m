Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0842CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 19:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA09620650
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 19:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+PBpQRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfJ0TtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:49:14 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37443 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfJ0TtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 15:49:14 -0400
Received: by mail-il1-f193.google.com with SMTP id v2so6171991ilq.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fp8qbpwsPU5t44meEzV5unnuVBGj/STbs393t2jsMas=;
        b=G+PBpQRQbVt6Enherj5lZsb71SRxc4snjY5IQwTWS+e+Ft/hoAXpwjeKfYEGo83gVW
         Rsuu0XwD/5Chxlu65jRX13j0lZf0BThZnk8m/rz3A8ka4rE6A8NywUSzV6t8iNq4pjAC
         eUrMQnGFuVwgvHogudXxzbfoBnRc+9HEeU1VqO/Kxg0q33LSUt/8yMwBbcVr+gB8dlc7
         J2pWjuk/CYsBthAyl4QJjvOsccUypq3YMiu4amifZK1hmTHjhBfkw5mw9Aq8pnJ+kfOw
         3hlPyueJG17CIIdcV0gXqt0mCOiGJWtBxIZXQZkYStIO/Q2PTDNNCVUnFeL+cEv8oBvz
         R6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fp8qbpwsPU5t44meEzV5unnuVBGj/STbs393t2jsMas=;
        b=pgDhNQeM+9UHIa2k/yZKOr9jfeG/OpR5+qkasTbXkznZSOhkXMFItz5SMG50RSeq7U
         lBYbYHQMW6hAU6HGeEBBaVJDkEUpRpRANc0pjom08IepLJKYmlY7vncpfqz2RXsApnXg
         vdxSvF00j0A7/1QJbhd4XHos/AnwqOd/P1iqPIdFkkD4b9iKTHWEReCp71fiJKjxWYII
         e7cGnPSVuhycW1esWbmyAjFC6LCCC8eRqvQpmv8ffOpsvsoApZxa2f2Zqa6XBx6Cgl01
         CWGGpK4KC4klgSRK1wG3MvdB+iRohwctEOMhl9DrZ2OAsd+zALwyLZOyN2uvQt1Tf48O
         A5iw==
X-Gm-Message-State: APjAAAUA1wi9csEksSqJibf13iTI6ajB21VcbOAfANh0q7W82Z3qq+MO
        JOHJ++RaGCGjSYmsdYeDtQE=
X-Google-Smtp-Source: APXvYqxB3deYkss+3cgHUIMyjARd3DX6Lwwi0mH+0eSz3n+olqnlOUOFQUkSUqZ+8nvlyYXil2QLLw==
X-Received: by 2002:a92:46c2:: with SMTP id d63mr16888139ilk.43.1572205753618;
        Sun, 27 Oct 2019 12:49:13 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id k4sm634726iof.61.2019.10.27.12.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 12:49:12 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Fix memory leak in sof_dfsentry_write
Date:   Sun, 27 Oct 2019 14:48:47 -0500
Message-Id: <20191027194856.4056-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of sof_dfsentry_write() memory allocated for
string is leaked in case of an error. Go to error handling path if the
d_name.name is not valid.

Fixes: 091c12e1f50c ("ASoC: SOF: debug: add new debugfs entries for IPC flood test")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/soc/sof/debug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 54cd431faab7..5529e8eeca46 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -152,8 +152,10 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 	 */
 	dentry = file->f_path.dentry;
 	if (strcmp(dentry->d_name.name, "ipc_flood_count") &&
-	    strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))
-		return -EINVAL;
+	    strcmp(dentry->d_name.name, "ipc_flood_duration_ms")) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (!strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))
 		flood_duration_test = true;
-- 
2.17.1

