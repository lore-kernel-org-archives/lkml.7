Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B212BFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEEB207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264118;
	bh=R7muj0ZQtz28cz8Rdo20VjZVXN0cWVxoYOowSW3clsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KSpo14/TcbmmlbVkA1Yh2gxFgbtIB8jBZs7M098nMl1gBKJFQyukfPB/T7x7KJgfY
	 PyrNbZ4TqfnNz+AXd3+4MlAuUQhkGpFL1hSWPc8tJfnjyxfSTsVGpxR5Jyfuac0XlZ
	 mihy00ytqe3oZ0kj1Fg2z7X5cIcZUktYsVUC91Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439356AbfJPWPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395220AbfJPVz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:28 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3674720872;
        Wed, 16 Oct 2019 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262928;
        bh=R7muj0ZQtz28cz8Rdo20VjZVXN0cWVxoYOowSW3clsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qoAHQRIKBAorgKbjy/GiIXiFR6JpQeBI3RgzCHSa5bcLJJDX1A6krKiCVTMCO/8sE
         dWYLA4scygYS3GFi0M6TX3D1tPhqdzl2Fd32T9+iONdA0TL+35kD6EjapnyWq0tAET
         PyKvrB4gfHSeasV1uy5mhhL7/3GF8U1txOQKk/zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 88/92] tracing/hwlat: Report total time spent in all NMIs during the sample
Date:   Wed, 16 Oct 2019 14:51:01 -0700
Message-Id: <20191016214848.472113499@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

commit 98dc19c11470ee6048aba723d77079ad2cda8a52 upstream.

nmi_total_ts is supposed to record the total time spent in *all* NMIs
that occur on the given CPU during the (active portion of the)
sampling window. However, the code seems to be overwriting this
variable for each NMI, thereby only recording the time spent in the
most recent NMI. Fix it by accumulating the duration instead.

Link: http://lkml.kernel.org/r/157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu

Fixes: 7b2c86250122 ("tracing: Add NMI tracing in hwlat detector")
Cc: stable@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_hwlat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -151,7 +151,7 @@ void trace_hwlat_callback(bool enter)
 		if (enter)
 			nmi_ts_start = time_get();
 		else
-			nmi_total_ts = time_get() - nmi_ts_start;
+			nmi_total_ts += time_get() - nmi_ts_start;
 	}
 
 	if (enter)


