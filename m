Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5256EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF202077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382489;
	bh=N9QFs/KP0RCjYYq/LG4A7GpA/CajXls59s95hKZ5nxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EsxGevoWmb7nLwrEyfPhZjkdl8GGT1R4+hLnssr3L3kTr3Sa1/6Q0eRHqjKdeytHe
	 RQ3tACs4+QuW2eCxYee3sq0EGPND6pw2PMO6582WpI2MwqDxAyjce4Cs9jyYTo9X1H
	 StkuDdLg7hPgRlQWZ4Oo8+hoOhb5jnG6qstXKM5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfJFRUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfJFRUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:20:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 352632077B;
        Sun,  6 Oct 2019 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382449;
        bh=N9QFs/KP0RCjYYq/LG4A7GpA/CajXls59s95hKZ5nxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkdULzdQGjq+n8szn41B2jsjnX0KU2ul+6qb2UkKWS+WkhLzlg3I+GBdRXSdeOkvU
         dBmuaWgjN7Orxw0Ii0iYdsEV24LfLnicgj+glw7dzoV0xwJArDRnkCGRohjV6z4csf
         DNgKS2EJcGx19xQS+v+ybS+KYn9fPgjaDEf+VMvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH 4.4 34/36] Smack: Dont ignore other bprm->unsafe flags if LSM_UNSAFE_PTRACE is set
Date:   Sun,  6 Oct 2019 19:19:16 +0200
Message-Id: <20191006171100.541305420@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171038.266461022@linuxfoundation.org>
References: <20191006171038.266461022@linuxfoundation.org>
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
@@ -932,7 +932,8 @@ static int smack_bprm_set_creds(struct l
 
 		if (rc != 0)
 			return rc;
-	} else if (bprm->unsafe)
+	}
+	if (bprm->unsafe & ~LSM_UNSAFE_PTRACE)
 		return -EPERM;
 
 	bsp->smk_task = isp->smk_task;


