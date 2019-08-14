Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C62C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30343208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802350;
	bh=XiPjNHNVCK3KucFiNxonNoU7G7EJoy3Q8sILBxEOtk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=thqzuSgICUC4/q2Olv1Mn//GleVbnfSl+60H1EcYtDOQO6NA4B9aIWPpPJ4bMJBvy
	 IvnTueyaBZVkBP4KYH6NSoXEV95FQcaXvZHtRRNcKyRJZWX4vXwvLOnOsQcLTMY2lJ
	 bQQLFcUWzKk2e58dL1Jx/dp68/RCpimagiXkA8qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfHNRFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbfHNRFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:05:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66CA02084D;
        Wed, 14 Aug 2019 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802342;
        bh=XiPjNHNVCK3KucFiNxonNoU7G7EJoy3Q8sILBxEOtk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eulxkqj3/80L3gpZi5eVcfY9b2SIx2kItOadxG02EkfFSwWB2rkAQT+ifotHyQFtS
         L7unKodRFok9TXXchVyHLemfmqX1Ihl1F8e8jTnGPURQEzQsXOH0zaj1kLGu57yjsI
         wwcSJIv6aVMZ4GWdFBr203ySlTLYM49mLrVeGPII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 061/144] rq-qos: set ourself TASK_UNINTERRUPTIBLE after we schedule
Date:   Wed, 14 Aug 2019 19:00:17 +0200
Message-Id: <20190814165802.384808920@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d14a9b389a86a5154b704bc88ce8dd37c701456a ]

In case we get a spurious wakeup we need to make sure to re-set
ourselves to TASK_UNINTERRUPTIBLE so we don't busy wait.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-rq-qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index e5d75280b431e..e3ab75e4df9ea 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -261,6 +261,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		}
 		io_schedule();
 		has_sleeper = true;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
 }
-- 
2.20.1



