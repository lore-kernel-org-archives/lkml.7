Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700FEC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEC62529F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189902;
	bh=qzX+KFInt22eoOmpRc5otvECGGKHg+IPdDsI+izr9SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LHcs2GnCcE5BCqTYCkFCb7fb7r9UP/A9jsOzoKGpegwupwAbHPPmi/xnE4B74Fd4i
	 WwmjUm6sN3cYvXdXkWlWCLl+U6+AOPKLFgTr2Izkl6F9STgmVYUxFWWZ3AFBXGqPPn
	 cAwTMkiEhOTZpQkfbEW5peuyGA/4qJAtIbCssDog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfE3DPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfE3DM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:56 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9D323D83;
        Thu, 30 May 2019 03:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185975;
        bh=qzX+KFInt22eoOmpRc5otvECGGKHg+IPdDsI+izr9SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GL+bFAVgrSYkFplXdBfcF8Q8oDwKieCvdr8bud2erV/wrZMLcZ9YH76FbprxMbxr5
         Om6zbhlujqRXQIolU3RvXzTzLXpiumxl9KBvHOzZwytsrtOFQvY3S7mpgpxj31C0Vf
         nrm5Fo3yU1vt/q2Yej02a0jTtN+DqT0DY2TaTVsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 389/405] regulator: da9062: Fix notifier mutex lock warning
Date:   Wed, 29 May 2019 20:06:27 -0700
Message-Id: <20190530030600.332701688@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 978995def0f6030aa6b3b494682f673aca13881b ]

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index b064d8a19d4ce..bab88ddfc5098 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -974,8 +974,10 @@ static irqreturn_t da9062_ldo_lim_event(int irq, void *data)
 			continue;
 
 		if (BIT(regl->info->oc_event.lsb) & bits) {
+			regulator_lock(regl->rdev);
 			regulator_notifier_call_chain(regl->rdev,
 					REGULATOR_EVENT_OVER_CURRENT, NULL);
+			regulator_unlock(regl->rdev);
 			handled = IRQ_HANDLED;
 		}
 	}
-- 
2.20.1



