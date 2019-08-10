Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F28C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E792166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhEV4lP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfHJHth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:49:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46475 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfHJHth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:49:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so24094158pfa.13;
        Sat, 10 Aug 2019 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tfcngCHqd46yllw36zTt+HKJhbu2ae6xc0MYFSsQkao=;
        b=KhEV4lP5tlK/NolD1x059fVSIk9Ag8go1pfKAXNZfIiW8AUG4nzVOwlLO/+CDjkyff
         KlOlPAl0pj4fEsiDoA3rokoM+iTcp9eGriDzoQIZhtE1zpwTIADuE7G79JF45JvMvgoe
         Oij06L2zwSf+nOdUSezBj6jrSmTxtFsGIa4PEJvs3qPkS7ycJJOqYgcZjLyeTDDnjko3
         /Cglfowecm+2Cvf+Ewe1RMoQNnhlGOU0wmDpWS0i9u4Pv7esa0aPcfaghImAkXsOgIdA
         iyw03Hfz0Kb+adwRgHt3AJxDuWrNkY4qtjRrmX/WHUkhZDUWJoh42b32GC2yv/8zWQrC
         MXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tfcngCHqd46yllw36zTt+HKJhbu2ae6xc0MYFSsQkao=;
        b=tBjV92kvi29xW9QC4J1/gtBhIEpwavuP5U64//JK0KLow2vfipgJTfBUntuj4Agz4k
         lmfFnYBP6BRe7kJu2uNjuCG007XL9PlmfyeoZMgzSzvWPzwH1Kazfbar696UmDlfi9y8
         wFWGQo/ut760h41CZJxds2obzSQ7LvLdSVjL35nbqjMvPPjDtnGdKyPmgnGYll5sj7MK
         EVBPST5zEtHutvYykW36p5xt3W8D2X4+MK2ZiZRZf7KaGpEDQQsRuVNXNitRziAyhp2f
         5mTxxufw+tJwFtTc0WnTf+DomgI79te8iMCVrufRQepkP0/2fZuc0HqiKexEZp8eRq/a
         b3DA==
X-Gm-Message-State: APjAAAXa3r7/OHo0SNS7qDG/Km/bHz0XY5ZpPKcb3lIdWqrQayqPDOKS
        Z50SBYqn7dx3fghOXYZ/T3cLTYRQUTo=
X-Google-Smtp-Source: APXvYqwtOh6UGtC4RwED7iygtgaXorec3tY8T44ol3lTCDHO5KnIpOjkUISvLGClRcF5k6prFBinMg==
X-Received: by 2002:a63:48c:: with SMTP id 134mr21203419pge.386.1565423376348;
        Sat, 10 Aug 2019 00:49:36 -0700 (PDT)
Received: from localhost.localdomain ([219.91.196.106])
        by smtp.gmail.com with ESMTPSA id c98sm7769318pje.1.2019.08.10.00.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Aug 2019 00:49:35 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH 0/2] act8865 regulator modes and suspend states
Date:   Sat, 10 Aug 2019 13:18:53 +0530
Message-Id: <1565423335-3213-1-git-send-email-raagjadav@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements operating mode and suspend state support for act8865.

Raag Jadav (2):
  regulator: act8865: operating mode and suspend state support
  dt-bindings: regulator: act8865 regulator modes and suspend states

 .../bindings/regulator/act8865-regulator.txt       |  27 +++-
 drivers/regulator/act8865-regulator.c              | 160 ++++++++++++++++++++-
 .../regulator/active-semi,8865-regulator.h         |  28 ++++
 include/linux/regulator/act8865.h                  |   2 +-
 4 files changed, 213 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/regulator/active-semi,8865-regulator.h

-- 
2.7.4

