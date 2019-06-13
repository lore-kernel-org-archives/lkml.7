Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C9C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76442147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442804;
	bh=ARCRTzY0suUhboJLtjKbJugIFTrD91XgKQg1R1GXuBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BXoT6+uT62YZbCcB/dbBGbJMtfgYMJwWdiDuk6zNiXcYDnnEFuMX/FQRJkxPQjkJe
	 3IMkfia55QgpNqi7WAcDH6oAn5w2XTdJuL1T1Nr953egJOsjnufa3qoNM5u/GlqpfA
	 bd90853SrYT22scw9MBhukdXrZxwq2no6CzG6plg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392115AbfFMQUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731083AbfFMIjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:39:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D7520851;
        Thu, 13 Jun 2019 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415171;
        bh=ARCRTzY0suUhboJLtjKbJugIFTrD91XgKQg1R1GXuBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmYw9qPO19sSqPZgdLMeuivUL9ZgtAfb8SvaSZKTfUqiP+WBJrxL/tLgiKeI9MlZB
         flc+08RbwtlWauZr0FS5X7phIKzBsKrT2xbQQ9j++z+DEVFS2wBANkYiWXgOnDn65r
         i1d332IXidphruD30UHd3s2ZJ69yl4+Jd3+0JQ78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/118] bpf: fix undefined behavior in narrow load handling
Date:   Thu, 13 Jun 2019 10:32:46 +0200
Message-Id: <20190613075645.165720767@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e2f7fc0ac6957cabff4cecf6c721979b571af208 ]

Commit 31fd85816dbe ("bpf: permits narrower load from bpf program
context fields") made the verifier add AND instructions to clear the
unwanted bits with a mask when doing a narrow load. The mask is
computed with

  (1 << size * 8) - 1

where "size" is the size of the narrow load. When doing a 4 byte load
of a an 8 byte field the verifier shifts the literal 1 by 32 places to
the left. This results in an overflow of a signed integer, which is an
undefined behavior. Typically, the computed mask was zero, so the
result of the narrow load ended up being zero too.

Cast the literal to long long to avoid overflows. Note that narrow
load of the 4 byte fields does not have the undefined behavior,
because the load size can only be either 1 or 2 bytes, so shifting 1
by 8 or 16 places will not overflow it. And reading 4 bytes would not
be a narrow load of a 4 bytes field.

Fixes: 31fd85816dbe ("bpf: permits narrower load from bpf program context fields")
Reviewed-by: Alban Crequy <alban@kinvolk.io>
Reviewed-by: Iago López Galeiras <iago@kinvolk.io>
Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index acc2305ad895..d3580a68dbef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5743,7 +5743,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 									insn->dst_reg,
 									shift);
 				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
-								(1 << size * 8) - 1);
+								(1ULL << size * 8) - 1);
 			}
 		}
 
-- 
2.20.1



