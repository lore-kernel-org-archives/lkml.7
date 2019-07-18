Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD6C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A598321783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1FLy5Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389689AbfGRLZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:25:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41956 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:25:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so13672624pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k3a2v4scLqCzIgsIewhCrR8or1GEYNGppEVY9Fy2O/U=;
        b=M1FLy5Kk4LfikIbzpeaUWtN1zq1XlK5JvCef3h2YeRK38Wr6CrReh7qdmTSxBKd0tr
         o+bCMkEycBSfB22Ym3qrIiJhVXMF9RRjehkyX4ib2C30YhMXPk/zH6IB8r7T/nzqnuEx
         ldwsWbOg/J27MJz09b6pj/NMbBOco/WX3y3STg9Qgzjq5H3TaRXVvFHplilz8xmCFaRq
         2SlV3Yy6NxfGr3rWKGOpKjJbtACX48g85y5OprttVWZBrMtKLjw8FkeXjowey0P+3cWN
         oc/Yh0GZ+8n27tCHhwfoDVKKZ5PuL/GM+tRgRcQ9pLybCrQ79gy1bTYJ1liiVoE73HeL
         VkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k3a2v4scLqCzIgsIewhCrR8or1GEYNGppEVY9Fy2O/U=;
        b=VXD2n47LupFgntKthrcL3B/Hck7a5mX5/ZsRW1QL+mvRM71s6r9LVDo8jiTb12QyYJ
         EwtCg+PntkVF5NuPeAuOu8cZ0oJn3zlkMntX189Obnli+ZM0HYht4EDfVmeO/0EQxf5L
         BmBJzW3mtLLX78Ghv7zfg12SWLyvgTiA4jbbw3EDuiZBvg59uuENV23/FkJfZVavnFQx
         8WNt0ihGNDeUOeLoU2bgoCXowH/3EDHEeIeu9P2dKP2ulF1YRYSt+th+ob7M0YBIES2Q
         Ofsykp2bqSswOU5R1GEvd+2CIMAyGDxki4z4eYeHHUJYRthsg5bNgF/gMWL5C+Nnmt0V
         unhw==
X-Gm-Message-State: APjAAAUqAe2ZP6h1G5CURuIb7x8nugRwkJreeADD1bUZ9hALUH7BMmq0
        yFS/vXXgxwJhlrHp7kEq3GFlIw==
X-Google-Smtp-Source: APXvYqzQf4CQsiQAtlZs4mdLJM/AQwjnWt8JUhNrsglzHFXFxeb6/N9wuQp9kLw/Y9rgnv3leMPvBw==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr48096653plp.95.1563449142612;
        Thu, 18 Jul 2019 04:25:42 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.63])
        by smtp.gmail.com with ESMTPSA id 3sm29648436pfg.186.2019.07.18.04.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jul 2019 04:25:41 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC/RFT v2 0/2] KEYS: trusted: Add generic trusted keys framework
Date:   Thu, 18 Jul 2019 16:54:44 +0530
Message-Id: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set is an outcome of discussion here [1].

I have tested this framework with trusted keys support provided via TEE
but I wasn't able to test it with a TPM device as I don't possess one. It
would be really helpful if others could test this patch-set using a TPM
device.

[1] https://www.mail-archive.com/linux-doc@vger.kernel.org/msg30591.html

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (2):
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: Add generic trusted keys framework

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 include/keys/trusted-type.h                        |  45 +++
 include/keys/{trusted.h => trusted_tpm.h}          |  19 +-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   7 +
 .../keys/{trusted.c => trusted-keys/trusted-tpm.c} | 347 ++++-----------------
 security/keys/trusted-keys/trusted.c               | 343 ++++++++++++++++++++
 7 files changed, 458 insertions(+), 307 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (85%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (77%)
 create mode 100644 security/keys/trusted-keys/trusted.c

-- 
2.7.4

