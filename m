Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8325EC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E51424670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jlekstrand-net.20150623.gappssmtp.com header.i=@jlekstrand-net.20150623.gappssmtp.com header.b="mnEa9scs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:54:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39097 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:54:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so3019753plk.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 09:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImBNc4qgIrwMkM+rUGDaHKqVHr1dUMeLNQ6cHJK9ITc=;
        b=mnEa9scsD0yZ9KuG2m25kWPF915gHBveN/LvobWfLRm43El/RdiqlPFFWVkqTWWAEU
         lohSksI0zMUhkH6n/LgmLVP1/FwQBd0vKeVLxYWEmL5Wv1a6q8Fgp5SeeCD2NQFLr2Ge
         Rm5rYnDj/YzWHgAVSnmVkddW4yQ1LsCABhkYFn5A69BDGqwrC4JoM3ehQov1bQqtxPG8
         HYMGlI4LpXwS0FcQoyKBMTvwWRHtz5y4VuBtsyTMLPoymBU38grhJTgKkJJmg/GM4rBY
         H3uc/FlnOLvMnR0y2wEYoYr/S8A+5pxk9G+XX5ass9MThFZHqgBI61raJKEk3Bvx0HG6
         8Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImBNc4qgIrwMkM+rUGDaHKqVHr1dUMeLNQ6cHJK9ITc=;
        b=GMssy+fWkY7iDZQBHO5WfAzVENnWz/xjjFZWXgTY68DOzHmb5YFstBq5OE7e/jdGV1
         EI6cPsVepvMrpLLegpEc28v2fvpUCY6zzZi6+gbsWjCZyM4/mA5Ro085NG+VEgaKvX9r
         hHqdqdGrMSiKohjvuF6mu1sU03J2Vh8qThUwOKPm4qegwzw6QLS7TjraKj2+ZI20b8H0
         N7KymqKp8ggKYwQyHWEUt/t+VsJWbEwUTiuwYmulh8xpdbbxUEbXgHKULoanehRQC22F
         f8pd259o7QytD72hkU5cRHMYVsqB3lIAd6PPel7AuJtwQj6gP2OtJ3y13HFv3RF3nD4X
         ZIjg==
X-Gm-Message-State: APjAAAX9PWsukt1x+iyP+NTreTYLOrjL59xliYfkgr/Qhu+uHc9w3Xtf
        aejbpKWlgcyMAM303nR12V8iWA==
X-Google-Smtp-Source: APXvYqyPsz0unA2rwxCZ07LA/cUq/kYApAfKk+0M+ZkkMZbAYWyEOc6D3gfVKMiKnp8Zf0rJOh0IiQ==
X-Received: by 2002:a17:902:aa46:: with SMTP id c6mr15231626plr.250.1575654861115;
        Fri, 06 Dec 2019 09:54:21 -0800 (PST)
Received: from omlet.com ([2605:6000:1026:c273::341])
        by smtp.gmail.com with ESMTPSA id d22sm16597000pfn.164.2019.12.06.09.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:54:20 -0800 (PST)
From:   Jason Ekstrand <jason@jlekstrand.net>
Cc:     hdegoede@redhat.com, Jason Ekstrand <jason@jlekstrand.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13 late 2019 lid-switch
Date:   Fri,  6 Dec 2019 11:54:09 -0600
Message-Id: <20191206175409.335568-1-jason@jlekstrand.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running evemu-record on the lid switch event shows that the lid reports
the first close but then never reports an open.  This causes systemd to
continuously re-suspend the laptop every 30s.  Resetting the _LID to
open fixes the issue.

Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
---

Re-sending due to a typo in my own e-mail address. :(

 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 662e07afe9a1..f7ca94e41c48 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Razer Blade Stealth 13 late 2019, _LID reports the first
+		 * close but never resets to open.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Razer Blade Stealth 13 Late 2019"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 
-- 
2.23.0

