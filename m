Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B08FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA04520673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T5EiCgkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfIYW5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:57:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45872 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfIYW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:57:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id u12so62900pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Su3YbMX4TjBXJn8xWP4LnB3UVGIbfhWnsfvHaIxOPLo=;
        b=T5EiCgkE9qhORn45R+LPqlJ9tdLHwlTiKN2kkaOpBKnmOA7A8BHRSboW0hfi0Oa9DY
         7sUvBQe0rag9+C27pnWS63Qceqnfy+I1KB3UJ8kVKTkhIkfJe3Staa+sXT0BlomB2iU1
         JqBCyR7vYMygJJCwqni2pGCatNSwwjfkRAIAJ1T4S+rxFGbL+EgFJK3lWzgRUx1gPvrg
         V3H0XTkWimm420fik8fxvwU6FdCc6xJnu6RcdKW+yftO+s3BPhrwfgF80zZlsZOIAx96
         Ul/cdvrNKTWrZY07RFtbvMzt7UhwEtSOf8af2RKj0g+B7d/kR+/Psa+qPQBmeo7ysV5k
         DN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Su3YbMX4TjBXJn8xWP4LnB3UVGIbfhWnsfvHaIxOPLo=;
        b=kPP+Wm8j/Laz4iG0u2tJabr/XlMRHqTFcu5/mvhJPzygEtKn9vtpuRO+ub8TLzgdP0
         ZgjriYROmuXhdVcLGyFXQFEovOGjIR3Tc2hA1XDg3OH9aoLTJw9Pjq8mcL0GPd+RP7ZS
         cG1N2LwamDWI/SId3/L2G1fiOW8XQuVAM5ewCZsN237DCnom7RV8i3riUU8JT7wg2eiA
         Ip3lKoHzfW8snfvfz8iZzvbkKK24Rxakc46rN5OzUgMMWI3JHRSXGnrnTw63IvRxQDb6
         NoXt0jIoWsELkrj4mi2shL0Td50IGjKUe+qVW2ZgaAiRkvM1MvW15bbYdrWnjhvnZZk+
         Nigg==
X-Gm-Message-State: APjAAAVJPsJv7V8rvByN3oxrflMcGVf99LuOD/HMiXbdHAGw19FXyLKJ
        KzVM+dTJL2cuGnP0FnZtJsvxMg==
X-Google-Smtp-Source: APXvYqzGVbr0CkFH3ciLzynsBdMN/FIPGIUhMEZhO9+EU+yLvS3NZ9X1vfefUaaj702D8WZl+2UOzA==
X-Received: by 2002:a17:902:748a:: with SMTP id h10mr511672pll.257.1569452228436;
        Wed, 25 Sep 2019 15:57:08 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d5sm118177pjw.31.2019.09.25.15.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 15:57:07 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] reset: add support for the Meson-A1 SoC Reset Controller
In-Reply-To: <1569227661-4261-4-git-send-email-xingyu.chen@amlogic.com>
References: <1569227661-4261-1-git-send-email-xingyu.chen@amlogic.com> <1569227661-4261-4-git-send-email-xingyu.chen@amlogic.com>
Date:   Wed, 25 Sep 2019 15:57:07 -0700
Message-ID: <7hlfucrnlo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xingyu,

Xingyu Chen <xingyu.chen@amlogic.com> writes:

> The number of RESET registers and offset of RESET_LEVEL register for
> Meson-A1 are different from previous SoCs, In order to describe these
> differences, we introduce the struct meson_reset_param.
>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Again, order here isn't quite right.  Add the reviewed-by tags first,
and the sender should be the last sign-off.

Other than that, driver looks good.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
