Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB6DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978182171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLWsAGV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfETVoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:44:44 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:36253 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfETVon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:44:43 -0400
Received: by mail-qt1-f176.google.com with SMTP id a17so18169053qth.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syIucGvkYPsk144lQ5pJgQSBGwyVOOPuqC44FRwBLoY=;
        b=aLWsAGV9r9wzM/rvq4OOno1lkAx/+8EPCBmykRQWhQnOe5zfw9nI5r1rN7eAOL0o0P
         pHiWhuWoGsSepg+riMty2MO0Vlauv4tBnK8Zo9QeGNjyKpKnNFCT/tIChi5IzRk/vTtq
         Wk3m3d0XDPg6qP/XpmmICgDVQkhbSOgVED0PbIO8V4a5dpiJMGDKg7ujs8EVkg0MBRGL
         rV0vCQg6sfcG2kevGcHxTX9sPCmJHYy8FRc16CW19LaFyyfft6CTlW5Zr/iUaDZUa77F
         DmwJLzTKldxlvUl9m0gBdZ8gFcR382rvnS7Q3RIcBdJl7GGyigXJj526mxgbsNiWyGDe
         6sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syIucGvkYPsk144lQ5pJgQSBGwyVOOPuqC44FRwBLoY=;
        b=cSFPLVpgFukCVyid9Snjy0sr67raGwTaQFSuaGwkX2ZY2a5nolaY8iMxIGNJ+dMro4
         5ORE7zt5TdpvOkl7v9B0yK/01IbN0SMzh7hZAFF07pVN7hSIlEiFAKgfFWTRnDjQzvpA
         DbjuXO/cHQX/FdWhkm4q2Bu9sTJAhSQHQMfhzlD9eZOn0U09vevhLxCwv7R7dwuMGIG+
         YqErwZKlLgoXjrVxqGnSYTfYIISvK/IE/pJSdeLNE03D1xuCDIWeQOENaK25Y1tUEAPg
         kz/hclI6XKoxiwwbuVq6pUkAnsBM2JmaMN7tyfV911ZK6iP71loPABPaI7FCrveCNB3d
         kL0w==
X-Gm-Message-State: APjAAAUCO0vcsytDKJyzqgaef2H8+pcvsGJzDtrQ5Xf6biAkeuAULutW
        64t9kW+KScT23ujurTdxp+KUhatV
X-Google-Smtp-Source: APXvYqwOyBqwZAtDzmUFi7dkBtCIdNUoDg6WfEsDHAj9WuD4UrN/QQ4AkQt341XaSCsRsI41ExGQ7Q==
X-Received: by 2002:a0c:9654:: with SMTP id 20mr60930126qvy.109.1558388682123;
        Mon, 20 May 2019 14:44:42 -0700 (PDT)
Received: from localhost.localdomain ([179.185.210.219])
        by smtp.gmail.com with ESMTPSA id t30sm11427530qtc.80.2019.05.20.14.44.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:44:41 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 0/5] raid1-10 and raid0 cleanups
Date:   Mon, 20 May 2019 18:44:23 -0300
Message-Id: <20190520214427.18729-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is just removing some code duplicated in raid1 and raid10, and
the other three patches are just cleanups.

These patches were based in "drivers: md: Unify common definitions of raid1 and
raid10", sent a few weeks ago. Let me know if these patches can be improved.

Thanks

Marcos Paulo de Souza (5):
  md cleanup
  raid1-10: Unify r{1,10}bio_pool_free
  raid0: Remove return statement from void function
  md: raid0: Return md_integrity_register result directly
  md: raid0: Make ret local in raid0_run

 drivers/md/raid0.c    |  8 ++------
 drivers/md/raid1-10.c | 30 ++++++++++++++++++++++++++++++
 drivers/md/raid1.c    | 42 ++++++------------------------------------
 drivers/md/raid10.c   | 38 ++++----------------------------------
 4 files changed, 42 insertions(+), 76 deletions(-)

-- 
2.21.0

