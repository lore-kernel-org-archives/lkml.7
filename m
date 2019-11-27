Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EABC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E6B21780
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887387;
	bh=0NAakbf0aFFUr3C1ssYzRRr9w/w1NNglKrosxTZzK+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZF+PPd20m//506QO4bcUTLy1SzRQd7NliifzSN9QrQd7mSAH0IiOn5Am1n/OZ9/CM
	 lqNc+Bfs9AYQPjIVlDTqlvNKPIhsjbDIBAaoGuTvEI5GO/5sH96pHyXF7X7VmD7kWu
	 QmSJfEesDjQRojmsy0Oz17rDlfu6tna6Q/M0sCQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfK0UnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbfK0UnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:43:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86369217BA;
        Wed, 27 Nov 2019 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887382;
        bh=0NAakbf0aFFUr3C1ssYzRRr9w/w1NNglKrosxTZzK+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WamoV0JqFOmtx6ME1e3D1xKO9o36JA1A2dc+3QsD8dNP9gv1kksWy0gPrNRIWKbce
         Dfgy1gIs95ooqQF2i1EiW4TqFjJeTHxL6WspF4gYgPVU2W+oyX8K+KnqRnkvnl1vFM
         PMYa8aQA9sBgSguxaZj6MVdNCEEe9myUiRWpxzwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 089/151] audit: print empty EXECVE args
Date:   Wed, 27 Nov 2019 21:31:12 +0100
Message-Id: <20191127203037.037579187@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Guy Briggs <rgb@redhat.com>

[ Upstream commit ea956d8be91edc702a98b7fe1f9463e7ca8c42ab ]

Empty executable arguments were being skipped when printing out the list
of arguments in an EXECVE record, making it appear they were somehow
lost.  Include empty arguments as an itemized empty string.

Reproducer:
	autrace /bin/ls "" "/etc"
	ausearch --start recent -m execve -i | grep EXECVE
	type=EXECVE msg=audit(10/03/2018 13:04:03.208:1391) : argc=3 a0=/bin/ls a2=/etc

With fix:
	type=EXECVE msg=audit(10/03/2018 21:51:38.290:194) : argc=3 a0=/bin/ls a1= a2=/etc
	type=EXECVE msg=audit(1538617898.290:194): argc=3 a0="/bin/ls" a1="" a2="/etc"

Passes audit-testsuite.  GH issue tracker at
https://github.com/linux-audit/audit-kernel/issues/99

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
[PM: cleaned up the commit metadata]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c2aaf539728fb..854e90be1a023 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1096,7 +1096,7 @@ static void audit_log_execve_info(struct audit_context *context,
 		}
 
 		/* write as much as we can to the audit log */
-		if (len_buf > 0) {
+		if (len_buf >= 0) {
 			/* NOTE: some magic numbers here - basically if we
 			 *       can't fit a reasonable amount of data into the
 			 *       existing audit buffer, flush it and start with
-- 
2.20.1



