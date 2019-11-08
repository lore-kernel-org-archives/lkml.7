Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6D4C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2883720865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0tKYfww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfKHDvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:51:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36676 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfKHDvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:51:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id f10so4068859oto.3;
        Thu, 07 Nov 2019 19:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhuDy7k1YQ8fNXLKpPn/sc6C1FLdaiYWgUMBjQg/bFo=;
        b=E0tKYfwwrZDCdsh04gyklOIRSpMjrcZf7XFyRLcpx8x0pxA4Humn44TwuUQLZfK/1b
         DIJAUa72iHHl3W8JOk9gC0IoqX+RzQFpVTlLZbUsAIV+H8JULQJjB7WF+xoI4A7ibEeb
         x4OmdARMasC/SpvW/Qxj/m8VVxYvMnAHuzB5pYghTduxlcAih6ob712gkfAOl0RUFWfv
         6bj1niVXsQ8yZlejOg7g+4vxz+99Xjublz3dvnsnE+PC00dP5xGPe1roWntjK5FEmWsz
         JgDdCFE8U/7BdNPxiBYtudoex4LpRAacGADeazvwjutcDrZ0v61hhKDNtV75Kab+ZWHC
         TCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhuDy7k1YQ8fNXLKpPn/sc6C1FLdaiYWgUMBjQg/bFo=;
        b=m1Kqsu7MXkgzrPvFdIlCnTHmVEohizdaMY6bwCngtC0vGFyGkSHFBur7KyRwihuGdx
         TN9eT+b8Q7EefuXLcp7BbHvLrY0xy+t94fYzAQoGeLWDwn1yLH+X8kMCo3F8yd4PSzA1
         o59YJRzeTcAf3U9dkyETzviFFqYOIKE8BBtF6BBXEccOjySuEf0gCNkpsStduuoHOOwG
         J98Hpe7rkARhUOL0PlQ8Jj0tE5OxteuwT3Tmt7XVgdJZ+8+ZD8xkx4Bp3wTnCxIG3j63
         LCHuuXEGLlj2Zwm9bAWx9PAgaK4H6a7A8N+80FjGQIXApWLKT6HlUan3MPpesRK5lMh+
         jQXw==
X-Gm-Message-State: APjAAAUdB7A+acpPx4UN9tKxcv1lOFFQC/vdu169GMKeM1ThdUjh79H5
        F5QWiK9apO+kzcvEfN5qAGKdgLuFFwpwk21xtdQZuGuz
X-Google-Smtp-Source: APXvYqy2t/kO5ZRGsn5pm8g1lSt5wtAL2Dz+sn0BJoP+m3eFEMrEvRM44WhCuk2uQLh+OC2wKvuDp/aXC2cBaaLmIIw=
X-Received: by 2002:a9d:6b81:: with SMTP id b1mr6069691otq.70.1573185077890;
 Thu, 07 Nov 2019 19:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20191106140748.13100-1-gch981213@gmail.com> <20191106140748.13100-3-gch981213@gmail.com>
In-Reply-To: <20191106140748.13100-3-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 8 Nov 2019 11:51:06 +0800
Message-ID: <CAJsYDVJ8zFBJBQHVgyWE1joqGhsq9AibKqrgCZToySPT3p0PnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mtd: mtk-quadspi: update bindings for
 mmap flash read
To:     linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Nov 6, 2019 at 10:08 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> update register descriptions and add an example binding using it.
>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

I'll abandon this patchset and implement DMA reading instead.

Regards,
Chuanhong Guo
