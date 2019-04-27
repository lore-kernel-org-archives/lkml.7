Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AAFC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA8F20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329201;
	bh=iGOrOURlLZIdE8x1gOG5js2ENjGi3lYXZghsgScNvv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HIvedYPqS5VtdEm0tBA1cMeQZabD1se492bR+pOF6STb7NnyBNmhm3xK+sZbrXwrQ
	 QIaB9GBXby4ZRL8pyBx31ND1ok++1+4D7uXbJsvkWgZBCR5kyMluG5uSAmWHWTMSha
	 ifr2sPsqIgBPVCrUQcKpVjtO26T+rOgGIYw0PXXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfD0Bj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfD0Bj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 386632146E;
        Sat, 27 Apr 2019 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329197;
        bh=iGOrOURlLZIdE8x1gOG5js2ENjGi3lYXZghsgScNvv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I37YSTRahbjUPsuTus5k7NB54Sp18KX8QE4Wt9H/BEIpMRlgLJONKI788WQhUer5o
         5Vb5Af1ds5TNK4AYlFRQbK2f019sVakXB3LtuK6DTfnXx6+uORHnZYiEwlkiDIP296
         kN4Gox16VNDipQcHcj5lJIMwKsbJ32mWubFkOx0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 51/79] tpm: fix an invalid condition in tpm_common_poll
Date:   Fri, 26 Apr 2019 21:38:10 -0400
Message-Id: <20190427013838.6596-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tadeusz Struk <tadeusz.struk@intel.com>

[ Upstream commit 7110629263469b4664d00b38ef80a656eddf3637 ]

The poll condition should only check response_length,
because reads should only be issued if there is data to read.
The response_read flag only prevents double writes.
The problem was that the write set the response_read to false,
enqued a tpm job, and returned. Then application called poll
which checked the response_read flag and returned EPOLLIN.
Then the application called read, but got nothing.
After all that the async_work kicked in.
Added also mutex_lock around the poll check to prevent
other possible race conditions.

Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
Reported-by: Mantas Mikulėnas <grawity@gmail.com>
Tested-by: Mantas Mikulėnas <grawity@gmail.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-dev-common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 5eecad233ea1..744b0237300a 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -203,12 +203,19 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 	__poll_t mask = 0;
 
 	poll_wait(file, &priv->async_wait, wait);
+	mutex_lock(&priv->buffer_mutex);
 
-	if (!priv->response_read || priv->response_length)
+	/*
+	 * The response_length indicates if there is still response
+	 * (or part of it) to be consumed. Partial reads decrease it
+	 * by the number of bytes read, and write resets it the zero.
+	 */
+	if (priv->response_length)
 		mask = EPOLLIN | EPOLLRDNORM;
 	else
 		mask = EPOLLOUT | EPOLLWRNORM;
 
+	mutex_unlock(&priv->buffer_mutex);
 	return mask;
 }
 
-- 
2.19.1

