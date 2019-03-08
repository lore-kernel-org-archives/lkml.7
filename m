Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A69520449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049995;
	bh=Zhprm00b5tNqSg1wwSRELQsutXpxJHZoMgrVLaDesCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2F07Ltj392BMlgobgY9nxL6gjGFA0tMuLmigcw/qZV94VCcoGV86HGWuYmi9RHJsN
	 UHqxXOr2FB8SUPAK5RfEFq/wFEStcxqI89s8VjJ17Njz/pZXFdy26TZdl+RN7FFi7i
	 e9HDizJJKa6ntXePVbxp7umHeTd34pkopTpq2Q1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfCHM7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbfCHM7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2929F20449;
        Fri,  8 Mar 2019 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049990;
        bh=Zhprm00b5tNqSg1wwSRELQsutXpxJHZoMgrVLaDesCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CT2HeSpeq5qd/uuyUMB7558e1jB8U16Qt2o9WiWM/aXGtkXIM2/nBRU0bf6bx76Te
         8rLFaFDl1AqoBljkakgDLF2sDt8gyKJSdfVBKGHcO4+Y/oz94js+ho8il28o8pg7jW
         x0Up/nrKsh/JhVWZwjPQz+hR/L91Y9D3MPDoZoBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 50/68] net/sched: act_ipt: fix refcount leak when replace fails
Date:   Fri,  8 Mar 2019 13:50:20 +0100
Message-Id: <20190308124913.121064401@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 8f67c90ee9148eab3d2b4393c3cf76489b27f87c ]

After commit 4e8ddd7f1758 ("net: sched: don't release reference on action
overwrite"), the error path of all actions was converted to drop refcount
also when the action was being overwritten. But we forgot act_ipt_init(),
in case allocation of 'tname' was not successful:

 # tc action add action xt -j LOG --log-prefix hello index 100
 tablename: mangle hook: NF_IP_POST_ROUTING
         target:  LOG level warning prefix "hello" index 100
 # tc action show action xt
 total acts 1

         action order 0: tablename: mangle  hook: NF_IP_POST_ROUTING
         target  LOG level warning prefix "hello"
         index 100 ref 1 bind 0
 # tc action replace action xt -j LOG --log-prefix world index 100
 tablename: mangle hook: NF_IP_POST_ROUTING
         target:  LOG level warning prefix "world" index 100
 RTNETLINK answers: Cannot allocate memory
 We have an error talking to the kernel
 # tc action show action xt
 total acts 1

         action order 0: tablename: mangle  hook: NF_IP_POST_ROUTING
         target  LOG level warning prefix "hello"
         index 100 ref 2 bind 0

Ensure we call tcf_idr_release(), in case 'tname' allocation failed, also
when the action is being replaced.

Fixes: 4e8ddd7f1758 ("net: sched: don't release reference on action overwrite")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ipt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -199,8 +199,7 @@ err3:
 err2:
 	kfree(tname);
 err1:
-	if (ret == ACT_P_CREATED)
-		tcf_idr_release(*a, bind);
+	tcf_idr_release(*a, bind);
 	return err;
 }
 


