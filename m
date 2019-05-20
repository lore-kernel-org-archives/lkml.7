Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD50E2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KH9eQMCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfETLZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:25:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45420 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732695AbfETLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:25:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so14109245wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jjlgRqd7/3GdbXtzivENZGFK0W6UGcne26rpZyW4X3o=;
        b=KH9eQMCgAcp+vePFV58EJikabmf6tk7CPaw16nowcMlcJ9rfsp+jqtVbW4ziTIqtJn
         pWBQacIbPY+n191m2WqHswFszkMDXBbauB4/HyE6ZwSzMGnaDM8mc8BC2ItArt3r48p2
         hDW8UVhT/aOcBwNkv3AV39O5SBWYxCLPywsppIcLpCzNlu/SO8Kh6XrvNVW+vDf3BVGO
         dgf7CDa6gkuA6sajvyDCOePcqFxpVeLPk1UFIDhhneZxknvlnqxb4xVh9g1wgPR2ykgo
         bBj2h5PQdq+NXx0DTW2epwkjiXbsm30gJiyeKCUH09+ynK2MOyTfMXH1G5PwwvMSpl9b
         Ihnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jjlgRqd7/3GdbXtzivENZGFK0W6UGcne26rpZyW4X3o=;
        b=VYkyIRC5T5RYkoNfJf+7a5EyEpyBkHu9OiYdQSkhO2JRy3bgZZ0LLmHHFTH0rlST0w
         WuTDk+lD9tMcZsAIdGaoQEkrnq+rdigfnux6J6Ld+V84N3wiEWgJ8y1yv6xo70M5tl+m
         Pq+F0wBfCU6S45cjLE4qU47XF8tMeUZsCGpq/4mfrXHxdC9zoZ6zDm61kwG7Mu3CwfVb
         2DioeK8ifDwW9cPYQebxramSe6iZhm/EZmzSpu8Pjm4N6mB5yu3bynNvRuBxMiFKMmG3
         sKhN3xfQULBkpgHdbMVuH4twezQOwXlv2nDm6zkpwwCqOKroH48HqtPese6byPkTRqHr
         fXWg==
X-Gm-Message-State: APjAAAVZHQte1PbY0OB3rV4AhG8NCS1mHHTxg6dY6C19JzHRspje01Aq
        Tt18CIXzeTumlFl+s9IoeNRA6w==
X-Google-Smtp-Source: APXvYqwD19LntnajDRGhTBQ60xM1YyUoHyMgHC0GjSUru7HiinTiDHC+FsHKj7HQJg4LRDftmwD8dQ==
X-Received: by 2002:a5d:624d:: with SMTP id m13mr45190092wrv.305.1558351516800;
        Mon, 20 May 2019 04:25:16 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m13sm15690440wrs.87.2019.05.20.04.25.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 04:25:16 -0700 (PDT)
Message-ID: <fa275d9d4a451d6ef5332a6836e8316c5644d913.camel@baylibre.com>
Subject: Re: [PATCH 1/1] clk: meson: meson8b: fix a typo in the VPU parent
 names array variable
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 May 2019 13:25:14 +0200
In-Reply-To: <20190512194300.7445-2-martin.blumenstingl@googlemail.com>
References: <20190512194300.7445-1-martin.blumenstingl@googlemail.com>
         <20190512194300.7445-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-05-12 at 21:43 +0200, Martin Blumenstingl wrote:
> The variable which holds the parent names for the VPU clocks has a typo
> in it. Fix this typo to make the variable naming in the driver
> consistent. No functional changes.
> 
> Fixes: 41785ce562491d ("clk: meson: meson8b: add the VPU clock trees")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

applied to v5.3/fixes

