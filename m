Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9719920830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256599;
	bh=keZPob0LfMUmmYsdhVaKAuvNoAflxEJfpZDXv3I0eTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSnW9JnSTl+NX0tCHeW8i9JzspYfuSKO+V21GAhVZKdVzN0CuYAfJipCnfitVrTjG
	 9pjfZVDASdyzplsExAxfvhpypd0XjA5mOFo6GzVk9ar5MIi1uFTVGUGOD84XcMm8k+
	 7fSAEDyX+YkfbuLQRwEM7KCVioX2ow29YG7Vzbfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfCVMJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389394AbfCVMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CF92082C;
        Fri, 22 Mar 2019 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256590;
        bh=keZPob0LfMUmmYsdhVaKAuvNoAflxEJfpZDXv3I0eTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1b6csUn2lquHAAvaqeCVqhaPD1Fk0bu+CgWDOzDRbk11Pau4nnccGMG57IbBE8nD
         A9fE1FPrDmSHVfn8BYXQUGQWfucSzVt2B3jrGjzGxa++ESaKVaD5Xqscr4A3jV0En8
         7x/MOH+iJ/Ovq5ThY/rgoqxURvE/BKZqRarMFrN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 258/280] perf intel-pt: Fix divide by zero when TSC is not available
Date:   Fri, 22 Mar 2019 12:16:51 +0100
Message-Id: <20190322111343.454235928@linuxfoundation.org>
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
@@ -2507,6 +2507,8 @@ int intel_pt_process_auxtrace_info(union
 	}
 
 	pt->timeless_decoding = intel_pt_timeless_decoding(pt);
+	if (pt->timeless_decoding && !pt->tc.time_mult)
+		pt->tc.time_mult = 1;
 	pt->have_tsc = intel_pt_have_tsc(pt);
 	pt->sampling_mode = false;
 	pt->est_tsc = !pt->timeless_decoding;


