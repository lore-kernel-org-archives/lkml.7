Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96EAC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21A320717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DkgsWaf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFERqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:46:10 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:43795 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfFERqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:46:10 -0400
Received: by mail-pf1-f175.google.com with SMTP id i189so3253861pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=mdjnarB+nUXz7hnRyqlS2w/7X0NaH7xvH9rt61WhNEo=;
        b=DkgsWaf5ewgbwf/bhecR7Rlzf6+bbU/HCSGByz46RTTeljIuZgxfGrTodm2URXsetz
         zYc8Igeto3YdkLx+b2ImfPB9az8pby31RZ4PzJ+65G0xUDv1orMqZhlHjjxu+tbRYEsl
         V3oDPtEn4kppz3G1ccPtcREEO19sNdRiw2Fx9zkZP69V/gPMTnXX1oyu7SBNJL8EGqmr
         xEZ5HsFSy7ThZs9E86eAK1GRltaZcazaWgfYQTbmViawm5CCU9I/bE039nd4VfrZ4+vR
         4TonpnDtToAjc0p3pVpbjana5UawaEYHmvXq5hvGHZEQNm/n86b3zr1H9Kt/wwGVwYCk
         Dh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mdjnarB+nUXz7hnRyqlS2w/7X0NaH7xvH9rt61WhNEo=;
        b=sMhZ4p9Z/abD/XjG5a2WXADqAZzM2EK+b+KQ18jl6/5nPmVXt7fjK9NpBDmtAGNLio
         6elWTcUHC4g56VGiHzrnZpeAvPSoFK9BalwX5HsWZ9OfxJhAmxfgIlrIuj+OiBzPoc0X
         KJ6hS51H2Nyr5MHa/UhvXAstT9I/DqoL1V3dm46VxnRiA8kyERAqirAq952IMxiqVGv3
         DP47d+aVouTDyx8MjRtV0I+g75rQ4bR26FibFPR99pdcBlcJny4Mr3zFEaK6zq9dj6iP
         lnoNk+kHruuBwOQRLrrgT0XtbhxDk6iPGNfum4nnQTWUQ5fh7K7VIkteL3Rup3pSiWhk
         CGjA==
X-Gm-Message-State: APjAAAWUb2X8Di0hn7DAF1f6BEOkDbgNazPaGeioKqrpnk/vbVqPmsi5
        b+m0NcV1e9/+VIrJ2VQWGLsAAQ==
X-Google-Smtp-Source: APXvYqw8SKXZxXfsqJkxBQv5IYJ1v6uVYYSyGSHw1/ni2fuuBT7oUs6WpH34VbtII796X3z4xjM9nQ==
X-Received: by 2002:aa7:860a:: with SMTP id p10mr48871257pfn.214.1559756769781;
        Wed, 05 Jun 2019 10:46:09 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r77sm26803689pgr.93.2019.06.05.10.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 10:46:08 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: Patches for v5.2-rc and v5.3 merge window
In-Reply-To: <alpine.DEB.2.21.9999.1905201019010.15580@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1905201019010.15580@viisi.sifive.com>
Date:   Wed, 05 Jun 2019 10:46:08 -0700
Message-ID: <7hr288exi7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> writes:

> Palmer has asked me to collect patches for the v5.2-rc releases and v5.3 
> merge window, so I'll be doing so.  This is just a heads-up so no one is 
> surprised to see 'patch queued' responses from me.

Speaking of v5.2-rc, any chance your DT series will make it for v5.2?
I'm hoping to have upstream v5.2 ready for testing in kernelCI, and
that's one of the last missing pieces.  I just tested it on v5.2-rc3 and
it's working great with mainline u-boot.

The other one is the default defconfig, which I'll submit a patch for
shortly.

Kevin
