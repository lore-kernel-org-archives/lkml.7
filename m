Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD9EC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB4E2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QidYQZ1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfF1R56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:57:58 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:43382 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfF1R56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:57:58 -0400
Received: by mail-pl1-f176.google.com with SMTP id cl9so3636384plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JXDx5Of53xKpwKzie292LEzpOCIt7HdxAp/TZojOC98=;
        b=QidYQZ1e5tVfpSNlbzJAwZ1PSEo4dbT1h4HX6qlUhaYy/0WDP2DbYNFPTucwsPtXtJ
         P5Da3q4BSmLlg7YBmA0owHM1bUPrEb7BS8gzdHoNIWge3t/+SscDfMMBa3vx9swwjY5n
         LFvDrn5pgiwG3LzawIGsvptYLxKuORQdAVK4jqhJjDPscsuEl0XBsIcIhtmOUiqLnY31
         rl5J0Is/8LGOWfkwroXrx5lrTEZnf+8x1H9rCHGrYrmt0cwF3/5ZHvKqdnUE5x9l17cs
         65Qi5bpDUOP3xQ2tieEt795doUy4MrobU1fhvRK9NMQeo5arbU4RPh5V9yXTVNhCQ2rL
         ovHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JXDx5Of53xKpwKzie292LEzpOCIt7HdxAp/TZojOC98=;
        b=t7On/6VSw+4QQMgQhgTYZIEdZ4eQ5gPZSB8lP5btlrvJ9FtgRA8GDzrQemiwVck/DI
         XwdVh9852HnmVbenEJaQuj0GujZJTR80GpGs8gjxgnVeELf0rAKXNxNBCigNGOCYBrTg
         ysnObMhjfR5bOHIVDtlG660/dX4JrsgSv6Fz+P/duBMFfAW7S9OoIj1RG+KrwWpohpF5
         OybeJrlyM9629WmUWSJynsMPYEYPeoZdVd1MqvS3t+uITOiWgjdAjWf+bKeMljTjC6bR
         79qfe7b/8ZiCnS8mQ6IKHBl722DvPiIBEA75S5sxW574b0wORCgEN7JEN9W01QR5wdTc
         y5MA==
X-Gm-Message-State: APjAAAU88IBMhayw65qAgWVBMb75pBzGLMoupBkGnJ+ZJvIXcEP5mmEv
        XvXSxKygOw5cNdkql5yZ4cn9iM/cQyC6ww==
X-Google-Smtp-Source: APXvYqxBvlNYSLn6PRoeEXRuFeavrw3x9z3+yywP5RFfiMDYAfvzlGijWI2kL3fNFlbko9TEHruOVA==
X-Received: by 2002:a17:902:3341:: with SMTP id a59mr12892929plc.186.1561744677360;
        Fri, 28 Jun 2019 10:57:57 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id c26sm2814912pfr.172.2019.06.28.10.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 10:57:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFC/RFT v2 05/14] soc: amlogic: meson-clk-measure: protect measure with a mutex
In-Reply-To: <20190626090632.7540-6-narmstrong@baylibre.com>
References: <20190626090632.7540-1-narmstrong@baylibre.com> <20190626090632.7540-6-narmstrong@baylibre.com>
Date:   Fri, 28 Jun 2019 10:57:56 -0700
Message-ID: <7hsgrtr3rv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> In order to protect clock measuring when multiple process asks for
> a mesure, protect the main measure function with mutexes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
