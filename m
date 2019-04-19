Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD71C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EBD21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555709365;
	bh=2I4GhElLMoKoq3btUbEjrYOSkBQpe94fF99hIaPHHTc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=t7hUFjBOBGAgnJfrwx3oj2m2O655rWptf5VWVJajt4/sbE6ZMbdSp0XyebP2Y6hM3
	 VLUgmsX4DxBNzaubNuvLvrzxTRIbNfjbDDrLw6e1lNbmX8MdjN0hu6XmsN0yj2bYDB
	 quIiywGWb7djdCvHelRihLGhVFfpQ+tAnWpyDIaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfDSV3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:29:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39775 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:29:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so3016726pgj.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JMqGq5BV59AptRGsupzRON9Eb4IfgADF4oTkTUkl3S0=;
        b=G4HYJ+KgBi6IAQiZUlzlIKniPVdVfWU9ZsY2BrbwVbLO+oohcAcAjKDlOwUMreTBJq
         iz72OBAogfLhFMiDuGtv71TUYOoeln7J4K0lKtTXCeRdaHbzTgLH0DjwBIitb/M09Wfn
         0iHBRdDxf69RKuftcrisUkzUmqF7Mmn0Z3QMmoYudgIodxFNn2s/kWIE4PRwmRHViPHC
         8bmPY9OMJgfZ4NyHcjiOen6DFHOR5Pko8Y8zZQgy29ac4eKg6OEIcqKqaN3jOLuqZ594
         B3GKVbyr4BZ+ATnJG6Prcut+btQwWVrz2J2zowOadzqmL4bV0HBWezb2lbNOoBxr1pDv
         d1HA==
X-Gm-Message-State: APjAAAVnQLKcUrrFuhmje/41CCjPmnTnqivHOucb3unYuvod8PSxn0Of
        XmWbNbgxTN2Zk5zxqgrL2Ms=
X-Google-Smtp-Source: APXvYqxWbwG0bHvvMG4ozEUcUZHTm9+qkxcXZcXUC5qCfa5pjecaeyvPivKyfiWetldcTd9493aqfQ==
X-Received: by 2002:a65:4048:: with SMTP id h8mr5909350pgp.6.1555709363176;
        Fri, 19 Apr 2019 14:29:23 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::3:fab])
        by smtp.gmail.com with ESMTPSA id v189sm8371850pgd.77.2019.04.19.14.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:29:22 -0700 (PDT)
Date:   Fri, 19 Apr 2019 17:29:18 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.1-rc6
Message-ID: <20190419212918.GA12787@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This stops printing the base address of percpu memory on initialization.

Thanks,
Dennis

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.1-fixes

for you to fetch changes up to 00206a69ee32f03e6f40837684dcbe475ea02266:

  percpu: stop printing kernel addresses (2019-03-18 10:36:36 -0700)

----------------------------------------------------------------
Matteo Croce (1):
      percpu: stop printing kernel addresses

 mm/percpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 2e6fc8d552c9..68dd2e7e73b5 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2567,8 +2567,8 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 		ai->groups[group].base_offset = areas[group] - base;
 	}
 
-	pr_info("Embedded %zu pages/cpu @%p s%zu r%zu d%zu u%zu\n",
-		PFN_DOWN(size_sum), base, ai->static_size, ai->reserved_size,
+	pr_info("Embedded %zu pages/cpu s%zu r%zu d%zu u%zu\n",
+		PFN_DOWN(size_sum), ai->static_size, ai->reserved_size,
 		ai->dyn_size, ai->unit_size);
 
 	rc = pcpu_setup_first_chunk(ai, base);
@@ -2692,8 +2692,8 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 	}
 
 	/* we're ready, commit */
-	pr_info("%d %s pages/cpu @%p s%zu r%zu d%zu\n",
-		unit_pages, psize_str, vm.addr, ai->static_size,
+	pr_info("%d %s pages/cpu s%zu r%zu d%zu\n",
+		unit_pages, psize_str, ai->static_size,
 		ai->reserved_size, ai->dyn_size);
 
 	rc = pcpu_setup_first_chunk(ai, vm.addr);
