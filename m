Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F174C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D485217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qi0eOgLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfDREjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:39:18 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44028 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfDREjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:39:17 -0400
Received: by mail-yw1-f67.google.com with SMTP id j66so323693ywc.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 21:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4JoamRecAWd8cKazq71dy9mVtQ/gxexVKnzXwgT6aM=;
        b=Qi0eOgLT2MKpn506Su0UjcOm5T6g3y5KTRiP95G4Jtu/mJL2G80f655pFaNzp8vivN
         wdyk9B4mfZSCoaQQPEus1fYyjFCeuIgHHPH/A/2iITCmmKs2uFvI6y7Bf4BdSTwAC+9+
         2wRbBdGeJJLHn3iNufrULbAWTSvXgho+QXs0dKyzW1B8Ev0FcHoMBL+Exd+XsthdmmZU
         WSAFU4qAvjvekEx+B3ZCh2MQktK2+U7vlWMyOqdQOVL81FBTwTzN7fiSfT86oRJf1cRW
         e4hWB0/6zvBQQjwzTmOkOlWS1eDGsQcUJgmjEdA3J/Xvvn83XdLs/kTxIfIVctyT2FlZ
         vpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4JoamRecAWd8cKazq71dy9mVtQ/gxexVKnzXwgT6aM=;
        b=V1X7vLl7fq9AVMlLVcT0rh7jYnQ9s2d23fytjWcopg7VT8r9Ykr6Y2WcCUdAQpGBmD
         LoFGutqO3vUudp/0wJyW2LPOUkSfwAjJn9I6t3zE71KVnhryUo9hvoXtgblKnj7ZdFID
         YUILrUXO0nlgs1CX8R5WIGYBJZuIVMAJLX3f5ZdsV+V9uwtCfjkiq06EXMOFOrzLerxT
         7ympQUTI3H6ipq5AyP1blp2mr/HCcB09ICtkEVdnPPaYzjjxAlisS4jTRWD62nu6QiAN
         nmvlCeXE+J0lPbT3kp6o/tLtbB7gVSc9RR5GdUxy5kJlqMlyScTKGJzV776fvgSIi9kM
         uWAQ==
X-Gm-Message-State: APjAAAWGtNj1cAt71bZBRon7Oz/k6QY5KIW+WKvFVuxGUwmmOE/S0BLW
        k5MHMYi58FwmsW2ODRpHz+GXh+FAY8/UyIokst/geA==
X-Google-Smtp-Source: APXvYqwnIbb8ppm4MHQJzZhFyfp830PZHkA9kVRRVyvrR1puj63qv9jK06UNrIGfM0irnK2OSuNqMSRTej6eXirx9og=
X-Received: by 2002:a81:3c55:: with SMTP id j82mr22411ywa.56.1555562356874;
 Wed, 17 Apr 2019 21:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190410195852.4066-1-anders.roxell@linaro.org> <20190416235322.3b88df99@xps13>
In-Reply-To: <20190416235322.3b88df99@xps13>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 18 Apr 2019 06:39:06 +0200
Message-ID: <CADYN=9JS9vkw99+LkTVcEQYqwFd1O9_txgRUTYfqK1-9TnKGDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: nand: Kconfig: correct the MTD_NAND_ECC_SW_BCH select
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 at 23:53, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Anders,
>
> Anders Roxell <anders.roxell@linaro.org> wrote on Wed, 10 Apr 2019
> 21:58:51 +0200:
>
> > Config fragments should not have the prefix 'CONFIG_'.
> >
> > Rework to remove the prefix 'CONFIG_' from 'CONFIG_MTD_NAND_ECC_SW_BCH'.
> >
> > Fixes: 51ef1d0b2095 ("mtd: nand: Clarify Kconfig entry for software BCH ECC algorithm")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
>
> Thanks for both patches, do you mind if I squash these with the faulty
> commits which are still in nand/next?

That is fine by me.

Cheers,
Anders
