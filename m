Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C48C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF294207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxXPOhc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfJNHIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:08:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43367 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbfJNHIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:08:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id f21so7592998plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NguePtiRLqxxPERuaTU6qYGHlLMZjTiDWKMVkMyftlI=;
        b=pxXPOhc4f+9VgOl55DLeIiVMic5UpGOtXZyhX9MkkzluVA6Hb9lV7/dwJcIh4u9zy8
         DDhzHzZmg3EfkwS0ZALwQlNWzvM5U9HLaIff2voswp0oRABMadlT8GEAnhxQC+y5OIqI
         CNqnImA3S66tx/nFbxFvfKM2+t7ZNENG3hLw+1ZM0K3VvYlbpcNBPm8lelOFTh3bXhmM
         gMwatu4vE8ZYstGm7fkMssvWoVHgkTQ8bPVXKeqK5HaLs2F/ulm/AW7Jneyb24PLF6Fu
         mSz7/XLFsCEn38aKUkzyf4YkusQEDcWLNREJx9njDl3z9f93jsfexS4ZUlmeCJmzf8gy
         fubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NguePtiRLqxxPERuaTU6qYGHlLMZjTiDWKMVkMyftlI=;
        b=jgLz2bSoJtNrMZMBjezAy8x9+BCE8RvMPC8Up6znC3nzMEfaZmNuoOVrG6BBTkxQw8
         pLQYt3KxY9GnZYcHrfQAVu48FCYnefMnYwrD7kcgohFFIFFCLMZPAnFbDMveaYQpZ9pn
         ZtJ2sSPH259OY+/yhSMpREe8OOAAnu9+9VudEZP3UDMCr9oxRdwWzmuqxXbRv3z8HEBF
         qJvUbLxIhaHT7dhhVZjwED/+vPA+CFnV82M4TbhpiCORSUme7x6aqmrxgpc7oweLAoej
         mEsCuUGvQN3EMdAMSs09ccgTKWh0CO3NyTX6fGQ7pKx81nc+Uq2JobFWu2vs+Fuw+16b
         3FbQ==
X-Gm-Message-State: APjAAAUdVh5FsiuQ0RcIBGNy3SnXAhk4IZSNGbLmLRc1HhlKleKESLBX
        WA2Kt0+5hygSO2fp9QZ5IRchWw==
X-Google-Smtp-Source: APXvYqwejRJqYN+1PN+rmvhGFte4RQiA22AwEs1KXqwUn+eV0HR/gMGjIqh5w5+BnvYjRJHsoXZdvQ==
X-Received: by 2002:a17:902:9696:: with SMTP id n22mr26782696plp.252.1571036894371;
        Mon, 14 Oct 2019 00:08:14 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p190sm20619948pfb.160.2019.10.14.00.08.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Oct 2019 00:08:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linus.walleij@linaro.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, baolin.wang@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Some improvements for hwspinlock
Date:   Mon, 14 Oct 2019 15:07:42 +0800
Message-Id: <cover.1571036463.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set removes the BUG_ON() from hwspinlock core and changes the
PM runtime support to be optional.

Baolin Wang (4):
  hwspinlock: Remove BUG_ON() from the hwspinlock core
  hwspinlock: Let the PM runtime can be optional
  hwspinlock: sprd: Remove redundant PM runtime implementation
  hwspinlock: u8500_hsem: Remove redundant PM runtime implementation

 drivers/hwspinlock/hwspinlock_core.c |   16 ++++++++--------
 drivers/hwspinlock/sprd_hwspinlock.c |   21 +++------------------
 drivers/hwspinlock/u8500_hsem.c      |   19 ++++---------------
 3 files changed, 15 insertions(+), 41 deletions(-)

-- 
1.7.9.5

