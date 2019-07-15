Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34FEC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A934A2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198929;
	bh=hkbA/sYe4uhxv3xBqDfgTo3n7jU8Yf6FGRsBhp4/HrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKxQMjvRYBv1/Y2QrvvsxeCVoyWp+H1+NRk3gf7vdb7wmVFTcSUDJ8I1FE7fAc70H
	 SMhpy/q4MlKkkERrMlRQ5B/9q9VbvY1oQdj+AAvnHHFhXJPAcepTXCcX5pDLxEWlim
	 crxHS+bZWhWUSQZD/LxBFsAbZE7wmDvaVBTcIAkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfGONz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732103AbfGONzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:55:24 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9872083D;
        Mon, 15 Jul 2019 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198924;
        bh=hkbA/sYe4uhxv3xBqDfgTo3n7jU8Yf6FGRsBhp4/HrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCNqhswXqg0oDfdXxiNnaHDeC8/uPYNMgVYprGKd3IceT650TKSy9wdDzU3B49vvo
         qwE3Ai7G5dWG8HB+qA4qB2URh4eawfn2/gNQmuUWYTR/xDvxo6GB63VPfR3l1SX1yq
         Vk6Um06umhJVJkuFHJnpv8q3AeRlM9PoFdShqP4M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.2 142/249] media: staging: davinci: fix memory leaks and check for allocation failure
Date:   Mon, 15 Jul 2019 09:45:07 -0400
Message-Id: <20190715134655.4076-142-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit a84e355ecd3ed9759d7aaa40170aab78e2a68a06 ]

There are three error return paths that don't kfree params causing a
memory leak.  Fix this by adding an error return path that kfree's
params before returning.  Also add a check to see params failed to
be allocated.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
index 30e2edc0cec5..b88855c7ffe8 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
@@ -1251,10 +1251,10 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 	struct vpfe_ipipe_device *ipipe = v4l2_get_subdevdata(sd);
 	unsigned int i;
 	int rval = 0;
+	struct ipipe_module_params *params;
 
 	for (i = 0; i < ARRAY_SIZE(ipipe_modules); i++) {
 		const struct ipipe_module_if *module_if;
-		struct ipipe_module_params *params;
 		void *from, *to;
 		size_t size;
 
@@ -1265,25 +1265,30 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 		from = *(void **)((void *)cfg + module_if->config_offset);
 
 		params = kmalloc(sizeof(*params), GFP_KERNEL);
+		if (!params)
+			return -ENOMEM;
 		to = (void *)params + module_if->param_offset;
 		size = module_if->param_size;
 
 		if (to && from && size) {
 			if (copy_from_user(to, (void __user *)from, size)) {
 				rval = -EFAULT;
-				break;
+				goto error_free;
 			}
 			rval = module_if->set(ipipe, to);
 			if (rval)
-				goto error;
+				goto error_free;
 		} else if (to && !from && size) {
 			rval = module_if->set(ipipe, NULL);
 			if (rval)
-				goto error;
+				goto error_free;
 		}
 		kfree(params);
 	}
-error:
+	return rval;
+
+error_free:
+	kfree(params);
 	return rval;
 }
 
-- 
2.20.1

