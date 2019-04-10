Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19E4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F91620818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih3INteI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfDJMAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:00:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33935 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfDJMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:00:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id o199so1628683lfo.1;
        Wed, 10 Apr 2019 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8h+eeqcoNv3kyMs7wxLtSg8BXmVRJHVJ+1QgZzK7z0=;
        b=ih3INteISV76tIB5NHBs8EPVi92NmEICuOYXJk45NxDGaFrBDV90vr177LnUQkMrer
         DX+zk8Q8UrNDdw8RAQOmbJbsJDExSRGRZYkQ1nbAxChBSkxBDoEJ9CqKOQwlUITzzjQg
         7HpMKnkW6FDiM11hOEq52xBYmADe8nYxwhjxEvwGJX96o1/RAiyWinCiaVTuQAKJAfKE
         NIkWlaxNYbeaC6WWl/vZLUb72UTSbwJjNHBpHB6QDko7nNq278UUlbwPd2zDv50ZnHHJ
         OUag1ROKFK51DkpJCDj8z1QRarmECdkKmKe7gKqHD/Gf/6yn+01j/xo8+Yl/sQx0qXnu
         gaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8h+eeqcoNv3kyMs7wxLtSg8BXmVRJHVJ+1QgZzK7z0=;
        b=Q6gjS4rtLmO8DNnUOKDooPP4mE+4SJCl3rPagzwJWAX2Yb4ysjNYpzbXSf7KhAkl+M
         xP/d0lAeTmRv15TPMHw+ONNqQBkUEcbVD6mAmkGwbdEMalI/AREVBT6AfS1Z8l3f05Qg
         bxcs3Qw0ZmJF26xcjEQmhD+zQ4Pe37VeMfIhg1ANj6FTZb975RGIY67Z7EU67EAAa/6E
         6rMfD/QFQKTvRNeVAdBFz+c+0CWgHspok/JScXdd4szOTRt13FARPNcNkkUz4Jn7PwNu
         D8tRJXOBXW6FiRnZo3vlrhqk1oauqbUM9wLjyojuJuBziqzNiSpMi55X3vuu5fxHames
         cK6A==
X-Gm-Message-State: APjAAAWtcwW93481WYZVwcdDR6RCOgsgqdGYqX17/K1uMRqjWGi2xgTG
        VUDeh9Ozy7g62dJu5hY4rbD5lmTZXpONPkP2r2w=
X-Google-Smtp-Source: APXvYqziTOTow+WGumWfiuxGLia6VPIaw7tKUOWAnPlug1QQw/2eHP2SQOp1zSyTovruvrF2y6qAKnOsj6Cja63SOWM=
X-Received: by 2002:a19:c51a:: with SMTP id w26mr22183827lfe.59.1554897612453;
 Wed, 10 Apr 2019 05:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190408175319.9106-1-robert.foss@collabora.com>
 <CAOMZO5DAvaibi5r9CXzk8qbE7XHiHJHHvi9rcq_BJdx7aRVgoQ@mail.gmail.com>
 <4fd506a1-c961-0569-6d39-283758f363d9@collabora.com> <CAAMH-ys-S7miJFCAY9bxrDGTPPT7e7c430-_4+edH8scV_qTwA@mail.gmail.com>
 <550afae6-8dd8-39aa-c7a2-01b27557aa53@collabora.com> <CAOMZO5Aj+NKOsa1zXfQqsSzqDJGOcza+1wGjdiEytvjAhsnOVQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Aj+NKOsa1zXfQqsSzqDJGOcza+1wGjdiEytvjAhsnOVQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 10 Apr 2019 09:00:07 -0300
Message-ID: <CAOMZO5Dfyu3AvQ9gD+PXCFE=PG9O1Q+0oRE=rM21nTriJpTzog@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-nitrogen6_max: Disable LVDS channels
To:     Robert Foss <robert.foss@collabora.com>
Cc:     Gary Bisson <gary.bisson@boundarydevices.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 8:55 AM Fabio Estevam <festevam@gmail.com> wrote:

> Please check if this patch fixes the problem on your case:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190410&id=728e096dd70889c2e80dd4153feee91afb1daf72

Also, just confirmed that this commit reached 5.1-rc3.

Robert, please run 5.1-rc3 (or rc4) and let us know if you still see
the problem.
