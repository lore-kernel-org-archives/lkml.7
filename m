Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2894AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00482683F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0svwj2jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFCWZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:25:54 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:36279 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCWZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:25:54 -0400
Received: by mail-pl1-f180.google.com with SMTP id d21so7518035plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ik7OKZ9J9bSDp1bm2rOmAtlE84TTDqAVmgooCQeS/Bo=;
        b=0svwj2jn0c7y5OH0otcrckgib+WkKv1EW7+xx5dc+sjwjycdCK/Ta6//1sv9QKNgPQ
         1jmhCgdEn8SYPziXQu8iVYn4lpEc6W6S2YaSFh7HZCNDQemXUEzOey1bTaF7PfPuQzQd
         Gd7VH63DZaay8qz6uQ7Z1lOf620YHpSFKqKwxLutkycHpJsPOvx4vLwjkc9Xuhbtj+HS
         SLRE1LFOeiLTa9+FQ37klOu5lGS5IjAPLXJB6s4dkgodzaszfer/mLqBQUb5AKeEOqv6
         a4pwrybHcgXnoJpS4AjWgBJB31yyvywL9aGzi5QJOjMqwoS2l0eQTUTWNRRCz6O8anwQ
         Fg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ik7OKZ9J9bSDp1bm2rOmAtlE84TTDqAVmgooCQeS/Bo=;
        b=GJuLIpTX1aCkf4DlKdVK17//mDwfjhbReVCFEUhUOkYykCB/E3feyyxOw9Vb1Vultw
         jDieoMF9DZg3J1mNNbedUwyCxXGQADGvJSCFVCJFlAooIzgQQXU8Uz+fx1drMsE5vkNB
         hTFIRM422bMzLD9zgIqEfy5/M2iAcETbsgSu3GPbnJ4Tik1S9OSAHL1OAAeXruOaL/cW
         Fk2cKbMSXi8jJfhzJGKDuM6DTPpAu2igBheQt5U7cLECLVzjsdSnRWzAiNMNC6rvXiCd
         V5pBYTpIrAMUjXXbMZZa1gN4A409CIhL5hUDl/V70SyPHPVVZgFZy3Aimox52JbiS1qN
         tNEg==
X-Gm-Message-State: APjAAAX1sk0sv0aVe4P+9om60b3PZ9mUtaYEabFwhRzv8lzsHUYK5ezl
        7agobXpS6m0zdDso5G+V5OmVsw==
X-Google-Smtp-Source: APXvYqyUVbCq5wYHPsCSWvk56C4V0YcIIPwDrGeX2enduJL0SwUMS6U+vOK+IkxCDgH9iPCmNKU07g==
X-Received: by 2002:a17:902:2a68:: with SMTP id i95mr33399553plb.167.1559600753876;
        Mon, 03 Jun 2019 15:25:53 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r64sm21793471pfr.58.2019.06.03.15.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:25:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] arm64: meson-gx: misc fixes
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
Date:   Mon, 03 Jun 2019 15:25:52 -0700
Message-ID: <7himtmi9vz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset :
> - Fixes GPIO key DT on Khadas VIM2 board
> - Fixes regulator naming on Vega S95 board
> - Enable SARADC on Wetek and Vega S95 boards
> - Enable/Fix Bluetooth on VIM2, Wetek and Vega S95 boards
> - Enable CEC & HDMI on Vega S95 board
> - Adds ethernet PHY interrupt on Vega S95 board

Series queued for v5.3 with tags from Martin,

Thanks,

Kevin
