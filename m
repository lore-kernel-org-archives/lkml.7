Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01997C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2532187F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OmKcRIuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfHOQjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:39:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37948 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbfHOQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:39:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so1774225wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQYuVRWeyp8z2V68VQ+ceXmiIOG++TFaEr2U30kvyLQ=;
        b=OmKcRIucRyDa/oy2hPhsOntXWU40/6VL1vZJ8TPGS1PTHNvC+4Qu3LjJu7EZ3nqta5
         TrEYUnl1wTw794X6uOWBYJlohk9+t50cGswnT+av/TMqfzdEHBjjkoyV46/cjzS0ieUf
         NQq/f08lBfTHcHqVAAekwiDhuanecbcuy9p3UJQesmJ3ejiH1w+1wIjmESTqwR1fJsMF
         C0e8zNh+D8rQ5PqrRPVEhlG8FoHiXn6L0dnsVHwJp2B0SkSl4H16aZFqmopMczjk8Qpa
         dInTJqjocz/oJ31IqnpL0yMKt/4+V+zN6N946hK/JzgTF9Fz8LC0zyn5vDBWQsoeoB0D
         Kngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQYuVRWeyp8z2V68VQ+ceXmiIOG++TFaEr2U30kvyLQ=;
        b=E/uguAU6fnl8cOzC/3NLiI0Pah5IckVY8Q5LbZ6R4Xh80PIJlNYeKZVXDR/0yWhMIN
         S5PvmBEDf/F4RumVGfe0ekmViaHdkY/sw7ogPm/qpGaIwXYuwXk46mjEzOTl5KrNB0tf
         oNsau2FJhQi9kmbXDDqcLIXmGfEESEPNzkhkXICncmFGuQPU+KpPfrcM1aB2aiCFYgnI
         Vr3wTr1oBpiAT9K65A3KYn+VKybYZAELtlhQ0vMDyKjDYFSN7Ev50lrcRq77wpbPvcMx
         5A9mWywrKuCgNhfWVGVJYcJ3EZ5Z0qVGj6plE296cnhJGEljC7GcKJtrpk7SyD5+oXtH
         vbKA==
X-Gm-Message-State: APjAAAVQJS18sgxVYEj8xieMarlVNOMv52AH9sBNYCg0SyQ7QkdtP/+m
        1Rng3IRrvbgqPVoKbT0Q9ZB3yKFZ7oU=
X-Google-Smtp-Source: APXvYqym6qXFpduVEP81+UYhW2YRvg7TdhGKs+L69sFY8cK3y4t5e8sRZwvv3lnOutSiB5b4fj9ORQ==
X-Received: by 2002:a1c:7a12:: with SMTP id v18mr3540883wmc.56.1565887142614;
        Thu, 15 Aug 2019 09:39:02 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:01 -0700 (PDT)
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
Subject: [PATCHv6 17/36] x86/vdso2c: Correct err messages on file opening
Date:   Thu, 15 Aug 2019 17:38:17 +0100
Message-Id: <20190815163836.2927-18-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err() message in main() is misleading: it should print `outfilename`,
which is argv[3], not argv[2].

Correct error messages to be more precise about what failed and for
which file.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 3a4d8d4d39f8..ce67370d14e5 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -184,7 +184,7 @@ static void map_input(const char *name, void **addr, size_t *len, int prot)
 
 	int fd = open(name, O_RDONLY);
 	if (fd == -1)
-		err(1, "%s", name);
+		err(1, "open(%s)", name);
 
 	tmp_len = lseek(fd, 0, SEEK_END);
 	if (tmp_len == (off_t)-1)
@@ -237,7 +237,7 @@ int main(int argc, char **argv)
 	outfilename = argv[3];
 	outfile = fopen(outfilename, "w");
 	if (!outfile)
-		err(1, "%s", argv[2]);
+		err(1, "fopen(%s)", outfilename);
 
 	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
 
-- 
2.22.0

