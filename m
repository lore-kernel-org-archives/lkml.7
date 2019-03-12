Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9BDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749B92084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7r/dLdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCLALM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:11:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40783 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfCLALL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:11:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id w6so685286ljd.7;
        Mon, 11 Mar 2019 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/h0clgeHKB0qltPs98XNvP4STxJrG8ACaYubtp4mc8=;
        b=E7r/dLdd9Wb2DiRmtjnv+9uIQOWXyVvgxqKZx4O9xgbgnYe68BbxbTC7llqKFcHGGw
         RLip5VmRZfC8TYQ29uIMAKEUwgxmkmFqKMW/KbkMf64QeQYg/GwHe/IfhP+ZDkI3g+qM
         BSdriFptWmSTuJmWxsfQEEKVKU197H9gWYTTQwvfUY6AU1W/Q6zJwYm8rpWq1VggbfCD
         U9TAZfCmNdjheDYzZAPAWiWNgB4iA7Sm1LL/uIID9rnPekNkk/47/KFpaKZczlci42o7
         B3gI4UzBHG2hvQOmlkLGwx3W20ufhCvzYK6JdXwTRVNcjqYnacpN/TTa9xaj4I50lJvi
         2UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/h0clgeHKB0qltPs98XNvP4STxJrG8ACaYubtp4mc8=;
        b=LqZxY8L82I9clCJBKEWwXHAHVt6A6sTRN2WA7I2/I8Q3ipczvLzk9lWJpPvOMV9FJ3
         tHQLzXwitMTjSrUgJzZuhijgwqgTGpzAmk+cyuZVVwnOL0RLRNMSJ+xcjpcJABvvpG8C
         bIPKnDTQClWTJrME2hbEAOTCTY8YCbKKUYg8WubU95jJ94ghB19VADTZzB/p3Idorm/M
         uZZ78qLTXvWwN9fB3x6QCr777e/rFcBcPn1ij79SStI2ZILaFxfbudRHgVQPbjkDP/Qv
         TwjbPbBG0wxh2b6wHj/6mDburAOgMGzItbwtY+3eyIZRvVx3b4wv3zk3oivYzHUQ/wgF
         qVCQ==
X-Gm-Message-State: APjAAAV6Mj9l97NBFRO/jL6/monkQHwG+aR9g1yGoPQ8UaJ3JY/OLqU7
        C79/ZlcXVQyd70YfTmdHZWFd53tXYj+CRtEVn1Q=
X-Google-Smtp-Source: APXvYqyrbmb0py6ny9RK82qzZYcIYkKgs8MJmK2alTJNFSwGrwcbvtVCnklxkfZSh+2OmI1igRAQnwMqfEOiGPaHXgo=
X-Received: by 2002:a2e:91d4:: with SMTP id u20mr11543486ljg.54.1552349469290;
 Mon, 11 Mar 2019 17:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190311234655.30357-1-angus@akkea.ca> <20190311234655.30357-4-angus@akkea.ca>
In-Reply-To: <20190311234655.30357-4-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Mar 2019 21:11:19 -0300
Message-ID: <CAOMZO5AqbJg4LgSR5TWGKAJjwUgDcbeVhqNCD9qMZM1A2GPu9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: librem5-devkit: Add defconfig for the Librem5 devkit
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:47 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

No commit log?

Not sure if we want to add a new defconfig for a single board.
