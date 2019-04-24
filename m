Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E87EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46CD218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127488;
	bh=p+jBVZs35rk9TKVCeijqSwaj9ywYFKMuGFHdlkuTxNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N4qlxp/dyBs88uiJRACOXeFZhPp/iHmLLYNvqBa75mTXItk64O8ysbxFFsxiv2zky
	 ann3RjGL9dhh0wYEWLfUl0EzSQqhh79uvdonN9nLxzOFXhE+idaAp0fkgBCepiVv6J
	 jiVboiwCIVGmXxaGGeuO6qIsbvpGIwMUQFCpfD0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392353AbfDXRiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392336AbfDXRiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:05 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6AB218B0;
        Wed, 24 Apr 2019 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127484;
        bh=p+jBVZs35rk9TKVCeijqSwaj9ywYFKMuGFHdlkuTxNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrkFkycGvXoxBVuYPn8sb/PhwtReOqWF1rbhbb7IbiOezLmpXAleIWFPpuo01sGlQ
         asIzJHyeXWCnqIyBdfQFt/+gwFe5WtIWjavNFEYh8Tne6ZzYgshHmSWjKnHG5FKGxA
         hzmneOdX6FoPbkDhYSPjItckD3qcy1yiaiEZc5y8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 108/115] tpm: fix an invalid condition in tpm_common_poll
Date:   Wed, 24 Apr 2019 19:10:44 +0200
Message-Id: <20190424170931.001860087@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



