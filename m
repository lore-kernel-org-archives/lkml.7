Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED7C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860172089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gy3GdGrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbfIIKZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:25:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42996 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbfIIKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:25:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id x20so720854plm.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=TyNObdox1Iixd3zdjTU48f1Hvwe8ktTALjvLZDb3R8o=;
        b=Gy3GdGrC2H0vAPvVXFy7E3x7By74bGTaeH6NGTKpD7w8/GgGJHjYKmbfMF22EDtA5B
         f5t5fUsvRZnfkAg2s2I3/vJwMxsVh0krMkkMa7Ee4s/w4KIBoRIUCTM0OI59Mh4RXkVw
         R7LTkg25XjGZcEUZlnpMa19BBp6+z5JcwqKWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=TyNObdox1Iixd3zdjTU48f1Hvwe8ktTALjvLZDb3R8o=;
        b=AQSdmc0r94CEZu8xal5o0+X9JiiXtmJHtXudpQeMSjq4oeElF+GNWSq/JYv1eGtgA0
         qfVpTcbTGSLRiRyaODPjXxUBH8RYb8cldhBrLXGRn5+Q46ilMn2aYkwJj2R7P2LbjPv2
         hTNhvTqRPc3pultLXeVzKR4ch3zIK8YYpLlaZUkAWvZ4+lrCnBllODyP76GnxXU3AeJm
         HcukXwOlrMTzdhW1a37Ct5bl1KL4/b1he09UOPV9+8lvQhzqplsRN91qVqblqxWlEFDG
         RFk+RyhtP6nrHbvgYkJWs3wGcPIUqqxkVTWwr/ozcn1UsDAD9guji3lOlczLRw1baPzJ
         qh9Q==
X-Gm-Message-State: APjAAAUf+R9JylvN/LM7QX4ltTCEE/rVrSdb8QPEWOIHq4e9V+NcFK3j
        gLoRiWL/4Sy7jDbJHTP0TGlKs9Vua19kaveX
X-Google-Smtp-Source: APXvYqzpzWFH0V95+RGywC3U3nviZcDv33Y78qLcJHexUGEwPoPTOCrEwCOBBtQM/gjQNV2ltj/5YA==
X-Received: by 2002:a17:902:9347:: with SMTP id g7mr23722181plp.0.1568024702129;
        Mon, 09 Sep 2019 03:25:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l6sm33369863pje.28.2019.09.09.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:25:01 -0700 (PDT)
Message-ID: <5d76287d.1c69fb81.1631c.4ca4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830195142.103564-1-swboyd@chromium.org>
References: <20190830195142.103564-1-swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] clk: qcom: gcc-sdm845: Use floor ops for sdcc clks
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 03:25:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 12:51:42)
> Some MMC cards fail to enumerate properly when inserted into an MMC slot
> on sdm845 devices. This is because the clk ops for qcom clks round the
> frequency up to the nearest rate instead of down to the nearest rate.
> For example, the MMC driver requests a frequency of 52MHz from
> clk_set_rate() but the qcom implementation for these clks rounds 52MHz
> up to the next supported frequency of 100MHz. The MMC driver could be
> modified to request clk rate ranges but for now we can fix this in the
> clk driver by changing the rounding policy for this clk to be round down
> instead of round up.
>=20
> Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver=
 for SDM845")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Cc: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Applied to clk-next

