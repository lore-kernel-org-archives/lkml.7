Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02801C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DF3222CE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118678;
	bh=JWoQwYa5H76DAUBqCzDOjjVohTZObjYeydY9EYZpwEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n+3E+ZaEveQAk+1k8OcbLtgE6tsKT4Xg5N+kruITXlCkIsAnyWHZ4IQd8nFLmaqBy
	 7fMU1XDOegnJQlcOlL3UIYGWwT7aqvDKCeBF62WWCOD1KNmJPSSmtrYm5hMLQX97FR
	 r9nn2h0gahUtqy73BGFTH9sygpvwFuHihnAwCq4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfJCQEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732430AbfJCQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:04:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB04C21D81;
        Thu,  3 Oct 2019 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118674;
        bh=JWoQwYa5H76DAUBqCzDOjjVohTZObjYeydY9EYZpwEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBm7msikmSUFnp+cQH4/5mtr2F+ANCBXsPWYAKJzqOAZ2BrRxU3SK1hXSXSFWqkeM
         /Kmt0pZO7ApCREB0czAIROAjaj+4C+/Zv1/ndLsOuYsSb8yJeH+YqWiaKOAxlQpCOv
         gxAXz//qd+/1+y3PSkkpRkU7z7q2XvFdIlpweoeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 097/129] PM / devfreq: passive: fix compiler warning
Date:   Thu,  3 Oct 2019 17:53:40 +0200
Message-Id: <20191003154403.884103313@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: MyungJoo Ham <myungjoo.ham@samsung.com>

[ Upstream commit 0465814831a926ce2f83e8f606d067d86745234e ]

The recent commit of
PM / devfreq: passive: Use non-devm notifiers
had incurred compiler warning, "unused variable 'dev'".

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/governor_passive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 8e889fd805b58..62c262fc2178d 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -152,7 +152,6 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
 static int devfreq_passive_event_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
-	struct device *dev = devfreq->dev.parent;
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent = (struct devfreq *)p_data->parent;
-- 
2.20.1



