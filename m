Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEDEECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B6F20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263246;
	bh=r4AUOYR8v+E1OaFX4qVSirdArg5U+qp6rBVI9XN0p6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ixa4X1Y/rnFDN7nwjt8T+XOyUo5fIvRJxReWG1oS87tJATpui1Whu45fYUA09EJC+
	 J5CcmfaXWH/PCXJeSEiNrSrHIgUwymWsf3F9o6n0JdzNwZkve2WXfSPL+iyBrTdBb8
	 rK85jVRu9lpgFMUkR65S9n5MgezG6gS5MiHQ4xjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438877AbfJPWAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438568AbfJPV7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:37 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA80B21925;
        Wed, 16 Oct 2019 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263176;
        bh=r4AUOYR8v+E1OaFX4qVSirdArg5U+qp6rBVI9XN0p6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsiflNbWkz95Kt8g2l1kwHkpKmW1V3kj/FbVYIrqjKDq4QR+E5xdNm2lPKjeGdM0S
         bc7Oin+jET/ab1ulglx8/xnFYQsZrYS49XhLE5lJKA09qRk1Vo+5nHLhyr+fldN9Qw
         qZIBVTLg/SNLPbPz9cG9FJf6CcqC6IyL3Q5wQAUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.3 104/112] tracing/hwlat: Dont ignore outer-loop duration when calculating max_latency
Date:   Wed, 16 Oct 2019 14:51:36 -0700
Message-Id: <20191016214906.951835525@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

commit fc64e4ad80d4b72efce116f87b3174f0b7196f8e upstream.

max_latency is intended to record the maximum ever observed hardware
latency, which may occur in either part of the loop (inner/outer). So
we need to also consider the outer-loop sample when updating
max_latency.

Link: http://lkml.kernel.org/r/157073345463.17189.18124025522664682811.stgit@srivatsa-ubuntu

Fixes: e7c15cd8a113 ("tracing: Added hardware latency tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_hwlat.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -256,6 +256,8 @@ static int get_sample(void)
 		/* Keep a running maximum ever recorded hardware latency */
 		if (sample > tr->max_latency)
 			tr->max_latency = sample;
+		if (outer_sample > tr->max_latency)
+			tr->max_latency = outer_sample;
 	}
 
 out:


