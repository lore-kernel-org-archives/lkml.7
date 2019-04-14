Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57789C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C275206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTji6j3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfDNXht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 19:37:49 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:46086 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfDNXht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 19:37:49 -0400
Received: by mail-qk1-f171.google.com with SMTP id s81so8810680qke.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/7g73vBINjAFJ3cXmSL0Ila94Jgkgr0b1V9GNbbcok=;
        b=fTji6j3Rv1/fmuQGPxqpK9jQytOsd2dNBG/ccAUTyc+iqhrUHH2DLAGS30CeT/Ck69
         c1SfqL4dXTufMy3khsHEjoXHUIC2T4ShRPLT7wejMerVmY9mn3pllKSoHeUyfZShWUzv
         gmrA6zUxy96C9QilP8/PRSF7Gy99dI2kbPva/xf5RXsdm2oDBPp4KAP3ssytEUl4tMeo
         xNpfnRd1io4Vi99pOjKzwZ1uD6Yi+mQoPcZma7k8styVRcYCoZuv8GQBmaoqZHkKdWaR
         bcjYvAYgcZqlxcPAT/Z7zi+tfK5HDJAY5THzvVxmvJw1nmaN53km1XczVRZFJ7W+u1ot
         1CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/7g73vBINjAFJ3cXmSL0Ila94Jgkgr0b1V9GNbbcok=;
        b=WtFmRMHITvDYm2Mzl0CnDo+P6Diw+YlND1Uh5/+NgiFyzjs/daNTTSrliD+btFbJ5q
         O3DsdQ47ry7RMjsN2GWQKEhi8OjSjamzu23rRxEzaXKqFaqRKZLIzxJbn/5vz2RHuCvf
         7+vasMwgIY0/4shun2EOv9C8s+HJliR8Qqj01udvpSV/crFllge33fvsY17KLspBQJGB
         +akH8cK2L1ot1R8pYfWEkUbBpHG+EdN1mTKFSHGpji2nKMELqeryifp+JNlfKW0ABsCJ
         57AHNanQVRAz3K8mM5vsgqFrkatnjNOmlWnmk6T2AvCqDRX05h54G7XdPks7RuotJHvZ
         /Adw==
X-Gm-Message-State: APjAAAUlv2sC6WOHVUYqFsQAsfEOnTaxU/yHEglSSTiVGMqSoluBGQ54
        aqCenGVaZc6KaGxWOzAg0xc=
X-Google-Smtp-Source: APXvYqyVzLcuKLTauycBg1bhSKi/ZHVrurU0me+eDh+f8witAgTjWwRkWJDj/TPxWP6y3dD8ESoXbQ==
X-Received: by 2002:a05:620a:126e:: with SMTP id b14mr54306414qkl.49.1555285068409;
        Sun, 14 Apr 2019 16:37:48 -0700 (PDT)
Received: from debian (hlfxns017vw-142-68-56-253.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.56.253])
        by smtp.gmail.com with ESMTPSA id f191sm20187342qke.28.2019.04.14.16.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 16:37:47 -0700 (PDT)
From:   Brian Yip <itsbriany@gmail.com>
To:     christian.koenig@amd.com
Cc:     ray.huang@amd.com, Jerry.Zhang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Brian Yip <itsbriany@gmail.com>
Subject: [PATCH 0/3] drm/ttm: Cleanup state in global ttm structures
Date:   Sun, 14 Apr 2019 23:37:26 +0000
Message-Id: <20190414233729.17956-1-itsbriany@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

State in global ttm structures was not properly reset on cleanup.

In the scenario where multiple drm drivers are loaded and the first one 
fails to initialize, there is an attempt to reset the global state in
the ttm structures. However, there were some attributes which were not
properly reset during this process. This resulted in a crash and 
false positive kobj initialization warnings during subsequent initialization
of these global structures.

Fix the crash and false positive kobj initialization warnings.

Brian Yip (3):
  drm/ttm: Reset num_zones on ttm_mem_global cleanup
  drm/ttm: Fix ttm_mem_glob.kobj state on cleanup
  drm/ttm: Fix ttm_bo_glob.kobj state on cleanup

 drivers/gpu/drm/ttm/ttm_bo.c     | 4 ++++
 drivers/gpu/drm/ttm/ttm_memory.c | 5 +++++
 2 files changed, 9 insertions(+)

-- 
2.20.1

