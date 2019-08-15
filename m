Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AF1C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D22520578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ea62pj4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfHOQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:39:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38040 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732329AbfHOQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:39:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so2772913wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBAXcNmS3l3nfaiqDJOSvjXWDET+01IZ2JhTywzQRP4=;
        b=Ea62pj4GwRIhBbcl3F+yl8GH57tG3qBQ/uZnTuUqIhq92RdhfYySLk9+dvAOOVtxc7
         1d2WJsu0kHmKDhkjS7wvpPbS/YkmRAWyKddYNPT7Fufzi3Car+UPC9G7MWDX/yprMLCs
         pe20PGUOVJQHPrgtpaDP+LwwchZXVprQMK/0Q/ZLUmDaAKTF3hDMZTcTsphq5mLSH04i
         Ezh4Q24ZAHZEMe2nWpMnolreFeIJXDF98eroOo5AUOEgY4n1dOLqzTdYa0ru1YOV5Yso
         kljs6FNHhSiMdF3wTrAD+COtOxTfNzpdcgQlEbYOG9QWwu9LyJh2KWuFJ4hRB0ykRP6y
         rxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBAXcNmS3l3nfaiqDJOSvjXWDET+01IZ2JhTywzQRP4=;
        b=EvogzaEPB4Xa6lsaiIhh4xpibli3+EqxGPoQDKiM503i+WSRkI5DK/0GtHxqYvINye
         IZ5M095fuhzL8MwLUnxEWn+Qrcb//wqaA8IsywvBYjhoe+QS3010Qk14Jxbqwbuv3VOc
         mUiRbSdT32qdyZtwJP14haL7DMR20GyhqxNeCjcpw7LrVpnP06QNjdBEo+fxIZLKT9l9
         oUWWgDQuQvyv5vX/HWveEGBe15C0kjEElDfJGbIuo1AOLURoNpjxfl+c121l1gHlkRdL
         TZndHcbNsiEmnzL14PY2ye74NPziS8rAn90pOalV5o1OE3g9t3OvKbHjwObCT+8cnggv
         /MIw==
X-Gm-Message-State: APjAAAVmiwRhQbQO7Q4QO/id0OVKiYmvqe/56uIW5gJrk02xFfjVPJEk
        3r/D1FOteHX6hNTME3iOw+Rn0k2I2/I=
X-Google-Smtp-Source: APXvYqwKOiGydl+4zn3GoYcnRO+8R+asfCMd1zXzop65k0bIXTVW253QxUthlrrMDyVqkR1pdSP66Q==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr6216185wrm.2.1565887141195;
        Thu, 15 Aug 2019 09:39:01 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:00 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 16/36] fd/proc: Respect boottime inside time namespace for /proc/uptime
Date:   Thu, 15 Aug 2019 17:38:16 +0100
Message-Id: <20190815163836.2927-17-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/proc/uptime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index a4c2791ab70b..5a1b228964fb 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
 
 static int uptime_proc_show(struct seq_file *m, void *v)
@@ -20,6 +21,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
 
 	ktime_get_boottime_ts64(&uptime);
+	timens_add_boottime(&uptime);
+
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-- 
2.22.0

