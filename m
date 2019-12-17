Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FB521D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UXcywob3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfLQOfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:35:18 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:57375 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbfLQOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:35:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576593314; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=21aBxipy8p7uk0rKdijJDM9b/aNaNo4M823NpVdIVDU=; b=UXcywob3w3WHof0J0qPgk0jTMxjv2Tunxr1gJbJ0KcbsjZEgGzxvYMaXM/JTlGap1YisduzI
 M1A/RgA8afeFu0fw0QIthwc6GIcCb2Und0mrJbQ34bvISuNKlkYy5boKaV+ej1+0DSH+epm+
 EIalLQrBXPQcIFRDMq3U43q2H0g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df8e79f.7f9759a6a880-smtp-out-n01;
 Tue, 17 Dec 2019 14:35:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B324EC433A2; Tue, 17 Dec 2019 14:35:10 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A0EEC43383;
        Tue, 17 Dec 2019 14:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A0EEC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mt76: fix LED link time failure
References: <20191216131902.3251040-1-arnd@arndb.de>
Date:   Tue, 17 Dec 2019 16:35:02 +0200
In-Reply-To: <20191216131902.3251040-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 16 Dec 2019 14:18:42 +0100")
Message-ID: <87lfrbaull.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The mt76_led_cleanup() function is called unconditionally, which
> leads to a link error when CONFIG_LEDS is a loadable module or
> disabled but mt76 is built-in:
>
> drivers/net/wireless/mediatek/mt76/mac80211.o: In function `mt76_unregister_device':
> mac80211.c:(.text+0x2ac): undefined reference to `led_classdev_unregister'
>
> Use the same trick that is guarding the registration, using an
> IS_ENABLED() check for the CONFIG_MT76_LEDS symbol that indicates
> whether LEDs can be used or not.
>
> Fixes: 36f7e2b2bb1d ("mt76: do not use devm API for led classdev")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Felix, as this is a regression in v5.5-rc1 can I take this directly to
wireless-drivers?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
