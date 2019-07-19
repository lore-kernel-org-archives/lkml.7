Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328AAC76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0748B2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="VGetOwiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbfGSXyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 19:54:47 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:42636 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfGSXyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 19:54:47 -0400
Received: by mail-pl1-f177.google.com with SMTP id ay6so16347866plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6cF21B988mtg8JkiiTcyqs2kw0W/2vZ4uwNBCFvvJxg=;
        b=VGetOwiU8W6Z/ZIH6yHeTxN6eBQuK6msIQeicLWmsVqIOUdVrjh88gSSdpVgWNpQh5
         FToFO6imnfCJFIHoiZ5dNCVn0mTvIn7AGJwN1AN1t72Q3HZCIwgKqKCy9Yca3JNEHG/Y
         UU189UtvDEpfx9JqceNKzmDEG0Rn4nnk/zOvZyKIoB+zhPjcsvZWgxrr3Knkr2Cb9I+f
         URhAf4cVUnvEvi1lqZddiZriyPy8GbCOvBNYs7h2qt+BgHD1DktEN5VACq1HPNlyN1WP
         TxMMu5mJweBoXXs5jurgV4jsjcOTDGPJC75Y8vgfUhOZXRzlfOMeYLGMgORVEE6jH7rU
         KJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6cF21B988mtg8JkiiTcyqs2kw0W/2vZ4uwNBCFvvJxg=;
        b=lH/7WaPd83dAAEk8m/yAIIAl+kBhDoUJ/vegF+KvNJvr6I0GD7sAu4UgHd97C+fCli
         g5F5c3pqTcLDxc4KNy6PwKDHB8OfSbcwBbmnBlGpS1GN8cgreM7VyCm6NXZQqNcNHSlz
         /XRxLQKutq4oxUByWn0vhpoY2trToWLDKyn0RUK1Y6Vi6FA2mYANBr/a6BnAwcKaPSBK
         vCvG8egaSaVSk+kdG7iXJO5UE5lNLGoXupgtafS5iYhyrix4DDBXUyUrmn/7dGAq+c/I
         Lz2Wv1hgPviQq4TEUZnUStu9iiUn6e8cFPujTfNQkvxEKqjGtrp9I16V2TnkU5jCPXI9
         ceEQ==
X-Gm-Message-State: APjAAAVs5EUkcqYNwPq0B8q+WBuCyqwxObsldF3U4xTFpV7JykjWQ/2i
        1bFU0A3wm/cEA/3aOWabLjXndKlsR+w=
X-Google-Smtp-Source: APXvYqzqDQr2Tyw1CVrA8UzuF1hfUD3iN3eA6nsQovNh4riXMppPXhP9mcZffXSTBgN3Cf9txn40YA==
X-Received: by 2002:a17:902:5c3:: with SMTP id f61mr55498786plf.98.1563580486272;
        Fri, 19 Jul 2019 16:54:46 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id v184sm31975215pfb.82.2019.07.19.16.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 16:54:44 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, arm@kernel.org
Subject: [GIT PULL 0/4] ARM: SoC contents for 5.3 merge window
Date:   Fri, 19 Jul 2019 16:54:30 -0700
Message-Id: <20190719235434.13214-1-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Squeaking in on the last few days of the merge window, here's the ARM
SoC contents for this merge window.

It's again another cycle of business-as-usual. We've seen a few new
SoCs, a handful of better supported boards (and new boards), and the
general tweaks, improvements and cleanups. Most of the hardware support
is described in the DT pull request downthread.

One thing worth highlighting is that a bunch of SoCs and boards now
have their GPUs described in the device-trees, since the drivers for
Mali have been merged.

We're also experimenting with improving our merging flow, adding email
links as been discussed, and added some more automation on patchwork. Most
of this should be invisible for those who don't send us code.

Please merge!


Thanks,

-Olof


