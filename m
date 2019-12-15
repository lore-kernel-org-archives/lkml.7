Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ECEC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 14:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413F3206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbEDLRMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfLOOZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 09:25:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34953 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfLOOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 09:25:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so3896404lja.2;
        Sun, 15 Dec 2019 06:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJydTZHkesdHgSzZFjvg4ewf57EUtmZOykP8heOTn30=;
        b=LbEDLRMrDEcGDNF0xxcPisZn1hl8ND2yW75hdo/Y4LGFQ5hiaBAnW51Y/WqLQvZ/uw
         WhQOP+IDn8TKLWDLvLb9cq2dKP1scfxTujlmCDYL6LguWPyZ2XKbrwMLQCh3uyfPAv65
         eRkXDInR6z1oivB6wmOe5JMhXgeLxEBokK53FtL7HyFN2S4HNTWMPZ19EvCcfzT8nZwe
         TzzdwJ4h9IABZJToRiwWCde7k84KveJMkPz5iNY0f3A9S+FkynzqodFiFpCgjQwi3VMr
         NG0JnG5fcRbvg/eobzmpp/mUweNlWHMYgnsdE6AFZYLw43E2pma7QChN+mKwVunlZpJm
         BG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJydTZHkesdHgSzZFjvg4ewf57EUtmZOykP8heOTn30=;
        b=H8KhWa+1nkJ84GAlUx4PBpU1lFMxy5BMgnlk6F3HI5fmbmXOhD/VFc3mljT24lYCkJ
         jmemTT5kvASU4dCVxsLmFn1vzFTiLYieW4Iy4cY6xpDAIfhBdVFyGsCepVWA31n5BGbQ
         j6fj1Qdmqr3WimV/TP/Szt21M/2tVbl10c1+gfytUxIMZLlelF44lBO69pLyTsV5dYQ3
         uuH7Go60rEcNfTJbU2YwJJJ+1/TJVCQfPkfd4SWsLBcaDNmeY5M5SlugHunSbVkcjJaa
         50pl3eHVi9hDiOLk9+hldubx8K6di3qUA0Pt7fKWYaGXqLtLm1o/S1vKcJvtcxN0Ofna
         qGZw==
X-Gm-Message-State: APjAAAVgEYoKddfMKHnH3EhBeYXX/6NB/+hMZotztxR95liVQiECKkz7
        dJ7gn/nTBuIonzBnADQqWsiPFUqy
X-Google-Smtp-Source: APXvYqxsPx5OunWlr3wv/mjK/7x/Yv4AlnYMaKswEgT7Cg2yW5NJYHucmCKoCEvGEgdkmJo6BL+Q/w==
X-Received: by 2002:a2e:91c1:: with SMTP id u1mr16402744ljg.181.1576419942130;
        Sun, 15 Dec 2019 06:25:42 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id t6sm8364634ljj.62.2019.12.15.06.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 06:25:41 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-api@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v6 0/2] platform/x86: asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
Date:   Sun, 15 Dec 2019 16:25:27 +0200
Message-Id: <20191215142527.13780-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds support of Throttle themal policy ACPI device to
existing asus_wmi platform driver. Support of this device is required
for ASUS TUF laptops on Ryzen CPUs to properly work on Linux.

v2: fixed indentation.
v3: patches 2/3 and 3/3 are refactored.
v4: patch 2/3 are simplified.
v5: add new device instead of merging with fan boost mode.
v6: document new ABI, simplify code.

Leonid Maksymchuk (2):
  platform/x86: asus_wmi: Support throttle thermal policy
  platform/x86: asus_wmi: Set throttle thermal policy to default

 .../ABI/testing/sysfs-platform-asus-wmi       |  10 ++
 drivers/platform/x86/asus-wmi.c               | 124 ++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |   1 +
 3 files changed, 135 insertions(+)

-- 
2.24.0

