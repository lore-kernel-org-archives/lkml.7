Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E0BC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F71122BEB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998190;
	bh=z1ZhBcm+Rf/j/5jfTf+WVUG8QXKT2kLpGJDb8UUl/DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ddLYvq6CVpBf93xmyLGLvFP6ru7UhxqxBPVtdijyK96YFWL1Heuud+meUmvXXEafZ
	 cCEJNHymmD99OAaBLNjWmRYUGj8Mv9c+3PJrngbGDHnU356Tbnr0qAMUQVb/aCf9nX
	 VuUjYwHZ8LnU03+p0lKD7XZzP16/RelW1Qg0ngIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404653AbfGXT42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404628AbfGXT40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:56:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEC39205C9;
        Wed, 24 Jul 2019 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998185;
        bh=z1ZhBcm+Rf/j/5jfTf+WVUG8QXKT2kLpGJDb8UUl/DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q69GTQMKS+U1q1NQot4YfYqrOdDtPtc2bMw+3KQWXjtTu6DsCAroUCa+eMsY9Oufe
         4pp8rqtadHXW+pnWktiTr0R5BiXuZjZmuOCZqjFItCwRmkEoqzzNPsdBzveWUlemlA
         6azQO+5eTPdpoCz0BfypkRluTXxBHecpekAzoOT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dietrich <marvin24@gmx.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5.1 276/371] opp: Dont use IS_ERR on invalid supplies
Date:   Wed, 24 Jul 2019 21:20:28 +0200
Message-Id: <20190724191745.084711327@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

commit 560d1bcad715c215e7ffe5d7cffe045974b623d0 upstream.

_set_opp_custom() receives a set of OPP supplies as its arguments and
the caller of it passes NULL when the supplies are not valid. But
_set_opp_custom(), by mistake, checks for error by performing
IS_ERR(old_supply) on it which will always evaluate to false.

The problem was spotted during of testing of upcoming update for the
NVIDIA Tegra CPUFreq driver.

Cc: stable <stable@vger.kernel.org>
Fixes: 7e535993fa4f ("OPP: Separate out custom OPP handler specific code")
Reported-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
[ Viresh: Massaged changelog ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/opp/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -631,7 +631,7 @@ static int _set_opp_custom(const struct
 
 	data->old_opp.rate = old_freq;
 	size = sizeof(*old_supply) * opp_table->regulator_count;
-	if (IS_ERR(old_supply))
+	if (!old_supply)
 		memset(data->old_opp.supplies, 0, size);
 	else
 		memcpy(data->old_opp.supplies, old_supply, size);


