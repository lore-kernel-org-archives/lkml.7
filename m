Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6FDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D423724249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b92J8jdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfLEHUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:20:12 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:54899 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfLEHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:20:12 -0500
Received: by mail-pj1-f74.google.com with SMTP id d21so1289301pjs.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 23:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=FNNXF5sUDk2To9IrnQY1hGu8S5uYxVxFAu+jBAyZens=;
        b=b92J8jdHjDyp2TLoSTYcNkHxDjlQ5qxZ7Da03+LrBT04ke/jGvQoONMdEk5oSvIRTl
         CEKhj+dtAbAp6OmO3IePN8x23GL1nzmoG1zKRKbv9lLY+jhyfeLFMLADUDjyuksd9jc6
         k2qF+K82+KbAcSIbPhJaDBl3AccamQ9BXV6cyZTeIJIT/gL/iHaj8q8K0GeVA473uWsa
         DDPCe++FW0h4Aa3DiAoJLWnNbkuh0BiLV7s94B8DR0efpZarhGZiNSkqCxK/TjjA7gr8
         kzVDzv97h9o8PMPdVnVy4lFklDND5JFoMDHrX2OJvB59HHeS4qn6t2c7dOUjg3DGkMEE
         Dbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=FNNXF5sUDk2To9IrnQY1hGu8S5uYxVxFAu+jBAyZens=;
        b=SKVepRXrChoxV8JhRdJXY3FbD5pzIVCaUhkvrywdlO3DtV80PcdUedf8LxNFxWM3eG
         t6MBo4D3ouhhCQEcACQ7fIbp7KnUnHUuZy7Q6xw7m+AL4Z2nRMxwJNu4dS1l8X5bT28v
         t6XVj8Pdy+RuuOBZWTml6Zk44OCZx9901XdgOh30uJxXJdseFwvWcOvnk5dikCl5N9/d
         eHulP4UUT8gtEepTXi/NrhVJ9/hwDWfgmnKeLCv+wCpJ/j8ekELYsHw7fclPj/XnTabM
         seeuULZ7bOclaLAeGU4nrv0g2TEvjpq6Pradyqi3YcBgcMMXI6W5jessDwDKV8LJTBGa
         CMwQ==
X-Gm-Message-State: APjAAAWl2qOd7G9ntICT95PTyt3nZGeZ/3j+6uFNeEivboY5N1ENXZl3
        yH3TyE/GhkdJVXN9BunvLDna9zU=
X-Google-Smtp-Source: APXvYqzfr1djZRzCLhdN2stJ/Dej4cwmyYyYT2uv32U/e5C4i6hrYuFKOIEW+kE0Fwc/GDHzVHDp860=
X-Received: by 2002:a63:4303:: with SMTP id q3mr7864698pga.439.1575530411658;
 Wed, 04 Dec 2019 23:20:11 -0800 (PST)
Date:   Wed,  4 Dec 2019 23:19:50 -0800
Message-Id: <20191205071953.121511-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v3 0/3] thermal: introduce by-name softlink
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paths thermal_zone%d and cooling_device%d are not intuitive and the
numbers are subject to change due to device tree change. This usually
leads to tree traversal in userspace code.
The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
cooling_device respectively.


Changes since v1 [1]:
 * Split cooling device registration into a seperate patch
Changes since v2 [2]:
 * Split improve error message in thermal zone registration

[1]: v1: https://lore.kernel.org/patchwork/patch/1139450/
[2]: v2: https://lkml.org/lkml/2019/12/4/1291

Wei Wang (3):
  thermal: prevent cooling device with no type to be registered
  thermal: improve error message in thermal zone registration
  thermal: create softlink by name for thermal_zone and cooling_device

 drivers/thermal/thermal_core.c | 55 +++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 11 deletions(-)

-- 
2.24.0.393.g34dc348eaf-goog

