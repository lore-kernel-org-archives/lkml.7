Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFFAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9E520675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szks1tnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfEVMOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:14:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39936 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:14:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id k24so1969934qtq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmXHajl5kyPy81dUiGVwne11QESr1+8af/1NAUcnXEs=;
        b=Szks1tnIvPQLCzlNN86MfKrk12QyqIYMwHvWTyXPe7wa9LKHjGEeZlX9u3c+pDWYX8
         mERsNyrNjrd7+YYhCZ+SeRpsbPBUZve38tJopVkFhpmYm/Yn+sRT7Xf8z+dolB745a29
         /R2xKS2xkGjcVQvnkBZ+SWtRgIriQwCrV8bfMaMuMWyHGHBBlLU6JvxlMKYTyqwCGP20
         wMeszgXUDbvZoWJ17iigeACdyWX5EcBgd0pdaV/x/QodcjnIZFjDvxMA+3V6/9btzQB5
         FJLn4QvT+QL9bsUXzFiakgkqOYM3WCWqS7Cs9Q1zC5NBG1fNtXhSVgVdbS2c16zMQIO+
         j7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmXHajl5kyPy81dUiGVwne11QESr1+8af/1NAUcnXEs=;
        b=jeJxQ7N8kZ5l1A+YfKGe15bgk6ITNgCMQjJocYMdezB2koG7bvB5Wj9bgEBzKgTHUR
         j7NfM3vvRrRSaP4eOWXyICvMio2p2gp/8ifPnlK02e6ZM//F8bBqjRMTnX/2inI52+pj
         IPOAqd7dgIgyqkKbkx5Kw8YBm9Chr9ICudjtltxIZta+iP66OvxtA3lkfcKhhp6UW8r8
         HV2VjUiGMMN84Wcfcq4cPjeB7wIRPRWGbGNQi+kb3/I8wF882GCG1wfrCA0N23FeDR/C
         I1uvZTtUEOHslKdY2I12Y0+JM+yuWimrRcztz3LfBQbTnGreXxSVJG0KsqS+KwvP5O7d
         OXpQ==
X-Gm-Message-State: APjAAAUrzObFc0G7Eu4Rq2NQpaugH+rCuGKH4Q52HlixplJ6lkDRp/5w
        TusdmoO3jRhl5W0bNEcLxAM=
X-Google-Smtp-Source: APXvYqxicc8K/VIjD86mIRCSYHAAG19cDsAP0ppLOuRI3drCUry/zAV9SS1QgyLJKCb/nXMMe3TwhQ==
X-Received: by 2002:ac8:fa3:: with SMTP id b32mr71040633qtk.89.1558527281195;
        Wed, 22 May 2019 05:14:41 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id w2sm8742070qto.19.2019.05.22.05.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:14:40 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 0/6] Minor updates to kpc_i2c driver and kpc2000 core
Date:   Wed, 22 May 2019 12:13:56 +0000
Message-Id: <cover.1558526487.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attached are an assortment of minor updates to the kpc_i2c driver as
well as a build fix for all of those who will need the KPC2000 core.

Thanks,
Geordan

Geordan Neukum (6):
  staging: kpc2000: make kconfig symbol 'KPC2000' select dependencies
  staging: kpc2000: kpc_i2c: remove unused module param disable_features
  staging: kpc2000: kpc_i2c: newline fixups to meet linux style guide
  staging: kpc2000: kpc_i2c: use <linux/io.h> instead of <asm/io.h>
  staging: kpc2000: kpc_i2c: Remove unnecessary function tracing prints
  staging: kpc2000: kpc_i2c: add static qual to local symbols in
    kpc_i2c.c

 drivers/staging/kpc2000/Kconfig       |   2 +
 drivers/staging/kpc2000/kpc2000_i2c.c | 118 +++++++-------------------
 2 files changed, 34 insertions(+), 86 deletions(-)

-- 
2.21.0

