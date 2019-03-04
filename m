Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C539CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A70B206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwcIjNae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfCDSmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:42:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39795 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:42:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id i20so3635681pfo.6;
        Mon, 04 Mar 2019 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mOmoZfkJPkF3cQ5otM/9OVlGvpXMShtqZ4y0MVLc2bw=;
        b=KwcIjNae4PkNkX/ww6yfgigNsIWdC0jWvg4hhwOhAuh1X3FPcZOBY5NWutu0ZLsirl
         sF0RHjBVdveQ7aKrDkP1DjxjNqyQStL5CQigPfn0JptcyuOhT4pfj7QpmvcvSAYTtjoO
         uC9lOWVxfmW+/BoN4xEy33bDa0LoQGrBR6kG33PWyBgSWpoWLhImO4g4fQHiZtEqH8zU
         5tVyfI1FwBVRxEs7P9ocXUM6gvXPIo0jn6XvEYW2PcsSKldVc1usR1CISCSEsnsMjF+/
         bXjEahnMr5VQxts1wa4I+EPXpeNljmcRZDU/vcwotYBkLZAXbFe9vZRJafMvboighXcM
         JVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mOmoZfkJPkF3cQ5otM/9OVlGvpXMShtqZ4y0MVLc2bw=;
        b=l1Cdxiq0f1KI+lsMX008E6fkIw5nd+Nv6fJZYU9Fc/jbbCQ/eWCBurGMkMDywIWfy3
         T9wtkm/fP/8r/bkOj625ulpUvEwDArnmYuNDc+aCJtXL9rHporwlkzL0DY9sH+47Jfsj
         GekHBa0aFvbfQ2gRbP7Jw6eFKsQ1M5VHhCHcFQWu6WSvB0KC57X9yA2wOij8XKo3Ypw+
         6vFTaIyWfrblIa2wTwBFWThdeYUbgQlJzTuTM+FrRffMODyRSAqcXN8xEm3/GxCUkKct
         cX2pmnAgQcKSmyu3Kwzn9ubg6lRcsk+HmpL/hFf9+8HPbwgBXp5zMPcy+zEOWMpQNlGj
         4gew==
X-Gm-Message-State: APjAAAUFZHu0O1cncCRvAqO8mksL9Xjp0sdQWhKUFJGxtIU/Q7yscMD8
        lcmqPl7rlbBIrq30eWk+HSk=
X-Google-Smtp-Source: APXvYqxoaB7qoNdLFmvP9B8ZLBAocUHsP9MiZhgbcX+wVUNjlfRsU8UORbazKbQ0kMphTNbuD50awg==
X-Received: by 2002:a63:1044:: with SMTP id 4mr19851660pgq.324.1551724933538;
        Mon, 04 Mar 2019 10:42:13 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.146])
        by smtp.gmail.com with ESMTPSA id c13sm9141127pfd.121.2019.03.04.10.42.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 10:42:12 -0800 (PST)
Date:   Tue, 5 Mar 2019 00:16:41 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] selftest/timers: Remove duplicate header
Message-ID: <20190304184641.GA6900@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/testing/selftests/timers/skew_consistency.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 022b711..8066be9 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -32,7 +32,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/wait.h>
 #include "../kselftest.h"
-- 
1.9.1

