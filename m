Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2BBC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6A7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430254;
	bh=rHm3w1s+OA3vgn6UbbqNpJH1RefhjVI02EjHY1GJZcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IKgnOQB6mH4KDRSfSDV3V08Kl/gNXfk2NgAPH7W9IeWrfjdBmljg14q8mCLH0v0pc
	 0Bg/2VsUFJ/PbFeIP0GV+N+9CfNGEwtqcCYO3N1rj4oJ02pDWIbe7zU4PsR7jIDv0w
	 QzEViWc5kkjvzrg2vwa0WCRm58TijCYhY/XZLMG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404009AbfG2TyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390989AbfG2TyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:54:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49C32054F;
        Mon, 29 Jul 2019 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564430050;
        bh=rHm3w1s+OA3vgn6UbbqNpJH1RefhjVI02EjHY1GJZcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iV6RCgeHS6+M27njPBltpyfnwTh+bjdCaf7SbuVboNzVuv+dW8KI3s+eikCo0zdo
         NfqXGx/ZdrRnpmiRNsy1/JtRelcJXlreE45UQKg8KPOQ3bTk2wezGTZo/VfPUPcBKo
         GRrzLllwoMHrhlf5mhYl97466XiXjIjyGlx9vcKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 5.2 180/215] selinux: check sidtab limit before adding a new entry
Date:   Mon, 29 Jul 2019 21:22:56 +0200
Message-Id: <20190729190811.251798429@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

commit acbc372e6109c803cbee4733769d02008381740f upstream.

We need to error out when trying to add an entry above SIDTAB_MAX in
sidtab_reverse_lookup() to avoid overflow on the odd chance that this
happens.

Cc: stable@vger.kernel.org
Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/sidtab.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct
 		++count;
 	}
 
+	/* bail out if we already reached max entries */
+	rc = -EOVERFLOW;
+	if (count >= SIDTAB_MAX)
+		goto out_unlock;
+
 	/* insert context into new entry */
 	rc = -ENOMEM;
 	dst = sidtab_do_lookup(s, count, 1);


