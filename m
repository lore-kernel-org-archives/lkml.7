Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED7BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5F720663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEzIcJAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfFXR07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:26:59 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37304 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfFXR07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:26:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id 189so6044232ybh.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXmuDDswJwasFysM5xAe3iWKG6lQgSipjb+VoaydZpo=;
        b=ZEzIcJAE76hfGZSdojtnNCDq8KnZa8QzLX4gcsB7N0ETY6ORcgQdkor67xpQexSWWo
         fnprlr44zWbGI7KMkoUFtAlcXBvv5h8VZTTFA5WYfT7tmNiBdpnUEvMjWV1eespYOnxk
         Fl+PI+e3gWgPAAA77uCNH9dQDpxVjW9vD+haq9JfuhF09FQJyTdun0ZPUHYjjtY0KurC
         v+0o1Wo/EOBSSgiNa8QwBP/x7zBnjsu9+huHIxK7XbalT0GWYGrUmiI2uEkTzkEN6Djk
         nC9qkPQYSsytaWz/1g2lwHRxrOvwJWFj6RibszIU/C+giXx6xQLf/9D3PHoZAG1pkMQh
         vRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXmuDDswJwasFysM5xAe3iWKG6lQgSipjb+VoaydZpo=;
        b=DgKFH1UceSCK/9Z/ju3Q0rEXYE/wzdsRoAmGouun0WDIH9TiB9J6K2igA4JRDWLQ6d
         +B4sXiRjkF6D4R2Gem5E6NmA5L85BYIYyBKWPRNYE+HlMQhICa2hihMimIc48zeqadU3
         YhZTIVAYqoyCvZz5p5sftpzE1ZvWfr1tB97NOzDDqVx/WYzHbrJKV4yGDHVbEOmRtHh1
         rrW46ybjj/kjDO23+eKvKYvLCYoAHlHIAwrbCyVy7qImZxZ0BEOqDXDgMZbdyL0+a3Uy
         /X1hfMRF1+UIk7+AoZA6+UsShSQBOJxfce2QjMgMWQ/NIH8/CP38c+FprbAtQCB2qFsm
         xgaA==
X-Gm-Message-State: APjAAAXAFHQd76FsASM2u3uZPvPSsIIwT+loTjPfsgbH0VUI27gO3pVB
        D2Epqyac5lqn41bbquAK6Gr2s2oE
X-Google-Smtp-Source: APXvYqzw8pbSlUaKwCUcp6NeRqSPYljdiyzEkEXM9NNBWRW2xkxurNFP0j4uN8krsT/yijPD9nLmFw==
X-Received: by 2002:a25:5f10:: with SMTP id t16mr3102086ybb.5.1561397218061;
        Mon, 24 Jun 2019 10:26:58 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id q8sm2628622ywj.58.2019.06.24.10.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 10:26:56 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 189so6044156ybh.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 10:26:56 -0700 (PDT)
X-Received: by 2002:a25:21c2:: with SMTP id h185mr14071216ybh.125.1561397215686;
 Mon, 24 Jun 2019 10:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 24 Jun 2019 13:26:18 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeHhz1kntLyeUfAB4ZbtYjO1=Ornwse-yQbPwo5c-_2=g@mail.gmail.com>
Message-ID: <CA+FuTSeHhz1kntLyeUfAB4ZbtYjO1=Ornwse-yQbPwo5c-_2=g@mail.gmail.com>
Subject: Re: [PATCH net-next] can: dev: call netif_carrier_off() in register_candev()
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 4:34 AM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
> trigger as suggested, there's a small inconsistency with the link
> property: The LED is on initially, stays on when the device is brought
> up, and then turns off (as expected) when the device is brought down.
>
> Make sure the LED always reflects the state of the CAN device.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Should this target net? Regardless of CONFIG_CAN_LEDS deprecation,
this is already not initialized properly if that CONFIG is disabled
and a can_led_event call at device probe is a noop.
