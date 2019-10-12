Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B676EC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 07:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB8B206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 07:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uR2hqb86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfJLHYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 03:24:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37061 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfJLHYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 03:24:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so12094188wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAYSIpIU3hJKU2u4hHTRX9v4IZBeJlln5UqpWWtBOKQ=;
        b=uR2hqb86vFeLoehGG9nQq+UzP1qbzEkHMu9gB1Z1mPmdY2pyRGj8GQIjU8AqIri6ic
         4xkbqIkn/uCLwxUBwSA1V0vsLY5X6eq1GrrUGx8G4PVgTiTb9DsevH9tzUE7zWquRaC5
         x7fmWKcwbdP/wcnaswp9we57PR6XnYoCouhhKJDfYkJUrovG3D3def0y/BDAexOKcaxz
         62Yp5v8CEy3I51k3l71lgZgCM/qf7u8Uv3KV5l7hdn/FAXcY22/JshOjYA1aDmGOM7jR
         9L/vdbgRF6SKyy1Fxx2CjN77fRn1CnJ8zP4YTQioHbc4EjiMWQEO7t6PNz8FUDSquVkf
         02tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAYSIpIU3hJKU2u4hHTRX9v4IZBeJlln5UqpWWtBOKQ=;
        b=W6zDdMAhXUlERDHXtK/2jkWY0tNmt5j0OuReodfDKadtDHtIklFpzzxNfbgdnRe5Mv
         dhazhwxVgJ27xk+MmSeBEgwrcWeNtPKj3BL97C/YzJn26avkiS8P/d4a+7teR+1QN6Xf
         VFahfJoMoA2fQ98b0YINNYm/kPtdqWT3kH3Nz+D87D1UhlsjCLlDKASDq5UmTF/LHZxc
         3Jx9nqPlZH6P7JYiFFT9HB2eieaVUNVFIxnSkEe8iLCXhPqXJfJQ5gnzk1jujREBQL7N
         htOZLncgCzDbS4bE7SMv0aN3WWSa+3liMBku90zT+qBMeuS4QoHT1ow0lhktU2Jq27re
         krcg==
X-Gm-Message-State: APjAAAU34d4uOvotN0ZuZRXhkfztqHA8ZQOh3So1JpNJ3yjB/zV67ccp
        eAx/ENY8Cp4BOqSocrI2pHp6neFc8fM8effzT5bLz4tN
X-Google-Smtp-Source: APXvYqwEsXRXwFwnnik3tZHluRyeExDE+ZTPScWLzikmZiNBW7pzwWZWUUmNoV5MLCdU1uXQk853i8QEPl5oBJ6JSvM=
X-Received: by 2002:a1c:a608:: with SMTP id p8mr6150105wme.25.1570865056487;
 Sat, 12 Oct 2019 00:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <1564980742-19124-1-git-send-email-hongxing.zhu@nxp.com>
 <1564980742-19124-5-git-send-email-hongxing.zhu@nxp.com> <CAEnQRZBoLw5pfZ10STGMRfmR7=6hFjYNFOmXiMAnbM+-8Q4uLg@mail.gmail.com>
 <CAEnQRZCkoA-q=C6nU0L_i33W8iTPY2RC4Cvb-aWuExA8VEqM4g@mail.gmail.com>
 <AM0PR0402MB35709FCA367D132B3E1634118C950@AM0PR0402MB3570.eurprd04.prod.outlook.com>
 <AM0PR0402MB357085BEB3A0B7FD7D5649AA8C960@AM0PR0402MB3570.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB357085BEB3A0B7FD7D5649AA8C960@AM0PR0402MB3570.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sat, 12 Oct 2019 10:24:05 +0300
Message-ID: <CAEnQRZApkTEyvgoTGo6So5NJAHARmEnxfzTcahDVXr_9ns+_Sw@mail.gmail.com>
Subject: Re: [EXT] Re: [RESEND PATCH v5 4/4] mailbox: imx: add support for imx
 v1 mu
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 4:12 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Hi Daniel:
> New version patch-set had been sent out on Oct9.
> https://patchwork.kernel.org/cover/11180683/

Thanks Richard. Jassi, care to have a look?

Daniel
