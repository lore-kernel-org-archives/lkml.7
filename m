Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26379C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA83420656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="IOJjPyAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgAGT0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:26:02 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46072 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgAGT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:26:02 -0500
Received: by mail-yb1-f196.google.com with SMTP id y67so425259yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4DKB6Qc7EQjmBiBL2Egn9+nwj/mOHqlQ9foMEYlIG8s=;
        b=IOJjPyAyvnzuaeYvsM7svksubqWXA8Hoa7vK1bSt+tq7EJBo7VMbZS8S8OZSLwg1pG
         36w/czHJ96ImfadkDxCEjuu2XWNf62lAMDsXNsGFKHjawBMtvJOe2BF5ITEpiN1FAxl9
         5YiirNrNugcI13cQILvJLZwP+M6SsP86e47EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4DKB6Qc7EQjmBiBL2Egn9+nwj/mOHqlQ9foMEYlIG8s=;
        b=HyE6egLFclR0RWmrcsXVoPoEF6hKo0iwSqkFnFIo5QSKdIQQ3/Mb5Vxu69fs0L0/BI
         AILva48ZnUgxnzvYeTjS/uP08T/GBCeddz4pxURUeUSxaD5bpz4017hj04A4XrJS3ZzS
         q07NLviN2ex6sTvgV1YqCXVcY3hxp8mpCdhjbUCOyebBz8HDS2kW5U2OfHYukKmih74j
         M/PYJ7XN7HelyUTBNjPMO2lcTvDACUX9aXIoNrJBwBnnxgqzjaflV8lOalBHpJ98/3/T
         iET9CTQrMprRIa3CqtTCe2adNJ0L1BdEdaJCZMZ2Y7qwM3D/8ekpKzQMutKoxHD0n9sx
         jIHw==
X-Gm-Message-State: APjAAAXsn85oAjFvZJEH6SgLnkvQ/pm6/VnOTfWeIMoIjUD4lfRc8X/m
        1DatfdA5jtLGadG1ADd70F5v
X-Google-Smtp-Source: APXvYqy+9ob7vtrukxOuHGC9cxGwvi0VR2CE0/vcLH7EgE5nxS3/p087frpqoeKCnXIBDamwJYeLvQ==
X-Received: by 2002:a25:40c4:: with SMTP id n187mr909330yba.199.1578425160957;
        Tue, 07 Jan 2020 11:26:00 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
        by smtp.gmail.com with ESMTPSA id y9sm252630ywc.19.2020.01.07.11.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:26:00 -0800 (PST)
From:   Tianlin Li <tli@digitalocean.com>
To:     kernel-hardening@lists.openwall.com, keescook@chromium.org
Cc:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tianlin Li <tli@digitalocean.com>
Subject: [PATCH 0/2] drm/radeon: have the callers of set_memory_*() check the return value
Date:   Tue,  7 Jan 2020 13:25:53 -0600
Message-Id: <20200107192555.20606-1-tli@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now several architectures allow their set_memory_*() family of  
functions to fail, but callers may not be checking the return values.
If set_memory_*() returns with an error, call-site assumptions may be
infact wrong to assume that it would either succeed or not succeed at  
all. Ideally, the failure of set_memory_*() should be passed up the 
call stack, and callers should examine the failure and deal with it. 

Need to fix the callers and add the __must_check attribute. They also 
may not provide any level of atomicity, in the sense that the memory 
protections may be left incomplete on failure. This issue likely has a 
few steps on effects architectures:
1)Have all callers of set_memory_*() helpers check the return value.
2)Add __must_check to all set_memory_*() helpers so that new uses do  
not ignore the return value.
3)Add atomicity to the calls so that the memory protections aren't left 
in a partial state.

This series is part of step 1. Make drm/radeon check the return value of  
set_memory_*().

Tianlin Li (2):
  drm/radeon: have the callers of set_memory_*() check the return value
  drm/radeon: change call sites to handle return value properly.

 drivers/gpu/drm/radeon/r100.c        |  3 ++-
 drivers/gpu/drm/radeon/radeon.h      |  2 +-
 drivers/gpu/drm/radeon/radeon_gart.c | 22 ++++++++++++++++++----
 drivers/gpu/drm/radeon/rs400.c       |  3 ++-
 4 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.17.1

