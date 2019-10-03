Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4AC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA91220673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122078;
	bh=J2I7SM7bMsl2OQ6fr2CABIWGTg6EorLiy5htaNXQeuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E8i32DQmaGtksK1+Wpk32iiD5EepbkWYBanSSQc0pUsSp7o+QkFqP9zQA1lxt5D1h
	 TqwITAHuy38QXyg2gE/5aO75eZ5L/8jiorLJ2xDDgbRrqJL3vuxJK8+cF4nfNJ6L2S
	 drLWppYTSFU4QRWaMY0OAkfctLbMOG9AJrzULSP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405467AbfJCQpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404740AbfJCQox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:44:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64AC7206BB;
        Thu,  3 Oct 2019 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121092;
        bh=J2I7SM7bMsl2OQ6fr2CABIWGTg6EorLiy5htaNXQeuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exwgFh8qxuEtkDldN19X+pM7VHk/Pr64VVLAJALFRyN/uRIBaVv8iMeW+dz2e08C0
         dhY4Rj6QFQ+KxffuzRw1nfwaFzOOYddQSHew1PIexKasay4PhkfFqtV1cHA3AoMEmn
         COJnx5/4h/KQcTO5oiguJLN82+PllCJzZqLc5Qsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 152/344] PM / devfreq: Fix kernel oops on governor module load
Date:   Thu,  3 Oct 2019 17:51:57 +0200
Message-Id: <20191003154555.236136924@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

[ Upstream commit 7544fd7f384591038646d3cd9efb311ab4509e24 ]

A bit unexpectedly (but still documented), request_module may
return a positive value, in case of a modprobe error.
This is currently causing issues in the devfreq framework.

When a request_module exits with a positive value, we currently
return that via ERR_PTR. However, because the value is positive,
it's not a ERR_VALUE proper, and is therefore treated as a
valid struct devfreq_governor pointer, leading to a kernel oops.

Fix this by returning -EINVAL if request_module returns a positive
value.

Fixes: b53b0128052ff ("PM / devfreq: Fix static checker warning in try_then_request_governor")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d69..a0e19802149fc 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return ERR_PTR(err);
+			return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1



