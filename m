Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76483C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B102218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KqpADW95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfCOUpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:45:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37383 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCOUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:45:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id q206so7245027pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=INmq8MbRt/UXoxqFi0o2O4Jb/P0MxYcsAHf+jqSjeuw=;
        b=KqpADW959wxweuXQaNPwEG7NB8DAOpHTugic6BlOW7hVGn/kk3oXiNRnGRXmE2VbrK
         CANNGuSHfjDy8YOtLNHilLW9cpBvlkXun/I5ji5EvutqtORo2gmxOizyU+Ik81FRzCaW
         UHhCFfVHCY63hAI9elb8Mn0pO0IDo6knFb0qq1+E+dKtnVCYTUp/M4n2Iv58yn/7gPoN
         xJITe386f/JW3inCKjWov9d03YHbZyUlYnflcDv2chxOD+akzdsimP8GOgNLB4Fd1btR
         GoZwRoDGW/K38RPRCGoBbTsG/lOWpr9h/Rdu9vhLbPveULADaOU9psCZ6MVYcuHP6ohZ
         oK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=INmq8MbRt/UXoxqFi0o2O4Jb/P0MxYcsAHf+jqSjeuw=;
        b=R1s7vHg2WQ93sQPInIeXIiCpbYXJNHvkw2R396KXm+o3gZT7gJJe0S3OaPXWHRyvyE
         iN8azF9rYzTO3ozthiU4PG9n+nA4b4ZIOiz9lwJHAzgRaA91jQmgoR0fFTWK/5j6WPI4
         koutNjAFNnnXWu/PyeTv1hE8K14yV/whUTTjjhy6chQ8RMaWta2+XANJfIt8OjV1/JcD
         usQWsBJShETTjC5eEiY6zkN8aXuZWyETPQKGkmDv/qR6KwEaP4ogemLXRAtRvFKTTutW
         da+OQ++LBkjmsXNXJiZKlwjg3ROH8KFy7rvlXdnAlOxVIAhu0mvIUmYYhopvAlataSM3
         aNmw==
X-Gm-Message-State: APjAAAWBKT4lcWYZUS3RQHc0myGCkasQs6fMuna6n7UftY54H8Afi5Gp
        VY9eZMTJ04shyLONTuon0DJRme74o3c=
X-Google-Smtp-Source: APXvYqxbM7ZNYq0Llh/Da5etx9sUL9osubd8FOI8k7hLkoLxuRuaI3Udfs4WjIB2pUzEiW1tcPtQkQ==
X-Received: by 2002:a62:5687:: with SMTP id h7mr6005464pfj.198.1552682739662;
        Fri, 15 Mar 2019 13:45:39 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a567:ae30:4f79:6ce5])
        by smtp.googlemail.com with ESMTPSA id d86sm9975887pfm.18.2019.03.15.13.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:45:38 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: g12a: add secure monitor and efuse
In-Reply-To: <20190315134244.14141-1-jbrunet@baylibre.com>
References: <20190315134244.14141-1-jbrunet@baylibre.com>
Date:   Fri, 15 Mar 2019 13:45:37 -0700
Message-ID: <7h5zsjc1e6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the secure monitor and efuse to the g12a SoC family.
> These are sent together because the secure monitor is required for the
> efuse driver to work properly. This is probably something the bindings
> should show but it was not designed that way when the secure monitor was
> introduced ... something to look at someday.

Queued for v5.2 (branch: v5.2/dt64)

Thanks,

Kevin
