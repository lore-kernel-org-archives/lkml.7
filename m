Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5BFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C4621850
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639557;
	bh=EhYtP/rpvE8jWFvUYVqzJ7BQ2mvQOotty2PPRp7l7Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHotZV655Nhos6pwSc2T5njdaO0W86uyjrxfzBHwCBKXdU883KSXalLhctMy40ZAS
	 jnhvjlqdE86e+6kBYtqmAKBSaoAgMUDJ9lGklNPZjvMxUII92ZJIlrHOaMKkz3y/tg
	 Ezmhp0DYo9BMl2TBhu2HdqcbdD83UpfPl5rLO+ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391218AbfEWTZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391198AbfEWTZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:25:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED55220868;
        Thu, 23 May 2019 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639551;
        bh=EhYtP/rpvE8jWFvUYVqzJ7BQ2mvQOotty2PPRp7l7Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jBV/gwhQSLDUhetVhJWEmQwXJH5mUSqc6GXUlFVVtOrVVWEM+qN1y6hdiuHiOLlr
         O77B3PaDPTxEGRpx5rmEbaI0MiXE/eeQNUN0FH8EQBB1sTv2rzZjUuT1FM24u6tS+G
         6IoUtPYG14Zn1sS2oxpOXavgE4Lw366vaoLhvq7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chenbo Feng <fengc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.0 137/139] bpf: relax inode permission check for retrieving bpf program
Date:   Thu, 23 May 2019 21:07:05 +0200
Message-Id: <20190523181736.640635204@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenbo Feng <fengc@google.com>

commit e547ff3f803e779a3898f1f48447b29f43c54085 upstream.

For iptable module to load a bpf program from a pinned location, it
only retrieve a loaded program and cannot change the program content so
requiring a write permission for it might not be necessary.
Also when adding or removing an unrelated iptable rule, it might need to
flush and reload the xt_bpf related rules as well and triggers the inode
permission check. It might be better to remove the write premission
check for the inode so we won't need to grant write access to all the
processes that flush and restore iptables rules.

Signed-off-by: Chenbo Feng <fengc@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -518,7 +518,7 @@ out:
 static struct bpf_prog *__get_prog_inode(struct inode *inode, enum bpf_prog_type type)
 {
 	struct bpf_prog *prog;
-	int ret = inode_permission(inode, MAY_READ | MAY_WRITE);
+	int ret = inode_permission(inode, MAY_READ);
 	if (ret)
 		return ERR_PTR(ret);
 


