Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5CC20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JrDwC/Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfCRUHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:07:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45403 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfCRUHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:07:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12so15565839otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygUaR7GiYrQw12EOQDMxY7EWNNS00Ue7tqp1hNhMuCA=;
        b=JrDwC/OyTzjt1oikQlIpcbuBZqSW+C9CV1Dm3ASNk1fhv1T6mGPpmukmAfy7O8/o/x
         RzeTxutE7vMA5uOHPPoqgnwh1lVJ6GQwqgbP9Y5BE9pRiAzYg5lAngaf2UzQ0NSejm/C
         jRH3pdtLFKL1Fsaq4Mr3eJ/bm/yVzMbJ9Tr4jTv+SUPZMPEfLQQjI+ASWORQvJRyqlrq
         YtlM18Ah5la8nEmWYqFC4Ag0YmZDSlaGY6PEZlusAbt+ush+04E3IG5BAf7SFiGIoVzY
         E08rEwc2ORe5MLrLm1iALMGV22qhtHggJIVcECo5WvlnzDC9Gi9ZHURI7pjDV+qXPKYt
         I6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygUaR7GiYrQw12EOQDMxY7EWNNS00Ue7tqp1hNhMuCA=;
        b=nuV0vhNkrQATFrcEaHJPi+IFHGtQlZl2L3/E2hBgRqxt+jG+5b3FPqd0Y/LmTx4O1F
         h3+bbyCOw9Nys6riS7hbnRUW1d8t0AW58v4CkM2+eDOoOb9sDRV8kFZswTqpUCW0dfh4
         9RNV+qYO9hdaX8WBbv2vMdkt6Rd6B9jkihPVM7aewZHNskgT/xWaWnkMoRKhBY+F4Aor
         WbqqkYJEnoxV6DxQqv9gJj/eBYlonISsShM74kCE22W27tA9tCWaFXuHlLTYNwARheZB
         tKmio+huzVhnuu8WDmJK2djLjPeYPX2iI6YnigtCJGe3i+VDYyZ8EtEX52YgGZ5lCxk3
         fX1g==
X-Gm-Message-State: APjAAAWMp2P7opjq6xXq8OwlHokfPnagAR9t2pr+URIbnf74bZxeGKvL
        HqPjN0113Z4zX/moHotmexWJNe6cFwQ9He4bTs0bcBuO
X-Google-Smtp-Source: APXvYqyikuKV8prgrvcnBwE28bAN24G4srbVqNtWicPnEsu99gsfPhP+/y0kY4F8CO22zm3KsHt3vjK5DT/T4briXEE=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr12035998oth.308.1552939639256;
 Mon, 18 Mar 2019 13:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100458.5619-1-narmstrong@baylibre.com> <20190318100458.5619-5-narmstrong@baylibre.com>
In-Reply-To: <20190318100458.5619-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 21:07:08 +0100
Message-ID: <CAFBinCAT848_qGPuERj+nAc3B+2y4kN5gbF3k4JYYWEu5maDDg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] arm64: dts: meson-g12a-u200: add regulators
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Jerome Brunet <jbrunet@baylibre.com>
>
> Add system regulators for the S905D U200 reference design.
>
> Add some regulators. Still missing
> * VDD_EE (0.8V - PWM controlled)
> * VDD_CPU (PWM controlled)
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I have no details about this board but the changes look sane, so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
