Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ABECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5913E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaxXB8yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410135AbfJRM4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:56:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34821 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfJRM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:56:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so5747204wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CD+bty2JgPn943TXaARoc4H7hkdb+h7lncGCHmaCcN0=;
        b=EaxXB8yxpjgjqwE0bD1jv7eEoqqaOonz1N2djpz721OFIF0SOlfI2YHO/fm1KnHC4r
         E1soMZAW3KI1TxX1d9HBNyCSz/R368Z52LRPE6EQHZdTkLOTfghR6vtw2Waes46H4NQU
         EWUtsUBLSXS2wgkez92ZoF5W4Amxmyu2a5iZCIpDHeyGtcmfXqHXtyTmfDEKvv0Do/Wb
         AdypkdXk1CaPdm2bHf91rOLbVNY+s5kVI0C7B+93s0pwpwb04GrhekXCaEFBJlA0uuIb
         LQlIOFFhfzXzRiV+OQJmj/pVLVG+j7hD1TWykpN6gz0WRFfli4EB1Dk8z6N1S4iJoJF2
         VvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CD+bty2JgPn943TXaARoc4H7hkdb+h7lncGCHmaCcN0=;
        b=DSdEEHgxDEdeONvfV21EEcD1SNgIw64dxUTudNHUvQZiOaoNNWG3SU7YBSAliys097
         pbvQO4fLqib4GCC1VN+kVLr8yNzPEaHrGy6nNm2RqIGT8NMrEZKpTIlwmKEMDKGij+6m
         ccKCCucJ9tnqHLBp1Xs7wh6fl5Jp76vX5trR/o0DBbBbPk+Z63UWFR6nPzimRxn/NnGZ
         NMxnYaMc9DT+uLGySxKkNh6Xl+yAIRR5Ju1kwSKQ9ytnxvnvUVPO8QpCFqckiqZQeHlQ
         /DSOQ2/kJauK1k8t5DPU/pMOBBov9xGpBBZNZMfm60ztRq7+gQs1clv/og5KVo3TmTDz
         ffwQ==
X-Gm-Message-State: APjAAAUMlCEp325E1sGvyaK67QhxD5GTSpVbECbxyn0kcL277B4YVLSZ
        AyBbk8Yb9lHILUIPwxW9Q5rciQ==
X-Google-Smtp-Source: APXvYqzhKfBhrK7QtUfqpevfqJ71ENZUKgC+sVTep3qJNI5X9AKSvISdqmAywnq/+lv1DRUZSA48gw==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr8279585wrq.9.1571403370810;
        Fri, 18 Oct 2019 05:56:10 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id q14sm6058491wre.27.2019.10.18.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:56:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dilinger@queued.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/4] Remove mfd_clone_cell() from the MFD API
Date:   Fri, 18 Oct 2019 13:56:04 +0100
Message-Id: <20191018125608.5362-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mfd_clone_cell() only has one user and it quite easy to replicate
using the existing MFD registration API in the traditional way.
Here we convert the user and remove the superfluous helper.

Lee Jones (4):
  mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
  mfd: cs5535-mfd: Remove mfd_cell->id hack
  mfd: cs5535-mfd: Register clients using their own dedicated MFD cell
    entries
  mfd: mfd-core: Remove mfd_clone_cell()

 drivers/mfd/cs5535-mfd.c | 70 ++++++++++++++++++++++++++--------------
 drivers/mfd/mfd-core.c   | 33 -------------------
 include/linux/mfd/core.h | 18 -----------
 3 files changed, 45 insertions(+), 76 deletions(-)

-- 
2.17.1

