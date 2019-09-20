Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDBAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709F320644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlfQu6O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436965AbfITW6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:58:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46103 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404525AbfITW6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:58:13 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so6619154ioo.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O/x5T74yZq88Tqsbcl5S4dT7q/hySvCrnkLTlqMwcEw=;
        b=IlfQu6O568zwC+InEvUq7LAw98oMj4q2FNQIfnjWHixsjaZWgc5WeIAzZOOUPXAEdD
         wIVepkwUVWO5saHmsI1twEz+/6SqOl60vAAJYMVPBigNgprBJgK5E1brQmY9mUeBBI/x
         wc4FITiQdazy4XY4Vo4Vy9e4IjW/W9RaDYFNvOU198U8T9hygUnVPGIVUhJNfyVj6Ug2
         Eu/HaJaAic3/YxDMi0yShas42NCnGCwPz9Szp74vf3jqLD6Tz7mZI+2Ffq2Wicjwrmgq
         Ns9cpYLHTEgqQg8UCVn3iPQzKeSwqRL/uiOfxNATNr/Xlb+ELpi23xr8C81FkLj+J/fW
         SzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O/x5T74yZq88Tqsbcl5S4dT7q/hySvCrnkLTlqMwcEw=;
        b=maqyqWGhFZdVCumpu4YOgav1gdkphpZATTbUeiJyT83Fd4EAI9genm9+UoD73FFRmV
         MJGqtfhTv3COItyIcoEgPI0TvURipZRYkMwqECP859Hi0QNBWvo2n6ppIQthlb8JOcwV
         fGti5PCEvD5BpWPTcVi/D0tvtlGyt+ddnzkW1GZ9IYC2mxHhmXxx1FuGtmMnN8CKi3Dq
         7Iy1G/z6SgVkqaNpHJTUIUzpWSNb49GoHt+lvgJ/5GeyCiUmHaVRtAIUQ8gd+WtAkwP/
         tAOAScQ6vBC37t+o26vbUBEKvzG38+B3rl0Du+kYl2kr6/6swC+Mi3AxQhfxNVmiZg06
         /ZXw==
X-Gm-Message-State: APjAAAWy5/8j9iXS2y1gDr3zOYxHo3jxi246+1Oiwp14IiMSXyx7gO01
        attjxvoAOzTBNdbp5eI+6nxADZgA0WI=
X-Google-Smtp-Source: APXvYqyTJBnq8J9VkvosjVeHWZJfeDTSB1OUEYkN5xl2bqRfzAdlKbbC1W2YQBVO8ovGQ1bVQAZUHg==
X-Received: by 2002:a5d:8415:: with SMTP id i21mr601410ion.86.1569020291108;
        Fri, 20 Sep 2019 15:58:11 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id s5sm3451440iol.71.2019.09.20.15.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:58:10 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: prevent memory leak
Date:   Fri, 20 Sep 2019 17:57:59 -0500
Message-Id: <20190920225800.3870-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In predicate_parse, there is an error path that is not going to
out_free instead it returns directly which leads to memory leak.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 kernel/trace/trace_events_filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c773b8fb270c..c9a74f82b14a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -452,8 +452,10 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 
 		switch (*next) {
 		case '(':					/* #2 */
-			if (top - op_stack > nr_parens)
-				return ERR_PTR(-EINVAL);
+			if (top - op_stack > nr_parens) {
+				ret = -EINVAL;
+				goto out_free;
+			}
 			*(++top) = invert;
 			continue;
 		case '!':					/* #3 */
-- 
2.17.1

