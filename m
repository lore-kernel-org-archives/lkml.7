Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C690EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9491B2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256577;
	bh=+6pL2mci+WZBRm7pQDorhNLTQuC1gmAQAsAo/gHV4SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ScwU2B7KQF+bED+HjX4RZRjW7IUo1qzkp1/RgK6asicZfPn2O5j1v+hLhrMPfn5Zd
	 e2Ace3NFlsSxovYh3cYLA1lTFB8xTkR2vFkKbfQZ5pXCf4pXfYTa1YYV0Nd5FyZ1Ya
	 K4+JTJp614vTSFRWM4kwihyNY6m1dF/30opsoReg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbfCVMJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388867AbfCVMJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C732083D;
        Fri, 22 Mar 2019 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256572;
        bh=+6pL2mci+WZBRm7pQDorhNLTQuC1gmAQAsAo/gHV4SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2is2pPpopWMAyp9neNVtBAhYa1lbFKjhrFkEg63Pco136esXabMZ+OYzlqVqcZWJ
         L7/W4wT3GxZLRI6nX7tKzSKDB9zQ6F/X6xi2HmRA/MIIagp/XxUBUDxFqKtXW3ZDRk
         FhRSxDjGSwie3Sj9qQCfk07e+1M43G5+Miui30OM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 253/280] perf intel-pt: Fix CYC timestamp calculation after OVF
Date:   Fri, 22 Mar 2019 12:16:46 +0100
Message-Id: <20190322111342.173729808@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 03997612904866abe7cdcc992784ef65cb3a4b81 upstream.

CYC packet timestamp calculation depends upon CBR which was being
cleared upon overflow (OVF). That can cause errors due to failing to
synchronize with sideband events. Even if a CBR change has been lost,
the old CBR is still a better estimate than zero. So remove the clearing
of CBR.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190206103947.15750-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |    1 -
 1 file changed, 1 deletion(-)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1389,7 +1389,6 @@ static int intel_pt_overflow(struct inte
 {
 	intel_pt_log("ERROR: Buffer overflow\n");
 	intel_pt_clear_tx_flags(decoder);
-	decoder->cbr = 0;
 	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;


