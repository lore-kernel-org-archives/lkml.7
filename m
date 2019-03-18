Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA43C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5B32133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFFN0pzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfCRRSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:18:16 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39160 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfCRRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:18:11 -0400
Received: by mail-pg1-f201.google.com with SMTP id o4so19304193pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MRHHZYm6qbbddi64ikktRuAjn8BoXK8Gf7bv/2tC2r0=;
        b=YFFN0pzAH8aZKTAjwEnRibFpDgHMBLVgE+Y/H6BldyMJfISdxeV4TieTiwWBUf4++h
         5qPE8agzsmBOu94H7aWR8TKMxJHOgpBxp+05T//MmjQV6X0IOo3LoMT6g453xDS32JNL
         uEO1aHTq8Rnk2u7skv3uFK7PlcfyAPVOgEppwAZwtzGwNkP4ro6UBD/uLtdfnq9xy7XW
         XO0COxSTv1Jmnv80OnZ2/0dsLvQrl7sHFJMan50DHp20r8EaWagDzYNNog4tZOIZ3oMY
         w/ooiTzJSI12lW99h0KIupXV6luZppWPt/ReHe66F1061arfZzk+YHF0fBmf1FEO1sRB
         IxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MRHHZYm6qbbddi64ikktRuAjn8BoXK8Gf7bv/2tC2r0=;
        b=NNqSk3ZYuBhZIblTBnktDtMjevc0LWK34NskHiHzIJmGSHdHoIk7L/hWlVK6/N4Ln+
         3MNVDaHnan8WiHzzyHYn7bf0iUOJF6JfNbJu16gz4n6ub43/ooIxQH7i+9g6HOjwB3OE
         CVxsQ4qi4umB8XgwkulgImYTc+cenHrqh5r9dvc9BPDNdgZDjZcCBhdXdbh0Uk15auvr
         V2E+6CdSJdoh5aQ4uiTYfMfLJ+uS6dG9Q3RfyzFH72cI7uJgYSavjy1GZSxwxGLA0e+K
         vJyZDQAja7iCbXgj209C+9O19OHI7AvagHvHjD4YICWRs5T9c1meY/SXDHI58skA/g1a
         /Qwg==
X-Gm-Message-State: APjAAAW2r8t/zRPD+SInRwEfsh92PSk8LwUVToUD+PE9OOEfnfe+MVRX
        0RBhs1dO0BTES81UKboj51PFe6DIoEvjREYh
X-Google-Smtp-Source: APXvYqwaXHvEHlP/j2S09wr/+VgOKvwauhGMa/tD/zVNDmmjkYJkKZn9iKzY6FKhtrC83z5lWNUQLgPCNgcfil0L
X-Received: by 2002:a63:4964:: with SMTP id y36mr7052420pgk.60.1552929490581;
 Mon, 18 Mar 2019 10:18:10 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:17:39 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <4368bfa2a799442392ee9582dd1cccb8c96e524d.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v12 07/13] fs, arm64: untag user pointers in fs/userfaultfd.c
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

userfaultfd_register() and userfaultfd_unregister() use provided user
pointers for vma lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 89800fc7dc9d..a3b70e0d9756 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1320,6 +1320,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
+	uffdio_register.range.start =
+		untagged_addr(uffdio_register.range.start);
+
 	ret = validate_range(mm, uffdio_register.range.start,
 			     uffdio_register.range.len);
 	if (ret)
@@ -1507,6 +1510,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
+	uffdio_unregister.start = untagged_addr(uffdio_unregister.start);
+
 	ret = validate_range(mm, uffdio_unregister.start,
 			     uffdio_unregister.len);
 	if (ret)
-- 
2.21.0.225.g810b269d1ac-goog

