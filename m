Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2981C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D21020679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfFXGTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:19:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39354 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFXGTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:19:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so6287000pls.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Yk5g4E1oOOxyZWouEDSkn3wBtFgCalVkAqRyr4Twh04=;
        b=MNJap4nKmkM9SQwMl3zGpywLZvknKFpQ6LTJt89YWLL+w6BOUWU3zL9owvr9SZBjSm
         Qjc+WpNVCkWeEWjgMNxEolfp416RXnQLkNIlZfegpShsr3XuiMDzhxylaSJ7eKx53Fzh
         lDGOlRBBLqBWCX/XrhctbDu0B/3nQyl3ltSWuQbdljskTRcDLUY7IuYqspiuooH8bcrT
         H2ZQyxP4aAWBERjG685Zhx64YWqU00CXOBhvBpewivVnOYY5A4w63kcC9jNSL7RxYkc1
         iykpYmnYYd09ZuPv3R5mglTunb3cKGzNjAd7K+ecsWNt7IL2man7oSajuRhMJBlj0VD+
         pEIw==
X-Gm-Message-State: APjAAAUfq2eqec9C4Hyfmyf/489Q6bSFE5lrdVn+bK9yTPtjkVds7Cwi
        jSahIDk5yhW2sWnxuio+x825qw==
X-Google-Smtp-Source: APXvYqzwssm7ZD70bnrrYdcH/DhTHZHfURHw6XroLCE2C6HFfBMDxWngPW9zv7qCLGInB6xuxsOJDw==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr141275004pls.323.1561357144505;
        Sun, 23 Jun 2019 23:19:04 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v9sm9874143pfm.34.2019.06.23.23.19.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 23:19:04 -0700 (PDT)
Subject: net: macb: Fix compilation on systems without COMMON_CLK
Date:   Sun, 23 Jun 2019 23:16:01 -0700
Message-Id: <20190624061603.1704-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     davem@davemloft.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our patch to add support for the FU540-C000 broke compilation on at
least powerpc allyesconfig, which was found as part of the linux-next
build regression tests.  This must have somehow slipped through the
cracks, as the patch has been reverted in linux-next for a while now.  This
patch applies on top of the offending commit, which is the only one I've even
tried it on as I'm not sure how this subsystem makes it to Linus.

This patch set fixes the issue by adding another Kconfig entry to
conditionally enable the FU540-C000 support.  It would be less code to
just make MACB depend on COMMON_CLK, but I'm not sure if that dependency
would cause trouble for anyone so I didn't do it that way.  I'm happy to
re-spin the patch to add the dependency, but as it's a very small change
I'm also happy if you do it yourself :).

I've also included a second patch to indicate this is a Cadence driver,
not an Atmel driver.  As far as I know the controller is from Cadence,
but it looks like maybe it showed up first on some Atmel chips.  I'm
fine either way, so feel free to just drop it if you think the old name
is better.  The only relation is that I stumbled across it when writing the
first patch.
