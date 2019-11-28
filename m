Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF908C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687F21789
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZqFnPPmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfK1NpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:45:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46169 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfK1NpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:45:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id a17so20066698lfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVyVH3GucIXCwfrLXX19RLZ09hFTpdgyonXBY6f04/k=;
        b=ZqFnPPmFXVOZPQ+d07lBFfoR3OZn+DTxcIkmUV2Ixk3ZgAOc1136lj4VSNYn7ltmue
         Y7q9kYYfko+UbksL+7cOxZg2Xfz1Uo6AavH2kyMi3RteXWGRsX5vpWqQf/RK77j9iwve
         PAQgcfFrhlltVqBW3kwiFTki7LGoQaa+o8mJwOZ8PQ51I6y8SYdjhmMkWkaoOG8+KOaO
         GhBnhG7YZzOGZpMTi96UUGJjxRLUc9Z09SJEjaM+uAlnWFpMohoEJNbhbL2mWtKnHjpU
         lC67Wv4bSGZdmb7egsTcBU3DgjWUCP9ugxohPyZsLVuYTFzueoyVkJ0Ix1hmF6ZSR0zK
         ueMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVyVH3GucIXCwfrLXX19RLZ09hFTpdgyonXBY6f04/k=;
        b=euaUHI1//xsBHtKODR6knwPhJXEVCNz2u9sDr08IFZKvBiH1N2+m4QmWXKffvvMRy3
         FK8q+wXMq7IGPTzv3WSMtJGWYCYr6+YsYbni/NpfRp8n7O3xEW5tl+Rl5vfyVcrhcBWx
         Rc0x8yVcyj14zo1K2o963D+pDkfW+aCp0Hr9MwOQCT65g6Fmumc4Ung3LpUZ4NHEsJcQ
         hCIJ5GJu4sdUFukwiXIsjtFpBodUaV5U9EO9IstqyD/eMOR7gYA2N4WwkexZsDgjhbGi
         aK2QKDxBGXlrnfV5Nqc17+Gxtzr+d3L1dfAiIbZnr0jIkGbgsn7WQkInN2hTINJ4RKLV
         y+vg==
X-Gm-Message-State: APjAAAW3kvySLgJN0qeQ1Pouhm5SrgCaTieZlrJ5pPUuZjGfaMCRYsE6
        xntazny0SEDZGHw9IwCvoAQBAcPGiKcSzUBLelZc4g==
X-Google-Smtp-Source: APXvYqxmD5I6HnIUXKd0kI0HkU3aSQ4hioXpM0yhKdtcDcsx3EccroOaBtiV8gi40+vkYztiQmeRCAXkMncEdw2+E9Y=
X-Received: by 2002:a19:f701:: with SMTP id z1mr26973589lfe.133.1574948708877;
 Thu, 28 Nov 2019 05:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
 <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
 <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com>
 <CACRpkdaW82pgQivc0VVgqqVv4fgXxMyGD3Lo8YHcMK7aGPDKaw@mail.gmail.com>
 <CAMpxmJU_0MzroyD_ZF5WOxpZz3dkADLOmW7aKpWdJ7GCvo-RnA@mail.gmail.com>
 <CACRpkdaPQKxfC66yhG=xdmCOGGd9PjDVCwZquKb+4HmuS_=kNA@mail.gmail.com> <CALL1Z1xpcGyh_f3ooRT+gGApoAnS7YBMd2hUKqnt+pTcAFoeAg@mail.gmail.com>
In-Reply-To: <CALL1Z1xpcGyh_f3ooRT+gGApoAnS7YBMd2hUKqnt+pTcAFoeAg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 14:44:56 +0100
Message-ID: <CACRpkdYEEypRZOaO3Ta9aDgizNeLyUOSraBEhKaZcHaJV+o0gQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
To:     Khouloud Touil <ktouil@baylibre.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        baylibre-upstreaming@groups.io,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 4:18 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> [Me]
>> 4. The code still need to be modified to set the value
>>    to "1" to assert the line since the gpiolib now handles
>>    the inversion semantics.

> By saying "assert the wp" do you mean enable the write operation or
> block it ?

Yeah one more layer of confusion, sorry :/

By "asserting WP" I mean driving the line to a state where
writing to the EEPROM is enabled, i.e. the default state is
that the EEPROM is write protected and when you "assert"
WP it becomes writable.

If you feel the inverse semantics are more intuitive (such that
WP comes up asserted and thus write protected), be my
guest :D

As long as it is unambiguously documented in the bindings
and with comments in the code I'm game for whatever the
at24 people feel is most appropriate. (You will set the standard
for everyone else.)

Yours.
Linus Walleij
