Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9528C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26EC23439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0AEN2xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfH3Veh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:34:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43250 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3Veg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:34:36 -0400
Received: by mail-io1-f67.google.com with SMTP id u185so13177511iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRs4USZKqbM7XBEpqSlf+cAqUnmhWlYsbxb13NQJujQ=;
        b=I0AEN2xKpIGmcgkXKtx6SFCfbwffnshtQwlmZGZTHXEMrRwTHSroUZNeZHwZKpDjkB
         RP8EJtFJshofOn/0QZyr5+B4W28EsQhTiGx2lJUl1RgCA5q/sFUq1rS8nPS6HqNAofa1
         Nj6xnyfPyXccIvJZ96T74h/vhqDdxOJlw5cEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRs4USZKqbM7XBEpqSlf+cAqUnmhWlYsbxb13NQJujQ=;
        b=mXUzSrYkQnsBnIZF5va6u3XJHrMelxj15Jvf7BUXAJiE5x9lyXNRAD9JNI6Z7CnlA/
         8TDbK5EnWU68zd7B217NPMWonh2EkbUmm5tDLhesq/dfseKZDOay+EggrmfcTegw/HHL
         kTwEdBRy7VyYlSqOhKvqzmMJVHBdThBf1FY917tNFNRvJ8ELmOZ8GarW06bzYTv/doRW
         7qsTgpKavNhQmWXi/JRsphazJkLTEjo65xOEU9rSHE3Nqsg7ZS7CUFuyl5mMIwLPMP4n
         nWa1TwwdtDAIOLAYxtu+Ijz9rGPdRV850aGKL1JPChXaIOpQoJgh6Rt6LuoHvHiSAAJ3
         5wwA==
X-Gm-Message-State: APjAAAVgdGxzQsqN+y4/3skkTYexS9eHd/G3nL0mxwqAHcIoOX6ivhnA
        DP5PFI+hwkARWXizWwxSlefgOANLnvk=
X-Google-Smtp-Source: APXvYqym5E9nwMXLCn4vqvi8Qb0Oe4CL1gAFwRj5Y9FfKhidBWFwcTyLIhTu6Xi2kOcNU40CFltC/w==
X-Received: by 2002:a5d:8986:: with SMTP id m6mr19958050iol.166.1567200875315;
        Fri, 30 Aug 2019 14:34:35 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id p1sm5695463iol.11.2019.08.30.14.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 14:34:34 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id h144so1657343iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:34:34 -0700 (PDT)
X-Received: by 2002:a6b:cac2:: with SMTP id a185mr4014873iog.142.1567200873979;
 Fri, 30 Aug 2019 14:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190830195142.103564-1-swboyd@chromium.org>
In-Reply-To: <20190830195142.103564-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Aug 2019 14:34:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vr5o-b86588qe--bVZ5YjKVB3gzaoYa6YcqCd9smkxVg@mail.gmail.com>
Message-ID: <CAD=FV=Vr5o-b86588qe--bVZ5YjKVB3gzaoYa6YcqCd9smkxVg@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gcc-sdm845: Use floor ops for sdcc clks
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 30, 2019 at 12:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some MMC cards fail to enumerate properly when inserted into an MMC slot
> on sdm845 devices. This is because the clk ops for qcom clks round the
> frequency up to the nearest rate instead of down to the nearest rate.
> For example, the MMC driver requests a frequency of 52MHz from
> clk_set_rate() but the qcom implementation for these clks rounds 52MHz
> up to the next supported frequency of 100MHz. The MMC driver could be
> modified to request clk rate ranges but for now we can fix this in the
> clk driver by changing the rounding policy for this clk to be round down
> instead of round up.

Since all the MMC rates are expressed as "maximum" clock rates doing
it like you are doing it now seems sane.


> Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver for SDM845")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Cc: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> I suppose we need to do this for all the sdc clks in qcom driver?

Seems like a good idea to me.


>  drivers/clk/qcom/gcc-sdm845.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
