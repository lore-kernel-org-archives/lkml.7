Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17732C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DE9217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UQGWSTEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfKFUvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:51:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44534 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfKFUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:51:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so19810526pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtkSiVUDCM/UIO4qaxjTuXDpS0EWTNh+zARatlA8Dr8=;
        b=UQGWSTEMDiZ70fruLNHyT8ne7OM5QDrBkhaTDuuO3R1p6BCyTUOceATfWGhHD6ipJQ
         fRjpVyJclq2VkRKuGbO9x+4lfIVlmTIV/RyIw29CYHaKnGXS0uLh+T9b3R7+ylBop/y6
         FxJ/mUjHfMdEqp2Ibn/1H1g7PRGCRxTDBbwto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtkSiVUDCM/UIO4qaxjTuXDpS0EWTNh+zARatlA8Dr8=;
        b=bhhfRMMf/CrPSUzVGSlUA+8fvTkZRjkC5SDI393qN4vV2qNQLgnji81HfM8iiUynvL
         O1LHcNS/JLdts6CD6RgwhqCZRVTOweK9W220PstiJxk230wHRuGfXd9HwB5CGe0GWeaq
         gwx2tEiZq8FsgF/okZzpOu/0p8vY6EFFVs+/VWgLgkG0hLsiNu/YLMEBqr/Y5mnmNnqY
         NRAws7JCbYBT1h9VPdINWkb6J7TdxQg1X5j0A+rEUzlpd9pFD7srnRhfpt6c/Msh6BS0
         uTnPuC9vy+FncgShq+p9awvH4PWP1muvPMmDJ/0eTE3cFTVYGbzyzWCo+AWCiXbou9Q4
         XXjA==
X-Gm-Message-State: APjAAAV+3AZHKCM5iWBI+5Dd8HUvs9jzN6S40M8d7XRt3OT8ussMIxWD
        /GM+0aOioZ+rxOf2tNnEDC2O0w==
X-Google-Smtp-Source: APXvYqz5jDrPhPkR4s9kLnMQjr8kvvbpRuKsFN3hsHRHoDkliANjFFcOxwYAKkE3opnBUl/Q1ozD7A==
X-Received: by 2002:a17:90a:35d0:: with SMTP id r74mr6548654pjb.47.1573073482203;
        Wed, 06 Nov 2019 12:51:22 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id t8sm3521668pjv.18.2019.11.06.12.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 12:51:21 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     groeck@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/1] platform: chrome: Update traced EC commands
Date:   Wed,  6 Nov 2019 12:51:16 -0800
Message-Id: <20191106205117.49584-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cros_ec_commands.h has migrated to platform data,
refresh the list of commands EC can support to be able to trace them.

This patch is orthogonal to https://lkml.org/lkml/2019/7/30/594
that update the script to not require manual cleanup.

Check that no commands have been erased.

Gwendal Grignou (1):
  platform: chrome: Update traced EC commands

 drivers/platform/chrome/cros_ec_trace.c | 71 ++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 7 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog

