Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE886C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921A7206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyThrPUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKUXmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:42:13 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:37695 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfKUXmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:42:02 -0500
Received: by mail-wm1-f45.google.com with SMTP id f129so4299894wmf.2;
        Thu, 21 Nov 2019 15:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfglY/0k5XsNkuHoTjTLG3M0i7rTl61XmHsyTLDxDS8=;
        b=CyThrPUh/mxwEgLsthKjyQA8cLmCzwKxOwyaQIvS17H8K/FmyxcDuqu9hwqnecn7IO
         KFF2CDwjXhM3rMih0LOWt1nD+vXOZOSaST5WFCuK9UKpRLuIssurrJeeaFTCyjcEVPRd
         GozAlSUdyjUlJHxRQS3aw66DWta/ASn5e5DA6ZoTJ/zRS18rcBpWbK9Ka8sCWNktzaem
         m8LZt/50yEVjtV7p1B3HhPiHoyeJJgdRPrabjwYLjInInG0hjkE+pMnSSaCIGSw5ndVA
         v87MQLeG/7tRRqPcx7plgrKd1eiUH6+Of7iHWnPkQrFixk3o/hiT1di4jYlmhQpYH7VE
         Z0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfglY/0k5XsNkuHoTjTLG3M0i7rTl61XmHsyTLDxDS8=;
        b=g+tzxn6U0ytRySvOG2Wca7qvRuxGXGJdkFvFRa9j8kGtUzrjkHDkX9NTcqE6GtUUWb
         cD5g8LASdOZ2Z0Uz9GPzMRCyzuvyzUCNvJcBTZxvEPoJ8DZuFP7rIM55xUTUAfO3g6MP
         9G+Ut4QI9y8c9OvleXvNFeMStwhoCnXRLnG9kd0WMVVO35djC6Z9caMLOKli2PgKAuh0
         /RVHNuOOHAjY1PPIRlVrgIUMpr/f8R91ZXcrA/RuiZDG9LhsULWJ1I1z0m5XqYv/2GAN
         aCI+AFLBmD5EsllU5Iu5Lb10IyvMekb0wmbnk+mWrJY1Qgz/RqFo8+G0v95JwdTsOKkb
         uDhA==
X-Gm-Message-State: APjAAAU1DSxoXj1f3TZ5lI6bm3OMNtP/iHsq64/n6Wuq0l3aOZ09HbMa
        qk543MnriCHdOqcKpsN2kWrrRKa3
X-Google-Smtp-Source: APXvYqyz8ftUa5yojz1QifDeEHG1K/lqToXsDAYZrgrfL/m6aSZDI63DlWFqFEbd2TszUC/vj2KZpQ==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr12652080wmk.133.1574379719849;
        Thu, 21 Nov 2019 15:41:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id l10sm5894420wrg.90.2019.11.21.15.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:59 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, will@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 6/7] Documentation/translation: Use Korean for Korean translation title
Date:   Fri, 22 Nov 2019 00:41:24 +0100
Message-Id: <20191121234125.28032-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191121234125.28032-1-sj38.park@gmail.com>
References: <20191121234125.28032-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
index 0b695345abc7..27995c4233de 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -3,8 +3,8 @@
         \renewcommand\thesection*
         \renewcommand\thesubsection*
 
-Korean translations
-===================
+한국어 번역
+===========
 
 .. toctree::
    :maxdepth: 1
-- 
2.17.2

