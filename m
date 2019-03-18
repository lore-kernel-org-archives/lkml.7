Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD197C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23412133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXAkqzYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfCRRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:19:07 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34294 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfCRRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:18:14 -0400
Received: by mail-qt1-f201.google.com with SMTP id x58so512153qtc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nIZeb0pZ+Rs1twP/26IxdjvHz5r8ncIzXCkOe4U4COg=;
        b=EXAkqzYXquwoZW9zPquYoEc1VixgrJrxtJjurULtOsll9F/x8BSgkuYbNYqPNAK+sc
         QdGu01FYNxKrm1YnjhDssa3BGmNkam/8XvRG+67blmdUDkqpgD3yiL0tqlkzvcOHlEdD
         fz/vfMUJKMxApfo9M6ta6ANBN/hBFJ8sHT6IIlVMu94hJTj8vY7Ch6oVS78GY6mduhfg
         Mfa3G2yUPRZbMrYKuIq4vjmPLT9/Hrg9S0x5wCC0nEBvOOrzKzgwcqVZmA0wCyKJejEO
         fM02iW8f+3jGAOZtPgjTq3dSiMBluDfCCoyJ/neHAzTlpna8RAP9peqgVYpDqOfBkGtD
         dYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nIZeb0pZ+Rs1twP/26IxdjvHz5r8ncIzXCkOe4U4COg=;
        b=mBES11+XW5Zz+RYLk11vKLu1zmC9NG4KqgIFbmkkVrwPgwYvmZHLkHvyKSP5OXlQez
         y68fgFkNTf84duLYc0J1eC1OEpobpJo2ql5SCAHoDIEexzXtCyxzxZP2SpR0QddMAJZD
         kS+T0yIdyQCXsrDvVd8WLpr4Lchubmu7+y3Ea2mQq1miE+AogDzmJfWVlfLWgkT1UpzX
         axiI9eIQxTJkLr5IMOxMs1x2QQCrK28ofXgr8LNRhDB+67A27igiUAkS0F50XkKaZ3P4
         VzsQgjOBTu4CMajU6HbjTby7LPJ8l8X7X1CQdZ7FzHjiW6dvyjYRC5fXbEaa/MRPnOAN
         KOmg==
X-Gm-Message-State: APjAAAXSmG7QVijwMhqt4YGPF6tfAzB8XGPUvnQMygHrE7RMB8KCcyVA
        vwa68TouoZOLtyLTcJj5kGAbBla3Jt8xk6n1
X-Google-Smtp-Source: APXvYqxadZqo6uzYQyuENLgyHusNMUz8mCv/BxMvfZyt1rftgNKCVV69MZQdKa9n4B6FLFRP2mw6D3xauqnW81d3
X-Received: by 2002:ac8:38b7:: with SMTP id f52mr10498903qtc.7.1552929493810;
 Mon, 18 Mar 2019 10:18:13 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:17:40 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <80e79c47dc7c5ee3572034a1d69bb724fbed2ecb.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v12 08/13] net, arm64: untag user pointers in tcp_zerocopy_receive
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

tcp_zerocopy_receive() uses provided user pointers for vma lookups, which
can only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 net/ipv4/tcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6baa6dc1b13b..e76beb5ff1ff 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1749,7 +1749,7 @@ EXPORT_SYMBOL(tcp_mmap);
 static int tcp_zerocopy_receive(struct sock *sk,
 				struct tcp_zerocopy_receive *zc)
 {
-	unsigned long address = (unsigned long)zc->address;
+	unsigned long address;
 	const skb_frag_t *frags = NULL;
 	u32 length = 0, seq, offset;
 	struct vm_area_struct *vma;
@@ -1758,7 +1758,12 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	int inq;
 	int ret;
 
-	if (address & (PAGE_SIZE - 1) || address != zc->address)
+	address = (unsigned long)untagged_addr(zc->address);
+
+	/* The second test in this if detects if the u64->unsigned long
+	 * conversion had any truncated bits.
+	 */
+	if (address & (PAGE_SIZE - 1) || address != untagged_addr(zc->address))
 		return -EINVAL;
 
 	if (sk->sk_state == TCP_LISTEN)
-- 
2.21.0.225.g810b269d1ac-goog

