Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF7C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5361B218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1xNP2ViB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfGCUlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:41:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43144 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfGCUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:41:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so2490364qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7UrgCJh7ynybyKVyA1NdfWdn/54CS6hsmMgsbu19Pro=;
        b=1xNP2ViByzwg7pUQH7ecLseKnc6Kf20ns0UGpDVoStT7GQGvwmwE6SJ0k1iU5yGYP1
         YkAGhrv0HN2QIN8wQn6mXjkbKkeU5iP2vQLDN2W3vBP0GIuM0QWyFHyFz6ZvUz/PtGTu
         LbFashhUsq2OaHMk3U4qMxU16BQ81vhjqjqPqmmr29MJZE1diWeHz5ZEjXmgySm2Zcwl
         vEonLtxm9XIuu8gCqbEbILaGG75AS6iF8/PterCoeKr5wJQYNeLwGrDFJEKOPk6IN3/W
         Do59BlnuM6zXZnfMXtx78p5hoPPsg3DnI2cUOWPuIIvurACVL6MnBqrNQuyXjnrggF21
         sFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7UrgCJh7ynybyKVyA1NdfWdn/54CS6hsmMgsbu19Pro=;
        b=iO75vC9B3P9O+AZT/AX6O+PD8O7QJonhfDmd8Ssss49S9yccmkdVJNEK6vPh8QE9hF
         uGgBBhn6j0F/Jqwuc9YUYm+Fz6E+/HWtvNOttFjipn22/rmpd/4AHUDeIUPnzBT9wSgc
         iAOQXwZJhCmna4By80HiFDkC4ro68/qLhcpnyorOfzpsnlXNnJWE8hH7Y5cKffyYIYu9
         kZu5hel+xKYmR+6LlXbpTA4/D3FCYF6V+B7pXDfcD66FFcbL021zVC7/W7du+KqT9HsW
         NgeQ7QE1k0B6CNzhtCkioOQRnCP7MlJSuB8csPWnTRrO3C+heJQpug+ZX/Zi0xF7oDBM
         Jd9w==
X-Gm-Message-State: APjAAAWfE2Q6csRCjrKMCBtsXqZX9m1aS1YChxIGCXq5spGLb2oCbgDX
        tFJ7MVh/JoiUf4hJURcvxjY6mw==
X-Google-Smtp-Source: APXvYqyNeh/RKaf68L+vXqVqLoLkpZavQ2W3Xnd/iPV5JNOmdb39n5515aLelaTUJXaJbjErhrpkTg==
X-Received: by 2002:aed:2fa7:: with SMTP id m36mr33207887qtd.344.1562186477682;
        Wed, 03 Jul 2019 13:41:17 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y20sm1452439qka.14.2019.07.03.13.41.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 13:41:17 -0700 (PDT)
Date:   Wed, 3 Jul 2019 13:41:13 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH net-next 1/3] net: stmmac: Implement RX Coalesce Frames
 setting
Message-ID: <20190703134113.0e256b33@cakuba.netronome.com>
In-Reply-To: <003df660052f33891ab74ee79c5f1272b72bde54.1562149883.git.joabreu@synopsys.com>
References: <cover.1562149883.git.joabreu@synopsys.com>
        <003df660052f33891ab74ee79c5f1272b72bde54.1562149883.git.joabreu@synopsys.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Jul 2019 12:37:48 +0200, Jose Abreu wrote:
> Add support for coalescing RX path by specifying number of frames which
> don't need to have interrupt on completion bit set.
> 
> This is only available when RX Watchdog is enabled.
> 
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
