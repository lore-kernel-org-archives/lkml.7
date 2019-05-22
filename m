Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9812421773
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ0iQKw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfEVMjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:39:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38681 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:39:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id b76so1271638pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dc7HIox1GsMuz4SBq4z5Y4Rf5G0I0yZOZzYD3qgtYkk=;
        b=bJ0iQKw1WpVz5o+fAWQbVQTRvyqZj/6Mirn0lL9A+ptZB/CHbOT2FixTnj4fc/NfrK
         0JAhbnGR9zUz4Fo1hnQ+GrtTo7OEfzVNY36Fwan0FSE6Kc3c535Ny13OG4ZKPC2RJhKW
         UhEpSp+NxC41s4Y9m+5Re0Ain+tENvUL6HfhP44K/gZiahcp94gVoH49moHpv14ffiQM
         KX+A99qSVDYJGv1m0/JaC9ztwdqkmN6cLO87sVlG4hTTlulR1f4k8ouVCMxMeyoT/AaL
         ZH4ckKIkO96lt0dRYoNO2AfOLRCy2qHasKE5gTdRrjIm/1QLfnFIaYLlZCA7jZAJ1O0r
         oyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dc7HIox1GsMuz4SBq4z5Y4Rf5G0I0yZOZzYD3qgtYkk=;
        b=F1zDPHUdiJlrDvb/eB9RyZ/UdnmIftaQFdIZdLHnQK7FrFpaEMFIvr6atFuhbM96nd
         4f8P1X4UEPNCGfvgNc0JBJbVw3nX9uJRN+Vo1WRuqsk5dNj705WBVn4gTzh8uvi0XHd/
         M/PziBxfBOIt1IDQDN1UfvoEoroPtCYJEEvTu4bIu9buym7/cY9sWRZBgWAotUlX//U5
         /HijrmRco1FKBJOA5cErMj0cEe7M//ZAKUQyXZCN74axkFUZ5g6czqbTl3YKFudFsGap
         v/1oWMUAs66lAxPYJO/WuzjRVwIT5WCwqca9pdrIyDrklDU8OnpB1hHHFgO2q/lBWin7
         qmHQ==
X-Gm-Message-State: APjAAAVPm6ZLbps3AjOtGLJOxewUqZZB0cdcACPyoJT34TWX3cra2FBX
        M/Jw+KKZSj+3flyGOrkxlHxhgRYsO/2TyA==
X-Google-Smtp-Source: APXvYqxqnL4m4W21i3wMRJGnCrMhpbAjue2VzlAFhr3P/pr64Je+zpBUV1ERw25chi2BkyvOo31N9w==
X-Received: by 2002:a62:164f:: with SMTP id 76mr96965718pfw.172.1558528775567;
        Wed, 22 May 2019 05:39:35 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id p16sm7830380pff.35.2019.05.22.05.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:39:35 -0700 (PDT)
Date:   Wed, 22 May 2019 20:39:20 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     sean@poorly.run
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm_edid-load: Fix a missing-check bug in
 drivers/gpu/drm/drm_edid_load.c
Message-ID: <20190522123920.GB6772@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drm_load_edid_firmware(), fwstr is allocated by kstrdup(). And fwstr
is dereferenced in the following codes. However, memory allocation 
functions such as kstrdup() may fail and returns NULL. Dereferencing 
this null pointer may cause the kernel go wrong. Thus we should check 
this kstrdup() operation.
Further, if kstrdup() returns NULL, we should return ERR_PTR(-ENOMEM) to
the caller site.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
index a491509..a0e107a 100644
--- a/drivers/gpu/drm/drm_edid_load.c
+++ b/drivers/gpu/drm/drm_edid_load.c
@@ -290,6 +290,8 @@ struct edid *drm_load_edid_firmware(struct drm_connector *connector)
 	 * the last one found one as a fallback.
 	 */
 	fwstr = kstrdup(edid_firmware, GFP_KERNEL);
+	if (!fwstr)
+		return ERR_PTR(-ENOMEM);
 	edidstr = fwstr;
 
 	while ((edidname = strsep(&edidstr, ","))) {
---
