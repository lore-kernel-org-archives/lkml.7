Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D7DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4B220851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558641014;
	bh=FZI5N1ooc/Jf6QBaLIZLSXt2/oMJG9xwKnO+Glubvng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=asA8d4AKoHPjIj60DwjoogWnE80n86vvFyKvPmGCcisY7SgBs/QaOm2lFoOfq1kN6
	 sB+3Uug70JqJZZN3O94FAipwtHDeUiYa8edkit4QolmwPd/GH2TQZy+tsQhkcI8Qa7
	 zqx0GqVeo/T5f00Otb7cCRkGfPflmw3qkLbr8ZQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbfEWTKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387650AbfEWTKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:10:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0F5217F9;
        Thu, 23 May 2019 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638608;
        bh=FZI5N1ooc/Jf6QBaLIZLSXt2/oMJG9xwKnO+Glubvng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwhrRzsN6bkvLbUGIfM/wKPau60htNMJhAnKd/f0UEnF60c1piBhC4JGB3O9P1o/R
         w5J2seONfEYLTCRrAIggd8uQzgD8Fd5hBNH0dbhzGouDIXFhrY4ewV3c/d5cEuGtmg
         7KSdFxmaeFFcI/+FThv6NYU3b5iQDOjnhPH38nOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Nigel Croxon <ncroxon@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.9 52/53] md/raid: raid5 preserve the writeback action after the parity check
Date:   Thu, 23 May 2019 21:06:16 +0200
Message-Id: <20190523181719.226466348@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nigel Croxon <ncroxon@redhat.com>

commit b2176a1dfb518d870ee073445d27055fea64dfb8 upstream.

The problem is that any 'uptodate' vs 'disks' check is not precise
in this path. Put a "WARN_ON(!test_bit(R5_UPTODATE, &dev->flags)" on the
device that might try to kick off writes and then skip the action.
Better to prevent the raid driver from taking unexpected action *and* keep
the system alive vs killing the machine with BUG_ON.

Note: fixed warning reported by kbuild test robot <lkp@intel.com>

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid5.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3878,7 +3878,7 @@ static void handle_parity_checks6(struct
 		/* now write out any block on a failed drive,
 		 * or P or Q if they were recomputed
 		 */
-		BUG_ON(s->uptodate < disks - 1); /* We don't need Q to recover */
+		dev = NULL;
 		if (s->failed == 2) {
 			dev = &sh->dev[s->failed_num[1]];
 			s->locked++;
@@ -3903,6 +3903,14 @@ static void handle_parity_checks6(struct
 			set_bit(R5_LOCKED, &dev->flags);
 			set_bit(R5_Wantwrite, &dev->flags);
 		}
+		if (WARN_ONCE(dev && !test_bit(R5_UPTODATE, &dev->flags),
+			      "%s: disk%td not up to date\n",
+			      mdname(conf->mddev),
+			      dev - (struct r5dev *) &sh->dev)) {
+			clear_bit(R5_LOCKED, &dev->flags);
+			clear_bit(R5_Wantwrite, &dev->flags);
+			s->locked--;
+		}
 		clear_bit(STRIPE_DEGRADED, &sh->state);
 
 		set_bit(STRIPE_INSYNC, &sh->state);


