Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32288C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3B020883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF+FPIwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfDIRcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:32:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44270 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfDIRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:32:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id i21so14243035oib.11;
        Tue, 09 Apr 2019 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4C37kuk/3QFpUiiREEwzcAc84XKEDNmELmFYcLjkEI=;
        b=MF+FPIwyi4WoexvD6zWXNKaS8kN8zCQo7ftTcZYalBMpNeISIYYygjgQ0J+sgloIFs
         HawHXQ/GNBpj03c5Luy62vgEcKyOeF2u6S+p9TKCe/J9r9akSSx4tUJxbYilDhz9ltd4
         6tFVqy9Bomv99WsUiFifSZZjCv91GFAPTSjRn0WOxNzW7a69Pe9uLoyll7TCnDLjxk61
         BDbEOWKUqPYYCt7EF4BOx5ZsuSPvsvVw8+DPPWyDQCvdA5CMdws5RO/p3qP+puxTyHPt
         4kL/XRf/MJHwDpgH6S4bcrbUU4RDoM+T3gpzFyUF9HtGHOiVDUgkw1dF8HsHk19GFec+
         NdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4C37kuk/3QFpUiiREEwzcAc84XKEDNmELmFYcLjkEI=;
        b=IMXa74oXcWQiywgx02adJ/L0PFozCBR4KQvj0jpjBkX90Gwk1UZgbiV0ptPm0VA3Mt
         trhrj1CSOgZ4+GDxf7CrTTSLoR6llbO/RYQyVG6ETkpK4knXOMWdabbUb0z0U34j2W07
         s00p5e4XKscOyPDNjR7Z7PcwYCsBDR56g+9VpN3eeYqZC3TIGAlXv7D/NDJ7oVccV2jL
         d4BCHK7YXWHzqai5X4xYJF3gNqZw19lklYE2luASoFk5H46yBIPBraQJOOfP1Sjyne96
         nWLwxJAyIeU2TGl1D2g64lMnB41oZYHFgLw3VlZiUHrl+r14ZNJKcPMQHa7YOTETivKi
         3sJA==
X-Gm-Message-State: APjAAAUuT+NZkDIYqYC+yw5culC+ABo/QzcP+XBRY0X7UIENbBX3TUSI
        l2FHagDvg77peOpUYmTZ+AwdeLjj2Zo662oj8l8=
X-Google-Smtp-Source: APXvYqzosr0oVFGgTYFfLwGAJTnjqnihK1XEdKaMO4M/f+9wFlCJVSS1zn0MEQrqZu2PowaMGtPqtZaiNY9Y8UxZrIQ=
X-Received: by 2002:aca:c405:: with SMTP id u5mr21816544oif.77.1554831125587;
 Tue, 09 Apr 2019 10:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <20190409144250.7237-5-TheSven73@gmail.com>
 <CAL_JsqJhefb3qmPN4Fn5zMz_UYFTRdPthqi4NNGMNqwNtSy76A@mail.gmail.com> <CAGngYiX15ts+dr4MzvtHcEfasZCSK1Lok=PkVhqRwKtzWVnQtA@mail.gmail.com>
In-Reply-To: <CAGngYiX15ts+dr4MzvtHcEfasZCSK1Lok=PkVhqRwKtzWVnQtA@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 9 Apr 2019 13:31:53 -0400
Message-ID: <CAGngYiX+53Rk2gTJ7G0QhQvEL-fF=Zan5jW9h7cR3gV1-J9xCg@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] dt-bindings: anybus-controller: document
 devicetree binding
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 1:16 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> My apologies for the confusion. You already offered your tag to an
> identical commit in v3:
> https://lkml.org/lkml/2018/11/6/66
>
> Am I ok to add it, given that nothing has changed in this particular commit?

I added a link to the wrong version. The current patch is identical to
v5, where you
said it looks fine, but the series itself still has discussion.
https://lkml.org/lkml/2018/12/7/600

Should I re-post to the DT list?
