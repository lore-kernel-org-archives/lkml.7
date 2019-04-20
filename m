Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD11C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98D720859
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555720120;
	bh=f1VkJviQAG6FszlGMvJzC9sdEL4MZyZ8wPNOAFjLH00=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=UlCnGWIKOgABOyq0zMLOvDCwk2efTVuM4LPViVZGxBjHbE7fy1gx2AAaa5Njk77xX
	 x8+Y6bP14IEFkdm90kTeqtBys+NbgW5LMr1p+WA0GyBqgeLJcbdnx81J7IMobpbMIl
	 Pjjv+L5oQhEaArIVn9rLc+J3VKGsJTR98ce2cgfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfDTA2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:28:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:32937 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDTA2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:28:38 -0400
Received: by mail-yw1-f65.google.com with SMTP id l5so2406359ywa.0;
        Fri, 19 Apr 2019 17:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=whM287JCYRLKjBUtoh/GKWmrgoB+ad0LTio69nyTqYU=;
        b=sYQ21R2lr6tXtIJkDpuTpN2tO2/MTL4ii3ThQAIVlgKQEovrSC7Jm+mQOnpHAcgQsK
         SMskNuaol0CtSLXyldsY8iOWusbwYuSRdCh+2aqgLv1xNC2Ro/lQFqjD8EwZvwq5FBFv
         aLRCDr5BuhM5YkTPNDCx9toYAi9/yT2SXxjR1EVvprVO2xASE4dGn4nCVxvF9LgDCT5m
         xaOVXFCpMlhvGCM2APJs4E9kofjI+wA7fwrxsBk5ADRNzWolVyEsh7QqR2+El04Lylx1
         TIiquBSb9L5Xav/SkmVaqbcZ39hHXVQB9DP3JsiMJrKOmSqPrnwzwC4V6v3EJ+rKGvXT
         imZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=whM287JCYRLKjBUtoh/GKWmrgoB+ad0LTio69nyTqYU=;
        b=WOtcbl7HQu/aqS5bhq8ZLgzHSXZ09lDtxZErEouaW1zmyk1HXCI+r96MtwGBe8wEiI
         Bhe1ZbGnHSqKUP4TU16+cGelwdoVVsgDBvYRTOSOxlpCvcoMZWUQuopMhisbAdo5y2Xf
         Ds0YEdh0jcs0x0B7X/M/QcXmcDonbdHActEOTKTfUZJREJjzYByed7eY77MvQ5FMeFPL
         exDamnG5ar4OfKlzQ9MfbdBRx70oaCinpYBnzS73eWhkYY3p+/wEOIErk42Gy2Up04TP
         CEATLqmixZNnvGjo/iwYjCLHiP9DFPRSPjrxgN1m7nkTCXRDcXmqgnzV5iEdnauO1jLb
         K4Sg==
X-Gm-Message-State: APjAAAUzByAb/juC/Jb/s1CHeYwwo3H0ntu3I0fzjy4Eo6p2JnkVWvzk
        Ll9j1lZfcfuSv00n5OCzJco=
X-Google-Smtp-Source: APXvYqzv0UwzPY+T4RJVm5G//d1Wqr9RgZekwIebLKLd8zWLIyV5f+wicb8NTc6JqKnOCy7glYXKRQ==
X-Received: by 2002:a81:6957:: with SMTP id e84mr5416848ywc.503.1555720117642;
        Fri, 19 Apr 2019 17:28:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::2f7e])
        by smtp.gmail.com with ESMTPSA id v144sm2508824ywc.37.2019.04.19.17.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 17:28:36 -0700 (PDT)
Date:   Fri, 19 Apr 2019 17:28:34 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fix for v5.1-rc5
Message-ID: <20190420002834.GJ374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

A patch to fix a RCU imbalance error in the devices cgroup
configuration error path.

Thanks.

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.1-fixes

for you to fetch changes up to 0fcc4c8c044e117ac126ab6df4138ea9a67fa2a9:

  device_cgroup: fix RCU imbalance in error case (2019-03-19 10:46:15 -0700)

----------------------------------------------------------------
Jann Horn (1):
      device_cgroup: fix RCU imbalance in error case

 security/device_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index cd97929fac66..dc28914fa72e 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -560,7 +560,7 @@ static int propagate_exception(struct dev_cgroup *devcg_root,
 		    devcg->behavior == DEVCG_DEFAULT_ALLOW) {
 			rc = dev_exception_add(devcg, ex);
 			if (rc)
-				break;
+				return rc;
 		} else {
 			/*
 			 * in the other possible cases:

-- 
tejun
