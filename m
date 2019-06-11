Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7484CC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4290A20872
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="myQGfU/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437027AbfFKXF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:05:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43210 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436837AbfFKXF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:05:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so8360022pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OBwSPzkDdi1CMoAJXu3fdSCyBq/M09/6VhI4AMk4Xd0=;
        b=myQGfU/fQ9FotkLvkIP5napMe/OlFIpyYMu85C1/ME8ATNL3ykv9VzsgnRpn3SiXtB
         oK2zfgP4tp0UvDA43Eb5BnXfH2n9vFTf5ttK+jxUOAKg64WPZlvO+qYjypkNRx7fOELh
         +/kyBy9tyGhTsyAtSsjBgdhzvl7i8qU0vwi0bKaYntUUFQFSCK1PzG8coiWfRIHEs3F7
         mZnu+yaiZIil39fibfqN1W7CTlDjWG1/6hcssnbsnUUyZ07qAhXeSB6EJNLM4XK++Dw+
         hRmBU2Gnj+VniTueB2pa2vhiNaHtAg4oP5sZcjecADRWjA8Nh9VCSyaq5PBegpLoen9p
         oYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OBwSPzkDdi1CMoAJXu3fdSCyBq/M09/6VhI4AMk4Xd0=;
        b=JNpeQYGL7kdbJNBKJF4rzLS+F8bQT0Ye2VWn+/CEMDSx56elfkk7Nl+AtDTWEkchOG
         THoLXMbGVbTLE8MNgEAadUA9w43fL5spfrkPP7QO81vpUfGVIR522nlKTd2NUN1ueT/j
         9kMfAly+zakyWVojeEqVl1Hkw5sRc7qX+zyaWeA6hO2sv2kkw4r7+4+gDfrXImOVwZ1u
         YVEzoa3Ss3PlwiM9M+FFhUAdzbgBxZg1QtRwe/x7wBxHJSeWfJApneqAaNSqN9nPjeUr
         H34ApxuBZ0NZNeMlfUdn8OaMrWdG+0ga04kqcqFC5Znzte8DPNf17Z5Fkg28zS7XsKEG
         p1pA==
X-Gm-Message-State: APjAAAXJHC3n8HNShYt9j3owR8uFRyy2SBmLVE3xY3ASNLJSTBDJDVfA
        NVa8HcqUtl1tH5yv1n+6YpV+oQ==
X-Google-Smtp-Source: APXvYqxjdj5vYjUUy2sB0u9Tk6uxU+kfxuJmVI3vHyHL5GJvrsWFCoAFGf8gZgFCMu8WEUVcxUHFCg==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr15629024pjr.116.1560294357844;
        Tue, 11 Jun 2019 16:05:57 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id x5sm4327928pjp.21.2019.06.11.16.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 16:05:57 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: sei510: add sound card
In-Reply-To: <20190524140318.17608-1-jbrunet@baylibre.com>
References: <20190524140318.17608-1-jbrunet@baylibre.com>
Date:   Tue, 11 Jun 2019 16:05:56 -0700
Message-ID: <7himtb4t9n.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the sound card of sei510 board.
>
> Note #1:
> The patchset (build) depends on the tohdmitx ASoC patch [0] for the dt
> bindings of the tohdmitx glue. It also (run) depends on the mpll clock
> series [1] to get a correct clock sources.
>
> Note #2:
> I would normaly prefer to use the HIFI pll dedicated to audio to provide
> the base rate for the 48kHz audio family. HIFI pll rate precision is a
> little bit better than the MPLL. However, the HIFI pll may sometimes,
> rarely, take a long time to report a lock. I'm still debugging this.
> In the mean time, let's use MPLL2 instead.
>
> [0]: e35f5ad6a965 ("ASoC: meson: add tohdmitx DT bindings")
> [1]: https://lkml.kernel.org/r/20190513123115.18145-1-jbrunet@baylibre.com

All dependencies are merged or queued for v5.3, so queuing this for v5.3
also,

Kevin
