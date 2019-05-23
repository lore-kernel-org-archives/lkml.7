Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E7DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2A320863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639168;
	bh=pxM08Jm7nV5u+7Rp/rbVJR/+mOVGbPaQ4aZ/2Yp105I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZCaJr7l9zs0aQhshM+wAxjoC9hu51BUFWzKJOfT4hOKAlI9NypJTTC882LmI/yHL
	 s+bicv7iCVvN+ksgYM+Nx3301iQOxVPfDiX2UQeI9gznYxThcxgh+TgNkATeBpeNRk
	 Ofh7Ffn0GLO0o39SRZbWh+Y23huuFvXAcHYfv7r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbfEWTT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389799AbfEWTTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF032186A;
        Thu, 23 May 2019 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639161;
        bh=pxM08Jm7nV5u+7Rp/rbVJR/+mOVGbPaQ4aZ/2Yp105I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xF+Ba1EtPNW7Yp9dZtR+EJlic3Q+s19PU5pS0JNHmhhRBcMnG2FUIChA32B9syHpR
         NU7HItqGk6ViNDW9Hf2mgq01nmzdGPZtaEanrimovFgfGDulGRiXJZxTCrs1ccFh8f
         CX4ORf7dWCeM2g6NWPWRjL0wUznWaRlIupk1yRTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Nigel Croxon <ncroxon@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.19 109/114] md/raid: raid5 preserve the writeback action after the parity check
Date:   Thu, 23 May 2019 21:06:48 +0200
Message-Id: <20190523181740.700886331@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
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
@@ -4185,7 +4185,7 @@ static void handle_parity_checks6(struct
 		/* now write out any block on a failed drive,
 		 * or P or Q if they were recomputed
 		 */
-		BUG_ON(s->uptodate < disks - 1); /* We don't need Q to recover */
+		dev = NULL;
 		if (s->failed == 2) {
 			dev = &sh->dev[s->failed_num[1]];
 			s->locked++;
@@ -4210,6 +4210,14 @@ static void handle_parity_checks6(struct
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


