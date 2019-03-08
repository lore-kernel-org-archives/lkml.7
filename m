Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E12C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070420840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYa66Co4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCHBVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:21:39 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41250 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCHBVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:21:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id x7so15089213eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 17:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3e8r997SVj6Bk98fluLQ6Q9vfMzZl7RrRmp0X+vjVzU=;
        b=KYa66Co4GwvcTRTys0OiuDHP7xrLPX7fW76XpBeNr3jRv4gpJWq/5gmAlDTWQec2kw
         9t+hDL7OTpvagXdWHAIi0zvvBSQxWY7DjSL5xkVegjWv+qLAGJAVsDGS4pgP6RCU1mDw
         YG3z25M4YLUMuVEgtFFgC8kxltLCMk4FiWzdlmgquqvO9NRX0yHyOF2fwERVVeqNAMLj
         vyKutxCQ/1tY/hy8PrfmJaP/oFx9FcJv1AizMNjMShAzmC8KEP9m30rb98AEHMyjiCmE
         VDwN5cR3PYJooewThPaKWFDoAR+e+cAQ0LULbknfIS2/t084SFGNjBXK97vncj600JNW
         tA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3e8r997SVj6Bk98fluLQ6Q9vfMzZl7RrRmp0X+vjVzU=;
        b=Z81pJ9DUjyeDODhMy0C7o9q65BlTcsEG4RsI/IXw5NW/22wLwLeE6NIqyPneVSnfth
         yff35/0ei9apPWdRzxU0USRw5txTKX60kY3pNpAMmq5whm1e61N1ht8rMUOsmtXtkNOT
         hI5kY2r4sOgH9NuZAPrnrVU9FO5ycvGnv3Os6wsL8HMHMwLZt7vf2c3qftNWNlbokqsr
         csRvjp6Niymk71gwHjkAeE9lWsNmtu5Ri+uU/5WJR4o4KfJcMC6ympWiotcXF9zdJxi+
         6C0uAiMjFaeiYX4ZBwUUS3Y0to1KxfA/4AX4vssd9ce7HrphzRUKaGp3RDj8XpVhaOQp
         We0A==
X-Gm-Message-State: APjAAAW2Rur1DsNm7a5EZkRfvVbSWQvumZ2SL9YW54MyiRL7XI9P9pFJ
        yBvU0Wa/oVaJPpoDvyUnOmA=
X-Google-Smtp-Source: APXvYqxf+zp1nno8wAmnvDbzj8mMrJ/KVm6GzTIdbm4o0QRFtEMNErFxFGoSg/uZBTxEBCqLH0GBWg==
X-Received: by 2002:a17:906:6c93:: with SMTP id s19mr9875481ejr.155.1552008096785;
        Thu, 07 Mar 2019 17:21:36 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id z42sm1813862edd.29.2019.03.07.17.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 17:21:36 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/i915: Zero initialize this_cpu in busywait_stop
Date:   Thu,  7 Mar 2019 18:20:24 -0700
Message-Id: <20190308012023.5709-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/gpu/drm/i915/i915_request.c:1032:6: warning: variable 'this_cpu'
is used uninitialized whenever '&&' condition is false
[-Wsometimes-uninitialized]

time_after expands to use two typecheck with logical ANDs between them.
typecheck evaluates to 1 but Clang clearly gets confused with the logic
that as semantic analysis happens early in the pipeline. Fix this by
just zero initializing this_cpu as it will always be properly
initialized before the comparison below.

Link: https://github.com/ClangBuiltLinux/linux/issues/415
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Alternatively, this can be solved by having the return value of
local_clock_us(&this_cpu) be a local variable but this seems less
controversial.

 drivers/gpu/drm/i915/i915_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index c2a5c48c7541..06c0c952191f 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -1027,7 +1027,7 @@ static unsigned long local_clock_us(unsigned int *cpu)
 
 static bool busywait_stop(unsigned long timeout, unsigned int cpu)
 {
-	unsigned int this_cpu;
+	unsigned int this_cpu = 0;
 
 	if (time_after(local_clock_us(&this_cpu), timeout))
 		return true;
-- 
2.21.0

