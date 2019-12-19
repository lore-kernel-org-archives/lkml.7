Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2EFC2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2482465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781767;
	bh=TV7reKbOwC/Y7RHTX7qKGlBuIi38AILlTu9b0ggzADY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aPAfyJI/NMjTTVhfaS+HxaPGxQa15wnhyQYyMggjf87MtrfEAuwXUcIsmyXd4UTa0
	 q7yr4HNDoU73CJ+zwAyUZyd88hZeA8V8SSPsXgXuwJjUoOvcVhzV0hAwZsZROgpHYp
	 5eAukEKQ/Ca+QE/RI4eWeGbs0MkPKExkSlsUq+fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfLSS4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:56:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbfLSS4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:56:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C872465E;
        Thu, 19 Dec 2019 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781762;
        bh=TV7reKbOwC/Y7RHTX7qKGlBuIi38AILlTu9b0ggzADY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQQWg4Toge7/Pw0ATEpIGtDjGW+sVt1WVfuqdACCZ+3U01Bw+1Ek0heU6zCxlMHYV
         h6ZVzfdxXPlsvX91xoXf8eljz6tx6YyO6Zk2N3VSp9VL74SNzPFSShEtQhIP0DkGhl
         PLVP+I9a1SkxHTMCLdx5tKh03xpa51HYk8LfRT/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 5.4 69/80] drm/i915/fbc: Disable fbc by default on all glk+
Date:   Thu, 19 Dec 2019 19:35:01 +0100
Message-Id: <20191219183140.351406355@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 0eb8e74f7202a4a98bbc0c1adeed3986cf50b66a upstream.

We're missing a workaround in the fbc code for all glk+ platforms
which can cause corruption around the top of the screen. So
enabling fbc by default is a bad idea. I'm not keen to backport
the w/a so let's start by disabling fbc by default on all glk+.
We'll lift the restriction once the w/a is in place.

Cc: stable@vger.kernel.org
Cc: Daniel Drake <drake@endlessm.com>
Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191127201222.16669-2-ville.syrjala@linux.intel.com
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
(cherry picked from commit cd8c021b36a66833cefe2c90a79a9e312a2a5690)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/display/intel_fbc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -1284,7 +1284,7 @@ static int intel_sanitize_fbc_option(str
 		return 0;
 
 	/* https://bugs.freedesktop.org/show_bug.cgi?id=108085 */
-	if (IS_GEMINILAKE(dev_priv))
+	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
 		return 0;
 
 	if (IS_BROADWELL(dev_priv) || INTEL_GEN(dev_priv) >= 9)


