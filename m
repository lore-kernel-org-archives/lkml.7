Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F247EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B857221917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257282;
	bh=oloJtzE09vzllUXRSEmWMfk+TzoHxJmzOqAggmADqZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/ocbiPQRWiGbRzrOWxs6DCQNmJI1QqyKQ8z2bDPsiW81RvsVx2rxVPrr0bKlrn26
	 nMD7kb2ktgUku0HzCqqbIXLfP81lw32UuBdnXPX1goKY+XJJirLiHAfp0xWfC0ysPF
	 kMHTqGDK+sMu6jJmjXIznUT2gJmQEA31y5OQz1j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390857AbfCVMVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390846AbfCVMVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB0E2054F;
        Fri, 22 Mar 2019 12:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257276;
        bh=oloJtzE09vzllUXRSEmWMfk+TzoHxJmzOqAggmADqZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LyUYgvL9tqTxUkhrTXAFJMj2et81gD3DlePg836mesMxFzGjBB5C3VysLo6pp99l4
         yGyG8mkOXRlIwboer8bcJT0GxdbUdAK2v60x3Md6R4DeEMtAMxjNSQDpTbWTiyB9Kr
         W9KItz48uQ48P5ke3JryXJS1E5eBffeJcvPfp3j8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.0 183/238] cpuidle: governor: Add new governors to cpuidle_governors again
Date:   Fri, 22 Mar 2019 12:16:42 +0100
Message-Id: <20190322111309.068955453@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 22782b3f9bb8ae21c710e2880db21bc729771e92 upstream.

After commit 61cb5758d3c4 ("cpuidle: Add cpuidle.governor= command
line parameter") new cpuidle governors are not added to the list
of available governors, so governor selection via sysfs doesn't
work as expected (even though it is rarely used anyway).

Fix that by making cpuidle_register_governor() add new governors to
cpuidle_governors again.

Fixes: 61cb5758d3c4 ("cpuidle: Add cpuidle.governor= command line parameter")
Reported-by: Kees Cook <keescook@chromium.org>
Cc: 5.0+ <stable@vger.kernel.org> # 5.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/governor.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -89,6 +89,7 @@ int cpuidle_register_governor(struct cpu
 	mutex_lock(&cpuidle_lock);
 	if (__cpuidle_find_governor(gov->name) == NULL) {
 		ret = 0;
+		list_add_tail(&gov->governor_list, &cpuidle_governors);
 		if (!cpuidle_curr_governor ||
 		    !strncasecmp(param_governor, gov->name, CPUIDLE_NAME_LEN) ||
 		    (cpuidle_curr_governor->rating < gov->rating &&


