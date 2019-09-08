Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E276C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 08:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43122082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 08:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2wFFBVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfIHIAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 04:00:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38107 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfIHIAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 04:00:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so9400667ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wbSNJrCAMMQJMsBoL29fGN+8+5asXhPwIIrH+qFROu0=;
        b=B2wFFBVZS2tQgIEY42dR7+c/26RYg5hKQMiSxHnvNKlrT6w3VfP/D65XHDWF3tU4PT
         o+O/04SVby78Gqwmhit7Hlzjc4iuPS96ybm3db4WncHo9d+beRsfBVBn8/JwV48aRasa
         H0OaF765vXtU/lHYIh660Uc8tpckvZdA3/PfFlcT8pm5caheaiGAnc7ifkplWaTC7v41
         1GbHhdLJXOltgKZfkd2rj1KcDLarIlyv2kGYQMZEaMUOrwzscGnq9J2MNc0Y/n5GdU3F
         5EZIZ1K3tM1W7S+TbY2+EPUiV5NJqlI7TE5/YXH+OoHvnHm+Ui99lVN1mybTVa4PGFsI
         3yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wbSNJrCAMMQJMsBoL29fGN+8+5asXhPwIIrH+qFROu0=;
        b=neVlYWb3+a4y+EL3dDbWAxqlRTXvhoXp/VipekbDG9pI+SQvkJxQJxZL5b6FjFXFE3
         7A1KtyYdIjXHepKdPwf/J6ld2Whpy0GOiFtJKaAnVnPUA37X5fnO3U6OuaBVC89IqZFk
         NUER2NegMF4TAfsbRcL/0ACEEvj8/AK82y5u9KtfV7Co7Oj4FAA7tYS5Nx3/zSxTo+PB
         PVpZIYNtBZSBvujRcJXhGAcKt3gk7dGO/1MLi3x19LusWv5lyBs6HFSzlKCTo36b1jME
         5760EIAk+kNMXvwuPCR/M1jqGHmHUK9Ba0ct7BQukxyxZgLMYvpe5gkvUvWMdGPzOz9Y
         cbTw==
X-Gm-Message-State: APjAAAXdhbzXsw1XhkOnLWCkHaJDdL+ZTFf4CP2pskI/cE/YxCqohMeL
        6wfaHU392eK3SRHQTXW1KiMpg/93qXesMjsOlTcxO2aYO+KKGwMQ
X-Google-Smtp-Source: APXvYqw6wtbItyTMNxmQSL+6YPhMyTlVsY65bMRTcpjMt+/ghv8xzVMdU/PSxMDbEwBprdXJ3iVlsITqi2bH0hvmdzc=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr11211958ljj.62.1567929638593;
 Sun, 08 Sep 2019 01:00:38 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Sep 2019 09:00:26 +0100
Message-ID: <CACRpkdYEPBOFnKvNiH0kSOZWTujMaMNhQQgRTGSZUosbbqAdkQ@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some (hopefully last) small GPIO fix for the v5.3 series.
Just affecting PCA953x expanders. Details in the tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.3-5

for you to fetch changes up to 89f2c0425cb51e38d6b39795c08d55421bec680c:

  Merge tag 'gpio-v5.3-rc7-fixes-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into fixes
(2019-08-30 15:28:04 +0200)

----------------------------------------------------------------
GPIO fixes for the v5.3 series:
all related to the PCA953x driver when handling chips with
more than 8 ports, now that works again.

----------------------------------------------------------------
David Jander (2):
      gpio: pca953x: correct type of reg_direction
      gpio: pca953x: use pca953x_read_regs instead of regmap_bulk_read

Linus Walleij (1):
      Merge tag 'gpio-v5.3-rc7-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes

 drivers/gpio/gpio-pca953x.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
