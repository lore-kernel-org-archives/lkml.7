Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9A3C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3FC2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thejn3/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfHPOMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:12:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34355 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfHPOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:12:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so3026979pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/cyIfJWJ/UWNnNSvZZjCx3YIHhLZlnOfcKruShOBv5w=;
        b=Thejn3/zFMxGXOKAToYFQG5C6X9tkXJSsDxEckLDLhWbAD7xKiw6OEjVuWKLCpfRQb
         s4/bgFMApva9XmRoWqWV9aF3v3YiUGPN2jS8hnbuQmXH8KwFAxnteOpFyRNX7QJ9FS2Z
         +015CE51+932sZ6ZJ57hUoV9Immm4rNuJfMWblol4onOsJDuN2sqsBpSET3hqAAS99B2
         ZpPsjPpHDisg3AHGDuFgi58MMvaerqd/ZLvwll4rbUZoYuY4MgOfE26uUhBoIYnnRDpg
         BPmsOwty9hevwRf670hzkcGffzDBdGgRVfKa+MxuXul4hmTfBRlRDOg7FZ1tywhdWIAx
         GOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/cyIfJWJ/UWNnNSvZZjCx3YIHhLZlnOfcKruShOBv5w=;
        b=ABFfSlGxaQ6P9AthrckxNoP2u9W1Dhliq4PPNfyrh68P69GZVrilgCn/AcKpeNOqp0
         8/Qa+rSJr3Fyjt2BTEra1W4OdYwKhlsBbSsf+93kYDtC5qCMqoAVWqRtoJdijMvnm23+
         JF9G4wFeSHL7zvC8VIsdL6mIKtYIEiULFJG5brSE7r1kT9AxttAXS9xQzO+H+FTWdbYI
         4ZnJreT/7HcLiGyXF2LyXZWWOArV8K04hsCYSEZFsCGbME6Fs4H6INQ9QIMQseQ6RTAp
         iaxRgynjo3VAElY/nFnty0mUdyPuldqNUOResPQ6Tkkmo0xV0K945aC7KQOUo8Z1tUXq
         JaqQ==
X-Gm-Message-State: APjAAAXMlAsS6ZEG+M22lrVbpNsyaPyw/cvgUOH9gH15znNtLgfchF9N
        a93gfoiFCQXhVv6AqYdOaK3oksyyYlw=
X-Google-Smtp-Source: APXvYqzKIv+PX3Uv9D+gDHIu6kb7hY06drZ/Z5F7KQnyx7otYoLWMCIScIxke711hRxG/yJxZ39CRg==
X-Received: by 2002:a65:458d:: with SMTP id o13mr7866189pgq.34.1565964725590;
        Fri, 16 Aug 2019 07:12:05 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id r23sm7377809pfg.10.2019.08.16.07.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 07:12:05 -0700 (PDT)
Date:   Fri, 16 Aug 2019 22:12:02 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com
Subject: [PATCH] sched/fair: eliminate redundant code in sched_slice()
Message-ID: <20190816141202.GA3135@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since sched_slice() is used in high frequency,
small change should also make sense.

Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---
 kernel/sched/fair.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1054d2cf6aaa..6ae2a507aac0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -694,19 +694,16 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
 
 	for_each_sched_entity(se) {
-		struct load_weight *load;
 		struct load_weight lw;
 
 		cfs_rq = cfs_rq_of(se);
-		load = &cfs_rq->load;
+		lw = cfs_rq->load;
 
-		if (unlikely(!se->on_rq)) {
+		if (unlikely(!se->on_rq))
 			lw = cfs_rq->load;
 
-			update_load_add(&lw, se->load.weight);
-			load = &lw;
-		}
-		slice = __calc_delta(slice, se->load.weight, load);
+		update_load_add(&lw, se->load.weight);
+		slice = __calc_delta(slice, se->load.weight, &lw);
 	}
 	return slice;
 }
-- 
2.17.1

