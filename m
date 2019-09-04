Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D2C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91F822CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ugedal.com header.i=@ugedal.com header.b="fM7h7Ro/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfIDGrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:47:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37133 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbfIDGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:47:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so14936661lff.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCpvUPnGtMaFPkKWpq/J1xLXz67crIRrfnDYom7vI1g=;
        b=fM7h7Ro/Da9WkUH/yjvTgbmcfpyqgsXqgsXMpf/v288stiaUjSytVzf1AFKEWqfC4Q
         dfWwvOPgLO1omPbDDVx+9013ZTdWFpJy+eZybOosvQUXXfuCAy5zm+A9++Rmt61Q64tA
         FgkZNJiV0QABtIiPLAt4+baM6Vs4uyY1iEqdO7WlqvOUIJRo61FsBaU2Li0hhiXJRSGH
         PldVQeDsENp+y/92d79U0uyGqPPSFEDp+0Lp9hDv4JpUWsSW6cCza/vmv/tcsqbDlAUD
         9kqc/YZWXoP7yaz2QY9lutn1Pd/34+ZrMiL6R7reWwLkA/haqxNURUGKoSZBZ1OM+DJX
         Ge4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCpvUPnGtMaFPkKWpq/J1xLXz67crIRrfnDYom7vI1g=;
        b=uVLKFYg/0XNSlT/LUoQ3HahU6itCKp7GJ9fHEauAGL9i26y67Z52b9eq4Z0EukVjjh
         LPn3WboCiiPmOEUs3LW2X18utfMVRQnBAQEYj5vqFjBlPlwbxVK2TIBm4Ju50P7EZZjg
         /s14wGeCkF+uiQEIbqNLhwiV9l5OqQP2k6p0ez8N/3RBfWUZO82Uta8gM2ZGQeFCLuuK
         AeqLm2S5sK4v8SYW1FrD1whQSIU0c6fDwWh3EkoByyNwyc0lIBkGx6M37CT5zxFM+hMb
         IEmuOVkPmvQ+moHvAJ/QFLAnOrBu/OPAuXVTtzvsxEUR6U6vrPLDJr7GjATBlCswgVuK
         H8FA==
X-Gm-Message-State: APjAAAXAV+Oawgroy/w48XPJnBpoSC16sLCdwW2KE4e+YRIV6tNDWTel
        GkgZavoPYKlQTRxDQN1RBfFjSg==
X-Google-Smtp-Source: APXvYqzfFtKPoonHXM4AZdh4mJOJhhl2Y8xYGA+4gUVPiMpRz4I9lf1kZTJRY4o47kAPlzJLuuUN5w==
X-Received: by 2002:ac2:4a70:: with SMTP id q16mr9016716lfp.4.1567579666730;
        Tue, 03 Sep 2019 23:47:46 -0700 (PDT)
Received: from xps13.wlan.ntnu.no ([2001:700:300:4010:e6a4:71ff:fe46:cbe8])
        by smtp.gmail.com with ESMTPSA id a20sm3376721lff.78.2019.09.03.23.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 23:47:45 -0700 (PDT)
From:   Odin Ugedal <odin@ugedal.com>
Cc:     tj@kernel.org, Odin Ugedal <odin@ugedal.com>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm,hugetlb_cgroup: Fix typo failcntfile in comment
Date:   Wed,  4 Sep 2019 08:47:09 +0200
Message-Id: <20190904064711.14490-1-odin@ugedal.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "failcntfile" to "failcnt file"

Signed-off-by: Odin Ugedal <odin@ugedal.com>
---
 mm/hugetlb_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 68c2f2f3c05b..3b004028c490 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -379,7 +379,7 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	cft->write = hugetlb_cgroup_reset;
 	cft->read_u64 = hugetlb_cgroup_read_u64;
 
-	/* Add the failcntfile */
+	/* Add the failcnt file */
 	cft = &h->cgroup_files[3];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
 	cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
-- 
2.23.0

