Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2BBC4D2E1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116AF24815
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fi8pocFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfLMUFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:05:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35731 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfLMUFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:05:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so80144qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AGxRnEh5CXFWXGLun9RvFBMrbc3Csuo1hFkC8taJ9Ao=;
        b=fi8pocFAG1MtH+wrS/RwicUEW6vUdIGEjPL2lsSHOLPBs6UThnygqIyuQc95xton9e
         Yxoneci0+u6nu3ovdvs2nwA6RCfIMHAvQP7WkJLiEs9uazqRsxy1GzWplPGcynkU2vEK
         m7juwjZ8BwyfJRwNzTstai0DRHVpUgvjzk1Q5uqS/8LJE0nHMg3ldrRcWLKuHAHLT9dG
         VlArpH8BK+h7UwtXjWpyLxEFn8kV0wny/tRfB8fOru0yd0avuJOpcJRwpsLKPK0y/1/z
         q1OAdPQzLYkV9FLa/Gez/xOtKcg1Uv+ldtQ5Z2yWXT1+Sl1YJ5Vol1E4IiG9H3W6XsSS
         WQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AGxRnEh5CXFWXGLun9RvFBMrbc3Csuo1hFkC8taJ9Ao=;
        b=am+Mz0aldLp0ukkWdwSEn1eKevpeu9oHerfuCIGyWoDaSzOSS5jW3+k+UFO8yxIn9k
         qIxeunNv1o6dfvrlGO86koAKtxx9WGX99/P+vOIQFsnCWm+w/KvjqnT1oi6p9Fj+wI30
         LydM/IAdzCVFQpJsaLBHS4uSaeWIOhQ+6P5j6ugXE3jHuF2HSJ25K8eEr7SUU8M95kTw
         HqzjLvEoZJ2Q+4srNMJARiHoTdE90mfIsoaTBsmtzi9zpAHLmCzLtsIS2NZqlkX2vhJ+
         iJ8Y/tONAr7dICY/IN9cE0u3rIvFjSy0T1jgXfCNi3dI5RCRfnJwhrT7eMrBTMYzWXCe
         bdbA==
X-Gm-Message-State: APjAAAVErmsltRchHa3EPgs+RnN752Ler8f5Qa8/kcItfJsFzW6QtLqY
        zQkPPu21q7gIZee/5myJUcua6Q==
X-Google-Smtp-Source: APXvYqyt8/F7dcovN6ml4CYTmL9Z4Gv+D5IHB1cNmx/2gV7w9evyzyCC0M4BYf6Eo/p0Bvy7I4PQQA==
X-Received: by 2002:aed:24ec:: with SMTP id u41mr4951304qtc.220.1576267520991;
        Fri, 13 Dec 2019 12:05:20 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id f23sm3092385qke.104.2019.12.13.12.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 12:05:20 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:05:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20191213200519.GA168988@cmpxchg.org>
References: <20191213192158.188939-1-hannes@cmpxchg.org>
 <20191213192158.188939-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213192158.188939-4-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 02:21:58PM -0500, Johannes Weiner wrote:
> +	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT) {
> +		unsigned long unclaimed;
> +		/*
> +		 * If the children aren't claiming (all of) the
> +		 * protection afforded to them by the parent,
> +		 * distribute the remainder in proportion to the
> +		 * (unprotected) size of each cgroup. That way,
> +		 * cgroups that aren't explicitly prioritized wrt each
> +		 * other compete freely over the allowance, but they
> +		 * are collectively protected from neighboring trees.
> +		 *
> +		 * We're using unprotected size for the weight so that
> +		 * if some cgroups DO claim explicit protection, we
> +		 * don't protect the same bytes twice.
> +		 */
> +		unclaimed = parent_effective - siblings_protected;
> +		unclaimed *= usage - protected;
> +		unclaimed /= parent_usage - siblings_protected;

Brainfart I noticed just after sending it out - naturally. If there is
unclaimed protection in the parent, but the children use exactly how
much they claim, this will div0. We have to check for usage that isn't
explicitly protected in the child to which to apply the float. Fixlet
below. Doesn't change the overall logic, though.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2e352cd6c38d..8d7e9490740b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6328,21 +6328,24 @@ static unsigned long effective_protection(unsigned long usage,
 	 */
 	ep = protected;
 
-	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT) {
+	/*
+	 * If the children aren't claiming (all of) the protection
+	 * afforded to them by the parent, distribute the remainder in
+	 * proportion to the (unprotected) size of each cgroup. That
+	 * way, cgroups that aren't explicitly prioritized wrt each
+	 * other compete freely over the allowance, but they are
+	 * collectively protected from neighboring trees.
+	 *
+	 * We're using unprotected size for the weight so that if some
+	 * cgroups DO claim explicit protection, we don't protect the
+	 * same bytes twice.
+	 */
+	if (!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT))
+		return ep;
+
+	if (usage > protected && parent_effective > siblings_protected) {
 		unsigned long unclaimed;
-		/*
-		 * If the children aren't claiming (all of) the
-		 * protection afforded to them by the parent,
-		 * distribute the remainder in proportion to the
-		 * (unprotected) size of each cgroup. That way,
-		 * cgroups that aren't explicitly prioritized wrt each
-		 * other compete freely over the allowance, but they
-		 * are collectively protected from neighboring trees.
-		 *
-		 * We're using unprotected size for the weight so that
-		 * if some cgroups DO claim explicit protection, we
-		 * don't protect the same bytes twice.
-		 */
+
 		unclaimed = parent_effective - siblings_protected;
 		unclaimed *= usage - protected;
 		unclaimed /= parent_usage - siblings_protected;
