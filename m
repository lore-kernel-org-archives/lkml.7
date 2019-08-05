Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C051EC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E992067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010830;
	bh=MzY3GTrzMHFCOZgbaePkw1i7Fuq60WcQXcMJR8PmiuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mk5QEwQ8zwIi8DgdkRxWhFB+j5ZYiryShd3aZZGPq4t8Cf2Vq8h2wKBfRUNDU82la
	 370ddfB14ZwxJBlhjOzVHOSOe2sVfCY0cKRGt/I2Wt8dpfLfOacaS4KAM5AYr57SYQ
	 8Dv1+txD3UDPyTSGmCe0NURUFr2q8uOLnDcU9VWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfHENIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfHENIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:08:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7982087B;
        Mon,  5 Aug 2019 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010525;
        bh=MzY3GTrzMHFCOZgbaePkw1i7Fuq60WcQXcMJR8PmiuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmaN0WMtVrgOIwrgL4AGeP/RTV5/T6jeTQ6wYof+0TyKtBfbvGP0dne4JDxBWgSQy
         1pLE+01PekhUDKE30cGL6wa/1zGrWc1K+VdHhPpL0wQVqOOwXasBTH76zsRAmj9noS
         0CQONXHO8fMvNTnBLjkx5CWCP63M0bOPlr5kvcwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.14 39/53] selinux: fix memory leak in policydb_init()
Date:   Mon,  5 Aug 2019 15:03:04 +0200
Message-Id: <20190805124932.418968972@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124927.973499541@linuxfoundation.org>
References: <20190805124927.973499541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

commit 45385237f65aeee73641f1ef737d7273905a233f upstream.

Since roles_init() adds some entries to the role hash table, we need to
destroy also its keys/values on error, otherwise we get a memory leak in
the error path.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/policydb.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -275,6 +275,8 @@ static int rangetr_cmp(struct hashtab *h
 	return v;
 }
 
+static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap);
+
 /*
  * Initialize a policy database structure.
  */
@@ -322,8 +324,10 @@ static int policydb_init(struct policydb
 out:
 	hashtab_destroy(p->filename_trans);
 	hashtab_destroy(p->range_tr);
-	for (i = 0; i < SYM_NUM; i++)
+	for (i = 0; i < SYM_NUM; i++) {
+		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
 		hashtab_destroy(p->symtab[i].table);
+	}
 	return rc;
 }
 


