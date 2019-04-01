Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98642C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5E42196E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138817;
	bh=6/fz/0e+JrO4g6+gBtK73vhB6N5wIeVEhuv2B/fv0Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CsusDB6lVgVzvbo2DngN3peXj/keZUkEMuVol2VzyylMPVnz397egnMQwjytq5oYS
	 n+7RCjF9mkUasAW4IyyoognvIARfMMlSx79NFCawX/q2aAnjWpMG9oLC+a958AbB5n
	 339Ge6YkngPS0YHj2agiGz27gF5NBQNqvQwtzPIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfDARNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730257AbfDARNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887CE21934;
        Mon,  1 Apr 2019 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138813;
        bh=6/fz/0e+JrO4g6+gBtK73vhB6N5wIeVEhuv2B/fv0Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMHqprnFHtg6cJYihyyTAuiT2KhhA1rJTJHA4FpZCxltrWgoBfz8A6j4zz+5YqrsZ
         CYR6WYSSSYD+9XVJYvEqFlfBZKnH0yW6ldYiokhLrb7DlJoDvhW8zx84Tf+CQVFS+P
         Gz08U1ofLDTKIDsUD0r9hqRRePIQqIUOB4fHPF6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+dae72a112334aa65a159@syzkaller.appspotmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 028/134] ila: Fix rhashtable walker list corruption
Date:   Mon,  1 Apr 2019 19:01:04 +0200
Message-Id: <20190401170047.209214259@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit b5f9bd15b88563b55a99ed588416881367a0ce5f ]

ila_xlat_nl_cmd_flush uses rhashtable walkers allocated from the
stack but it never frees them.  This corrupts the walker list of
the hash table.

This patch fixes it.

Reported-by: syzbot+dae72a112334aa65a159@syzkaller.appspotmail.com
Fixes: b6e71bdebb12 ("ila: Flush netlink command to clear xlat...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ila/ila_xlat.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -420,6 +420,7 @@ int ila_xlat_nl_cmd_flush(struct sk_buff
 
 done:
 	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
 	return ret;
 }
 


