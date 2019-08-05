Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4228C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B660A20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FSuabh2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfHETH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:07:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39678 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHETH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:07:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so36875178pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HLFGcSRnrtzTL1mjh7cGHzUe4MbVsR9BlQbuANglj5c=;
        b=FSuabh2v9pq/6MkamWwdgBgV20CYzeHQtJwzBdq7lzoSb5UkOWU5v/iQ3CiwBW0M5u
         H3kWwgCGfNz4QL5IDAlo6ew+6Pb7VP5vAABw3IyFnaJ/DD/KySLDoGNTTR2TVYugvhaL
         KFhohMBJuOG7aom24gh69NuS5torpA++ACe/cGHxKqij0bK9e+Jzp2HUGW8s7ukHfOj1
         BfRKy0AgSlw+k5qGL6pMeNDgv/ybVrI3OlwWrhtnA/EIggHvi3kim2vh7hbV5H5ZAMUp
         bDsozCfjfZItrJOTz1HMEXv0Hla71yyPRANQkegzPwDilCscsPTPL1HcF5gPrjJcO2yT
         qTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HLFGcSRnrtzTL1mjh7cGHzUe4MbVsR9BlQbuANglj5c=;
        b=Qgq7iVdfNFTEfctpm7JlCG4XGBeg3TniekJMHENH/XVPIATYy5iVlFS8o9yUqJyR2W
         MALmgc2S3h4G0FuRh05s3GYBLitX7osp4C3gkMdDVMOOMW3s9//n81FbG3dKHdJGbYlu
         7ULJ6rayCPJhTPVuqJFsQS2XPmrym+IVBfxXmQBgG6ortp+m4RPI/1hBLAqsitEUHDxp
         /z0NwQugq7R9jfbWLG1SP0ko/H8xCqrwVlyIzj7/vlbDZ4F3RX2DhjmsKbLtrTpVcBdH
         DBS2L0PiTNMGRrSl40TqovZFeVPKOMiyrONsimQOjsS0nUi+oJj73eJbBEFNXgHf3+e/
         LrKg==
X-Gm-Message-State: APjAAAX3n8sKG7NoMxnNy0AitHEw8cNS87crvaIQF0Rmdrj8J+pFR8km
        Cd5J/u7MVu7qWi9KVlEmXJwWfg==
X-Google-Smtp-Source: APXvYqx9d9VCzc9djqGE8vhbN6fzsNZNeX3ceeR7YwwNB9iSwkiHZpuA9cyWGIFzRIf8wafnMVSCdQ==
X-Received: by 2002:a17:902:2be8:: with SMTP id l95mr135702321plb.231.1565032075952;
        Mon, 05 Aug 2019 12:07:55 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7483:80d6:7f67:2672])
        by smtp.googlemail.com with ESMTPSA id e189sm71404193pgc.15.2019.08.05.12.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 12:07:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: g12a: add support for DVFS
In-Reply-To: <20190729132622.7566-1-narmstrong@baylibre.com>
References: <20190729132622.7566-1-narmstrong@baylibre.com>
Date:   Mon, 05 Aug 2019 12:07:54 -0700
Message-ID: <7hwofrh1md.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The G12A & G12B SoCs has kernel controllable CPU clocks and PWMs for
> voltage regulators.
>
> This patchsets moves the meson-g12a.dtsi to meson-g12-common.dtsi to simplify
> handling the G12A & G12B differences in the meson-g12a.dtsi & meson-g12b.dtsi
> files, like the OPPs and CPU nodes.
>
> Then G12A & G12B OPP tables are added, followed by the CPU voltages regulators
> in each boards DT.
>
> It was voluntary chosen to enabled DVFS (CPU regulator and CPU clocks) only
> in boards, to make sure only tested boards has DVFS enabled.
>
> This patchset :
> - moves the G12A DT to a common g12a-common dtsi
> - adds the G12A and G12B OPPs
> - enables DVFS on all supported boards
>
> Dependencies:
> - None

Not quite.  The last patch to enable DVFS on odroid-n2 has a build-time
dependency on the clock series that adds the CPUB clock.

I'll apply the rest of the series to v5.4/dt64 until there's a stable
clock tag I can use for the clocks.

Kevin
