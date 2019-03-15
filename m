Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9508AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EEC2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzUF5/hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCOTwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:52:10 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:37036 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCOTwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:52:03 -0400
Received: by mail-yw1-f74.google.com with SMTP id x185so3793497ywd.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z/lbJIk5a8zt10jywFDNy5ZdetbtZxhqc2S4ejPNJ3g=;
        b=vzUF5/hV3N6LymY3D+bJBpSatNRK6fXpwnZa/1KVNOg7xeGxEXTPkbw+wbEOfgpNDR
         np5G4rL7T1cd+Sz5iJ0RCOtU4P6bLZVS0l14Aq6zvISFR6mzBUWQWKFDoL13DmN3dbM+
         SpIGClyUMZd9169+i8j5m3A6jrJ+Hyb10rwBPEQoaeyLAtm17DlPNuWH2RVG7xX1Y6TF
         9LKSfozE1SWXebNzzat2ugJn18cSW7bw5YZG+7kazfWFB4UEOKlKg3watEf4bHP24M7o
         9DP2o8Vqy0brwdDfGOvD+zN5V6FQV40T4Y8K+j9OS7OnApB4pexBW7Q518EArWyVitEY
         H6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z/lbJIk5a8zt10jywFDNy5ZdetbtZxhqc2S4ejPNJ3g=;
        b=XTlIav2I19fLgJzY+CY3JSW0EN0vxj8sUfH1ByDdPhKRE/3KJBo986AaACj66093Jz
         Omc66FWFqd2t3cV39DUU+sB+M+Wx4IakateFBhsWt7fesRIONT5Y7VfDOOeDXHwN3Vb4
         8RJmeQ6YIoo2YDbF1Fa3hCnskc2qOX9xaUkNjaXkBsoEGVhs2mYo1ZID+pqdun3KhztK
         B6kwXMsqYQ+9DIexFpk1rSKBsGSj0BMXcd6gmEvo0JaIe/J6yYdwirGu7h5rQiH9vGBt
         TlIpbfHZGoEPP5pRY5MEWWHCIF5VNNzr16k84t9l5BnTeUXcea+ZOkf8vzT+CSqacPWd
         t2KA==
X-Gm-Message-State: APjAAAW8k0WGEKSNLDGWPoi+xC8EEfDlsvSIJkw5WRRMnP5KLndaAl4P
        0I3z+ENSbHRuyc65hAV4AJv7kH0wAstUX2q/
X-Google-Smtp-Source: APXvYqzi5LEkko6ByM4uqeA/ILUmpPQs4A8NqtI2/DdkNKEbP39lGUp9icnx2HlBixyjeGCue9FZGuIPU0jeuK+1
X-Received: by 2002:a81:8a46:: with SMTP id a67mr2389102ywg.26.1552679522975;
 Fri, 15 Mar 2019 12:52:02 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:30 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <e12d6b5008f63b530d25ad73b2e3491939005c22.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 06/14] fs, arm64: untag user pointers in copy_mount_options
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

In copy_mount_options a user address is being subtracted from TASK_SIZE.
If the address is lower than TASK_SIZE, the size is calculated to not
allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
However if the address is tagged, then the size will be calculated
incorrectly.

Untag the address before subtracting.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c9cab307fa77..c27e5713bf04 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2825,7 +2825,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.21.0.360.g471c308f928-goog

