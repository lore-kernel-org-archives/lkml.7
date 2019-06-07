Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE6DC46470
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99F208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUZCsqP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfFGGAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:00:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37295 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFGGAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:00:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so996711qtk.4;
        Thu, 06 Jun 2019 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RGX8KhKka8Pl3+vesfNXkUWjRHHCXob324mKOkGT88=;
        b=bUZCsqP/Sagr0KrlVefrP0TctKD/wlxJRaimMtzcra7i7QXt4srnpJoAQR/xeT1Zw+
         LtQXFxhCKA6IDuVG8n6XK+XsF9NbR+NSVR26URuDLVYzhWWB1ewqxPSuVQr31xnB1rUI
         /YP+Abij3eTBFdvliLfQMtfSyimhJE4++fUxGonWODAPE5QSzfGs01uieCU89UUxyrGk
         XdShapx4V/x6tExDCaK77VF2CfRRuCDJ+uku4IziMMjs5N61uel4XrzAO4kDxl3es+IY
         wsjzFjvfzIQhLGjFxQJeFdJdBXt+eJwB6/kgsrMz5xyVHz3F6vZJVAEdD+4wvOHO611t
         RUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RGX8KhKka8Pl3+vesfNXkUWjRHHCXob324mKOkGT88=;
        b=HlsPyeUQHcSGSC7Mei9HRvRIpXJuKUEP+hQ6KSFVoJ02JLzuC0y0m/B1gLLQMpdr2T
         QRZh5VKIMX4JCVoibXhs7kE7RfdSGelirOhvfVa09h9lsL9OCvsfVdCyLv1EOTvXOsX4
         QAbWNL6nbIZzGCUe7DIclSGJwUUCQxloOEM3FC+oEgkjjrMuaXQu54gnlGw/N7d2Rl0F
         DSLB7hatkys4ZEA/Xgo9XY6NctazQNe7QM8jOnV9HmeiHgc5u8H9RTOEGOd3Rx/vJX7h
         /3ix70YTWpgkt1AwtWUQ5KJ+OFPshGaynaG/UzawFQrTHOPZFc1NjMEEACMGDabPI8et
         RxHg==
X-Gm-Message-State: APjAAAU2ow8tQy+ge+4jKmHFDLMbqEaCelLAwzEjjgRls8ctb+n0/Kui
        +XcLNtoao0evotk5O9I3IAdyPUepSgw=
X-Google-Smtp-Source: APXvYqy8QDCpgyjSYGbTWJE4qnK8J6n3snKXl+ZrIb/6YBsg25FMqGwRbBXgM7nSbyXjj0bb/WiANA==
X-Received: by 2002:ac8:38c5:: with SMTP id g5mr45162827qtc.299.1559887199834;
        Thu, 06 Jun 2019 22:59:59 -0700 (PDT)
Received: from localhost.localdomain (pool-108-45-70-22.washdc.fios.verizon.net. [108.45.70.22])
        by smtp.gmail.com with ESMTPSA id u26sm775134qtc.33.2019.06.06.22.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 22:59:59 -0700 (PDT)
From:   Alex <awaitingvictory@gmail.com>
To:     paulmck@linux.vnet.ibm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Alex <awaitingvictory@gmail.com>,
        Aaron A Montoya <aaron.a.montoya@gmail.com>
Subject: [PATCH] linux: README: reduced README size by 1 byte by removing unnecessary space character
Date:   Fri,  7 Jun 2019 01:59:18 -0400
Message-Id: <20190607055917.17040-1-awaitingvictory@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron A Montoya <aaron.a.montoya@gmail.com>

On line 9 of the README there is an unnecessary extra space character, 
after the period, that adds 1 byte of size to the file. By removing the 
unnecessary space, Linux downloads will be 1 byte smaller and therefor be 
faster to download and take up less space on a user's system, all while 
correcting a sentence structure issue. This change is one of the few 
optimizations with practically no downsides, besides taking time out 
of the hardworking Linux maintainers day to implement the change.
Remove extra space after the period on line 9 of the README.
Commit 0619770a02a30834 ("Removed unnecessary space character from README")

Signed-off-by: Aaron A Montoya <aaron.a.montoya@gmail.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 669ac7c32292..0b05d700637f 100644
--- a/README
+++ b/README
@@ -6,7 +6,7 @@ be rendered in a number of formats, like HTML and PDF. Please read
 Documentation/admin-guide/README.rst first.
 
 In order to build the documentation, use ``make htmldocs`` or
-``make pdfdocs``.  The formatted documentation can also be read online at:
+``make pdfdocs``. The formatted documentation can also be read online at:
 
     https://www.kernel.org/doc/html/latest/
 
-- 
2.21.0.windows.1

