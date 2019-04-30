Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24989C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD02A20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625943;
	bh=ya6GRpK1Vdqvqwi237qfrqSuzkYU7ga6aG1xS75P/ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bKXcc5tOTZdyZsMkpTyv2z87/O4MrfgsMJrBrWp+CCfYBynkxzW3TCduWUDgmRXzV
	 Pp8QD56iD+w4CyZdsYrQW/lnpkQ9daUkW590FjQLvhgfZ+jVlhuULNC78L8XEVHnRp
	 ZB8buUL8EugQ50GWCtqvTp/3AjnaTe5BsrRL8MRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfD3Llx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbfD3Llu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:41:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7D52173E;
        Tue, 30 Apr 2019 11:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624510;
        bh=ya6GRpK1Vdqvqwi237qfrqSuzkYU7ga6aG1xS75P/ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riWVNTr286cot4igpcLNYpqOLP/mQaSPC20CxC7PWdEcRzxzLhhvC2zv2JgDoJ3Oe
         Oz5gO2YGz6FXrhyvn1LUF2LFD099WVviBd54J13sCf7y+5NucSpkK1jX3Kv7tTfcY5
         /yI32R37Uj49c0gjeljD+GsbtnOaYG29FiaOCmzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 4.14 20/53] drm/vc4: Fix memory leak during gpu reset.
Date:   Tue, 30 Apr 2019 13:38:27 +0200
Message-Id: <20190430113554.539482282@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113549.400132183@linuxfoundation.org>
References: <20190430113549.400132183@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

commit d08106796a78a4273e39e1bbdf538dc4334b2635 upstream.

__drm_atomic_helper_crtc_destroy_state does not free memory, it only
cleans it up. Fix this by calling the functions own destroy function.

Fixes: 6d6e50039187 ("drm/vc4: Allocate the right amount of space for boot-time CRTC state.")
Cc: Eric Anholt <eric@anholt.net>
Cc: <stable@vger.kernel.org> # v4.6+
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190301125627.7285-2-maarten.lankhorst@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_crtc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -867,7 +867,7 @@ static void
 vc4_crtc_reset(struct drm_crtc *crtc)
 {
 	if (crtc->state)
-		__drm_atomic_helper_crtc_destroy_state(crtc->state);
+		vc4_crtc_destroy_state(crtc->state);
 
 	crtc->state = kzalloc(sizeof(struct vc4_crtc_state), GFP_KERNEL);
 	if (crtc->state)


