Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF0FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA882070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eB3u/4N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfEPVm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:42:29 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:55371 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEPVm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:42:28 -0400
Received: by mail-oi1-f201.google.com with SMTP id c64so2028895oia.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bCifeYOTD3ZRMR+f0DJzC8Jsulb5gaAzagPHZLEhx8E=;
        b=eB3u/4N9Lqf1dpOkY9UM43yqpeZDopx8/soQCcOB2zamnS3shAPt6eJYcUjtwZ68aN
         54eUKlps4CZWJTRsXL5V2YpQgv3Ck8tGgZQ8VLWpucd6LkJHBsNaIqOw9gAdbwMA7old
         W0P0pDzR/Nmr+Ivj0q5UG/63CCRxK+iwccajCg4qF8mOs+Qvo8wrikc+rDwnPQ7PdNmY
         sspwXzouTux0Y/5Bg0xxiy5L0ebt8zvxEx4O9M7FKN1+sHpXbRg0I7d0+fRrjZAWGrc3
         DyXwJmdvqYDva/ZbQUHx1aTKWkgX+/wLP2keuESnXg8vHpK7Iswkjlpks48QPQoNjWg9
         9sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bCifeYOTD3ZRMR+f0DJzC8Jsulb5gaAzagPHZLEhx8E=;
        b=KBAZtV78T3h9Hl5c3fmxFXwDusHi/x3W6/M/MPbSwJ8a3rrmKzk37J1QN5uz+bpLQL
         j3Ckakb8oDuIiQfG4ydx7C3QCkuxonKtMp7mF5xfMioXkNNZrssdQFOJcN+SRHoaHeE4
         xLPvQyZufqIHBa5iyl1lyiVStoRNPjtM7sA5Q0omDBTTDFXMe+i330BO6GaN9lzkJ1l/
         feu7apgviVzryFb6DUN/lpPry6thugzmjWOAqbDGpx7vpJ+xgK1v16HJlM5D731DnVjt
         470fVRu1kWhN/AeDS+mxMK7qBJvsLbIRItiOYGd403TFCKVKoR65cdHzr7jCIfW6EpTO
         p9BQ==
X-Gm-Message-State: APjAAAVPVefcCs9RoTK4P4cK90qnnUsUH1cgmg7qbLbwAXVQMcGxB+G8
        CXhBaxeh2csrVnIjDDKYG43tvaFgtQ==
X-Google-Smtp-Source: APXvYqymfc3zRs8o+jSc39kXwo0wB9flMCq+k1ZIVTCxqqf0oZhBmiZLWGcuX/yjgG0+8sd0WZgjf/2hhg==
X-Received: by 2002:a9d:7347:: with SMTP id l7mr511806otk.183.1558042947824;
 Thu, 16 May 2019 14:42:27 -0700 (PDT)
Date:   Thu, 16 May 2019 14:42:07 -0700
Message-Id: <20190516214209.139726-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH 0/2] Fix LED GPIO trigger behavior
From:   Kun Yi <kunyi@google.com>
To:     linux-leds@vger.kernel.org
Cc:     Kun Yi <kunyi@google.com>, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, dmurphy@ti.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***
Hello there,

I recently tested ledtrig-gpio on an embedded controller and one of the
issues I had involve not requesting the user input pin as GPIO.

In many embedded systems, a pin could be muxed as several functions, and
requesting the pin as GPIO is necessary to let pinmux select the pin as
a GPIO instead of, say an I2C pin. I'd like to learn whether it is appropriate
to assume user of ledtrig-gpio really intends to use GPIOs and not some
weird pins that are used as other functions.

Kun Yi (2):
  ledtrig-gpio: Request user input pin as GPIO
  ledtrig-gpio: 0 is a valid GPIO number

 drivers/leds/trigger/ledtrig-gpio.c | 35 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

