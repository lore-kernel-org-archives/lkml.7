Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C22720851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640833;
	bh=iinsLTxbI9GgEq3kXfceGAF5pzt0Yc7F8j71KqN8rV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UxhkPTAAewft/IfafO5dAI0Jsa0VEt8VTTqspLQRMEHqvR+XPPpnY+C0K7uzUjFNE
	 LPIeC6PL5SmznNLQLwNyItRxO4ADlO/4UioRzzfh61WAbzz869gHW2rg+o4E6CYYKn
	 WAs3Zk/tfuVcPMlmWu07W/wFAViRdnkWt7Z3ORO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388143AbfEWTrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388082AbfEWTN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:13:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAF32186A;
        Thu, 23 May 2019 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638806;
        bh=iinsLTxbI9GgEq3kXfceGAF5pzt0Yc7F8j71KqN8rV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPHLvEHjKJVFH/x3TVO4WhhLjOtAn0hjqbW8f6SrlFMWA/8a9RzET5rHIA0a8cLsn
         bIVPzW5Io7+t7/O4ODPYwTfozu1Y/HxoZ/qvaxzGekzU7FtmIUKyLA0uoqKTsmr8VM
         7N1MFuzGcRn/vM9xMvMe37AFCfE5p6YRi7FKEuas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Nigel Croxon <ncroxon@redhat.com>, Xiao Ni <xni@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.14 72/77] Revert "Dont jump to compute_result state from check_result state"
Date:   Thu, 23 May 2019 21:06:30 +0200
Message-Id: <20190523181729.932487393@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

commit a25d8c327bb41742dbd59f8c545f59f3b9c39983 upstream.

This reverts commit 4f4fd7c5798bbdd5a03a60f6269cf1177fbd11ef.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Nigel Croxon <ncroxon@redhat.com>
Cc: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid5.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -4218,15 +4218,26 @@ static void handle_parity_checks6(struct
 	case check_state_check_result:
 		sh->check_state = check_state_idle;
 
-		if (s->failed > 1)
-			break;
 		/* handle a successful check operation, if parity is correct
 		 * we are done.  Otherwise update the mismatch count and repair
 		 * parity if !MD_RECOVERY_CHECK
 		 */
 		if (sh->ops.zero_sum_result == 0) {
-			/* Any parity checked was correct */
-			set_bit(STRIPE_INSYNC, &sh->state);
+			/* both parities are correct */
+			if (!s->failed)
+				set_bit(STRIPE_INSYNC, &sh->state);
+			else {
+				/* in contrast to the raid5 case we can validate
+				 * parity, but still have a failure to write
+				 * back
+				 */
+				sh->check_state = check_state_compute_result;
+				/* Returning at this point means that we may go
+				 * off and bring p and/or q uptodate again so
+				 * we make sure to check zero_sum_result again
+				 * to verify if p or q need writeback
+				 */
+			}
 		} else {
 			atomic64_add(STRIPE_SECTORS, &conf->mddev->resync_mismatches);
 			if (test_bit(MD_RECOVERY_CHECK, &conf->mddev->recovery)) {


