Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCABBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9ED21743
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtBngVC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfFULN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:13:59 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38192 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFULN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:13:59 -0400
Received: by mail-lf1-f49.google.com with SMTP id b11so4818021lfa.5;
        Fri, 21 Jun 2019 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxdBzUZ3obkwqsW4eagvxPbm7+iIgAt4LnJnVKzvebA=;
        b=dtBngVC7J/yA+BdPIWOmzhfOMV222v+BfsEv3uq5oJBCv4cGc0wbTTIuaBcjCoYUzL
         BUNI5nPqz2o2OqtRz3uv8rNlWMj1RMBR3XTEzGdkWyyIx9kUHh301sKCvmY5/fn3ICC4
         1tmO1ftSpuyj7raffoNEbI/Wtyj9jXVhn23x6lOc3akTTJRgRbmT54L5YjObSmYemkK9
         0Ztu//q5hseXJdGxg/xPLQOrf1HocqqMTbpnL3oO0iSfd8bgLP2iNhebBiCT/WMCqCOM
         wDPb2oP3GPKOFCMgHzkmwNH9c5mUxz0lO/Um3rAiLeF65cyG3Y8KdUxjd/7O5w89EyNy
         xVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxdBzUZ3obkwqsW4eagvxPbm7+iIgAt4LnJnVKzvebA=;
        b=OUvmqd4/xZ4FLDHXps7TkmAZNH1jk4HTp4fhRRgxsKdSKc+KPHPe2EFMclSXR+AGlV
         9ZpnBqDmS5erW7bPppGFz+IB0G8akfbjbqMRhZlcaHFhAttHg+e6ZiPBE0BJ0cYA2MWv
         aFj3ETarwPgG/XNbYxrYM1cfqw+KwJXxXdmIw2ULQpOvuwsyDpe7ol1RB98p6+fwQKPh
         3HH1+o9G9yNYl3SZ8T26IH01LgS9M4Zzv+yJonxt9QtaNZj55S378j4cqWvPs8Xvc+P+
         LMNpb7J5ObeselUqvirJQ+brGFmvvqp62Sf6d511vNAY/zNZ3sgewFFGq0QOI88Vgekl
         iskw==
X-Gm-Message-State: APjAAAVeoYO+n6KY9a/bW9VwLoDK9DoE4SkhhL2lHgqqOeuvjN5MkVyI
        h8PuNybQIlSkFWitXjNb0zc=
X-Google-Smtp-Source: APXvYqxIZRU0b+KMFsF3P0gGpP8R7SGXD3LB3hFY2PhJabVgI8ezMoqnJeJCBR3tWCrYPI4YqfWfbg==
X-Received: by 2002:ac2:50cd:: with SMTP id h13mr31816235lfm.36.1561115637211;
        Fri, 21 Jun 2019 04:13:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:a5e4:32fe:c6e4:d5eb])
        by smtp.googlemail.com with ESMTPSA id l11sm391202lfc.18.2019.06.21.04.13.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 04:13:56 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     myungjoo.ham@samsung.com
Cc:     cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/2] extcon: Add fsa9480 extcon driver
Date:   Fri, 21 Jun 2019 13:13:50 +0200
Message-Id: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset adds support for Fairchild Semiconductor FSA9480
microUSB switch.

It has been tested on Samsung Galaxy S and Samsung Fascinate 4G,
but it can be found also on other Samsung Aries (s5pv210) based devices.

Tomasz Figa (2):
  dt-bindings: extcon: Add support for fsa9480 switch
  extcon: Add fsa9480 extcon driver

Changes from v1:
  - Added newline at end of dt-bindings file
  - Removed interrupt-parent from dt-bindings file
  - Added Acked-by to dt-bindings patch
  - Remove license sentences from driver
  - Remove custom sysfs entries and manual switch code
  - Switch to using regmap api

 .../bindings/extcon/extcon-fsa9480.txt        |  19 +
 drivers/extcon/Kconfig                        |  12 +
 drivers/extcon/Makefile                       |   1 +
 drivers/extcon/extcon-fsa9480.c               | 395 ++++++++++++++++++
 4 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
 create mode 100644 drivers/extcon/extcon-fsa9480.c

-- 
2.17.1

