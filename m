Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D8220862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBEQBjUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfLDKUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:20:09 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:32821 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfLDKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:20:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so2835502pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=up7wRNDiQakb25Ld8qipwPlfmty+/izO4vyiWQI+wHE=;
        b=HBEQBjUC51tDAwFLRg/VzpdIi04E8cnFGwEtaYKjFQ1CmQtkCDovuAMAg1xMqg6qF0
         WTB158ts4/d5+XtTQ3oBHN/O3SjRWx9O1I5GcpZcwohOdW4RgWBptIioied7PjwkskNx
         zdf5l4SlcXZvAzmts2+Mju1F9JYV6HsuqntyK4ejeq0Hf1j0rQg9Is5tm8wYdsrb1z2/
         G5f7duquUNSqTu03sJbwGWKGYPvn0txKq6VIcY1HbgeWh32d0zRZjvncp+d2fG427kK3
         7mR0ExQZSQjgE3OKKlD4Dd7LD09ky7HRMWGXBP/TgBczL9gMVZJgdh+vUyx5FT/3V3UJ
         F/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=up7wRNDiQakb25Ld8qipwPlfmty+/izO4vyiWQI+wHE=;
        b=Hn4pBTYaWbEav8dfgyxpbJ83dpk3gFkcoX95Py0I/76zouikc2M7Dc21TNCHlx9BEt
         TaTh5KTP75muj3ZS8WJp0GsyZ73cgRCtLkkVJLAD6C/1iVDh/jfi4mntJS0R/goD6toa
         By07wxroPRto2bQFHASkZlOBGSrYhzNlOOzLBnbIudKJi+gHl+Ob7LnwPvenVabPvMQ6
         PU3lAt2LPP2ukRa4PViW7UyPdTBJ0lPS8JHFkzs0COZtgy6ZySZEiCnN0Kv5G5/AArry
         TZhc2UZFtqbJJzbsocuGHpurw2OPh2KW4fo5tgXgVQ5syDKoOMqQsbAc5y5fWBmc4MLW
         J9LQ==
X-Gm-Message-State: APjAAAVOcoLO4Fb6pPdQabS9NoZPrsYmruq0a+BgFyJAx/OOgeZQatP8
        GYMryD6beo+0nWu2q4DUBSE=
X-Google-Smtp-Source: APXvYqwL1TM41IFYtBTyi9IDlGtHy7hkPVvUAIXIWa/c+wYFlAB/P7WWIdG0P2n945+R/zGzm1mfuA==
X-Received: by 2002:a17:90a:cf11:: with SMTP id h17mr2468035pju.103.1575454807763;
        Wed, 04 Dec 2019 02:20:07 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:cdb:94ce:3984:ab1:9b44:803])
        by smtp.gmail.com with ESMTPSA id d22sm7209393pfn.164.2019.12.04.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 02:20:07 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Documentation: filesystems: automount-support: Change reference to document autofs.txt to autofs.rst
Date:   Wed,  4 Dec 2019 15:49:39 +0530
Message-Id: <20191204101939.6939-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes following documentation build warning:
Warning: Documentation/filesystems/automount-support.txt references
a file that doesn't exist: Documentation/filesystems/autofs.txt

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 Documentation/filesystems/automount-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/automount-support.txt b/Documentation/filesystems/automount-support.txt
index b0afd3d55eaf..7d9f82607562 100644
--- a/Documentation/filesystems/automount-support.txt
+++ b/Documentation/filesystems/automount-support.txt
@@ -9,7 +9,7 @@ also be requested by userspace.
 IN-KERNEL AUTOMOUNTING
 ======================
 
-See section "Mount Traps" of  Documentation/filesystems/autofs.txt
+See section "Mount Traps" of  Documentation/filesystems/autofs.rst
 
 Then from userspace, you can just do something like:
 
-- 
2.17.1

