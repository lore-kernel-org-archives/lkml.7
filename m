Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21495C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED62B20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hc1sn9qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441870AbfIXTKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:10:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35536 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436860AbfIXTKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:10:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id a24so1833448pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ztDGYJ4coyv+LAVfttrEQdgcMXqg4Kriy9EN3YGCljM=;
        b=hc1sn9qIKaebOSz9we8ltrjhoIMvLleyAzfBIFg8oVbgZeB7q2cJhQXmas+QaBgGwa
         YJRVIUXVwHz9kWqcapUr6Ipz/YkKWU8bQ56QBM4F+kT616StfYzq1mHTTQyPKQI9C/CH
         8uIOTgdLeZ7flUAX/Rz6SL27oqnDGmx/pe4hErHmDDAFA1YrDPz2YjqgbGCLikM3f99P
         kjJjgMxmLwyYf32EXJ843imgVokwY/HHzSNj1ZtQfCz97/Pv8lgHx06XEEJm7xokK9zp
         LhIpX18Y/qNxzlhJckURdplDuevo97mSKW/ciISFXQeSuzmnXMs42TyHjyfxYIQU/dKy
         Z6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ztDGYJ4coyv+LAVfttrEQdgcMXqg4Kriy9EN3YGCljM=;
        b=jrc08d/h3fzLT86rX0Mzof7gIr36u9Hr56ydsOIzTYF3jhDYKYYqgfoKW4G1lLfZiI
         FU7YENzyq636eZf1XZjYs0ENteYjYe16eiCExXkmzqiu7+fg63LCFLfnCVYffa+sRUVw
         1vS5QjTsfXNIwp26tizgR+3tI5/q3+ewfb6BpeNzlyAK3u+1bA/w7/m9HlYNvz69+2vX
         U+IP5HgaiTB7NbCid5aayeHzV5brmnEx48cE+HDvS0W7Oetd9hTdLJtEBYyBHKo/PmJM
         al31+50nw1EL9rDLvdnmnvjmHkcwFYGmz82PvCvFhL747V5fDiipeXXrHuAl4dpgavlP
         i2wQ==
X-Gm-Message-State: APjAAAWPBdMRTwb83NOejvz7VadforQqFxyPywkYzn0Os2+O50Cbo2lt
        0T5Q6KRUVxV/BtmGI6YFGyvg4w==
X-Google-Smtp-Source: APXvYqya2nPu+2RWqeknPa0vJCecXJC5BrkFYN+q1VPzP0Et4zZGP3Bc2YytDsgp84YFrMCkeCvzpw==
X-Received: by 2002:a62:53c7:: with SMTP id h190mr5059698pfb.208.1569352206681;
        Tue, 24 Sep 2019 12:10:06 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id r28sm3261936pfg.62.2019.09.24.12.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 12:10:05 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Frank Hartung <supervisedthinking@gmail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Add capacity-dmips-mhz attributes to G12B
In-Reply-To: <1568429380-3231-1-git-send-email-christianshewitt@gmail.com>
References: <1568429380-3231-1-git-send-email-christianshewitt@gmail.com>
Date:   Tue, 24 Sep 2019 12:10:05 -0700
Message-ID: <7htv915x4i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> From: Frank Hartung <supervisedthinking@gmail.com>
>
> From: Frank Hartung <supervisedthinking@gmail.com>

nit: duplicate From line.  Removed when applying.

> Meson G12B SoCs (S922X and A311D) are a big-little design where not all CPUs
> are equal; the A53s cores are weaker than the A72s.
>
> Include capacity-dmips-mhz properties to tell the OS there is a difference
> in processing capacity. The dmips values are based on similar submissions for
> other A53/A72 SoCs: HiSilicon 3660 [1] and Rockchip RK3399 [2].
>
> This change is particularly beneficial for use-cases like retro gaming where
> emulators often run on a single core. The OS now chooses an A72 core instead
> of an A53 core.
>
> [1] https://lore.kernel.org/patchwork/patch/862742/
> [2] https://patchwork.kernel.org/patch/10836577/
>
> Signed-off-by: Frank Hartung <supervisedthinking@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Queued for v5.5,

Thanks!

Kevin
