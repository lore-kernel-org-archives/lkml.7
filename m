Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DCCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B22920830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256543;
	bh=HvvEhrvnZvwc9lt9y9aA5IFXJV0GQigyguAdWWyv5SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cwjOnbDbkpVXpj/sIYl6Hb1+6c49kxYVR1cuCnS+QqitKDpQzOLj9OgwdnBwUuFl6
	 NKMnaXecsHOZmRRArfMie+npNF/aHgvnZMH0PdOPRfMfKmcOKkST0g8uOuculRADWv
	 UgTrCVfHcEeBO6kWY9Ue1vTkCSF3sclmpUlrPLfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbfCVMJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733201AbfCVMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:08:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67888206C0;
        Fri, 22 Mar 2019 12:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256538;
        bh=HvvEhrvnZvwc9lt9y9aA5IFXJV0GQigyguAdWWyv5SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sinSHuVNkY1kRYBzbbIHwulO5wWEeZWsIYHKinJSQVvBOO6/NbGYM5ie9hxHZSiK4
         89vGx12SHziLMWqMmJjfAtxbhZjlPDSdjGqm3AMiGo1XmzamL7iJ6rHpigcxdN1o6Q
         XJCHqopKwHvoSV2LspmqQP13BCVa2DIEJr6PDaUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.19 219/280] selinux: add the missing walk_size + len check in selinux_sctp_bind_connect
Date:   Fri, 22 Mar 2019 12:16:12 +0100
Message-Id: <20190322111334.573696241@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit 292c997a1970f8d1e1dfa354ed770a22f7b5a434 upstream.

As does in __sctp_connect(), when checking addrs in a while loop, after
get the addr len according to sa_family, it's necessary to do the check
walk_size + af->sockaddr_len > addrs_size to make sure it won't access
an out-of-bounds addr.

The same thing is needed in selinux_sctp_bind_connect(), otherwise an
out-of-bounds issue can be triggered:

  [14548.772313] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x1aa/0x1f0
  [14548.927083] Call Trace:
  [14548.938072]  dump_stack+0x9a/0xe9
  [14548.953015]  print_address_description+0x65/0x22e
  [14548.996524]  kasan_report.cold.6+0x92/0x1a6
  [14549.015335]  selinux_sctp_bind_connect+0x1aa/0x1f0
  [14549.036947]  security_sctp_bind_connect+0x58/0x90
  [14549.058142]  __sctp_setsockopt_connectx+0x5a/0x150 [sctp]
  [14549.081650]  sctp_setsockopt.part.24+0x1322/0x3ce0 [sctp]

Cc: stable@vger.kernel.org
Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/hooks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5334,6 +5334,9 @@ static int selinux_sctp_bind_connect(str
 			return -EINVAL;
 		}
 
+		if (walk_size + len > addrlen)
+			return -EINVAL;
+
 		err = -EINVAL;
 		switch (optname) {
 		/* Bind checks */


