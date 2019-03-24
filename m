Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE79C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860402087F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OiFCf2Rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfCXWnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:43:40 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:32886 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfCXWnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:43:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4C003BB1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 22:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o4q0iXGOBA8v for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 17:43:38 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 1DB5BBD6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 17:43:38 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id s24so6491666ioe.17
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 15:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sul76dv3STc5/UWpJ9vmSfm2gGDqU8QZqXwdwOQU5TY=;
        b=OiFCf2Rcvcde0rQcfubl62GwfWlDHhfYhlykKz5XlwGmQcfApV+fqeL1DPL7eTZRF0
         zIb5ajAgkE/XUoKQGNWDPMwpML6NURRd3tPJeJ8baEFO2+ftwJBIje3WLP7ZOSVZd4FZ
         7d3BlVvzuimlUK8WT51YO3VKa8edLI9I+sRlYPXxCpmVMRw24QjefIiperBcRpf8ZoGQ
         ZRqPaxDEQ5ojQldUD1iOGOqDq+hHLbwqkipWAsViu/02kdcgEfbSW6jn0aXcFDBK0TLH
         ZzaZk10jYTWMx3lD1CwSzTFnLVrU0/q8HJZ8G5SyHNFyq6jSK4Dmy8Djcx/lmsPhCqR1
         0r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sul76dv3STc5/UWpJ9vmSfm2gGDqU8QZqXwdwOQU5TY=;
        b=ExdpKm+s3B1VPikcvm8OeGIZfhJyXLlW1N+VWy/tj1AGF0HFPDDsnkYABpm0MBYWNV
         soJy+RTIbTlyPrxvUeJJKDo2agnsxHm1Py/8qIdyVr/lFdGoIGEK/LcFJoXqQfzMLu76
         Puf1sNMLrR/125oAhdEJuT6joPDYkdhwUIW9g/9AeC281AEyaYWMVV3jx9Wmcg4gmqWO
         mMGgRUKl8dDIj8Xgd8x49niqAHAgCI1Bbqbfk7oJ/Ml6gMp73UR84K2pzhrHkyA9b9VR
         lz2bh2QROKsj/Tm/DwpsRGTnyZ5fvzdT7AVEzj1wmVZvS59LHiYt2vzb4jK0hoX54zDt
         lXLQ==
X-Gm-Message-State: APjAAAWSYzznwGbPjlrS5KNAabIBKdRJoaAkFSAXUUS2PvxnaTdo8eSv
        FtW/1CbTwoGuE5WvUNbR/Pq4YNZYUy6PoIgABRMUsc+FZarliCCfBdylYkHjWOtAXsO6ZNdHDRu
        7KHVQs8/VWv9tB4SVL7oEbAau8wHm
X-Received: by 2002:a24:738e:: with SMTP id y136mr8595816itb.147.1553467417704;
        Sun, 24 Mar 2019 15:43:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUO7Bn5GLpNWzElf5/ivicSmFq6GXcjoX7+4cfOKgYh8GN51FbrJhA3d+3pNiUNn9c1S59IA==
X-Received: by 2002:a24:738e:: with SMTP id y136mr8595803itb.147.1553467417518;
        Sun, 24 Mar 2019 15:43:37 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id u197sm4849059itb.9.2019.03.24.15.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 15:43:36 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominic Braun <inf.braun@fau.de>,
        =?UTF-8?q?Tobias=20B=C3=BCttner?= <tobias.buettner@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vc04_services: vchiq_arm: fix a NULL pointer dereference
Date:   Sun, 24 Mar 2019 17:43:30 -0500
Message-Id: <20190324224331.1163-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kzalloc fails, "platform_state->inited = 1" is a NULL pointer
dereference. The fix returns VCHIQ_ERROR in case it failed to
avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index dd4898861b83..0f12fe617575 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -209,6 +209,8 @@ vchiq_platform_init_state(struct vchiq_state *state)
 	struct vchiq_2835_state *platform_state;
 
 	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
+	if (!state->platform_state)
+		return VCHIQ_ERROR;
 	platform_state = (struct vchiq_2835_state *)state->platform_state;
 
 	platform_state->inited = 1;
-- 
2.17.1

