Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2826CCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6099214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffDI3R2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfKECX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:23:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42134 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfKECX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:23:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so5734975pfh.9;
        Mon, 04 Nov 2019 18:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LsXcsm2GHHqu1Vt0Snl+ykY6IrvFVgDaD/4d0g8GINY=;
        b=ffDI3R2T1dHvht2x5jtqWsQFPVQsa8dQxv0de3i0FqfFCz9qe722OVOayADpggb0zp
         cRcKLc3irCZdLVoVDFEmdcNxyw4waGj+55YVeG67+KOdIMOhh4bhzdxDHTcoQOjwfP0V
         YnrCZu8mtIy3zPDBHIgvEilMjHmF4OSLwa5d7ScG+3jPOiEyTpgj/5Vv1Jsue9YY1F8s
         BQqnovAb2IzvEnfV5BKKR/+rbu4F2D+RJQ6DgWQ6lcAC3+4R1L0hy6qkrQxuQu5bVq/R
         m0pf3MYwuHf03Ix8nOZnH2Pd1wswSjXT2vbSMKBbbMMLL0HHaPS+7haIAuV5ox2UE7Ye
         s/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LsXcsm2GHHqu1Vt0Snl+ykY6IrvFVgDaD/4d0g8GINY=;
        b=QkDlEHel/wRIhDLDodYbu1rOGWgE5tlTpE+PKrH5v+Id7DyjqncRrjeUk3TZN/DZSk
         RUftLKqyoBr0qJvRILFclAEvIKQq+HB1SLeNLSctfn/VEiXGjAW3jSbMR4phz91I6tBF
         DTKnm7J/zmw2YW7PHjsgUgi7p2gQjD4byiDXNttDyT9VsBPFbLJWWdVuVNo90S6n+WUu
         A6g8apTWV6MAYfLeLge55yoS9X6I3BIV+2FACIOtUqSVcg1a2rigCeb105IjXQ9sxV8a
         P4CWC8sZXi5kRHz30UTkxsfITSnDNhmY9nd/i0m9IptqUoFQESDZVgHbXWRYpzOkWbkx
         Vkvw==
X-Gm-Message-State: APjAAAXIpAszWPvLlitFNsIm7sY5K1EzS8XY0mF1JeiOtN2yP/4xrRtp
        cubw/w0q0JIdO+EfW+Qh5j8=
X-Google-Smtp-Source: APXvYqweZZE4NYDUt6+1uB6wHOE5HaTdK/3N36YwRyrmUabnLKxDDxU8a6uzOAi5vimdNvr33VNVOg==
X-Received: by 2002:a65:5a06:: with SMTP id y6mr34196253pgs.9.1572920605692;
        Mon, 04 Nov 2019 18:23:25 -0800 (PST)
Received: from jamal-desktop (97-126-66-56.tukw.qwest.net. [97.126.66.56])
        by smtp.gmail.com with ESMTPSA id w10sm16031382pjq.3.2019.11.04.18.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 18:23:25 -0800 (PST)
From:   Jamal Shareef <jamal.k.shareef@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jamal Shareef <jamal.k.shareef@gmail.com>
Subject: [PATCH 0/3] drm/tegra: Remove space after parenthesis
Date:   Mon,  4 Nov 2019 18:23:19 -0800
Message-Id: <cover.1572920482.git.jamal.k.shareef@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes spaces after left open parenthesis.
Issue found by checkpatch.

Jamal Shareef (3):
  drm/tegra: dc: Remove space after parenthesis
  drm/tegra: dsi: Remove space in open parenthesis
  drm/tegra: gr3d: Remove space after parenthesis

 drivers/gpu/drm/tegra/dc.h   |  40 ++++++------
 drivers/gpu/drm/tegra/dsi.c  |  60 +++++++++---------
 drivers/gpu/drm/tegra/gr3d.c | 120 +++++++++++++++++------------------
 3 files changed, 110 insertions(+), 110 deletions(-)

-- 
2.17.1

