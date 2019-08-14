Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7117BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394A520665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802975;
	bh=BtqCLSai4wh4OD2jBiqrILAd4IwAXlkPsvd5EAO5rtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vmk8D25VbBSJwVekXh1DE8d5PR6FrVmSRiOgeR59aRRx3pcecgr72rqNdB7M3n5//
	 w/jk1Jb3beZofDJhaLd/l+EJ8pJZHdq2A0jkauwVplqvCIR8jPoAsRreS+rM3y+Il8
	 8Nt629VpYI4amW1u7Vzke0TlwHz7qb2jvccMd5KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbfHNRQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbfHNROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:14:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B43C62133F;
        Wed, 14 Aug 2019 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802884;
        bh=BtqCLSai4wh4OD2jBiqrILAd4IwAXlkPsvd5EAO5rtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8FgeUvj31eB+abDzrK/YxjhhCGZ7WUHhseqoLnJM+tclsDPdJyhBAKwB/xKXRdI9
         +3zkI/XyKeOcwnydA5iJ6nsIZG5acOfa54nLlpWKRP0kqWAaZ/lzyxA+DlLJQpf81m
         Ey/5HUYH3NaagMqYoCUJm5ynQ1XkSaVqTA4OJcLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <aglo@umich.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.14 63/69] NFSv4: Fix an Oops in nfs4_do_setattr
Date:   Wed, 14 Aug 2019 19:02:01 +0200
Message-Id: <20190814165750.358605921@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 09a54f0ebfe263bc27c90bbd80187b9a93283887 upstream.

If the user specifies an open mode of 3, then we don't have a NFSv4 state
attached to the context, and so we Oops when we try to dereference it.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Fixes: 29b59f9416937 ("NFSv4: change nfs4_do_setattr to take...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.10: 991eedb1371dc: NFSv4: Only pass the...
Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2966,7 +2966,7 @@ static int _nfs4_do_setattr(struct inode
 
 	if (nfs4_copy_delegation_stateid(inode, FMODE_WRITE, &arg->stateid, &delegation_cred)) {
 		/* Use that stateid */
-	} else if (ctx != NULL) {
+	} else if (ctx != NULL && ctx->state) {
 		struct nfs_lock_context *l_ctx;
 		if (!nfs4_valid_open_stateid(ctx->state))
 			return -EBADF;


