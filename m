Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B14C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC3A216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="TxlQ7LnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfEHQJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:09:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41448 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfEHQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id d12so7473241wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfOB7GbrkVZQCFgD0TA7DzG1OYHj9B/YynSp6vT8HYg=;
        b=TxlQ7LnDi5z67Seonj7PKYAYmrQO64ZkA4yU/l7nOZnnysOHCUzQtw9DKvoHaVSsDC
         iqbKcnXtCpyph553a+nKcbwW4Q6ywTKBwSd8KGGkYnz3iys/qBQ+9WY67/RHTO+vpK4z
         Xjl9En5YRuddyiAo2dtSY3qy0kV8yBoh2tmOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfOB7GbrkVZQCFgD0TA7DzG1OYHj9B/YynSp6vT8HYg=;
        b=jDzmBE4FYGiw8unz8smw1TDZNDSmh9ETajtu+LA0FV6c4Sk+dMBsFp7fD7rBEYlLAs
         Cae4FA+WP1ZtU5beoi6SZyINKcttbHzixNpZzU7NjGmVQ01vSG3Q6L3V08gyex+4Em81
         m5BGmQV2T4QyFNaBBCzQ6GEvdnWF+R/sRDuLWhAGlcLPL54ZZq0myr+Ut6FmoSv5jJRq
         ht/ZfAHzCIjAJ0MUjzhA4N2+jtJ2zadKtKAJOvNnU2Dx3f5TrcWe47Oa4Dynxxbj8Ysh
         8vcHK34WAOijQkq1wCTUcUiDN3UI4TyApePu2Nuf/DaOOX6Swkbf0KXm0jXoYC5i+QSy
         +9+A==
X-Gm-Message-State: APjAAAVmy22DRvnfQ0reZHLt/WDXtrpl/KCsBf/wnDO22uJioy3CVWQm
        qTawId/aTUnwmQnNcCk3sKXA4w==
X-Google-Smtp-Source: APXvYqzgHU7/QFy+kUEadXwmue5yL6Xg92QjTGn320/Urf+QNinCxeLGYLo//3BTARwBgfRGmOvOcQ==
X-Received: by 2002:a05:6000:c2:: with SMTP id q2mr16616288wrx.324.1557331767708;
        Wed, 08 May 2019 09:09:27 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aea19.dynamic.kabel-deutschland.de. [95.90.234.25])
        by smtp.gmail.com with ESMTPSA id r2sm3235756wmh.31.2019.05.08.09.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 09:09:26 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     bpf@vger.kernel.org
Cc:     Krzesimir Nowak <krzesimir@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1] bpf: Fix undefined behavior in narrow load handling
Date:   Wed,  8 May 2019 18:08:58 +0200
Message-Id: <20190508160859.4380-1-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 31fd85816dbe ("bpf: permits narrower load from bpf program
context fields") made the verifier add AND instructions to clear the
unwanted bits with a mask when doing a narrow load. The mask is
computed with

(1 << size * 8) - 1

where "size" is the size of the narrow load. When doing a 4 byte load
of a an 8 byte field the verifier shifts the literal 1 by 32 places to
the left. This results in an overflow of a signed integer, which is an
undefined behavior. Typically the computed mask was zero, so the
result of the narrow load ended up being zero too.

Cast the literal to long long to avoid overflows. Note that narrow
load of the 4 byte fields does not have the undefined behavior,
because the load size can only be either 1 or 2 bytes, so shifting 1
by 8 or 16 places will not overflow it. And reading 4 bytes would not
be a narrow load of a 4 bytes field.

Reviewed-by: Alban Crequy <alban@kinvolk.io>
Reviewed-by: Iago López Galeiras <iago@kinvolk.io>
Fixes: 31fd85816dbe ("bpf: permits narrower load from bpf program context fields")
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09d5d972c9ff..950fac024fbb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7296,7 +7296,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 									insn->dst_reg,
 									shift);
 				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
-								(1 << size * 8) - 1);
+								(1ULL << size * 8) - 1);
 			}
 		}
 
-- 
2.20.1

