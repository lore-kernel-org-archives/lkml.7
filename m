Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56468C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBB621841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034406;
	bh=BX9MCZIAOYPOsjelgHbUzEQLu4/l3KyzgU1ltpoBe8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kj6ROeRkfsCNEbu1G07qPauRFO4YNnJcxp0D2taENnsZ64XJZOKPdmn09SWCITts+
	 X7sqM8LwNu1Lv88JvykiXPBKYPf1Oax3XbqCC4iy9WhpbdhcemHW4DDM1mVZ1jgSnq
	 6SdVo5474n+6ngyhu0uA6gOvzKO42Xer7uGNRyuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGBC0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfGBC0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0B021721;
        Tue,  2 Jul 2019 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034403;
        bh=BX9MCZIAOYPOsjelgHbUzEQLu4/l3KyzgU1ltpoBe8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+Awd+tMJZZ91p7DLyVRhrsuypUR/z/D6ft4iqjIB6lIHiVxktZMs+mq2uqejZ6X2
         D202KRA19ovHsJL+sv/g0uQ63Gy9tweUh66esFmIjhwZWLMDj9wpZxtLdIgyJxcNkq
         vJJZZ69kB3dpTJhdXeuhR1w33k4R5HtAsSCuEX0g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/43] perf intel-pt: Cater for CBR change in PSB+
Date:   Mon,  1 Jul 2019 23:25:39 -0300
Message-Id: <20190702022616.1259-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

PSB+ provides status information only so the core-to-bus ratio (CBR) in
PSB+ will not have changed from its previous value. However, cater for
the possibility of a another CBR change that gets caught up in the PSB+
anyway.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 3d2255f284f4..5eb792cc5d3a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1975,6 +1975,13 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 				goto next;
 			if (err)
 				return err;
+			/*
+			 * PSB+ CBR will not have changed but cater for the
+			 * possibility of another CBR change that gets caught up
+			 * in the PSB+.
+			 */
+			if (decoder->cbr != decoder->cbr_seen)
+				return 0;
 			break;
 
 		case INTEL_PT_PIP:
-- 
2.20.1

