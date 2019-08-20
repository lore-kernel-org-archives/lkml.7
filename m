Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE33C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA11206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoOVkgQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHTX50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:57:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37348 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfHTX50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:57:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so266181wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFWxZfDSgaxpgiVvfnA+C89QxTNzwFuJSCG0oY5/8cU=;
        b=NoOVkgQB5pI8+yvEo8zXInR2QIQgLE4GQTEHpmN0+49qM/bhxbTPmI6JlthW55qtBh
         E3iDLclKnfNYx+VB5kzXihL+ZzRe0bvdWb7UizyYbkXhJtzEyupEToQXeJC4TFV/oqcv
         7sl1CDWiYNPBfc6eYG10HCfSe+E//wiQ3DbU9QfTpkhI3nE04oNx1lZMbUe0K776Puv+
         wE+NtpDo83HoT5Dd8n31RL7zcAG3nYAyiLxMbkk5gnn7glp6ma3MS786qGrmi0f52voK
         +AGuxlDiaNzE6l0RWv9CHvvQXo/R6r/zlv0vxNwy/OTad4qrJ93D81/pxaHrLcObmp/V
         CaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFWxZfDSgaxpgiVvfnA+C89QxTNzwFuJSCG0oY5/8cU=;
        b=ZDdffMK6d5aGEm5AUAFkh4aqTp7ipb3UDJpbScvQ3wbPPwoOhNXIrMB3m7gEZizp9c
         3zvL5EO8HkWDh6c1SPDdVGhcYQXeRb152W4Pr2NHNQT39Aq4wk0LzMgR0db6XYjobIuV
         onHAxZAhGDmMdzmmUB1FGzeLNe1reTkN5ziOp7hqHaIFX0e105KEA0rnfxL/b7npEoQN
         IqsBFCTv6y5aOjSmvjBC74XVAUk7IOsRtepZ4CAufLnaNyHZ/tPszJTEpiPKNF4+3ZpA
         tIzi+RHX5B++awdsIWboow5Hu0UEHdBvaWbPvh2df8nXlnZCARVGMKW7CoXMzRZPNZX/
         kWeQ==
X-Gm-Message-State: APjAAAXuRUWA2OrmGjmQ2w3059KwsIfg5CNF/TNa2709fXMfFzoHyWye
        cf/RcrhZhC8sUKzgH77sFmCG2FJhMEK2aA==
X-Google-Smtp-Source: APXvYqxE8oZO9D0ftd/BMspekKYA6qAtN7ZH+yFAachqoYvAcGRekIGFBW94LXpj+pVcTZyDYfKrDw==
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr29487098wrr.344.1566345444030;
        Tue, 20 Aug 2019 16:57:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id p4sm19534872wrs.6.2019.08.20.16.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:57:23 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm/amd/display: Fix 32-bit divide error in wait_for_alt_mode
Date:   Tue, 20 Aug 2019 16:57:13 -0700
Message-Id: <20190820235713.3429-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building arm32 allyesconfig:

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by dc_link.c
>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a
>>> referenced by dc_link.c
>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a

time_taken_in_ns is of type unsigned long long so we need to use div_u64
to avoid this error.

Fixes: b5b1f4554904 ("drm/amd/display: Enable type C hotplug")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f2d78d7b089e..8634923b4444 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -721,7 +721,7 @@ bool wait_for_alt_mode(struct dc_link *link)
 			time_taken_in_ns = dm_get_elapse_time_in_ns(
 				link->ctx, finish_timestamp, enter_timestamp);
 			DC_LOG_WARNING("Alt mode entered finished after %llu ms\n",
-				       time_taken_in_ns / 1000000);
+				       div_u64(time_taken_in_ns, 1000000));
 			return true;
 		}
 
@@ -730,7 +730,7 @@ bool wait_for_alt_mode(struct dc_link *link)
 	time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp,
 						    enter_timestamp);
 	DC_LOG_WARNING("Alt mode has timed out after %llu ms\n",
-			time_taken_in_ns / 1000000);
+			div_u64(time_taken_in_ns, 1000000));
 	return false;
 }
 
-- 
2.23.0

