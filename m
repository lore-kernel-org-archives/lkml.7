Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E906FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD6820883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HFfUxrJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfE0SFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:05:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43273 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:05:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id i8so15471279oth.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzjIw5BLJk5drmWsGbwMcT1IBdvLRxaPnalQTSSBes4=;
        b=HFfUxrJhSYm2j8/HILqhg7e2ofeY9r3RcjD08fQe/AtwAyshGotCU0QD2P94+IP4yF
         lmbV61UJFI262leGz2czn5IWnK3/vE/mGGnkPgG9pAsXSP14vdqNMg374KhFtDHe8OCm
         VKWEXZwfnNnR6Uf/rgZ3ZbW4EDgagYKtCTsDyh4ZCf9L+P+e2JBxjQAKHpugULNHWsw/
         mCTiF0GQt1Y1BqO7X5YtBwMgMOR6GKMiW+4WqN93UE3cQ2Cz20m/20Ab7zHDxYH3nIUQ
         uD0qSU7sN/GwjuEDtUGoa3AZ7WMs1OsTw1LMnYEdp2+lHsmz77yja2LAikHUo8RgzeZk
         95GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzjIw5BLJk5drmWsGbwMcT1IBdvLRxaPnalQTSSBes4=;
        b=kFQLRBu1Nh9L+KMd1Z1VYbLPs4WqQOQF5i7AowAkT9M4hVPzTnSc/EqF8OFZeNZFkP
         FZwjKBukascc892R3DPxpFJ/Zofx9x9JNaBowinwV1NYPFsjVduNBnYziBVcSdDmwZR9
         6hC7qaSZKIezolInLq2eS494R03bjuumQblTJxv+U8J6UZ8emVsEHVY+08/Gg7xljO+n
         A4GU1SBQ63vi6UfSdBE+2NMLnTBASI7YXGXkzoMm0C/xxsuo8Ti7AvaIYDKGM9+Ir+Kh
         2mSPSIibVPJs6U7lUPHFfiNUqkViOSzBBv0309Xfaxny/N1bhDl9/v6cflmw5xDLbbJj
         HeQA==
X-Gm-Message-State: APjAAAUD0Jbyu3Xg9cqGQBs6G3hx++NYb1nypr3oZf3RHMBs3bkR4tkT
        Mq9LY+NMMFnEICBI4u/M598g0afA/FLMPtB4rzm8ttTuZyg=
X-Google-Smtp-Source: APXvYqx3kFWQFTkADAuGfjyGBlcOq0Ix3CuPnZhJhi9h13tqc0aa+NCakzhhRSzvyADIx87mSurffOEPjsyB55kp7Ew=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr71809486otb.42.1558980353780;
 Mon, 27 May 2019 11:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-2-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:05:42 +0200
Message-ID: <CAFBinCCz0v7iup21NBtsxDxOYXESON3TTFOqfurRHei3g__7vQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ARM: dts: meson: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
