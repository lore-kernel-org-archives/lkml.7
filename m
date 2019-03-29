Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB29C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4D120657
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dXR44ej9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfC2U5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:57:35 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34631 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbfC2U5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:57:34 -0400
Received: by mail-pg1-f173.google.com with SMTP id v12so1774682pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yOQHIHqs6rJaZH1VdOTite7NVnkSWVgMNqjDuwcXG8U=;
        b=dXR44ej9qLc+ja0JxocAvzju9L4iOyYI9TEZIQBjBCVO9+QvNhKapqjpDaY3MZ2Dsu
         iGnLcjYE7gv6o154g85DmtbiRybRxlrHhzFH1gw2zdUFtvSuK47WNx2X476jkfxAl1LO
         3j26FE2ggjFGptIouKrRFd4d+ycgGSaRIvXfKpxJy6mbnXN0clHHmdzhd01YqY/oFSIF
         i+6NKoh5d27EwnTDIRZHPdo6tRIJuXfRdUl0OkoIpSUAgluE/T+RrzhXuq1w/VaH/yjU
         P+2NraFKe1+8/8LQ3tuAUBvC4fcyfYjGyXo/5in8s5tQD4qQx6QvF7XbZlu72v/dHnEV
         xG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yOQHIHqs6rJaZH1VdOTite7NVnkSWVgMNqjDuwcXG8U=;
        b=asnRhBvh4nKOLRNolnesidKGlbwqbCmupVqGWdimY1w0BAQKjaONwQilthhXLfHsrA
         80kkuurEmgqB0E0Bj3tlip63CnRJx4YmwhBWqPoZT9aLe605KteGCSL1y6BeQce/yFcV
         ix3Wnhs3Q8L9pQd1wfoBco6zeHyKUtPEm9RaPPMMARBZK2SDzxV3tIMQcwOSVOd9Ylvz
         ioyJyhNKuTYq9qFg8VCexQB6joHu0OtSSTfg5s7LdpIU4SiqDdpZlD6M8bb6je0EJlHP
         9W9l6I04VhdVzC5t1jHpNEsvrnPd70GN8v0rnUvDaXCR6iqHx0pYiwe1Zf9wBTr5afIE
         lyKQ==
X-Gm-Message-State: APjAAAWurhDx908EyRssKjX7iXmrEgeQZ2410PiFaLUrPzfvn9sQipcb
        r1RnPyNWiXgelqQgAV2XCTax4w==
X-Google-Smtp-Source: APXvYqwUHTIyRfhErGvZU8IE6qbbE/vosE+F//qOmRab0/qjFkzRqKqLU5PDrKQcBqjhuGwjAvGgsQ==
X-Received: by 2002:a62:4649:: with SMTP id t70mr50738429pfa.100.1553893054191;
        Fri, 29 Mar 2019 13:57:34 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id z6sm7366443pfz.65.2019.03.29.13.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 13:57:33 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: meson-g12a: Add CMA reserved memory
In-Reply-To: <20190327102157.15908-1-narmstrong@baylibre.com>
References: <20190327102157.15908-1-narmstrong@baylibre.com>
Date:   Fri, 29 Mar 2019 13:57:33 -0700
Message-ID: <7hk1ghwg8y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> In order to handle Video Output and later on Video decoding,
> add a reserved CMA pool with a similar 256MiB size as other SoCs.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.2,

Thanks,

Kevin
