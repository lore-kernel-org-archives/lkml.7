Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFAA2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ADNMeBmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfCOEE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:04:26 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45268 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfCOEEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 00:04:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 7DD45279
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:04:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qcXTr7c5KY3w for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 23:04:24 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 517C95EB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:04:24 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id v12so6620827itv.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 21:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=38oI/R5MjfWcJIqTErHvH/1/2Owa3JAlRF9DuY8yntw=;
        b=ADNMeBmdQ8x2nZ08dZ3jwxtO5L3puFtNfQmMISlilsorBLjBnhMJwJGB4UcFB4xa+m
         +14rtLVEoOJo9kvavAf4R3td07LHCJiPXBoGEbUvrnHxlw8VXqxe1yFWRmQ0+m8NnBzQ
         5Oq7LCF0qZgVX2Y6NkZjd1tg1150Yu2z+jYyXC9Pm0MYogwS1XoWEtu250wsbaFAikEj
         SfpCPa3YWQFwASHJsI700XH32OqL0YLOkN5sDEVhEtcihBBud5vPr56f2FfmjjKGXZLr
         kbBBgoP1Rpdtc1PnEnxQVJd1aU8RAmgPiM0PUwyCXFs/IOVY6Y9gnhpk7Z3JfXZl2Pg0
         QihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=38oI/R5MjfWcJIqTErHvH/1/2Owa3JAlRF9DuY8yntw=;
        b=e0yUgl9mQhf5JCIIZ4ZbVD2oXbSU0rNq7iJd6jZzHxqvPolJQ9lFhcz+KmUCWeI9ks
         9T8iPky7Gaf80jvRJHgnVerSueLCYKYOKUXLINM8rPXGBfJwAhjnjFP3/Mjfdxxzq3Mu
         06DXCPiT97PR3BGoprBgAu5neIDqdUep8qt+69YAYDY2vc2FG1enHklFQFF2JB6LoxV9
         yK/Hu+9kolPPWCMUov41DtJCvueuqb2nHJBMc9zPpMU/1ewePGT3tTHxr6vJVrKQKeb4
         wEFbMckc/m6YQV74XxQZc1RoSRwDESIrIhALWyZqALawsLAJHdkMaBeAN8NLkEIl4duz
         6dBg==
X-Gm-Message-State: APjAAAU+lFv/qgIHDyWkWCGhOkf/ZLKNQ/zNRHeozDjEh1fNJfKct/s1
        PD7fyxUatXNf0+tH+fsa667ro1xmD8lF0pS9cIv/ZxvSH4Yl18EbJi/KZAkmiKEXtkOeGL+uJju
        5tFV00CziMk4rNm6TybZFagJ1imer
X-Received: by 2002:a5d:8d84:: with SMTP id b4mr893465ioj.109.1552622663636;
        Thu, 14 Mar 2019 21:04:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcHWFYS1fLUr4rxFpCWWgxcdWmsVlhddNWWAM/IlXnmBnRGjikRheE9pll2s1xfBFTFS8VnQ==
X-Received: by 2002:a5d:8d84:: with SMTP id b4mr893449ioj.109.1552622663396;
        Thu, 14 Mar 2019 21:04:23 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v10sm399958iom.45.2019.03.14.21.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 21:04:22 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: sb8: add a check for request_region
Date:   Thu, 14 Mar 2019 23:04:14 -0500
Message-Id: <20190315040415.30631-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case request_region fails, the fix returns an error code to
avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/isa/sb/sb8.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index aa2a83eb81a9..dc27a480c2d9 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -111,6 +111,10 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 
 	/* block the 0x388 port to avoid PnP conflicts */
 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
+	if (!acard->fm_res) {
+		err = -EBUSY;
+		goto _err;
+	}
 
 	if (port[dev] != SNDRV_AUTO_PORT) {
 		if ((err = snd_sbdsp_create(card, port[dev], irq[dev],
-- 
2.17.1

