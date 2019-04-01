Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB9CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEF221852
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139059;
	bh=eQIqaQ2N6YliSGFm8UsU8VPSDc2teTIggXS8kX4f+Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dqhLaI9Fw2suro2sSfvvktnVbBaI9ivJH+jWVdq0+hWILe44Cj/zOB3P8phgqizhq
	 wawWPayYudWhdQjxiEDAefOql0cz+MjnvuiBo1hXHkCNrXEuISkmVtdiZN7nafFy2Q
	 0qm5rvlxslL9nj1HxU+rcVpv48zcJ5fY2j4G3gm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfDARRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbfDARRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2D820856;
        Mon,  1 Apr 2019 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139053;
        bh=eQIqaQ2N6YliSGFm8UsU8VPSDc2teTIggXS8kX4f+Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1hU8TUNQpwitP94F9l0y4ezPEuo5e0EtVbuIHFM/dSdkd5hrKkbvvTuvdBKfQ2B54
         txKY3pF/DNE6PQziR1mNw9eVce9bnlXIJ7UZbL+z3bE+rLGtEM9hoZuea1P8QqiBLW
         E2zQus331Q1ra3bcl+yAZ24uX7nY7eSJl7yQZY5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4.19 099/134] drm/i915/gvt: Fix MI_FLUSH_DW parsing with correct index check
Date:   Mon,  1 Apr 2019 19:02:15 +0200
Message-Id: <20190401170053.517080312@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Zhenyu Wang <zhenyuw@linux.intel.com>

commit 13bcb80b7ee79431fce361e060611134cb19e209 upstream.

When MI_FLUSH_DW post write hw status page in index mode, the index
value is in dword step and turned into address offset in cmd dword1.
As status page size is 4K, so can't exceed that.

This fixed upper bound check in cmd parser code which incorrectly
stopped VM for reason of invalid MI_FLUSH_DW write index.

v2:
- Fix upper bound as 4K page size because index value is address offset.

Fixes: be1da7070aea ("drm/i915/gvt: vGPU command scanner")
Cc: stable@vger.kernel.org # v4.10+
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/cmd_parser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gvt/cmd_parser.c
+++ b/drivers/gpu/drm/i915/gvt/cmd_parser.c
@@ -1446,7 +1446,7 @@ static inline int cmd_address_audit(stru
 	}
 
 	if (index_mode)	{
-		if (guest_gma >= I915_GTT_PAGE_SIZE / sizeof(u64)) {
+		if (guest_gma >= I915_GTT_PAGE_SIZE) {
 			ret = -EFAULT;
 			goto err;
 		}


