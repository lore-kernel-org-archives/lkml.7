Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7ECF213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259574;
	bh=DbIgnu03dwPbW00BGeB7LLjyqJjoh+iLhsRolqy8NRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V1tYCgg/HhTAi13Rj9XMipRTSQm+mz5P2feDJ27CeR/2KQh0jJSqhxqNtx4Tv3s7q
	 fg9at6KWhiQraLIfiAt3In8SfLS/XU8gfaF6qHFUheqDVgC4vi9t0t6JTjDVxx6BpO
	 mZMa6We1e0VNq/fmKoJN9u2BwQbf4aGYwW43EWHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfCVM7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbfCVLpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F75218B0;
        Fri, 22 Mar 2019 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255116;
        bh=DbIgnu03dwPbW00BGeB7LLjyqJjoh+iLhsRolqy8NRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIzr1V/ujOYAO0rcw342g1ic23KCla2WM+VtliWUPj/hLeEuVI2FX73K1JVXhIJU0
         ixmgvTVCEMjmCzD5cGZRP2+gRce2+z0R8RNKrMP3vuZLFACmmihUCVX4u30kWwipeH
         ZP+819st6PKeNBgjP3OHDJuFU/O39KCOP+fVP1VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 111/118] perf intel-pt: Fix divide by zero when TSC is not available
Date:   Fri, 22 Mar 2019 12:16:23 +0100
Message-Id: <20190322111224.136101347@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 076333870c2f5bdd9b6d31e7ca1909cf0c84cbfa upstream.

When TSC is not available, "timeless" decoding is used but a divide by
zero occurs if perf_time_to_tsc() is called.

Ensure the divisor is not zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org # v4.9+
Link: https://lkml.kernel.org/n/tip-1i4j0wqoc8vlbkcizqqxpsf4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2259,6 +2259,8 @@ int intel_pt_process_auxtrace_info(union
 	}
 
 	pt->timeless_decoding = intel_pt_timeless_decoding(pt);
+	if (pt->timeless_decoding && !pt->tc.time_mult)
+		pt->tc.time_mult = 1;
 	pt->have_tsc = intel_pt_have_tsc(pt);
 	pt->sampling_mode = false;
 	pt->est_tsc = !pt->timeless_decoding;


