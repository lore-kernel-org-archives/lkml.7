Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F2BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCED206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519077;
	bh=8txS9mJL9J6Lew5YvRFGxoiMpn2Y4GzBC6UtL/Z2LXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hvz9aPGd8ygox0pGU5WI+UN6bzvSs+41O6xgH8jUxFs22OAx1/3vaXzDT5PRs6Uo8
	 sTPsN6KVWnLCDDm5vPilIb4g+NLl4ifigb6p5c9S4K/JwrtquLO9wazy+/fEPl0IOA
	 nJozBPhhO+2jDeU0+mpYF5mD7Ups0t52lahiV5X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfLPR5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfLPR5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:57:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58882166E;
        Mon, 16 Dec 2019 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519071;
        bh=8txS9mJL9J6Lew5YvRFGxoiMpn2Y4GzBC6UtL/Z2LXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPFaHVROTfr2HAdjIRSd42dgzLZpzx9rHWWxKUqaXKPlWsB3pbdnLlIyfFKIRTLeT
         dGDSMurqUo22PSq6A5sUVU4PNroaLOyFwMshgmVHCQf6nokmsqjxtae9b0NtLrnXrO
         D0mjh+LTxPMW7SNT/LcFdlCCiz/M3RAXBrXjsQs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tadeusz Struk <tadeusz.struk@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 181/267] tpm: add check after commands attribs tab allocation
Date:   Mon, 16 Dec 2019 18:48:27 +0100
Message-Id: <20191216174912.414990948@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tadeusz Struk <tadeusz.struk@intel.com>

commit f1689114acc5e89a196fec6d732dae3e48edb6ad upstream.

devm_kcalloc() can fail and return NULL so we need to check for that.

Cc: stable@vger.kernel.org
Fixes: 58472f5cd4f6f ("tpm: validate TPM 2.0 commands")
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm2-cmd.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -1029,6 +1029,10 @@ static int tpm2_get_cc_attrs_tbl(struct
 
 	chip->cc_attrs_tbl = devm_kzalloc(&chip->dev, 4 * nr_commands,
 					  GFP_KERNEL);
+	if (!chip->cc_attrs_tbl) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
 	if (rc)


