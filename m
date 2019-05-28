Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2355C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EBA2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWnGvhyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfE1NrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:47:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36428 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfE1NrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:47:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id w16so143490ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q+SZZ5tAxQ4Vd5Xnbbh6RAt+ZJ/b62Vu/qDWIJpgIhE=;
        b=FWnGvhyEBNmhNxNSrgWwbzncb9k0YMERtYSVSG7lyintd5ILGxxXIhUiN2BSzD7sIq
         bHNuU9ONhfMvK7QKNx4V+hyTJOrrfSzt58rB8hM9ZNMz3HCnq/fwsOWlXt26qI2PnOhS
         +p7pAFzxilifE6ILwHAZPW11vvAYBQNtqbkNn2ev+5LgkYH1KZ4wp1TyM8t4uDe/c30q
         aD8MSvAMYrV2zI8FzzLI++s2UPj9oGhE4GE+5CGUjEJK9rPsxvH28iUtHZxoG0TRQmPW
         PAzSq2BDZuVWBajlbx0hvUEpcru6hXVtY+hC9VBBilxblaXm+nDZTT7jrdfh3YQUaHAi
         XaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q+SZZ5tAxQ4Vd5Xnbbh6RAt+ZJ/b62Vu/qDWIJpgIhE=;
        b=mAyCaM2ZRrEPj4MJ4kNgRLZj2Em2ovTlUIB7mdbOatRMaZ2RVsKUNCF6Y24AUe6pyM
         yvG7JBcksg5qsDeEbWf+O4N8uAF7FWITyns8gbL/gq1f+KMXowxtEYdXPpSZnOhQSaWA
         4eeOkdIxc4sGBv6mr8LLuKV6V4FQJmkwzblinTNYb8iZtp3s5wXJkOmvjZTLb9hwkp+T
         8wtWvdGfjzFCfxrpebV4xijim75S6sEu9LA20w8zsY9ME4kH2CxMrXzMF7NFSVbqnsi2
         sdcrW0MfkIJZ3zNWE8snEKx+pABXN31a8YMK9k7tzlHGcwHBKpyE4CcxOhROPsOf8D6x
         73pA==
X-Gm-Message-State: APjAAAXGFctkS/lqZvoGFywouUJ9cumbCAVK8j4tGfrbl87PCG3YPpH2
        xPo/n4/VGqB4mpe6w4QXnsSWBJrWG0Y=
X-Google-Smtp-Source: APXvYqxDN0+TuOpLaiAYxDuXvI165ZLjkEU7mESeGzTAOWl5cfG0dkxoAOlSrKoHx/t/fcWF5wrSzg==
X-Received: by 2002:a2e:6a01:: with SMTP id f1mr64179834ljc.21.1559051221612;
        Tue, 28 May 2019 06:47:01 -0700 (PDT)
Received: from debian-tom.home (2-111-15-75-dynamic.dk.customer.tdc.net. [2.111.15.75])
        by smtp.gmail.com with ESMTPSA id b16sm1590109ljb.20.2019.05.28.06.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 06:47:01 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] trace: Avoid memory leak in predicate_parse()
Date:   Tue, 28 May 2019 15:46:59 +0200
Message-Id: <20190528134659.4041-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of errors, predicate_parse() goes to the out_free label
to free memory and to return an error code.

However, predicate_parse() does not free the predicates of the
temporary prog_stack array, thence leaking them.


Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com
---
 kernel/trace/trace_events_filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d3e59312ef40..98eafad750d3 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -433,6 +433,8 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
 	}
+	memset(prog_stack, 0, nr_preds * sizeof(*prog_stack));
+
 	inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
 	if (!inverts) {
 		parse_error(pe, -ENOMEM, 0);
@@ -579,6 +581,8 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 out_free:
 	kfree(op_stack);
 	kfree(inverts);
+	for (i = 0; prog_stack[i].pred; i++)
+		kfree(prog_stack[i].pred);
 	kfree(prog_stack);
 	return ERR_PTR(ret);
 }
-- 
2.11.0

