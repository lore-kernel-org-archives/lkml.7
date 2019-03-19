Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644462082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCSUbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:31:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:19688 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfCSUbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:31:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 13:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="126830422"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.61])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2019 13:31:34 -0700
Subject: [PATCH v2] tpm: fix an invalid condition in tpm_common_poll
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     grawity@gmail.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tadeusz.struk@intel.com
Date:   Tue, 19 Mar 2019 13:31:34 -0700
Message-ID: <155302749437.13955.651380639754310898.stgit@tstruk-mobl1.jf.intel.com>
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

Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
Reported-by: Mantas Mikulėnas <grawity@gmail.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 5eecad233ea1..7312d3214381 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -203,12 +203,14 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 	__poll_t mask = 0;
 
 	poll_wait(file, &priv->async_wait, wait);
+	mutex_lock(&priv->buffer_mutex);
 
-	if (!priv->response_read || priv->response_length)
+	if (priv->response_length)
 		mask = EPOLLIN | EPOLLRDNORM;
 	else
 		mask = EPOLLOUT | EPOLLWRNORM;
 
+	mutex_unlock(&priv->buffer_mutex);
 	return mask;
 }
 

