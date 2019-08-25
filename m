Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1791C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792592082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZWgvPDk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfHYTz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:55:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44250 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfHYTz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:55:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so13269319ote.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGmPx2xuPkputCeT387Wpalg1a3GB50jgvbEZF5SlNQ=;
        b=ZWgvPDk+e19f+KMo42AfleUbEhqmR1sbLN8un2pAZwnKo7R+VFoNu706wHkkepu0uj
         d/Q9lHk+J4OW9bqN0IAkEXFMzpQAr7rpurCXwxo59pu6SUYdLxN2zHRLq3pQGCTHHkYm
         4HnbVp8i7pIjGh9Xne1FL92bPb39lmbmnfBD6DhRM/6mWCUhl5DgB731UDJVNRLnIpbP
         QDhGbaHKI6HDe1YTMMIYqmN9aH27a+tuZv8rdpuwpULP8svXVorHyX6tV43FGyRJMtJl
         leWknAathV2ibsvyQgXz1FF9lfbszCiabYMdW5cnO1t7yG/L7PVtp29Hk4XfTg4YNk3l
         FrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGmPx2xuPkputCeT387Wpalg1a3GB50jgvbEZF5SlNQ=;
        b=nc5u0dPUYGFnHpD8Hfyrks9e8ThnlBssuSjbFGuFG9xxH5rSrBdBM4VPUBl5ti4/h0
         9BW/8jrdw76fmlM2Ca8/CM2MxN4q7NMheak/qhXGdMoKhzO3/iWOQTXOoN2XkoYEY8J6
         gGh+XTjSsStQv1d0YmOFw0EWDcKnV6ZaI0AgP7TT0vYfDOgug8mKoD/INs9IN+JgglTV
         uH5vEOvpfIE6GGbsZITFK9YB53QwvAb1o/D6PfUpBvl23d+PbhzzXjTsQXrpBd4xbp7U
         bwhtimPWwcRc276mHDbg2nF9MAnLg6eobuNvA4ouUHAAVDE/j5Ls3+QMOfRm4/sXy1wH
         EcGw==
X-Gm-Message-State: APjAAAV+GFt3+ZS39biK7i4z48usz2ZUfLO3hF9HfRBLT1S9WS6F9Fk7
        sbpJhpLupgY7oEAcc1ROia8pR8hy8SENXhUqdvk=
X-Google-Smtp-Source: APXvYqzzvtkVUjkecPWG03cxd1nVZTZf8ShZr+HnDL6BFQMZnJcYWHUOL3e4dOdG1vazH5JciiRHL10NvWwaLCvR9a4=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr12418370ote.98.1566762925225;
 Sun, 25 Aug 2019 12:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190823081427.17228-1-narmstrong@baylibre.com> <20190823081427.17228-4-narmstrong@baylibre.com>
In-Reply-To: <20190823081427.17228-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Aug 2019 21:55:14 +0200
Message-ID: <CAFBinCAH2LP2OyFEek290Prm9N=rxxAc-9gZ_jS0tY_4+utByA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: khadas-vim3: add support for the SM1
 based VIM3
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:15 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic SM1 based Khadas VIM3, sharing all the same features
> as the G12B based one, but:
> - a different DVFS support since only a single cluster is available
> - audio is still not available on SM1
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
schematics are not available yet but this looks sane so:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
