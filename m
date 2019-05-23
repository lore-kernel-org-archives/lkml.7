Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D572C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A682184E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639005;
	bh=oe3Ks5A33FJZZy8e0C9HZahremKFJ9LlOQk49bdyEpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f3Dp/8XVBagjbkgLSQgNHnmGTaLQuEjKupa2gqbbO52E3SQRov26ICcjG57bTDTuP
	 Z+JfdkJx9yKmzix5IyPKNx/kCU/Bi3srYlIou0+tcKjXEAq1apT2tZkAwoxaNLaKVV
	 tF1iVYKGm3yR9+J1nkgTxgXHVUW7/W2OZt2fjpJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbfEWTQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388748AbfEWTQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:16:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 105AF217D9;
        Thu, 23 May 2019 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638997;
        bh=oe3Ks5A33FJZZy8e0C9HZahremKFJ9LlOQk49bdyEpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIOg1LOPaLYhDpYuXZmYkcYnW26ALIr/YUzfkeuOxCPHEq/4f2Dv/Z583kNoK+JDB
         NDEHAiytKsrUZBgVJWuL8+mJj4znbGXY+DMM7u8WO6MjhnEIHuu9dO9oV/ZWZEH2Kg
         5d9xP2Qux9BnSiooY0Hpv4cq7WpS9uPFwG58B99g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 058/114] perf intel-pt: Fix sample timestamp wrt non-taken branches
Date:   Thu, 23 May 2019 21:05:57 +0200
Message-Id: <20190523181736.849861730@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

commit 1b6599a9d8e6c9f7e9b0476012383b1777f7fc93 upstream.

The sample timestamp is updated to ensure that the timestamp represents
the time of the sample and not a branch that the decoder is still
walking towards. The sample timestamp is updated when the decoder
returns, but the decoder does not return for non-taken branches. Update
the sample timestamp then also.

Note that commit 3f04d98e972b5 ("perf intel-pt: Improve sample
timestamp") was also a stable fix and appears, for example, in v4.4
stable tree as commit a4ebb58fd124 ("perf intel-pt: Improve sample
timestamp").

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org # v4.4+
Fixes: 3f04d98e972b ("perf intel-pt: Improve sample timestamp")
Link: http://lkml.kernel.org/r/20190510124143.27054-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1313,8 +1313,11 @@ static int intel_pt_walk_tnt(struct inte
 				return 0;
 			}
 			decoder->ip += intel_pt_insn.length;
-			if (!decoder->tnt.count)
+			if (!decoder->tnt.count) {
+				decoder->sample_timestamp = decoder->timestamp;
+				decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
 				return -EAGAIN;
+			}
 			decoder->tnt.payload <<= 1;
 			continue;
 		}


