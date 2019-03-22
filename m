Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2724FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D804721873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259532;
	bh=/bxKasrk56/cEv5icFThI/bb1hqLpOrooqE+0iF7PBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h96Xn4D2HYp+r6KHjmSnWXCTLSL8qmLdcVlsm4DRNk5yOgJjDmfgVXIuL5aCqs/YI
	 XjbBo31DIdlazNKh1aN+TWRZp7ELP5wq+hiOAs9qqq+o2nTJjU/7MKUPjI1TSgbdmO
	 GbWWNTZYIUCVP+JXnki3m+OY/d2lbHCjKZuGs1zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfCVM6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbfCVLqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D827A218B0;
        Fri, 22 Mar 2019 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255163;
        bh=/bxKasrk56/cEv5icFThI/bb1hqLpOrooqE+0iF7PBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lps54ruj5WGddl9UXfFMtRtc5UDr7gjvKkfnDah+00gTF0ePR00m8V7Amc8Miiipt
         fG3UPZtK4fyFqcJOQjeOap4bIaI3pmV6br0LFjKw/VCtwI/wDYpUT66ZxMbqWJ0PVC
         zLkR5N7R+cm1s5u9kMFXzLdmdzanFFOYtXQJ7lZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 108/118] perf intel-pt: Fix CYC timestamp calculation after OVF
Date:   Fri, 22 Mar 2019 12:16:20 +0100
Message-Id: <20190322111223.957271731@linuxfoundation.org>
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
@@ -1311,7 +1311,6 @@ static int intel_pt_overflow(struct inte
 {
 	intel_pt_log("ERROR: Buffer overflow\n");
 	intel_pt_clear_tx_flags(decoder);
-	decoder->cbr = 0;
 	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;


