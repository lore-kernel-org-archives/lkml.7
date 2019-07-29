Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B45AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E96C2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="sm+KrCEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfG2SbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:31:05 -0400
Received: from mxwww.masterlogin.de ([95.129.51.170]:34404 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbfG2SbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:31:05 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 14:31:03 EDT
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id E60D72C41E;
        Mon, 29 Jul 2019 18:16:19 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.253])
        by mxout1.routing.net (Postfix) with ESMTP id C9DC743E4E;
        Mon, 29 Jul 2019 18:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=dkim; t=1564424174; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HP6trMB9va7UVgbWclPeNJtnCBo+M1pqC/xaYjKxvj8=;
        b=sm+KrCEUw+eAxXAsg/LcgF3MQTCbRVLNqKsuxtH5m8fYpSZWdaXQCQ/KPJ7vK5JYq1JR8F
        oBeNmeY7VC5uTNpp+UVWvnXAu8LjpojxVF3JwQWgv7ieQg5e+fWpX/2UdpF/MvEyliNoiW
        r1m9nL5PR+zxy0ff3ItRqhSzBj5pNiE=
Received: from [192.168.0.21] (fttx-pool-185.76.97.79.bambit.de [185.76.97.79])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 7DC8D405D3;
        Mon, 29 Jul 2019 20:16:13 +0200 (CEST)
Subject: Re: [PATCH v3 00/10] implement poweroff for mt6323 / bpi-r2
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>
References: <20190729174154.4335-1-frank-w@public-files.de>
From:   Frank Wunderlich <frank@fw-web.de>
Message-ID: <e1274024-b67c-3d04-50d3-f6fcd3b3cbe6@fw-web.de>
Date:   Mon, 29 Jul 2019 20:16:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729174154.4335-1-frank-w@public-files.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry about missing part 9+10, my mail-provider blocks the mails, 
currently i cannot send with this account

i try sending with another

regards Frank
