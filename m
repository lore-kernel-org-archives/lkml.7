Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE67C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B323A218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610784;
	bh=/xxo/7s8rMO/fnBpCA39xGg+DKCQZRB0pENzdkE3tSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2dEE86RtqMIISMyBA/r+wW97j+mb6zTa/DzxC+dPfkKfJxx4CwmtHMjT8rOT4N1v
	 U5FVe/5MWm4xALwTgp/pUesSNj0CuvvBX8PJ4RU24CJBGDp0CJkDeovGvbwz11h7tO
	 VEVtSfqZuCKDoeju630yNLqKorV2cBtZJhvEMRgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403802AbfDRSGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390971AbfDRSGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2E321872;
        Thu, 18 Apr 2019 18:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610779;
        bh=/xxo/7s8rMO/fnBpCA39xGg+DKCQZRB0pENzdkE3tSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMo+U3A1pvN5WUJnhvKgeUkh3QIfRZiVSNCjqFWC4XvZPurhnHw8whKJiNXEy15e3
         3S9jJqJ6S96VIcRZzHMYEnxUiauaJ6dH1zDMEM+GHdacpO67tgf+80wPprOsy7TIMR
         I7mgWCJuPwRNoTi2vmqu3LalQgCSBgUfD23LXX3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 81/92] bpf: restrict stack pointer arithmetic for unprivileged
Date:   Thu, 18 Apr 2019 19:57:39 +0200
Message-Id: <20190418160437.603972318@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit e4298d25830a866cc0f427d4bccb858e76715859 upstream.

Restrict stack pointer arithmetic for unprivileged users in that
arithmetic itself must not go out of bounds as opposed to the actual
access later on. Therefore after each adjust_ptr_min_max_vals() with
a stack pointer as a destination we simulate a check_stack_access()
of 1 byte on the destination and once that fails the program is
rejected for unprivileged program loads. This is analog to map
value pointer arithmetic and needed for masking later on.


Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[backported to 4.14 sblbir]
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   62 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 21 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -940,6 +940,31 @@ static int check_stack_read(struct bpf_v
 	}
 }
 
+static int check_stack_access(struct bpf_verifier_env *env,
+			      const struct bpf_reg_state *reg,
+			      int off, int size)
+{
+	/* Stack accesses must be at a fixed offset, so that we
+	 * can determine what type of data were returned. See
+	 * check_stack_read().
+	 */
+	if (!tnum_is_const(reg->var_off)) {
+		char tn_buf[48];
+
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose("variable stack access var_off=%s off=%d size=%d",
+			tn_buf, off, size);
+		return -EACCES;
+	}
+
+	if (off >= 0 || off < -MAX_BPF_STACK) {
+		verbose("invalid stack off=%d size=%d\n", off, size);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
 /* check read/write into map element returned by bpf_map_lookup_elem() */
 static int __check_map_access(struct bpf_verifier_env *env, u32 regno, int off,
 			    int size)
@@ -1322,23 +1347,10 @@ static int check_mem_access(struct bpf_v
 		}
 
 	} else if (reg->type == PTR_TO_STACK) {
-		/* stack accesses must be at a fixed offset, so that we can
-		 * determine what type of data were returned.
-		 * See check_stack_read().
-		 */
-		if (!tnum_is_const(reg->var_off)) {
-			char tn_buf[48];
-
-			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose("variable stack access var_off=%s off=%d size=%d",
-				tn_buf, off, size);
-			return -EACCES;
-		}
 		off += reg->var_off.value;
-		if (off >= 0 || off < -MAX_BPF_STACK) {
-			verbose("invalid stack off=%d size=%d\n", off, size);
-			return -EACCES;
-		}
+		err = check_stack_access(env, reg, off, size);
+		if (err)
+			return err;
 
 		if (env->prog->aux->stack_depth < -off)
 			env->prog->aux->stack_depth = -off;
@@ -2195,11 +2207,19 @@ static int adjust_ptr_min_max_vals(struc
 	/* For unprivileged we require that resulting offset must be in bounds
 	 * in order to be able to sanitize access later on.
 	 */
-	if (!env->allow_ptr_leaks && dst_reg->type == PTR_TO_MAP_VALUE &&
-	    check_map_access(env, dst, dst_reg->off, 1, false)) {
-		verbose(env, "R%d pointer arithmetic of map value goes out of range, prohibited for !root\n",
-			dst);
-		return -EACCES;
+	if (!env->allow_ptr_leaks) {
+		if (dst_reg->type == PTR_TO_MAP_VALUE &&
+		    check_map_access(env, dst, dst_reg->off, 1)) {
+			verbose("R%d pointer arithmetic of map value goes out of range, "
+				"prohibited for !root\n", dst);
+			return -EACCES;
+		} else if (dst_reg->type == PTR_TO_STACK &&
+			   check_stack_access(env, dst_reg, dst_reg->off +
+					      dst_reg->var_off.value, 1)) {
+			verbose("R%d stack pointer arithmetic goes out of range, "
+				"prohibited for !root\n", dst);
+			return -EACCES;
+		}
 	}
 
 	return 0;


