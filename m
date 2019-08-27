Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F98C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2BB2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l6uFNGI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfH0TRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:17:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36725 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731229AbfH0TRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:17:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so30814plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=vJzw3QpMeKUQN9mhk1L8KwSYlM1O8J0WfSacmAROoZs=;
        b=l6uFNGI6x957C+EC5/aW9Yx7fg8JZ+lcCqjjsTH+8k7iItlRBiXO8ZTf9SNIpupFkC
         oSuNmg7PFn/ebDs8M8g+KOaI04jIfrTDroOVpzIItWImSWSf1eHhACbRgzRsaNUONRsh
         rplv2ndYyVe5diOf99PXG0oxUEzZRkYGLNFmLv4iahEuBPwYYdWAqzVdNsmtakNIxeqB
         a/NrJiL8vYCBFeFXW2y2TzpuH0JTd+0iRIqS20qyq6GuCiSuN3vt5+20VU5OZMuLjE27
         CDDG6b9OsVLL8Tk6E10FTyg9ncG/KR2ZmGwP9VZN1jPOiZ1aVMcfT3q5LkACVukAJZks
         YqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vJzw3QpMeKUQN9mhk1L8KwSYlM1O8J0WfSacmAROoZs=;
        b=QZG57tzfvnTywXG6/iGPdlHtuaZEaf/BXfaBo7jb/Wb2Fbg+55w3wVsatHFFkSe80t
         EoiFwlpY6Vhor1nXuQpXKwAkcV6s9HHU6XR4TL0AkWQ2O9Y/gPCGNH8EsV+InFk0EtAJ
         t/fwkWCOfrabzhCCB+PqR+Su3vqpHJZRNos+psO0+pzPn7VcBOMF0hbnDHvEqU0FCbO8
         WBgz+P1xK40HfQBVCJMDs/Dvfo9glnhYrteS71C5zzxUeSB6PwGNTNyD40+VUECGJZcb
         JldNdzye9T/etQb7mvwkTZTdELBk4GBRTefz3sdxrVbNNNcxOve9E6z2VP+DitFElW1f
         sEuQ==
X-Gm-Message-State: APjAAAUI5FcNBDPCS1XCdbH7lfAT7vwmLVFYxfPs0inoVaTziMAasmRp
        kwMMFqyUQugUGQyImucG/TZAIw==
X-Google-Smtp-Source: APXvYqweKeR+O1L8NUQ1dGQZwjj/kGMRlK298lUWAQfX/o+FgU8fpeeMRjkf/+I6PLTs1JLB3DAJow==
X-Received: by 2002:a17:902:8488:: with SMTP id c8mr440778plo.164.1566933473391;
        Tue, 27 Aug 2019 12:17:53 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id z16sm65758pfr.136.2019.08.27.12.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 12:17:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] drm/meson: add resume/suspend hooks
In-Reply-To: <20190827095825.21015-1-narmstrong@baylibre.com>
References: <20190827095825.21015-1-narmstrong@baylibre.com>
Date:   Tue, 27 Aug 2019 12:17:52 -0700
Message-ID: <7h5zmixvrz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This serie adds the resume/suspend hooks in the Amlogic Meson VPU main driver
> and the DW-HDMI Glue driver to correctly save state and disable HW before
> suspend, and succesfully re-init the HW to recover functionnal display
> after resume.
>
> This serie has been tested on Amlogic G12A based SEI510 board, using
> the newly accepted VRTC driver and the rtcwake utility.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Tested on my G12A SEI510 board, and I verified that it fixes
suspend/resume issues previously seen.

Kevin
