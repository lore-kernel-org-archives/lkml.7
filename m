Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B104C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E9722CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7pMMnHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfHWJmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:42:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42519 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfHWJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:42:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so8254573ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9mRsUodr8INx8kLiQuFLT6wntAGfHnLDVBZoZICFTI=;
        b=D7pMMnHdfqhTHEbILraVb+LJvXqHH0oAURqSthG109P6NhNjxj8dD1tTBKCsoZE6Wg
         +ZVyTADxuYmkbpWAU9YFNL+rpYNJAnnwAf1p4HUn77wkRPYNFoWUreoo8oq8nyQy+da8
         Y4EaWT/NZVIPTHhT/82Y8zlr/QsGAQEGJRBB/8CGdQOZKAilJteJ6NRHVCfWJ0EfLQkw
         ADRGbxPFwc43sXCSwFxqXc2rliWafXYyjNHb6g3A31lCi37BDlIFfaYbwMXOlolMDvVK
         5IW1yX/qn1VkdCUaFjnINEp+cGHSctJDS1HErbvHADRBx7bEijJbDa9sf0CIZlN889Vp
         +S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9mRsUodr8INx8kLiQuFLT6wntAGfHnLDVBZoZICFTI=;
        b=Scst+x4QCy0kVgWaQvJIRpeUxmNA8E9y5MqTfq0au6Fl3kYHpIaP3kdA4MMMEore1S
         UowWFdkAeJTaQd0xM4lBeARfe4qmu50GXVttBTArsrYnOY0oaA7pR8p3F1+9nYVt4uL6
         hIs2bkTg2+rzBkkosz2NkU/0HvRZu+dN0Z8SEEXXnvvwpyFRcFJ0oK+0+oW0CtL8Kzko
         0cpm6rbHITwfWMqSmMPM31fALkwF81gIpqKQ+6LYKtXf0CaFPtCPOhSFClLVtk43rpco
         Yo9Oj5D5AWVO6PuFQFGmP1APPLkhRxqp2NlYtWhXXKv569mW6ZxC0K31s24FVtmd3HTb
         EY1A==
X-Gm-Message-State: APjAAAUa967YxcSsvzuXVROwAWhuRhmIM7+GTyKc8h0Ai4H04CP2+q/z
        aDosD1O97mPAYCPniGGDqaYIs4bfrENAy57v8SBlbw==
X-Google-Smtp-Source: APXvYqxbUW9mwdFAw8PYUVklPhImRXOOG2mrpV80i8O7nFOQr4/Kq5cY8eZfZBLO11XOblNgr1rWKltULlseXo8MMs4=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr2368029ljc.28.1566553330329;
 Fri, 23 Aug 2019 02:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <1566335128-31498-1-git-send-email-hongweiz@ami.com> <1566335128-31498-2-git-send-email-hongweiz@ami.com>
In-Reply-To: <1566335128-31498-2-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 11:41:58 +0200
Message-ID: <CACRpkdaa3tWw_LC6Ce9Ru4gFji_SquitmsDqThRj114=Fro2zg@mail.gmail.com>
Subject: Re: [v8 1/1] gpio: aspeed: Add SGPIO driver
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 11:05 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add SGPIO driver support for Aspeed AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> Reviewed-by:   Andrew Jeffery <andrew@aj.id.au>

This v8 patch applied for v5.4, thanks!

Yours,
Linus Walleij
