Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB9C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE672184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGECiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:38:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45001 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGECiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:38:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so6858164edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 19:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WqY7P7z7HvZSik8uVxR3WylUoD8M+JaJvkcH77K5Dg=;
        b=WQchioRyA3aqmeERo1eaXSQsOEM//4zGjwiq7Kb/GOU51AO46GbxvIflLyCrUA4F4C
         d3D5UFlUNCwSY/YH3FXVv6m5JtwrHe/wzt1tdc40ZrCrlHHOw9R/ianEQljyxnEx1PaV
         1Wvw3feQZjYJc22H0eMUtDcAAeUsU077LI0AhzGM2jbuaGztubZJcnOZkz4IWqbGlMlW
         gsEKX+MH9ohj2pLivHrpe9XG1av5ILD3SIQdKivrSqpbK6QZwz5RCfpONpb9S5q3lnyD
         DYRS2HBtsmONknQvG9IqjYK2ZZWY9hEq07S1ExHfYYxjtgo9xliDM+KovbrB2Zghpv1T
         TDOg==
X-Gm-Message-State: APjAAAUiS6p8hp5L9rcdZ2RzSnlCyBwWxtmLsNdaEmC+khcWdQ4IbfJp
        l2Y5neYcgHKq8quhBKuyi5Xtr+zKBnU=
X-Google-Smtp-Source: APXvYqxWqCwfEi40oADEJNIBu4cpiimXwrzmJ6fVBltbQ2ToRxD9bNU1tsiDSLo8rmqn31poM+Cv1A==
X-Received: by 2002:a17:906:fae0:: with SMTP id lu32mr1153230ejb.283.1562294298010;
        Thu, 04 Jul 2019 19:38:18 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id l2sm2131099edn.59.2019.07.04.19.38.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 19:38:16 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id v14so8288744wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 19:38:16 -0700 (PDT)
X-Received: by 2002:adf:f70b:: with SMTP id r11mr1078942wrp.324.1562294296092;
 Thu, 04 Jul 2019 19:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190703184814.27191-1-luca@z3ntu.xyz>
In-Reply-To: <20190703184814.27191-1-luca@z3ntu.xyz>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Jul 2019 10:38:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64EL-v5YUuWA4t=KUhuwEqML6Co6iosG607_rZhUQ+OLg@mail.gmail.com>
Message-ID: <CAGb2v64EL-v5YUuWA4t=KUhuwEqML6Co6iosG607_rZhUQ+OLg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: sunxi: sun50i-codec-analog: Add earpiece
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        ~martijnbraam/pmos-upstream@lists.sr.ht,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 2:49 AM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> This adds the necessary registers and audio routes to play audio using
> the Earpiece, that's supported on the A64.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

LGTM.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
