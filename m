Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACFAC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150C02089E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="SjMHUZNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfDYQOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:38 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45696 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfDYQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:34 -0400
Received: by mail-ed1-f51.google.com with SMTP id k92so357437edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtiGMFXIlU7zEDTTStCnuipc/zos2HW3AAX7o8EWpvo=;
        b=SjMHUZNQpatI+fFzIVziwisbQQncrbw8byYcZRMzw7zVAxKHGYiiwhTL9kAeKzSY02
         H8H9tBrhUciuV7eB1ztZg8VnwP0SYomDfPWy9xZJYpHlv/TXLA2hq8qkgzqmdQyiNdQ5
         5FkbKGrCCjgb5LFXVJZhc4WKotOAJeyI8YRsJzCzJJTpQx7KfOG43BFHF1ZyBhLwpfhf
         4by7nx0ZMqXGWvHS3m1vKQRlxr3PufgwO1x66v8PqVa0ZKrI5Jl0+NKka5Fc4Ucwh9k/
         Z/Z0hMEFZ/4xJ74LqvTL8X3QYiDiZt7dLwYk3opbWcxpSQnc/xsvMKkecI5dhIF/eQDQ
         ZkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtiGMFXIlU7zEDTTStCnuipc/zos2HW3AAX7o8EWpvo=;
        b=pBExCjYqquJS7W8w7QxF8zSwU/5fCSVH2oH+85oDnnAbtxTRfhVaLa5ThdLQg+azzN
         v3hYESmrmklUG8ntOU+CUWb1FUfpWjHnwYb8fL4up1XOjc6Y51C0MO1TsnuHMuRVi3FT
         DDh8mEGMAV7z55Zstb0Pkoyn0iDjSuIZCb9C3Vk8z3mqdkK3A1NV808udncG2xHvZp37
         gMwRndaEZMCsWDJcDAoBU4xbbxL8ZabSh8TLsRlLoW+w0rUoSVf1fRRGr8as/XI2EVVt
         ZvSfQvUeEpqvxM9TNfgH0vY785x8NOm4FdCyEXCKcJ4fi8hL0N+DXisIlOBdM9e8vUmD
         oWgw==
X-Gm-Message-State: APjAAAXH1a41hdHCRWPcz/uCaVuxZS0XPM+Pg9l7Fm8pS3/TV5t+kNEG
        IKr82s1Fuoo8ongNMb4troH918RdLpM=
X-Google-Smtp-Source: APXvYqy/UhCUXQz8LM5qbRK5TewehZHfe7XL87V/Q+vKMyKWxO4JNxB3jcWG7ED2HOdwfaEJgAoyIQ==
X-Received: by 2002:a17:906:1142:: with SMTP id i2mr9273426eja.33.1556208872754;
        Thu, 25 Apr 2019 09:14:32 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:32 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 09/27] x86/vdso2c: Correct err messages on file opening
Date:   Thu, 25 Apr 2019 17:13:58 +0100
Message-Id: <20190425161416.26600-10-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 8e470b018512..26d7177c119e 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -187,7 +187,7 @@ static void map_input(const char *name, void **addr, size_t *len, int prot)
 
 	int fd = open(name, O_RDONLY);
 	if (fd == -1)
-		err(1, "%s", name);
+		err(1, "open(%s)", name);
 
 	tmp_len = lseek(fd, 0, SEEK_END);
 	if (tmp_len == (off_t)-1)
@@ -240,7 +240,7 @@ int main(int argc, char **argv)
 	outfilename = argv[3];
 	outfile = fopen(outfilename, "w");
 	if (!outfile)
-		err(1, "%s", argv[2]);
+		err(1, "fopen(%s)", outfilename);
 
 	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
 
-- 
2.21.0

