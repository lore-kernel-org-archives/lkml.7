Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5972DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2325A2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432156;
	bh=u1ijtqyYYwOMDo0bCfRl85cXKA5Ng3PJa34eRlUH728=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AZpeueCisVc6BCX4S+p9Thb5T4n7eWjOWeW01uAu/+oHmqJxLHcXkVHHhvJ+0z7y7
	 33PscmfXRqLczufwR3ONA6+8Tz4hbhhY4UH66XWN1s2u2KQ5iuLrBm9Y8mUWiHyo7e
	 RMNB2ix9RJATkTNW4cZjtZmI0qAWM2HrFrisy3Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAGVWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:22:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbgAGVCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:02:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE572077B;
        Tue,  7 Jan 2020 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430923;
        bh=u1ijtqyYYwOMDo0bCfRl85cXKA5Ng3PJa34eRlUH728=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lq+xoIG6a/WG2TVxgMRk5MDDQlXPlfYMtnD50dpHmYDtb7FO5xfLctsCdlPOWikyY
         0kdzJn7AzfwPkg5JX65vRIUQ4vEBL3fttPwQR0FU42zMPUWG2z7BYULUqycjuIJ/4S
         1+ad0pWj67zL8x4oV/AOuIN4YTMaqa2I3S8opMWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 125/191] ALSA: cs4236: fix error return comparison of an unsigned integer
Date:   Tue,  7 Jan 2020 21:54:05 +0100
Message-Id: <20200107205339.668661614@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit d60229d84846a8399257006af9c5444599f64361 upstream.

The return from pnp_irq is an unsigned integer type resource_size_t
and hence the error check for a positive non-error code is always
going to be true.  A check for a non-failure return from pnp_irq
should in fact be for (resource_size_t)-1 rather than >= 0.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: a9824c868a2c ("[ALSA] Add CS4232 PnP BIOS support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20191122131354.58042-1-colin.king@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/isa/cs423x/cs4236.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -278,7 +278,8 @@ static int snd_cs423x_pnp_init_mpu(int d
 	} else {
 		mpu_port[dev] = pnp_port_start(pdev, 0);
 		if (mpu_irq[dev] >= 0 &&
-		    pnp_irq_valid(pdev, 0) && pnp_irq(pdev, 0) >= 0) {
+		    pnp_irq_valid(pdev, 0) &&
+		    pnp_irq(pdev, 0) != (resource_size_t)-1) {
 			mpu_irq[dev] = pnp_irq(pdev, 0);
 		} else {
 			mpu_irq[dev] = -1;	/* disable interrupt */


