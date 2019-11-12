Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F85DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA53920659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J0RswMfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKLRRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:17:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44282 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:17:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id f19so12247480pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BY2Sx9ycP7suPutbppdg5ksZUAM56wjTk+wkOIX8bxA=;
        b=J0RswMfv3hSYMIY4PupyeNnJOXTmOF/hflLEhM63BB4SxANPvZMllCXwqDmtKwfh2O
         Nv98XUlfJmZtwniy5LMmt7n0dL9CLu/Z0Lrq8ttC2JMwKnxRGv/sgTDd2XbDwnFf/rFN
         BlXsVrC4QoI5gKd4jon3L0PEYiY/BEeMihelw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BY2Sx9ycP7suPutbppdg5ksZUAM56wjTk+wkOIX8bxA=;
        b=WVIUlupvAtGNAm1Qh6xBp+OsFXX+oqnLMdYZblv1wak5giligjYbSVtKOgI8C0xoDK
         5u+jtUqyC7cjjhUu/bmUOFXc7sfuu4+ut4nC/wao07qVecm5Co/LiRK8mulXhVlwn6m1
         +SQhIEGP8AE2nCJpzwdFrCSHJAJjjp6ggqDerlDrMwH2oeTp7vKGanqY19RID2vgqTsU
         w67ZzyMnETpNpJiwFc3lHiBH97hPFHR3GQtbGh0mKzaTvRd4+a1Hm4/Fgm5k+ra5VvT4
         /ILeL4Oi+FYksIA+6EtVWYREXQc8oZNRLS9J8KYCRVG6XmAQf1BlH79fk7cmw/ZMNANr
         50hA==
X-Gm-Message-State: APjAAAX/8WV282M6WRrBPEYToFD7nCS1gbp3RZ/yfdj4JgKrKCiJWdEn
        RQgU0q/c7nLtngoDlz9hA/VH/mZHfUI=
X-Google-Smtp-Source: APXvYqwsFUEGHYnOEtTfEDmiH6CoWp6u32EsFAXEL2oDavPytkste0r9mjvK96qhQR5sO4eKKy4mDg==
X-Received: by 2002:a17:90b:d85:: with SMTP id bg5mr8211033pjb.5.1573579040053;
        Tue, 12 Nov 2019 09:17:20 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:521e:3469:803b:9ad6])
        by smtp.gmail.com with ESMTPSA id d22sm2432660pjd.2.2019.11.12.09.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:17:19 -0800 (PST)
From:   paulhsia <paulhsia@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, paulhsia <paulhsia@chromium.org>
Subject: [PATCH 0/2] ALSA: pcm: Fix race condition in runtime access
Date:   Wed, 13 Nov 2019 01:17:13 +0800
Message-Id: <20191112171715.128727-1-paulhsia@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since
- snd_pcm_detach_substream sets runtime to null without stream lock and
- snd_pcm_period_elapsed checks the nullity of the runtime outside of
  stream lock.

This will trigger null memory access in snd_pcm_running() call in
snd_pcm_period_elapsed.

paulhsia (2):
  ALSA: pcm: Fix stream lock usage in snd_pcm_period_elapsed()
  ALSA: pcm: Use stream lock in snd_pcm_detach_substream()

 sound/core/pcm.c     | 8 +++++++-
 sound/core/pcm_lib.c | 8 ++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

