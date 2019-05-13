Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E9C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E96208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kIjXz//g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfEMQbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:31:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43846 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfEMQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:31:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so7472401pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=B032wxaSxEpjK9pKdC74UIRXdzFCuNECesldV5G8LvM=;
        b=kIjXz//gu34JmtpKR/dsJ1vaMB9L/2P9JKdACM4ZnrZf9kttODd7N98HnuFsEVpK3H
         FIdjl/FRyZnbbOTRJRV8suMt4wVHzS4puVd+He2wCyZw86kYaE7PwGgE65mZKz8zpvx8
         m16M2J/uGmFSVw12xYQdC2kH9O9BW+Ork2fQkP8Uz+GIaEyBXYZGvKooGAC274rZvpec
         iGEg2CrUt4GjOXKRlv/7EX/hdlW6bMXdDr7+Uf60Re/nYOrwXNcSUN8C9hxWLypcorIv
         KLxhUBL1CdM8nnMb1BjIQA4ek/gorM7PhHWs4EZxmiltYpeqqS6larlRaZ+Ggg0tqXRS
         cAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=B032wxaSxEpjK9pKdC74UIRXdzFCuNECesldV5G8LvM=;
        b=ZXrBbbgTQiISSn9DirvfoAXuJoUhJLSguWLqzhldLvNLfQuGFCaXs2HZ5zhBbI6IuM
         9yqyht9SZbyVMQz5fc291WFleUj/982uCTUoTuGwNY0DDAD7MwxwW2ZFZyogYM+/qVwM
         k2EfNMBy7E2s1VkqnKcYRTX8calQIY/ZYx1pcMAPX1ks8b+9A39Z3IVQ41C4RSruasqR
         B78NR4SrYGCsiruxGtth/qsgMQhrwitIfpQJrrWxdrxMZiTbdUTRf8E1Mi8Es3pqcwv6
         FioojGp9NPrO9ZS9FPaAVE8TNrDE4B9pKDSoPwILwgMvlqigti7uRMV5SWe30qtlzZHw
         Vg6w==
X-Gm-Message-State: APjAAAUCTiAbw3U+3J1NsrazeKJ3iPF3o4NW2M9xksC4mvLiLiFmsAwT
        QezYTYtWWRWvBLhxIvkBxFMPyQ==
X-Google-Smtp-Source: APXvYqykyJVcUw9loEPh58IKDLQ8HHbmdX1X7MaIJ18vVl9tQx/WiDfdyA5qBoncQW+XhiG6PHGTUg==
X-Received: by 2002:a63:fd50:: with SMTP id m16mr32686277pgj.192.1557765091630;
        Mon, 13 May 2019 09:31:31 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id x17sm3939633pgh.47.2019.05.13.09.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 09:31:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: meson: sei510: add network support
In-Reply-To: <bf1360ab62a4e7bd3928052ebb6c969e8059f29e.camel@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com> <20190510164940.13496-6-jbrunet@baylibre.com> <7ho94ac4jn.fsf@baylibre.com> <bf1360ab62a4e7bd3928052ebb6c969e8059f29e.camel@baylibre.com>
Date:   Mon, 13 May 2019 09:31:30 -0700
Message-ID: <7hftpico4d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Fri, 2019-05-10 at 15:45 -0700, Kevin Hilman wrote:
>> Jerome Brunet <jbrunet@baylibre.com> writes:
>> 
>> > Enable the network interface of the SEI510 which use the internal PHY.
>> > 
>> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> 
>> I tried testing this series on SEI510, but I must still be missing some
>> defconfig options, as the default defconfig doesn't lead to a working
>> interface.
>
> That's weird. AFAICT, the net part has hit Linus's tree.

Ah, that's the key ingredient.  I was testing with a v5.1 baseline (not
linus/master) along with all my queued up changes.  I just pulled in
linus/master to test this series, and indeed, everything works, and I
don't need my config fragment either.

Thanks for clarifying.

If repost needed, feel free to add

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
