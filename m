Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF2DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACB725214
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189706;
	bh=Npxmw6nnvgD0ZjvtCKn1B+RkWhFeIgCUudF25HHwcB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FM6cJJpue9e+gXwvr2Fzr8tLTFxaC6WK8npTI3urJOdP4rXcaKLKVzqXKlk9q2hu5
	 P4BuQM49AqpGzMvdwhJEK4+O4a9BrLOd/JEKk3tyMKRgiwI3eXQQ/wGGkQv1cA50n7
	 A1xG898peONzvLYfyxdfE0h0MBh2vCMy0rcLIQTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfE3EPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfE3DQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:05 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB89923D83;
        Thu, 30 May 2019 03:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186165;
        bh=Npxmw6nnvgD0ZjvtCKn1B+RkWhFeIgCUudF25HHwcB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwNGn9KmjlB+H4NtfHGoV4IB4DRBck9PytKnowuKSlLOGCiRgIh2TYKSvNAOVT5bs
         UCOxmyQhPWd0kU/z1QGs6wvqTENid0ASV8aEbWeZyOQqf9vxTANbqz9WJvy3H8dFfs
         WqarAjnlHNAmS73qXG6c3Apuns30DbWxUcNuHj4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4.19 016/276] gfs2: Fix sign extension bug in gfs2_update_stats
Date:   Wed, 29 May 2019 20:02:54 -0700
Message-Id: <20190530030524.947342987@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 5a5ec83d6ac974b12085cd99b196795f14079037 upstream.

Commit 4d207133e9c3 changed the types of the statistic values in struct
gfs2_lkstats from s64 to u64.  Because of that, what should be a signed
value in gfs2_update_stats turned into an unsigned value.  When shifted
right, we end up with a large positive value instead of a small negative
value, which results in an incorrect variance estimate.

Fixes: 4d207133e9c3 ("gfs2: Make statistics unsigned, suitable for use with do_div()")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/lock_dlm.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -31,9 +31,10 @@
  * @delta is the difference between the current rtt sample and the
  * running average srtt. We add 1/8 of that to the srtt in order to
  * update the current srtt estimate. The variance estimate is a bit
- * more complicated. We subtract the abs value of the @delta from
- * the current variance estimate and add 1/4 of that to the running
- * total.
+ * more complicated. We subtract the current variance estimate from
+ * the abs value of the @delta and add 1/4 of that to the running
+ * total.  That's equivalent to 3/4 of the current variance
+ * estimate plus 1/4 of the abs of @delta.
  *
  * Note that the index points at the array entry containing the smoothed
  * mean value, and the variance is always in the following entry
@@ -49,7 +50,7 @@ static inline void gfs2_update_stats(str
 	s64 delta = sample - s->stats[index];
 	s->stats[index] += (delta >> 3);
 	index++;
-	s->stats[index] += ((abs(delta) - s->stats[index]) >> 2);
+	s->stats[index] += (s64)(abs(delta) - s->stats[index]) >> 2;
 }
 
 /**


