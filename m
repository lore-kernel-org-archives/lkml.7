Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A46C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800EE20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="j6g7GnrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfJNR4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:56:37 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:28741 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728941AbfJNR4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:56:36 -0400
X-Greylist: delayed 1829 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Oct 2019 13:56:36 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 13E5F22EAD61
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:11:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id K3sDi8K823Qi0K3sDieARx; Mon, 14 Oct 2019 12:11:09 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jdPJLE9uakC1IcaYe4Xs+2uSSvoL2LQkYqUnRFzxWD0=; b=j6g7GnrEdMSGNbn6ehA/rSy+Z+
        3NP4XZzlDlhr8AOx5eBxLBaz/W+o6ebdeyHHBp1rpS58e4oB+JZvUmd7xQydc8ynJaeOXgg2uXA9N
        d9ehUFUdP51uD4VX8UWfzu7aSBZw52gTKHsMoZp4uGPcKVsoNse7B7e9qbb/Dv2fbsLnK3TZ8xcSI
        3k2tCISGmIU/lQvmmEehR5BCaM38CwJ5mGTSjaLEKTn/EB1b1Jn2Dx0Bm+dDmt41BEQJhLn/3CF9E
        6UnuO9nWP288wg6nCbGzHYLIFYzXXC7Sy2UplnwYMJuDw2rxRIrhri+bUmTU3kgj6rFwOKfm2chiB
        yxJwsH2A==;
Received: from [187.192.22.73] (port=48054 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iK3sB-004E34-Je; Mon, 14 Oct 2019 12:11:07 -0500
Date:   Mon, 14 Oct 2019 12:10:47 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] perf annotate: Fix multiple memory and file descriptor leaks
Message-ID: <20191014171047.GA30850@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.22.73
X-Source-L: No
X-Exim-ID: 1iK3sB-004E34-Je
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.22.73]:48054
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF in variable *ret*, instead
of returning in the middle of the function and leaking multiple
resources: prog_linfo, btf, s and bfdf.

Addresses-Coverity-ID: 1454832 ("Structurally dead code")
Fixes: 11aad897f6d1 ("perf annotate: Don't return -1 for error when doing BPF disassembly")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4036c7f7b0fb..e42bf572358c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1758,7 +1758,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
 						 dso->bpf_prog.id);
 	if (!info_node) {
-		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
 	}
 	info_linear = info_node->info_linear;
-- 
2.23.0

