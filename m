Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443E1C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1A2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bIqnOsRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfG2WB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:01:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35536 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbfG2V61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so54776077wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQYuVRWeyp8z2V68VQ+ceXmiIOG++TFaEr2U30kvyLQ=;
        b=bIqnOsRznP61ecCXYGsSAXMON+wdZ39nu38FnmMaUtPogKBisah8xilJZKiaeaI6Hp
         GoVRaYw3R11xAU8SdKo6GTM8WqGwGM6ziZgvIfVl6aYjl4eSv7LTnK3aIrBHIvcnLfuo
         bbzwlszfN4EglVZIAesg6A1Q1oEoN3fmCUO/rZgyjLQHYGU56s/4nWyBIGF5W/OQN6/D
         ARnBwi/WcJg9oX7v51OMFRaFfVkeq3oB/laTsJeYwOhnE5t9iFIygJMRDknmlpCIXtLe
         OsxbFLP/scRWvIoPHF/Y5ZbgWV+Pecrbqpz4985w/MVGh6FAh6CS73wA38+3vow2Q3oa
         NY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQYuVRWeyp8z2V68VQ+ceXmiIOG++TFaEr2U30kvyLQ=;
        b=b7RdLSQf82LYjn+Prwl/nJYDxxZDGN44yXT/CU3FIUNBpRa5/uCP0rT6bcdOmJxc49
         wuBrQvoPC8cgjwAbK/ll6ojbgAiLvOSR0N/c3jRrWnLoHo1LwWH5HDnooWt597kp4y98
         9vIx1PZyasdsjKZQDqpZALuf4BcrdKzX71OfPJVqmBK3klK3uj/2v66OPLIgp+DEk3Q+
         unr0cEzU2FDeMKlR8ympNdKszHc65rzDUAeiihoRCe0ddFhmZkuY5SDhB70qou1Y3dem
         tO7JBKxaMEhznkBSSuSkKhdoHnH9/wM2sCqmW6sYC04k3/wX4aT+BFSxpKDdgstPL8Aq
         GV8A==
X-Gm-Message-State: APjAAAVENNr6cmmOiUk4AY5boQjpxLXqeCr6koWhUbZcddbTjZ/DhLnW
        yACvx+4StuuqjvQhnNckj6ZvYolQs8UbyEg628r4+KrjhVp7lVFJzNcZNvARWG83eVlZoQcdxYE
        W5qTQU1mczj6k7qNPXq2JNQuaWPTumj9PEmZs207hT8FkF7DYuguBK1iYtk+XUHkcZdH8ZG7fJX
        BbDm4lwOPcmwZXO9EfJcYuJZTgaGTb2Vqb8lpStoE=
X-Google-Smtp-Source: APXvYqxmYa5cH4TUpkY9P8qxxinPxUumDPb3lQFKbFMkqFVE6c9os+pDYv7bH3lv02cZ3ZQmgjvuhQ==
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr104770662wme.67.1564437505201;
        Mon, 29 Jul 2019 14:58:25 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:24 -0700 (PDT)
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
Subject: [PATCHv5 18/37] x86/vdso2c: Correct err messages on file opening
Date:   Mon, 29 Jul 2019 22:57:00 +0100
Message-Id: <20190729215758.28405-19-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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

