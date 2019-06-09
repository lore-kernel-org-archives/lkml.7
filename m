Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE7C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3214B2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098806;
	bh=OK7EWTbn8Om3st0DiKNvyrQVX5gn2/m3sVGEgi1p1iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cOJsALLz8IJAkdIR8hFIIFxXpJvGtSap32a1F8ExhwWa4A/8LJx6SOEPmpICdg+KX
	 gPrLPB+6lbYqQxHjrQS2htit+EY80AOY+kGsQkmqmenNLREiXshjFOOnShX2irmTkl
	 itSrs7BRXxY9DHmmaoNNLAbSDbSkjjMWIgmQM7a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfFIQqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfFIQqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:46:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3AB2081C;
        Sun,  9 Jun 2019 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098802;
        bh=OK7EWTbn8Om3st0DiKNvyrQVX5gn2/m3sVGEgi1p1iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzkwctIxrhCQEUNVEKofy80pWoHsQX/s4rROpW2PAEr1heB2HTKfLs/h2+ki2ndKB
         adt8eZuLnHxL2/Kcyldp5NhF2/OKncFKJ4WX2AgUJ5oqGSZCTqCadE8gbKBXkfNNY5
         4VrEWc7gy8NHkj27DW5r69IOPFb9Owzducfs3Tug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>,
        Weinan <weinan.z.li@intel.com>
Subject: [PATCH 5.1 65/70] drm/i915/gvt: emit init breadcrumb for gvt request
Date:   Sun,  9 Jun 2019 18:42:16 +0200
Message-Id: <20190609164132.883538914@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weinan <weinan.z.li@intel.com>

commit a8c2d5ab9e71be3f9431c47bd45329a36e1fc650 upstream.

"To track whether a request has started on HW, we can emit a breadcrumb at
the beginning of the request and check its timeline's HWSP to see if the
breadcrumb has advanced past the start of this request." It means all the
request which timeline's has_init_breadcrumb is true, then the
emit_init_breadcrumb process must have before emitting the real commands,
otherwise, the scheduler might get a wrong state of this request during
reset. If the request is exactly the guilty one, the scheduler won't
terminate it with the wrong state. To avoid this, do emit_init_breadcrumb
for all the requests from gvt.

v2: cc to stable kernel

Fixes: 8547444137ec ("drm/i915: Identify active requests")
Cc: stable@vger.kernel.org
Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Weinan <weinan.z.li@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/scheduler.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -298,12 +298,31 @@ static int copy_workload_to_ring_buffer(
 	struct i915_request *req = workload->req;
 	void *shadow_ring_buffer_va;
 	u32 *cs;
+	int err;
 
 	if ((IS_KABYLAKE(req->i915) || IS_BROXTON(req->i915)
 		|| IS_COFFEELAKE(req->i915))
 		&& is_inhibit_context(req->hw_context))
 		intel_vgpu_restore_inhibit_context(vgpu, req);
 
+	/*
+	 * To track whether a request has started on HW, we can emit a
+	 * breadcrumb at the beginning of the request and check its
+	 * timeline's HWSP to see if the breadcrumb has advanced past the
+	 * start of this request. Actually, the request must have the
+	 * init_breadcrumb if its timeline set has_init_bread_crumb, or the
+	 * scheduler might get a wrong state of it during reset. Since the
+	 * requests from gvt always set the has_init_breadcrumb flag, here
+	 * need to do the emit_init_breadcrumb for all the requests.
+	 */
+	if (req->engine->emit_init_breadcrumb) {
+		err = req->engine->emit_init_breadcrumb(req);
+		if (err) {
+			gvt_vgpu_err("fail to emit init breadcrumb\n");
+			return err;
+		}
+	}
+
 	/* allocate shadow ring buffer */
 	cs = intel_ring_begin(workload->req, workload->rb_len / sizeof(u32));
 	if (IS_ERR(cs)) {


