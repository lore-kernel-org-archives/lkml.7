Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF89CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8703120856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCsfDwB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfJ3BE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:04:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJ3BE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:04:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id x5so313139wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZMZvZw5xIVfUz0rzmj9BJHoyhjJUnzATCK033QQWZA=;
        b=pCsfDwB6/b5ZeJiydhA6zZlaPuMPoMyiAJIAW4RGMSYnVpdEzcXBO6v0nqB0y4d2A/
         w9RWG2KD7WRCxBmqIfo7JNn23KrtOldirVEdEcb6W/Ke0thu0iD4D6aXpaNPFXTQ6PS3
         v2KTAeVOJy6huKIe+vUf2cCPg6JStVuZQezA8ecdH+iA+jRLknupVEiPnFyAFRL3clcZ
         hDRx/iVHhj8YNoj26CVSMuFo26NZxx8bBnHh9zOMhv/Ptbv1y7IOeftYF+7lLen/6XCV
         3DjGpK+AsJNtpb+DLPw/YryXUxThPt0Flnqd71GqmfTpENS7iaz28i5KrFYJzaj5lGxM
         c6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZMZvZw5xIVfUz0rzmj9BJHoyhjJUnzATCK033QQWZA=;
        b=c0c7MID/SesLdwizNyxRWm7Gh4e3oyqRLq07l0ieg7C19JM9hJhQbEDE8KRsXLgwM4
         vPkgkyazVZ2nAdqjqW/PWIGVWjf2tvnwFMfatwAqlxNvMJeHoGRlgcJDDWLhRzGxAIjL
         SAdX9673vgpBy0gf3GYNjWEI+WeI6SwtqiulSfXRLTg592AqqxoBlja32hI8kBdgFCGo
         8rPeBrL5907XT1qeiMHVIs9wBT/LoOSAgYZgRChZYcDMxDlE8rL1R+AbwfNDoCkd/dB2
         oBkiRSCvcCs2qD1SxnG3Sxb5wNxjJnDsRZOD5DgA6KdZfY3bRdY6DAC41DvBErLrcuCD
         xisQ==
X-Gm-Message-State: APjAAAUMY5exINEDWAP2sbu16dxCeanSt0OSyckwSt1NVLRmpg23E4AG
        J2RS4uXp7WJvSAoBRRjNBdUDySfHYWo=
X-Google-Smtp-Source: APXvYqyFD+shcmmnjNcgWEMzxaOKetRfDKBwI6qKLrLe15w2qWli/ypMkmV9cTwhgwnGHD/OytpGvw==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr6816581wmh.55.1572397467012;
        Tue, 29 Oct 2019 18:04:27 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id s17sm404542wmh.3.2019.10.29.18.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 18:04:26 -0700 (PDT)
From:   Roi Martin <jroi.martin@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH 0/6] staging: exfat: fix multiple coding-style issues
Date:   Wed, 30 Oct 2019 02:03:22 +0100
Message-Id: <20191030010328.10203-1-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multiple coding-style issues reported by the checkpatch.pl script in
the exfat module.

Roi Martin (6):
  staging: exfat: remove unnecessary parentheses
  staging: exfat: make alignment match open parenthesis
  staging: exfat: remove unnecessary new line in if condition
  staging: exfat: replace printk(KERN_INFO ...) with pr_info()
  staging: exfat: avoid multiple assignments
  staging: exfat: replace kmalloc with kmalloc_array

 drivers/staging/exfat/exfat_core.c  |  50 +++++-----
 drivers/staging/exfat/exfat_super.c | 136 +++++++++++++++++++---------
 2 files changed, 119 insertions(+), 67 deletions(-)

-- 
2.20.1

