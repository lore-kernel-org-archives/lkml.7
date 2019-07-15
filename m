Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC85C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B712220665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RpIk7j3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfGOUeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:34:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45481 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbfGOUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:34:18 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so36254676ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AAx+KCYrMtY/ELRUUN49P20LRASTzqK4lZ6I/S93X28=;
        b=RpIk7j3AS+hWigOL4/NO0cAujJh97clQ3BtY/u3jVW6nPPtiOE+viFrVvz1BSw1jkq
         880IhXGdnLCoHPy7+X/IKtRH1i7P5ceG2u7W5MJbkzF2OztF7v4ydbwKsHWiTTMAK0SF
         iw4K1QKMbkgiintmdjECPloTU31lbV8Kobm9JhSUiPTFIVXKlebvDbx2ZRIyh/3IKB6a
         xZbNPDGZbCO+yXvorzfXx5/ieunWgh7zYy/W4s8BTzoUQBeZg7vEJPlqlM1A5X85zBsh
         iVh/hqli58GoSSj3JED7K6kjIoMdDJ3oFdKgUThYX03SmVwWru6AOF13fgiLF34Gbb1L
         yT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AAx+KCYrMtY/ELRUUN49P20LRASTzqK4lZ6I/S93X28=;
        b=jUkYHszcZItZQLYCaJ37ypwyN6cFSP3aw8PFUcNswNJ2oKV+eL2aaR6laDkJ5d0N42
         QPqqnPfl+8C/ZnTfB5mpF1UliSBkiqukcMkZTRfQV/UuvbmSfU2C3fyPnmrFo6H4ZqlF
         oJYW440AaOo0oUeW9xm4y1TICxlseKcZlYqvZ2+YBvKVLeW7nq3GNc2qS863ty7y3wyG
         xt867oTz9EQiafgY4uWYnH1MgpyrcFIVo1kwPI7Oaq04PWG6x8cgZSPGItUJwXAGMjwj
         IKxfmYWPwOpGJqkVz6DSvT32RC3ljb5cn8uK8gvovtmit+BLADYNi+WToGnl2wWHem6e
         tsDA==
X-Gm-Message-State: APjAAAXBdMxhCo/xq6m3S737W/1ev7VhgSnctsDnpCK9j1uMQSMl3bIy
        24SLCtgx5Ye+GXJN1H+2TO/Ghw==
X-Google-Smtp-Source: APXvYqywZfe4luOYTPj2bKAQyrauUOFxlaTpfEZs9VJMfxXbS3dpLgxSPAbPdcnwrPKuMusn2uh4OQ==
X-Received: by 2002:a5e:d80d:: with SMTP id l13mr27309709iok.292.1563222857310;
        Mon, 15 Jul 2019 13:34:17 -0700 (PDT)
Received: from localhost (c-24-118-241-30.hsd1.mn.comcast.net. [24.118.241.30])
        by smtp.googlemail.com with ESMTPSA id n22sm40057663iob.37.2019.07.15.13.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 13:34:16 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH RESEND] arm64: dts: meson-g12a-sei510: enable IR controller
In-Reply-To: <20190701115724.15801-1-narmstrong@baylibre.com>
References: <20190701115724.15801-1-narmstrong@baylibre.com>
Date:   Mon, 15 Jul 2019 15:34:12 -0500
Message-ID: <7hef2ryr3v.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Enable the IR receiver controller on the SEI510 board.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Queued for v5.3-rc,

Kevin

