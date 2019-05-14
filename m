Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A69EC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6F221734
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DmaXwPUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfENAfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:35:11 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:49695 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENAfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:35:10 -0400
Received: by mail-yw1-f73.google.com with SMTP id v123so28332246ywf.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 17:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cQYS69pnKdMx3gTO+F+7L60HZWMlBVLEQe2DQzgIjmQ=;
        b=DmaXwPUuWIZMqSn3Lsqr881WEcVU27uNFKq/wiCngB4z8Zzw9SPR1itbmxkurWaCGj
         HxExxQXTVwHuFlqxg9Ua8Y/2PGoxyQvRgboX8EsKaLuXc7XGe7ijMvfbFo/EWGOBaGix
         SHvw6RLvCz7KTBEmnarZo3gSNYNBoAvCJrpq5/sdvbMlhw1QL/XoGdeQFKFyojg/nQwK
         DCvLMtAQEM8Wy6aFmNCuNEHIPxNiMfIG6/yOjqnELveRZtT6mEa1ToIv/mCy/ssO1a8a
         mszckrZjoviua2DCVZxW173T+Bf70pLXqbtYqmI8RvdRYsGf3r+WvOQGI56ppJ9FDAa0
         LXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cQYS69pnKdMx3gTO+F+7L60HZWMlBVLEQe2DQzgIjmQ=;
        b=NPFYgBEGgon5s6Vh4WI4BAhbBo6ivWvt10aFr4ft4RgBk9b9BXMMuvbUKQzFfC9ZGu
         chwcCSN94sXmGDACRLsp9E6z5S8MfomGXkrHRKi24t1Oz8ATogjS4qDcDMiZCuH3g49+
         SaqSzxQqYVGIhB6rBanM0GgkDxcvQnBXcxz13lJpt5/cTtGhSdut6TPKUYwEZG4p9or1
         jiEK7IfPPZDwpYZ4FHLWZQJ3stMnC93QvLOJLYFAJlLwZHO63/1rkYYzccZuAe8QSz1j
         Xpfkkv3HexAAnlnfwm1t6WHpsgkNeRDsDb8ZHZAGS8JlIYw2Y3yzgXAwMyGCCbJC1EcQ
         aU/Q==
X-Gm-Message-State: APjAAAVE4OUXsQ7INEr2RF5F4a7tn2eU7/LyfR+icamgo8f1eICJTquT
        i97uTlL8zqV7Eq9788QlLDcfyZaWoOKcYI1McumPqoSEgwtZSPr8xRJKaTHohk1YlNn6Fx8p0Mo
        bZfyLaQJ9PXbfyYM/jwA2ukiyq4G+HxAoOOP9ZUfIqY9B1daRbVoBHeDEj3seVw2s7UD8PMcR
X-Google-Smtp-Source: APXvYqzsmtb0KPyqn4PIBDgUHFGDExg8nnHyTZfy05UepuYWyO7FwFrB7WZTCQ76s0tcs+wV4QT9CyFyBRAz
X-Received: by 2002:a25:3b43:: with SMTP id i64mr15016395yba.477.1557794109918;
 Mon, 13 May 2019 17:35:09 -0700 (PDT)
Date:   Mon, 13 May 2019 17:34:00 -0700
Message-Id: <20190514003400.224340-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] perf/x86/intel: allow PEBS multi-entry in watermark mode
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, ak@linux.intel.com, kan.liang@intel.com,
        mingo@elte.hu, jolsa@redhat.com, vincent.weaver@maine.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an issue introduced with:

   583feb08e7f7 ("perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS")

The original patch prevented using multi-entry PEBS when wakeup_events != 0.
However given that wakeup_events is part of a union with wakeup_watermark, it
means that in watermark mode, PEBS multi-entry is also disabled which is not the
intent. This patch fixes this by checking is watermark mode is enabled.

Signed-off-by: Stephane Eranian <eranian@google.com>
Change-Id: I8362bbcf9035c860b64b4c2e8faf310ebd74c234
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 416233f92b3c..613fabba2c99 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3280,7 +3280,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!(event->attr.freq || event->attr.wakeup_events)) {
+		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_large_pebs_flags(event)))
