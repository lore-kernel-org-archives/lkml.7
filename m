Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3181BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C5121872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KsRq9jvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbfHZUOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:14:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36844 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbfHZUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:14:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id g24so853238edu.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEWFNP9G9XRQyNplR93hNjA88jcDbmmCg7h8xD2JEzU=;
        b=KsRq9jvc8+HnjknGWkm6taWVUdOk9oNM+c04XJIBVUYGcOP0MJNkQx9WOTX/WpSWMR
         VDHNqXxPNfx5r7fkM9tldZ4RH+WNleFaR3gLttKhoLCHbB76RNSX9LZcPAWgXMLWGZdX
         CA567cCQXUiG7iZja4mZg3jSGGXg0k9TiOMdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEWFNP9G9XRQyNplR93hNjA88jcDbmmCg7h8xD2JEzU=;
        b=hN3oDDsfGYh7poOLRaklxog/0+DU4lHrCHbTF3YEknfEWxc6JpzTrmkf5EON02CIOW
         kICIKsa+YK9wa7TxXHAaAskyT7M9QgxPG4VhQpedozIJt3Av0Nn8ZRRje2Pfp8s/S6Hr
         8qk/FE7rtKNwt5oD9UjVNZzinLx5fyexwE3G2qYB+ZN/LmPfHUJHBySo9X/z8ch0Bm1g
         y8ZWTgAW/69x9lLvGz1dc67dnKSETVhCzNgB1hw55sAOAmuxKZCqcI7B+zBl7VBeZQ9W
         V+qEYlF/+btylMJbrsYH3U9+CH0pHny//6T8DRibBVd4sZ2DuUGNipTQKPmp4/N8y6CG
         9Tbg==
X-Gm-Message-State: APjAAAWo+XSh2yl+YdnGFWlSG/SBkRfwvbu1+owh2dUS+v1mDE33k6hV
        QBtFp7XAzM3ZOjE9q7eyaAA9CpxQAtrBoA==
X-Google-Smtp-Source: APXvYqxLqEPD0/LdFMncbAYamThZ56ARg99koHGS0Ym61r97PqUdd+AzAX9vwScKfOBYaciZi35XAg==
X-Received: by 2002:a50:cc99:: with SMTP id q25mr20152694edi.207.1566850471666;
        Mon, 26 Aug 2019 13:14:31 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j25sm3000780ejb.49.2019.08.26.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:14:30 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/5] mmu notifer debug annotations
Date:   Mon, 26 Aug 2019 22:14:20 +0200
Message-Id: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Next round. Changes:

- I kept the two lockdep annotations patches since when I rebased this
  before retesting linux-next didn't yet have them. Otherwise unchanged
  except for a trivial conflict.

- Ack from Peter Z. on the kernel.h patch.

- Added annotations for non_block to invalidate_range_end. I can't test
  that readily since i915 doesn't use it.

- Added might_sleep annotations to also make sure the mm side keeps up
  it's side of the contract here around what's allowed and what's not.

Comments, feedback, review as usual very much appreciated.

Cheers, Daniel

Daniel Vetter (5):
  mm, notifier: Add a lockdep map for invalidate_range_start/end
  mm, notifier: Prime lockdep
  kernel.h: Add non_block_start/end()
  mm, notifier: Catch sleeping/blocking for !blockable
  mm, notifier: annotate with might_sleep()

 include/linux/kernel.h       | 25 ++++++++++++++++++++++++-
 include/linux/mmu_notifier.h | 13 +++++++++++++
 include/linux/sched.h        |  4 ++++
 kernel/sched/core.c          | 19 ++++++++++++++-----
 mm/mmu_notifier.c            | 31 +++++++++++++++++++++++++++++--
 5 files changed, 84 insertions(+), 8 deletions(-)

-- 
2.23.0

