Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C5BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055CA206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bw6N/Ou7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfDOVsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:48:14 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54422 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDOVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:48:14 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so12980044ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kXaB8APZP4Hr/ATS21yOa7SVL8EJy4H7VT042/0iBhA=;
        b=bw6N/Ou7HzleTSIK2SdWsF4YgqeWxqz9ISWTMv5EuIkkmwc9jYEnMFqoj2Q1Qky1hA
         +Zx95zeoWEnU+h6VJ5ek8tqGl9o9rlPPol4Hs3GOdb064DWxkZKieQr47MrP5LG0M5Pv
         0NY5ryq0GQjHs8KjsXwarObW8RRJjpFhoh6qIfCBw3lQMfFzLjqx6FofAkcTYhkVrlh/
         Y+s0tyxxaq/JSdKzu2HpFrI8dCxwE1KOy5crKd4GrhSuferEqsuuZexQpjpiZma4edPA
         kttpxA5n4a6JgnMc4pBqV1pD7/LKRqlgV1lWx/FaquEu8ykq0LQRaDwOeZnD1x+FhuCy
         //lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kXaB8APZP4Hr/ATS21yOa7SVL8EJy4H7VT042/0iBhA=;
        b=bzXvsuRtgUP/Q7eZblR/It1orutS4bomFvWeUN/MM2PBRUKmIxhgojbnaRRVL7lerj
         dCouBeZHLdYvCjqiA6fPJZd/ePgrB0onH/rvaMZgadUE0vWhmEngSZO0Lqo6i1Tlp6BX
         dHNcMKbtwHyxOu1j/trOatK7IhFy8SPkzvgtMXj1184VBJcmrC82XsCorg5iNbaOmilK
         I7SATKfG14B0KnT3xg/WSwIrvlDwiD2geYfqOzqu9nyhqACfaebIrM/ipAq6PccRnmVC
         krxSsD8T7b9EO6sV8p6NZZ2ednFlrH+JCsnP24wSW91/gMGnHkRwnwu1KBh2/J2m9YZL
         hSmw==
X-Gm-Message-State: APjAAAWrLEpV+7qSUK+KS1dJQ2msbQ/jaFgR6Qb6GcU1KoGQ+HjDc1Em
        XDJlt8443FvTuDBij3l1XMCNjg==
X-Google-Smtp-Source: APXvYqzpN7V/WTNAS2zfa+j2ISk7o4Ke05b98iugiQygVYs92f8buHhAVC5h+5tW2SVGf0zR7FqIRg==
X-Received: by 2002:a24:ac56:: with SMTP id m22mr26954319iti.25.1555364893311;
        Mon, 15 Apr 2019 14:48:13 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:4f03:26b9:1e31:4fda])
        by smtp.gmail.com with ESMTPSA id s3sm17486394ioo.65.2019.04.15.14.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 14:48:12 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:48:10 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-mmc@vger.kernel.org, djkurtz@chromium.org,
        zwisler@chromium.org, hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        linux-kernel@vger.kernel.org,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] mmc: core: Verify SD bus width
Message-ID: <20190415214810.GA157394@google.com>
References: <20190415210031.54062-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415210031.54062-1-rrangel@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:00:31PM -0600, Raul E Rangel wrote:
> The SD Physical Layer Spec says the following: Since the SD Memory Card
> shall support at least the two bus modes 1-bit or 4-bit width, then any SD
> Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").
> 
> This change verifies the card has specified a bus width.
> 
> verified it didn't mount.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> AMD SDHC Device 7806 can get into a bad state after a card disconnect
> where anything transferred via the DATA lines will always result in a
> zero filled buffer. Currently the driver will continue without error if
> the HC is in this condition. A block device will be created, but reading
> from it will result in a zero buffer. This makes it seem like the SD
> device has been erased, when in actuality the data is never getting
> copied from the DATA lines to the data buffer.
> 
> SCR is the first command in the SD initialization sequence that uses the
> DATA lines. By checking that the response was invalid, we can abort
> mounting the card.
> 
> Here is an example of a bad trace: https://pastebin.com/TY2cF9n0
> Look for sd_scr and sd_ssr.

Personally I think that all the info you have here below the --- should be in
the actual commit message.  It provides context for the bug that the patch is
fixing, what the old and new behaviors are and how you tested.  The text below
the --- is for ephemeral things that don't matter once the code is committed:
what revision of the patch set you are on, noting that you've addressed
someone's comments, etc.
