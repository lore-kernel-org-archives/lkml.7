Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042F7C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE488218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EzEThwPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCOFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:05:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:05:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E4ppK3320516
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:04:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E4ppK3320516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162692;
        bh=87rz6ILyri1JgwfwoaXClgAw4eGaRbeL4ihSvLBNaOo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EzEThwPodz81CkygGDHnUhi89JCytLdZ6P4JkLHMckxJUu+WtJ+buOkOCpYfYTum/
         ilRbFypoo1D1ovwFVz3z6hGUc8MyrvJNBtgqYYtw83HG0bV7B9md9ha1gf7HK/6Imv
         R/Pgl4mflKOy9KdLnNTKpwh5NUplw3Ofa8B3F6oAR37tP+Oo82FEH4OhD9OM8aU2W8
         5yMoa7EowNmf33kyGrwJAdPr6JvrwzdrBVU18eZz2kJqdSi8GzL8+NN0zEkDHXHmBC
         IED3GN6EuMkbD4cH/su/u6xRetuZDN+T3hqr2Nm686yBB2omIYGna+Rm4rvMgCe/TH
         sHwj6Uwiwq3ww==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E4prd3320513;
        Wed, 3 Jul 2019 07:04:51 -0700
Date:   Wed, 3 Jul 2019 07:04:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-91de8684f1cff6944634bfb9098dc3a2583f798c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
        hpa@zytor.com, acme@redhat.com
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@redhat.com, hpa@zytor.com,
          acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20190622093248.581-3-adrian.hunter@intel.com>
References: <20190622093248.581-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Cater for CBR change in PSB+
Git-Commit-ID: 91de8684f1cff6944634bfb9098dc3a2583f798c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  91de8684f1cff6944634bfb9098dc3a2583f798c
Gitweb:     https://git.kernel.org/tip/91de8684f1cff6944634bfb9098dc3a2583f798c
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sat, 22 Jun 2019 12:32:43 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf intel-pt: Cater for CBR change in PSB+

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
@@ -1975,6 +1975,13 @@ next:
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
