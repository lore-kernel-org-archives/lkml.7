Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBAC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE1421744
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="egvntGNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfFLT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:26:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39661 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFLT0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so15487454wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQYuVRWeyp8z2V68VQ+ceXmiIOG++TFaEr2U30kvyLQ=;
        b=egvntGNUuOx2Kv0rzH4bBjA2d/eNgZbZseUfkKLYstwMkJMliXgTidpfMT3sG3TFJY
         v4csc575IjFXzArKvq/XEJqw6uqRdD7fP0BuOll2Vkh6jVSkU5yvohJPgAmdjcVXhIym
         zHJGPac4g2DwQvDWvzHNQ4+Mvxt02WZyYASyyeDIuVazqXyKfS/NYfyLBfeiZVquIWIK
         f7Q4vfabv7DIXn/IUQzCMUurmQBgwPQrSfev1KWqUI7EYctp/0i+MwsaFTRKdPbBNcM+
         8rpXXXZv4+L24wcohKOSMjO2ASwkkuaLNXYZMz0InXRqLnaS8vtOHj2BmHAxO2dEcdhI
         51gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQYuVRWeyp8z2V68VQ+ceXmiIOG++TFaEr2U30kvyLQ=;
        b=RavJr2skRBKo3AlM4+pkIKoVFTm8pNcxghJEiCJjRls+SgCK9/YdZfih+o5Dv4b1VK
         efmPQEgK1BjaMm6JMvZkhwBkG0hMTFhH3kNtBN4fHzfPd5yLVdUZ1rhj3uI105YTYwzB
         wDfoq2s2V6bOOEvaQV8g7w54IXUKj6WaP3uHXw91fvR57HZk8ZKWZNTSIuJAkCLqn7DZ
         20LfFy7VMXTTillzDBkhCn5n3mNRO7k/a+Fy/d5wcNK/URl4eGbSbk/eajaWkHyJAwY1
         Z+Kxkgdruex2Z0Y0nGPVpTWEkcMxVYmnehc/acq2wbyC5W93cFL7EX93k2Bj+pB4tnCn
         W85g==
X-Gm-Message-State: APjAAAXO7jIDgJEjThntfS6QjrMkcD0ilal1ds80G/cIIr7hSVp88QlM
        1NDoOmWUvEr8fwOkf/Uef/Tss+oZDB8=
X-Google-Smtp-Source: APXvYqwSy+SQEmaxnOW73fMqtPP/7n7YbQcuU+lb8geAage2pxdtpBkw4APU7bz5Y21TMFCW2uf69A==
X-Received: by 2002:adf:c506:: with SMTP id q6mr41597659wrf.219.1560367604455;
        Wed, 12 Jun 2019 12:26:44 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:43 -0700 (PDT)
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
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 10/28] x86/vdso2c: Correct err messages on file opening
Date:   Wed, 12 Jun 2019 20:26:09 +0100
Message-Id: <20190612192628.23797-11-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
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

