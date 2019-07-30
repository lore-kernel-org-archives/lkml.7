Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7370C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA75206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfG3Q2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:28:17 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52538 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3Q2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:28:17 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsUyy-0002cI-8m; Tue, 30 Jul 2019 17:28:12 +0100
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic
 routine
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
 <20190730155027.GJ4264@sirena.org.uk>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <9b47a360-3b62-b968-b8d5-8639dc4b468d@codethink.co.uk>
Date:   Tue, 30 Jul 2019 17:28:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730155027.GJ4264@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 16:50, Mark Brown wrote:
> On Tue, Jul 30, 2019 at 04:25:56PM +0100, Thomas Preston wrote:
>> On 30/07/2019 15:19, Mark Brown wrote:
> 
>>> It is unclear what this mutex usefully protects, it only gets taken when
>>> writing to the debugfs file to trigger this diagnostic mode but doesn't
>>> do anything to control interactions with any other code path in the
>>> driver.
> 
>> If another process reads the debugfs node "diagnostic" while the turn-on 
>> diagnostic mode is running, this mutex prevents the second process
>> restarting the diagnostics.
> 
>> This is redundant if debugfs reads are atomic, but I don't think they are.
> 
> Like I say it's not just debugfs though, there's the standard driver
> interface too.
> 

Ah right, I understand. So if we run the turn-on diagnostics routine, there's
nothing stopping anyone from interacting with the device in other ways.

I guess there's no way to share that mutex with ALSA? In that case, it doesn't
matter if this mutex is there or not - this feature is incompatible. How
compatible do debugfs interfaces have to be? I was under the impression anything
goes. I would argue that the debugfs is better off for having the mutex so
that no one re-reads "diagnostic" within the 5s poll timeout.

Alternatively, this diagnostic feature could be handled with an external-handler
kcontrol SOC_SINGLE_EXT? I'm not sure if this is an atomic interface either.

What would be acceptable?
