Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A13C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CF02082F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596653;
	bh=tdF87nFJwnoC6wKG5yAiEGQ54gedFNILpUaj46a0uC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZOpRsFzw4W4noXNYJRLlkcXS9Z2DSOa5ixT9tyt2olvZxhHEjaGvNsLC4zBsAG1n4
	 06J13SBUY0Hi4YMb85Q/2CNMBP2+refy7wp4dwsu5yE0vbClJQ5QOKzsDlE6Y/YPF3
	 iR3GFWpeZVsDLv1H2DAt1coj7G1nGyMco+JDDU/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfF0Auv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbfF0Aex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:34:53 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69097217F4;
        Thu, 27 Jun 2019 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595692;
        bh=tdF87nFJwnoC6wKG5yAiEGQ54gedFNILpUaj46a0uC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gz4reelR8SwowZsO3Bp1nrkEXK+EdIUBCQvdQMYJmtPYmvX76I9jtlV8IknqjCkJm
         TwBJhvxOFRNT5gZg7aM2CJQlSX5vf+FihPAvzUS48q/tCpHCXiEUAz/tH+utIICnvA
         aZDiD8hjiITAA9GRpPB43dhb9bHsX0W0dWjaga2o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 81/95] IB/hfi1: Handle wakeup of orphaned QPs for pio
Date:   Wed, 26 Jun 2019 20:30:06 -0400
Message-Id: <20190627003021.19867-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

[ Upstream commit 099a884ba4c00145cef283d36e050726311c2e95 ]

Once a send context is taken down due to a link failure, any QPs waiting
for pio credits will stay on the waitlist indefinitely.

Fix by wakeing up all QPs linked to piowait list.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/pio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index a1de566fe95e..1ee47838d4de 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -952,6 +952,22 @@ void sc_disable(struct send_context *sc)
 		}
 	}
 	spin_unlock(&sc->release_lock);
+
+	write_seqlock(&sc->waitlock);
+	while (!list_empty(&sc->piowait)) {
+		struct iowait *wait;
+		struct rvt_qp *qp;
+		struct hfi1_qp_priv *priv;
+
+		wait = list_first_entry(&sc->piowait, struct iowait, list);
+		qp = iowait_to_qp(wait);
+		priv = qp->priv;
+		list_del_init(&priv->s_iowait.list);
+		priv->s_iowait.lock = NULL;
+		hfi1_qp_wakeup(qp, RVT_S_WAIT_PIO | HFI1_S_WAIT_PIO_DRAIN);
+	}
+	write_sequnlock(&sc->waitlock);
+
 	spin_unlock_irq(&sc->alloc_lock);
 }
 
-- 
2.20.1

