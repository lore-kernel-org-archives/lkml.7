Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76412C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477CB20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391874AbfC0Scm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:32:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:46956 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390457AbfC0Scj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:32:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 11:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="218112858"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.61])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2019 11:32:38 -0700
Subject: [PATCH v4] tpm: fix an invalid condition in tpm_common_poll
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     grawity@gmail.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, tadeusz.struk@intel.com
Date:   Wed, 27 Mar 2019 11:32:38 -0700
Message-ID: <155371155820.17863.10580533125620125669.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: stable@vger.kernel.org
Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
Reported-by: Mantas Mikulėnas <grawity@gmail.com>
Tested-by: Mantas Mikulėnas <grawity@gmail.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |    9 ++++++++-
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
 

