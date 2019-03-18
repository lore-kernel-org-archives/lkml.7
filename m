Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BD621741
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmesG1+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfCRRSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:18:11 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43691 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfCRRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:18:08 -0400
Received: by mail-qt1-f201.google.com with SMTP id q21so5872282qtf.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/AfMcWXUpr8qOV9jNlH+KOvJdLIB2O2rWZvj+eGhaHk=;
        b=ZmesG1+vdfvVJVysloZ/DvNyAHwl1NeoVDeZqmznyOpJWfePQRGjlMOaVKfDpQrgzs
         J2EQbjkMYChUC5zNqacIMsL4hIDlSJ8LlP4Fmv1sBUKWq1gONhy9n6WlIdgh6miGrDT+
         kxO+pObNRxAVLj1qO6umMp4FBt4KoE0pcjnUi2zV7lJYuNIAUHoun/OybTmy1PNaA5yQ
         p3eG+Dhv94MxYowpcID5/Yi84v5cik+7L0zhfsc+N+0vCh3BkkQf0oPyRfu2qOWqEfLW
         2tCSF4/OHp/EYgkB0s7TOad99Oui2rlmLjv/5KNArBSNE7FFiFH/+uNURIDaDJj0/jzV
         BjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/AfMcWXUpr8qOV9jNlH+KOvJdLIB2O2rWZvj+eGhaHk=;
        b=Aaz13aXaskMhA1xtdKlriHFLxuWjTyUZRfmkT6jEuDD1FLQXEcBOTQtcuvxLinTVuj
         r44hc4xrarFmE5rC4HAaJyQdypVxm8wrrhG+uEGvK1/x/DAfyuErH4mGtmF/cd0AfkAY
         RWz9gIOBikdUlbjc1t2g44+7kWv+ZTFDzM4eEiOY3xOfr3monynpJ4c3nuzaMW85PdW1
         lkc+1zmSWUpHxbm89axQo54fIByLijjqCTn0UHBdJz3KUzhrXmVQ3www1JYUvJyvZYOA
         nhbabkWTNP/ExRlSLyR0x8D+ziD2CS7xoIOCYP/cQaYYfcRXcAykwtf5dyBWgfjOHTM7
         FCVA==
X-Gm-Message-State: APjAAAX13f2V7/FlD2Qho+73roo6JwgkN8ycy8QIz+RuqWmrP5SUjSQs
        QgYzge1f/0vu15Aw5eeW2pVYED4kyYgx/zJW
X-Google-Smtp-Source: APXvYqzQcEeEWS2cRarzaICPGg9P+n5KYCEBV6zZ1LX2+H91hhlcnbntbKdJigMJk6uOOiOh4IgPE1iT+lDz1l6o
X-Received: by 2002:ac8:2733:: with SMTP id g48mr11081110qtg.0.1552929487390;
 Mon, 18 Mar 2019 10:18:07 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:17:38 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <e12d6b5008f63b530d25ad73b2e3491939005c22.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v12 06/13] fs, arm64: untag user pointers in copy_mount_options
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
2.21.0.225.g810b269d1ac-goog

