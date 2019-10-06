Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71459C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B782133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382860;
	bh=Gyx+YxoClyUsWanHAtgiXk3n+uf7ILNWM4v7yipxFlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEkJK3hrZd0H/BqKFBfq88SmKPt+EXkjvlaYIFzbEJQx5qQjgCNWtRJjSFSdWuQ5T
	 IK9OrMswzG99QUXKs7FW/8YZj3ZgKolGE6LuO1B96GDFZa87cfsQdprnJkuU8l/W/b
	 nCQj+BKPeeNEi717GUXMSh0LJZyH9XCFW30uTRJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfJFR1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfJFR1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:27:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733FD2080F;
        Sun,  6 Oct 2019 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382857;
        bh=Gyx+YxoClyUsWanHAtgiXk3n+uf7ILNWM4v7yipxFlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N65t+Zlwtc5Q3EBZL6TbvbTjfv7IA2/CKh+w0Xe3RmxHLtducD3GAX/CecrkMxghv
         sKYEaTq1eb6P/A+WFBuKOTcqYSN/fFK4P09l6UXYkFPCrj8yTzMNRTREcm+wLZ2iAG
         3XDL6JFVeCHZVKUMsiiXPaIodKn3/zEZePNtxa3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH 4.14 65/68] Smack: Dont ignore other bprm->unsafe flags if LSM_UNSAFE_PTRACE is set
Date:   Sun,  6 Oct 2019 19:21:41 +0200
Message-Id: <20191006171138.670100846@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 3675f052b43ba51b99b85b073c7070e083f3e6fb upstream.

There is a logic bug in the current smack_bprm_set_creds():
If LSM_UNSAFE_PTRACE is set, but the ptrace state is deemed to be
acceptable (e.g. because the ptracer detached in the meantime), the other
->unsafe flags aren't checked. As far as I can tell, this means that
something like the following could work (but I haven't tested it):

 - task A: create task B with fork()
 - task B: set NO_NEW_PRIVS
 - task B: install a seccomp filter that makes open() return 0 under some
   conditions
 - task B: replace fd 0 with a malicious library
 - task A: attach to task B with PTRACE_ATTACH
 - task B: execve() a file with an SMACK64EXEC extended attribute
 - task A: while task B is still in the middle of execve(), exit (which
   destroys the ptrace relationship)

Make sure that if any flags other than LSM_UNSAFE_PTRACE are set in
bprm->unsafe, we reject the execve().

Cc: stable@vger.kernel.org
Fixes: 5663884caab1 ("Smack: unify all ptrace accesses in the smack")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/smack/smack_lsm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -944,7 +944,8 @@ static int smack_bprm_set_creds(struct l
 
 		if (rc != 0)
 			return rc;
-	} else if (bprm->unsafe)
+	}
+	if (bprm->unsafe & ~LSM_UNSAFE_PTRACE)
 		return -EPERM;
 
 	bsp->smk_task = isp->smk_task;


