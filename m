Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87483C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9A620644
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuJnG6vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfH0SG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:06:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40536 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0SG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:06:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id h8so32507663edv.7;
        Tue, 27 Aug 2019 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ibe3kzD7C7QCZmA5WwJ37bObPlaX3KGqkjt9Odp1n8=;
        b=KuJnG6vgXqludJgsM0MzX6nDVVTbQdzw2bJuuc4s+Z/eNTG8K331LU6V0Hrtu88d+K
         hV5DM1jiNA3+Ek8Ka1h4nxW1th3otRbwF0LsPQh4s/RPQYigA0bhdJChPaHi7PnMuJnt
         wqqkh5MY7y1z0X6LPlOWrO6c8koifkYrp40fTgAtCqAS4HVu1BPDImSeGf7MxJb6HdC7
         xGNBPr9ev6YkkiI7Q3EP6Tj3A4sR+QbKIP7SLc04in1M5dxIph1zkDaLAQtTr+GkFL8E
         XruxZPyd24g9UxxSa23EvhFvDNMCRl7iZXQR9mZMvq0l533XnOUPpTrNMgiYIKnp13wK
         tFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ibe3kzD7C7QCZmA5WwJ37bObPlaX3KGqkjt9Odp1n8=;
        b=SqH7KQBb71R6//e64ZwBG/HkW20WojAdH7ZBkhpu1Ama0OAWH4tiv2VMcvz6IuMcKr
         UGKc/gruFfc6Dt2VP+sXvARTR+uSMjW01Lp1jA2wbtMBTMTiU3l1IsRiYzoCM6keGG9W
         optGhBMfPxp0LqIbWi4FMP8YRNRE9Jc4ie40sqyaw43wXLulCsX5tu7iwGYGkCW8LY2v
         RLUSLkK16oDUiMsp+0qgXEFh6MAkIGAALtjYtNE87G/I/oXYO4K4spmXrAe0VuphzBl/
         Ghzhv5KbUqzGZ5ND8Zu4/rcmKqjgM38t6ILmsIS2NFhzCfoV6kv+JF/R0JP8NLBJ2zwM
         6Trg==
X-Gm-Message-State: APjAAAUKeMmpW+VDxRbttqOLp/oddVjRhMv1hfCOXBUD3ZXbL3j0CKZT
        qhmd97t6BMHMFev9GcFcaKbkIzH0hYWwXDUTNlm6/g==
X-Google-Smtp-Source: APXvYqwBGa2cpvVeO2O+PpWsy33xgc1TKZKRmdvx6Zd4X70aTHp0+SmfpOyqobWNNyqGU7s9a2iYYS3yE0Hg9TYXbN8=
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr22743036ejc.204.1566929184870;
 Tue, 27 Aug 2019 11:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190822211514.19288-1-olteanv@gmail.com> <20190822211514.19288-6-olteanv@gmail.com>
 <CA+h21hqWGDCfTg813W1WaXFnRsMdE30WnaXw5TJvpkSp0-w5JA@mail.gmail.com> <20190827180502.GF23391@sirena.co.uk>
In-Reply-To: <20190827180502.GF23391@sirena.co.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Tue, 27 Aug 2019 21:06:14 +0300
Message-ID: <CA+h21hr3qmTG1LyWsEp+hZZW2NJFtg9Dh1k6SXVDd+A_YSQjjw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: ls1021a-tsn: Use the DSPI controller in
 poll mode
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Aug 26, 2019 at 04:10:51PM +0300, Vladimir Oltean wrote:
>
> > I noticed you skipped applying this patch, and I'm not sure that Shawn
> > will review it/take it.
> > Do you have a better suggestion how I can achieve putting the DSPI
> > driver in poll mode for this board? A Kconfig option maybe?
>
> DT changes go through the relevant platform trees, not the
> subsystem trees, so it's not something I'd expect to apply.

But at least is it something that you expect to see done through a
device tree change?
