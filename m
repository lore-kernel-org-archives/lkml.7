Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47330C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2180921582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UW4z10ZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLRSNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:13:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46081 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfLRSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:13:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so3283975wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=s6pr6X3YZWixb8igAL5ZzP135162lw6kkNkrAE5nvDY=;
        b=UW4z10ZFcOooL2c6GdzIvB9hmP5SseKfAI01lmvsAEbvOsrbWRmG8k+UDXtTLgnaM9
         gm2KqSYCyAOdc4YVMUZe4K319U183tNcXM872/5G0/gAs1i+iaUHQKiMKr747n6P7H1A
         YHXU6qxJ3oy4K+nWuCo6q0/101Zo9ssfrjX2grmDbtYOxTZkVGyQ+qH6dRHobBqWxa1M
         nIIVB01E33kFsHgdbAF+OVbVhtPJBpgERrJzzZG7WXk1APl7JNGY2Fp/gqFhtL2W7/LP
         Z/+75Nq94y6KhsbiFMDLZB1RmH3ScSQQX3cQaFbNa3OaQN7mg5QU2gqXUUQP/vSOqS5w
         ezMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=s6pr6X3YZWixb8igAL5ZzP135162lw6kkNkrAE5nvDY=;
        b=KPGnddGT25YwzZQKNjD/HajTnDJNdJDSgHwJSLAFQ28GnqRBRz6fZCdU/YiLCPrujX
         MtQVz2GRP9MWk4jGPz/FnoqephuHcmEMubAC5FibIsu1qpJgeCbm3jJBmNTS+W5rhTJ5
         maayHbvh/+A06ttHlW7J8t7zX6LMAKVCDd+3GCr4m1DF0cKEdQQI/petyM3r5cITIN3o
         ePE3AX0vDV7J1WNgD9648+/zB0UtF/9qrhdVKGWoRuzQc3elpxdlfwPEaklr5Esl6+IC
         cP60nTLHLTzBlteaQNNJsbdjARsvzsJNJco4Ewy3ZTVrgqJxBUDkEgG/QlE2joIqb3Ij
         7Mjw==
X-Gm-Message-State: APjAAAWny6m6ItRnmFj1T0tMtevpnD4vSVntUbXu9JrmJWDCzQylUbfu
        p5DzzeTYSxbR2RowudsNTM6EDQ==
X-Google-Smtp-Source: APXvYqwzBRl3g+BhMlJHg5Zu4pGS3x1Uk52GVE05baVV87Pi+U0SnH3/RibUeAZUwELOwUZoc+WBQQ==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr4372382wrc.175.1576692790684;
        Wed, 18 Dec 2019 10:13:10 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id h2sm3396271wrv.66.2019.12.18.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 10:13:09 -0800 (PST)
References: <20191218172420.1199117-1-jbrunet@baylibre.com> <20191218172420.1199117-3-jbrunet@baylibre.com> <20191218175031.GM3219@sirena.org.uk>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/4] ASoC: meson: axg-fifo: add fifo depth to the bindings documentation
In-reply-to: <20191218175031.GM3219@sirena.org.uk>
Date:   Wed, 18 Dec 2019 19:13:08 +0100
Message-ID: <1jimmdbiyz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 18 Dec 2019 at 18:50, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Dec 18, 2019 at 06:24:18PM +0100, Jerome Brunet wrote:
>
>> Add a new property with the depth of the fifo in bytes. This is useful
>> since some instance of the fifo, even on the same SoC, may have different
>> depth. The depth is useful is set some parameters of the fifo.
>
> Can't we figure this out from the compatible strings?  They look SoC
> specific (which is good).  That means we don't need to add new
> properties for each quirk that separates the variants.

I don't think it would be appropriate in this case:

If I take the example of TODDR fifos on the SM1 SoC;
All the TODDR fifo on this SoC are compatible with the same driver and use:

compatible = "amlogic,sm1-toddr", "amlogic,axg-toddr";

However instance A on this SoC has a 8192B fifo while instance B, C and D
have 256B fifo. Same goes for the other SoC and also FRDDR fifos.

To store this difference using compatible I would have to add 1 compatible
string for each "A" instance of each FRDDR and TODDR of each SoC. At the
moment this would be 6 more compatible string for something that is really a
parameter ... This also shows that fifo depth is something the HW
manufacturer can tweak easily for each instances.

It would not scale which is why I went for a property.
