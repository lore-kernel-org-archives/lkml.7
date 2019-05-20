Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D4C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533D52173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="avfP3RQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfETVSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:18:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38407 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfETVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:18:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id b76so7846724pfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KwAzvLOrsGrLdW37rNbsYgX7kOv9ZoeLzS/6hKC6W6g=;
        b=avfP3RQdwhppd/vstRNn/zdW5SsXvba3ffCdxGlgjEJ1y6rQJXDbRpyDlYvvwGXY98
         bJj0wY65p9eLbsYplwq5bLdQryZ/HRWp4gPRCsLmiQIkmnZkf2Y3wDlXMhktx9hMKHUo
         i7XrrouEq2/wvpTqBya5HHdVLVGid1h0UVlwEZtP9McnxzbBZzRUuiQdHPYHNKqANb/L
         /aZCjVMDIf9vegrCIhgarS6AUHfdKAjkb3IAsP/CdlxCVymAoX63nc02FRwDDFs0SZxB
         t8HuXTOw65xD1U1yggoT7YqcVQRONJ1JXbeiGKtRgL/FPs6iD9qU0FTcx0lAMcY3g/Yt
         1uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KwAzvLOrsGrLdW37rNbsYgX7kOv9ZoeLzS/6hKC6W6g=;
        b=hwA7fVljJ1Jc1yAHeXx1euldl7ucW7N1y/uwdrghzhenHUa8+uEqnM4VNwjYwQQePI
         0GPyt3U0sZcQOMWgxEM77y+YmOB5VZlfKtCodJkuWuJDTmd6ZNm6AzXTwE4l/HAwoLFd
         1R93p/PXy89qeGmieS2zEsyhnH/+rbuP75LVl71ZbxkGaNSrtDN1jwhhSWg0WSJlLZfV
         e57KJh7xuyzugIra64JhN90RzavaeDgdn35WCjUmtPj69Gj/C6I6xqSFXO/X4r4m2gMm
         Nyt3IamcF2YDWGgIVv9WUsAhJLziJqQOccNt0r1xEBSxkJ/NKru4OKfppBmx4nAltI3w
         Z7dQ==
X-Gm-Message-State: APjAAAVLTjdEtD9M91nznyDKZudPGC3K0J1MjbRB+4n3Ic9R5IYQuwwn
        /IoR/VC/Dozi60feYg94h0FNDg==
X-Google-Smtp-Source: APXvYqzSIOWReUBiSn5i9wiYls/tM3XVkbWOxHp5XkIIqOVylQGiSjT/FlLpBfs58MuEO6WmTc0QOw==
X-Received: by 2002:a62:fb10:: with SMTP id x16mr18663984pfm.112.1558387116318;
        Mon, 20 May 2019 14:18:36 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e483:1cc0:e2c2:140d])
        by smtp.googlemail.com with ESMTPSA id c15sm22024029pfi.172.2019.05.20.14.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 14:18:35 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: g12a: add tohdmitx
In-Reply-To: <20190516143216.6193-1-jbrunet@baylibre.com>
References: <20190516143216.6193-1-jbrunet@baylibre.com>
Date:   Mon, 20 May 2019 14:18:34 -0700
Message-ID: <7hr28s7rkl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the hdmitx glue device linking the SoC audio interfaces to the
> embedded Synopsys hdmi controller.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.3,

>  Hi Kevin,
>
>  The related device driver and dt-binding have been merged in the ASoC
>  tree, for-5.3 branch [0]
>
>  This patch is based on the audio series I have just sent [1]. Like the
>  patches I have sent this week, they are all based on Linus's master
>  branch. This is done so it applies nicely when setup your branch based
>  on 5.2-rc1

Thanks, for the detailed description,

Kevin
