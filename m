Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A66C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B672168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHS50Qbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFNSzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:55:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43047 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:55:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so1962193pfg.10;
        Fri, 14 Jun 2019 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D+syJ3SL1nuOH0xkteKH/buQWr95V/F3KATaumHZy1s=;
        b=EHS50QbzkjLT+Av6pFw2E5h+1zENcT2G8i6ylRVNrq0XFeaMWA/gSlbC2Ls+b6py+u
         fgSidofKxz+j5YRAhtPdVPiWCE8b76ajZVccTXvu3yphAsTqFZeZx51ZdFfh0eSwEUUb
         wBSu+RAdVMGiJeYPf3hCtY2yFQlU6UPuw60EdqSq3s76dKJWKvH9ed6cmxkXkc2Muss9
         trhUvrXlenEj+M0DrsCHQg/oiw58pcdLsWdDHj6JedT8vsc7duWGbGrJ9A28o0I/ruUt
         UZI4aknr5pBhWgWZKDRKFK/V10NXFGuVXCi/5fJ88QVw6dhKADcWjHNYcWgs27vHj68N
         jQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D+syJ3SL1nuOH0xkteKH/buQWr95V/F3KATaumHZy1s=;
        b=nbJjNyjxVRVXxouXTA6loWkBgQgrHaDHX1R4tU6QdFWFPaWlrKD12W7uYSVXg6FPyK
         PdHetiIPS8gUuY8k6ZEjQCt9RaOaG/yEvkQ2UPlHqmq6MIepzbg/LpojM/OVD5USaY+v
         731sfby10vwkIq72LG+mZFS+DhbnpauS0OBOrgRHL34pk5m0M+5KxDUVezaRdiecwlNt
         P4V7D1BAlhpcWDYe95/8Oy/unkPnVWc9+70zqtqxt9Q15K1hzLQCdpMV3h6AVTh8zRFy
         jmSblLsKfATqxkc2X3RjLTKnKnMJLpGF5AcCAOkVT+GR5AgXQhl54nq+moKZXZClYh4/
         tyVw==
X-Gm-Message-State: APjAAAX9hcTX1QkQGa2n/TISymeHpVWf00R2yrPZ2jVESW80yJBmuZeB
        EVqh0iEtUWbvAO/2/FlubwM=
X-Google-Smtp-Source: APXvYqwkcDuQH9liqXyWK1uKCKA4RPQF+zphrhMUb0LCRFkGimnSjaDuvjeLe1QCeWyGaARVQ6YKLA==
X-Received: by 2002:a63:e317:: with SMTP id f23mr23202775pgh.142.1560538551555;
        Fri, 14 Jun 2019 11:55:51 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id c26sm1225267pfr.71.2019.06.14.11.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 11:55:51 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com, sam@ravnborg.org,
        bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH 0/2] MSM8998 MTP Display
Date:   Fri, 14 Jun 2019 11:55:47 -0700
Message-Id: <20190614185547.34518-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are trying to get the GPU and display hardware in the SoC
supported, it would be nice to be able to put the output on the
integrated panel for the reference platform.  To do so, we need support
in the Truly driver to support the specific panel variant for the
MSM8998 MTP.  This series adds taht support.

Jeffrey Hugo (2):
  dt-bindings: display: truly: Add MSM8998 MTP panel
  drm/panel: truly: Add MSM8998 MTP support

 .../bindings/display/truly,nt35597.txt        |   7 +-
 drivers/gpu/drm/panel/panel-truly-nt35597.c   | 149 +++++++++++++-----
 2 files changed, 116 insertions(+), 40 deletions(-)

-- 
2.17.1

