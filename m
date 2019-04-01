Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD47C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE56E20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7JLvmsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfDAR02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:26:28 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38684 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732173AbfDAR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:26:22 -0400
Received: by mail-wm1-f47.google.com with SMTP id w15so281392wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bv7UCjI+yNjcPMWEEp3IAWLYP8xT5TsLG2d0Pq5TfV8=;
        b=K7JLvmsW0/eJ0djurBxHWJFNWUjXd9f4xD++B98nr7sBsuwKdEVUDMhcEkAnC0f/qH
         aGm9Afv+2nOlQ+GlHFCxGbuaAuKJ0ulLK4YRibEhJm0ujl4QUNkYvqVNYc7jxAAoGOqF
         F8AG5jkrebughhLvxZZ5QnR+8QwThHzD0MiOIe3UQapQoYdZ66jsu0VT8363zZ/LYeOQ
         pFA/eHlshiJBr2XskoHtwFKKq/vD1JdFFPlOkr10hNkZgQo0gy2z0STchrtcEs3Y9QHy
         wjAyq+5asyfkosZonoR0BU/7O3IsrC1Gox4Z754hNPbalbi3H0PK8Q5r20s6LaaVz+5H
         uWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bv7UCjI+yNjcPMWEEp3IAWLYP8xT5TsLG2d0Pq5TfV8=;
        b=RqFy+KtZfnFkIKzw2faPw9U00h+UTUjsrpHRMGS7psaYG2FuB44a0n0hJ2+p+LxwDR
         sKk6DtJojoTIIn3GxTG+1GOjaPEz1GxRM1edodIUgE+zUR+R8/5z8NR6fK7N1RWUz7Wl
         90tg/yCiHxM0+KCkzfk5P9/hzyPTIOKPuKneLRG+Pvh1Q+2i71O2H98pf68HO4wJqKSD
         z3xOz7o8CL9L+2IKbjt46Mca2sQIhCWqjdonEjV50YqGvoZ1d8OdSEmHr+fbZUvPlAKx
         uIQH3GkIqJOr5EdmoHuNKX7WiJsmXCW78FGB0xDi5cw1TzjajYQ0DM6rECWpcBB/k1C+
         xWZQ==
X-Gm-Message-State: APjAAAWVBf83XcReTPh6MA57jrLw3vxpY9J7DolbiHPK+aTwwLSnutPU
        pmjYAJVH1eGJHV2zyryFTMc=
X-Google-Smtp-Source: APXvYqzuLMEWk1bMnId9IBJQ2LiwWa+AfdqkAgztemNJn+gVYSnyrIes7NQzBJgYD758u4uuXRL+KQ==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr468562wmj.111.1554139580844;
        Mon, 01 Apr 2019 10:26:20 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 192sm6717035wme.13.2019.04.01.10.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 10:26:20 -0700 (PDT)
Date:   Mon, 1 Apr 2019 20:26:18 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.1-rc4
Message-ID: <20190401172618.GA6090@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

One small but important fix for the next -rc:

- Fix the low credit limit for DMA channel #0. Without this fix, the
  channel is unusable by the user.

Thanks,
Oded

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-04-01

for you to fetch changes up to bfb57a91c2cb497c3780ed2e08f85d038efd0b7b:

  habanalabs: remove low credit limit of DMA #0 (2019-03-24 18:07:02 +0200)

----------------------------------------------------------------
The following bug fix is included in this tag:

- Fix the low credit limit for DMA channel #0. Without this fix, the
  channel is unusable by the user.

----------------------------------------------------------------
Oded Gabbay (1):
      habanalabs: remove low credit limit of DMA #0

 drivers/misc/habanalabs/goya/goya.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
