Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B9B206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411645;
	bh=OWci8NHITgN+Qcxm9jxB+suFfiiK0yNqK98Fy8yYY3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TfgBvicgrZjuSnII+g79EK+3PpggzpeOstAsA5r1COJaxTS4pKByTyJrbYKHSCQkW
	 lZLYL4TQmisWb0CIHc/z8G/OXQHkHxA01iyGSfqxfCc536YgYs+O//JHrdqplUVeQS
	 rH/ZdoyTkwZaMygMjvkFfJt2bv29kPFVtph65oa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfCLR1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbfCLRRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:38 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889012183F;
        Tue, 12 Mar 2019 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411057;
        bh=OWci8NHITgN+Qcxm9jxB+suFfiiK0yNqK98Fy8yYY3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRslTnL4E71urBA9IWSPki0m99lyZEoEJEArW76xJlGF9H2Z/Odfijjt7WHUpQu0+
         jjmN63BsrUNKnhfXm3WrYd19r/d9/H+1abxrBvd1SD8zm3sgowxBHrXhOWuV52eN2D
         3SMb+gAiMCS/B5AE2ANjGhhS0ui6Xlh12BKeZKjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Celik <mail@timurcelik.de>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 26/96] tun: remove unnecessary memory barrier
Date:   Tue, 12 Mar 2019 10:09:44 -0700
Message-Id: <20190312171036.478222773@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Celik <mail@timurcelik.de>

[ Upstream commit ecef67cb10db7b83b3b71c61dbb29aa070ab0112 ]

Replace set_current_state with __set_current_state since no memory
barrier is needed at this point.

Signed-off-by: Timur Celik <mail@timurcelik.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1489,7 +1489,7 @@ static struct sk_buff *tun_ring_recv(str
 		schedule();
 	}
 
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:


