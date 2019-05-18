Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9EBC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED4121744
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRO1qdgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfERCbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 22:31:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38091 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfERCbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 22:31:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so10250902qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q67f1b2VxwMpxdmTspg9aRXu3YBX/BaqwxIwMcxxa5A=;
        b=CRO1qdgYKtpsKf1QqpQyrnSqu8vePhC+DaL23Vwv3zpWWx5DdVd2o/kH7L5qLlalr2
         VHom+PuE4UGqtHX78zcC9GIgXHqF1z8nzroNbvEyGc5/2U8k/wQOG7JdyPZ+yNpcm4AC
         P/fleD2A/UqxDOhuknM46vITzzRgAwj0+txNa6JeKB2VqjUCyocGTAkZwRTG+Febyyoq
         nQGgBbu4q22tpIUhWjmZ3niNV9qBkj6p9HFG8PcA2rPf3335tn5KcSi5k5xfxjZNKe9c
         6PCcMY2PTmM2bXBQ73yI/ExKIF/g7KnNCNuvpvZY4Gp9Esg+zs8Pu+Tw9frCUcYXSj2w
         fckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q67f1b2VxwMpxdmTspg9aRXu3YBX/BaqwxIwMcxxa5A=;
        b=mvxMHfMWvku4AfDzfhJkQgTkMsMYJQUGVoegW4ecfDKi0g3H7AvzQTLVcegZQanM9n
         K5cqx/iXQDJ1qxLKsovmGKH+uXPbjmdam0HOjqbOZYFP8FXDg+LU6NpRUthmKQNV/i69
         GXSajujIE1F6T5fmbGmWm8EADTknnxclfqpGKwrZFFuZE9r2RycbiVkoDjXmJGOCrBIv
         KcEaurUV1hDaVv4FAOkD4pX2z8Zo4bJVVh9Zsq/xKee7B80IRqe1NFuxjijiQPhBLCOb
         jkQPHl0VNIEza6ml/Y088PRrO7mZ7YE+F+OxSWxv1TV0KejKQhPIDYUu9X4tuebfOaMX
         PGiQ==
X-Gm-Message-State: APjAAAU9zOpPovejwWbLbKByIXWw843AZEjaahP960BbqnsW0oECp3I8
        Sx/ENWaDUC4SeRsYDKQQ7rU=
X-Google-Smtp-Source: APXvYqwc2ui0Mt2oTeKC744R/igCYt4EiQIOknTQYNHjLP0uMC9mU0xWi9CCaJFSbTibukNF7VFTFA==
X-Received: by 2002:a0c:b621:: with SMTP id f33mr19245270qve.199.1558146666930;
        Fri, 17 May 2019 19:31:06 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n66sm5210322qke.6.2019.05.17.19.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 19:31:06 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     gneukum1@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Updates to staging driver: kpc_i2c
Date:   Sat, 18 May 2019 02:29:55 +0000
Message-Id: <cover.1558146549.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attached are an assortment of updates to the kpc_i2c driver in the
staging subtree.

As a quick summary:

Patches 1, 4, and 5 address style concerns raised by the checkpatch
script. Patch 1 (a reindentation fix) likely added additional 'line
length' warnings, but given the fact that they were only hidden due to a
nonstandard indentation style, I elected to defer that work to a future
patchset. If the reviewers should disagree with that choice, I'd be happy
to fix up those issues in a v2 upload.

Patch 2 is a reformatting / reorganization of the copyright header at the
top of the file. I attempted to look at some other drivers in the i2c
subsystem for inspiration, but I'd be happy to drop this isn't as simple
an update as it seems.

Patch 3 addresses a potential bug in the cleanup of memory allocated in
the probe method.

Geordan Neukum (5):
  staging: kpc2000: kpc_i2c: reindent i2c_driver.c
  staging: kpc2000: kpc_i2c: reformat copyright for better readability
  staging: kpc2000: kpc_i2c: prevent memory leak in probe() error case
  staging: kpc2000: kpc_i2c: use %s with __func__ identifier in log
    messages
  staging: kpc2000: kpc_i2c: fixup block comment style in i2c_driver.c

 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 1043 +++++++++---------
 1 file changed, 527 insertions(+), 516 deletions(-)

--
2.21.0

