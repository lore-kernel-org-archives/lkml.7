Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11858C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26E720673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121849;
	bh=XWcptmxv1SX7IKJ84dhak6NlS0RXPtihWkoO7p8Rfp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WYLV6eqfcnpJk5UIPLw5uVfkHdRTQEfgaHQv/5zfGgsTtRvkKqHEruxnBmJUUIW2S
	 VsxQOtSYdFJfvGbIl8AVelXymYJUXWVzLSYOHpWfX6B/brjES2urHvPh+10Ca9VBIY
	 4w716bDKSsWMBFWm95Oib5+EPVRkelJunqxIwImA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405856AbfJCQtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393089AbfJCQtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:49:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADE32086A;
        Thu,  3 Oct 2019 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121380;
        bh=XWcptmxv1SX7IKJ84dhak6NlS0RXPtihWkoO7p8Rfp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSdpbvX4eYBHeN3D046XQGaVbaolBtLp98DYzo4ed9gW9XyajjGiqywrhpdXhOisV
         4gWYYV16sq9Ae6YtQdbsdBqYbJvBzST9LXUgvM4bjqE+aAzZPF2PVedJaZeiifM2HI
         irh8yktcR0GhzrRMC0RiyNnN40ZGX+jwjA5cq/Mg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 5.3 256/344] tpm: Wrap the buffer from the caller to tpm_buf in tpm_send()
Date:   Thu,  3 Oct 2019 17:53:41 +0200
Message-Id: <20191003154605.749615204@linuxfoundation.org>
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

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

commit e13cd21ffd50a07b55dcc4d8c38cedf27f28eaa1 upstream.

tpm_send() does not give anymore the result back to the caller. This
would require another memcpy(), which kind of tells that the whole
approach is somewhat broken. Instead, as Mimi suggested, this commit
just wraps the data to the tpm_buf, and thus the result will not go to
the garbage.

Obviously this assumes from the caller that it passes large enough
buffer, which makes the whole API somewhat broken because it could be
different size than @buflen but since trusted keys is the only module
using this API right now I think that this fix is sufficient for the
moment.

In the near future the plan is to replace the parameters with a tpm_buf
created by the caller.

Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 412eb585587a ("use tpm_buf in tpm_transmit_cmd() as the IO parameter")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -354,14 +354,9 @@ int tpm_send(struct tpm_chip *chip, void
 	if (!chip)
 		return -ENODEV;
 
-	rc = tpm_buf_init(&buf, 0, 0);
-	if (rc)
-		goto out;
-
-	memcpy(buf.data, cmd, buflen);
+	buf.data = cmd;
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command");
-	tpm_buf_destroy(&buf);
-out:
+
 	tpm_put_ops(chip);
 	return rc;
 }


