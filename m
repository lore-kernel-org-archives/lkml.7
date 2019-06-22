Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E914C48BE3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E873120645
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfLabKRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfFVAey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:34:54 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:49019 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfFVAey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:34:54 -0400
Received: by mail-vk1-f202.google.com with SMTP id f184so3066496vkd.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KfmaNk0Eu1BHVI+WPNp421IderZkjqwVQ/bXD2IsfF8=;
        b=NfLabKRBPTogQTjXkgamtEim4i76vkVJwx83MWI3SCzeuWvF9TwwKaNDvMPurCPAjR
         +talnPvE7Lku2Pcox/DE0vrSCLDWOWksEpLBWnTeyFb+m2DUXjNsclsDPld122aYvVoh
         P91Yed+76BhBWM7O3oOPV25IDxHfWP0qfh+npG1V856TUCIRmN4sXt63vLOTVt2JyTBr
         ymMAmaPC9t+TnkfT4CAl5fd36UWAd/JKKxHHkZJXq3uOFuW2JbGF2oiP8wVxO2VHZTvj
         jShcAjhAr4uQj7HtBG6/PFiaOAJJIbM9PG7kfaeTuUl1SBnkI/Dd2KqWgpbypE/RXAIu
         QmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KfmaNk0Eu1BHVI+WPNp421IderZkjqwVQ/bXD2IsfF8=;
        b=TzutOVcfBEYDV0Vho++7s75Rxt3Ao8JW+biScuHGdpHXr3Cuu29L/sZLa825sT27Lo
         JQXiP0nS1VnmJYZPa7BfzwpfrRwkBNAcLSU89M5sRyrO8tvIek5iGLwdeUo8RfOmLCZy
         u9xuRIAakJj3z1c5krNzx5epSzb25Q9G/zJ5lLhtLpB/DpGlQ0xHikNohjZ7o87OLfSC
         GaA6f9nBBOiEDJUfVNeU+HuERlRHZFoWeyGAUQY1oQEFGUcJtN4bCNKi0Pn0RpSBcfWx
         e1zLYPy6fB5JuwIS0V6LnJ7MLpNaOhVumNtIVNLpdRVQVWXHpw7dPfdiPm6ZsbuKBM+0
         kN3A==
X-Gm-Message-State: APjAAAV6vHc0fLZD6PwkIQzBAiCZJhRhcsjVGBVjfacSIw84VkJgUXn+
        pDuvgsYkPOuGxeBFM1DvuFqzMOVS3WTZcNc=
X-Google-Smtp-Source: APXvYqxI0kCH/VP1Tj1BapDK721tlVshuyp1M7qa5xUpC1IcNzSxjKfvyULOjetXxfShkRYS5JKc0oVN8dcjsKo=
X-Received: by 2002:a1f:2b07:: with SMTP id r7mr30702582vkr.65.1561163693358;
 Fri, 21 Jun 2019 17:34:53 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:34:45 -0700
Message-Id: <20190622003449.33707-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq passive governor scales the frequency of a "child" device
based on the current frequency of a "parent" device (not parent/child in
the sense of device hierarchy). As of today, the passive governor
requires one of the following to work correctly:
1. The parent and child device have the same number of frequencies
2. The child device driver passes a mapping function to translate from
   parent frequency to child frequency.

When (1) is not true, (2) is the only option right now. But often times,
all that is required is a simple mapping from parent's frequency to
child's frequency.

Since OPPs already support pointing to other "required-opps", add
support for using that to map from parent device frequency to child
device frequency. That way, every child device driver doesn't have to
implement a separate mapping function anytime (1) isn't true.

-Saravana

Saravana Kannan (3):
  OPP: Allow required-opps even if the device doesn't have power-domains
  OPP: Add function to look up required OPP's for a given OPP
  PM / devfreq: Add required OPPs support to passive governor

 drivers/devfreq/governor_passive.c | 25 +++++++++++--
 drivers/opp/core.c                 | 56 +++++++++++++++++++++++++++++-
 drivers/opp/of.c                   | 14 --------
 include/linux/pm_opp.h             | 11 ++++++
 4 files changed, 89 insertions(+), 17 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

