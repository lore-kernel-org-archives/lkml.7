Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92279C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D6F22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BRdtncww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfH1IDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:03:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36433 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfH1IDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:03:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so1559727wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=20Jn2+dCC+I8w6FtFfD0vbMvlgqMeEqx0r5JGNJSXvw=;
        b=BRdtncww57yR+oh9ioHww1AygNYE9lSkqU2mG//XHwzTsagVjR4YsA8HZLgV0wx8f7
         MGD8CF1vTBltWRC04ALXWMJqPiuhNcXA/dhIWF5i2SqNeYztB0T8jnz2K4A6VzLd+ddc
         YEpKr2fG5TixL2Xdu17BHvZgY600WF8v6JoftyobJhEdPNmnGwssFAydMClk+OSjNdH2
         /htwt76aoWHuRaxE0qDXMFOwIZwwxCT8fPe129GAv6C3axxfjNmENgSKz8MMSU5skxWO
         kFSMKYMxXvF+2P8J0wsa+XECHfZG9888WhVvnCG/iRlUy9lIbkqUYzBAiy/dd1pHDumy
         gjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=20Jn2+dCC+I8w6FtFfD0vbMvlgqMeEqx0r5JGNJSXvw=;
        b=PawJmeBG8Ffje5yUbO2ZHZCyFVIDr50pteMAIRWVQglx7N0TL+Ce+umJN9ECE3PJJp
         1Jcf7FRl710OOTecICE7gKUePpWoBBWKMdf2M6rmlqiZbvpmLgVG1gU2hX1q1KwTGxVG
         4lHrPb/ttEkmBMDc3f7K0YKEQFBY0KG3/e4NDMK7UGjtA/GWMQYN0IcZ8hHJGIUsB4W3
         esoUQIuAWjYdXC53EXewF6RJlFKxZiQitMIvdsLrbrOMjYLOxUn4qcQc4aGxeGitJElb
         ZGh7FrzhtVwS+pmy4y+RGM3r+EoAzS8n884XMMbu8MNU6OQXR5tQTK/9BETcIox1c3eo
         97rw==
X-Gm-Message-State: APjAAAX0YkH55XOdQKha6j+iw6cBQktgU4fSTaYl1ZpO1Yrve33anGF4
        A2ARyClZ5GPfZORwLEOJV/J0eA==
X-Google-Smtp-Source: APXvYqxmqwViJF2WTLIOMiRFCef/fmmO9N41vOJh+ND/giymLdwj+196F+O+dvCn+JoNQAz/G4CsdA==
X-Received: by 2002:a05:600c:352:: with SMTP id u18mr3102630wmd.141.1566979392301;
        Wed, 28 Aug 2019 01:03:12 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a11sm1330229wrx.59.2019.08.28.01.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 01:03:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: g12a: add tdm resets
In-Reply-To: <7hh862tbt2.fsf@baylibre.com>
References: <20190820121551.18398-1-jbrunet@baylibre.com> <7hh862tbt2.fsf@baylibre.com>
Date:   Wed, 28 Aug 2019 10:03:10 +0200
Message-ID: <1j4l217m4h.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27 Aug 2019 at 16:42, Kevin Hilman <khilman@baylibre.com> wrote:

> Jerome Brunet <jbrunet@baylibre.com> writes:
>
>> This patchset adds the dedicated reset of the tdm formatters which
>> have been added on the g12a SoC family. Using these help with the channel
>> mapping when the formatter uses more than 1 i2s lane.
>
> Because I forgot^W waited on this, we did the meson-g12a-common split,
> so this no longer applies cleanly.  Could you rebase this on current v5.4/dt64
> and I'll queue it for v5.4/dt64.

Acutally it was already not applying when I sent this v1 ...
.. which is why I sent a v2 [0] ;)

[0]: https://lkml.kernel.org/r/20190823154432.16268-1-jbrunet@baylibre.com

>
>> Kevin, please note that to build, this patchset depends on the new reset
>> bindings of the audio clock controller. I've prepared a tag for you [0]
>>
>> [0]: git://github.com/BayLibre/clk-meson.git - clk-meson-dt-v5.4-2
>
> Thanks for the tag.  This is now included in v5.4/dt64.
>
> Kevin
