Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4670C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5152077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRhKfFHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfCMDMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:12:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46652 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfCMDMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:12:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id v16so177187ljg.13;
        Tue, 12 Mar 2019 20:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mR2aKk5E0m+9wtTC+RkTdtubp0v+SYeWNTpJMmYgjM=;
        b=NRhKfFHTRV3A3nQZKa8+2mxm3Rhr6S3JcYNuXkv6qfm76nGkMlC5gl9bjwdi2a6rl1
         E5WdVkSFTCPgetQauvZyCCM5XZ07zUSSaxiGhrXGYVdouqykIFYd0ufj2hXjFvbZv55Q
         ysFP7VM00guh/DowTRyMPo20r9ofSKTalFDZgmkOZf/YaaaJ+KVNuseUDUBIM3MV4X8b
         kRwJ4g68p/jxRp1tuZP9sYeUJ519mxPJhdle1QqIuKhdWw4U4awpRF8xTXm3KjP9aLEo
         iRrfmqwB/Kc8BNcAvoFSB1WTQGAUEuIBTWpfHwZgQOADQ24bcAcbMC15NzMlRLEspCpW
         7y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mR2aKk5E0m+9wtTC+RkTdtubp0v+SYeWNTpJMmYgjM=;
        b=cTA6BWVkeOAAe/7avztq/HCx/8A/Hh/1a2UKM2HHZnncgsK4KYYjlTz4h+PHOraD/H
         h67GelPKsH5FD3WnAi6vp64auBq5LU9dusdvxY5B1kwxtzszWlJ1jsC82GxNx5As0oF1
         X+uLMLYIDxF0xVw83nraaBwH+dEa5Z/2JscA9/8PA/xY0EyL29CTh1e1SCKu1TXHe5xg
         gnkTRKmOs9SQ23AvgMp3UF/Lh16zefOz5W98OU5JXPeiY++Ek8VkSngvaf8axomsRQET
         1h3ZvbDwdt9O639VbO1+UwqBUM+wQ9PwXGgWtosq2DnM5PF6MyfBWoZ6hG7p5bmM7dxN
         Vnvg==
X-Gm-Message-State: APjAAAUh++ptyoQVF4mkchgxq2o9bYG3jd+B8zAsNGVfk77Iy6wPLue+
        IeJKNA70NpLzQ2NmGRJ3vvqX8TRwy5x5MRw9eOU=
X-Google-Smtp-Source: APXvYqxO4G4qEiww/O5ZEXUQI+pYBJs6RNaRLE32WNlAe2+rxqYTUoMgsTKKgO6HVfnTwrrSyU7z0YV3gGY8CBmiRMU=
X-Received: by 2002:a2e:8644:: with SMTP id i4mr20432784ljj.192.1552446718443;
 Tue, 12 Mar 2019 20:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <1551565949-13843-1-git-send-email-pjtexier@koncepto.io>
In-Reply-To: <1551565949-13843-1-git-send-email-pjtexier@koncepto.io>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 Mar 2019 00:11:55 -0300
Message-ID: <CAOMZO5DU9t8ajjOiN-z7bPEtOsB=-D=4yFbUJGJgFqwO7d=B=w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7s-warp: PMIC swbst boot-on/always-on
To:     Pierre-Jean Texier <pjtexier@koncepto.io>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 7:33 PM Pierre-Jean Texier <pjtexier@koncepto.io> wrote:
>
> PMIC swbst regulator is used for the MikroBUS socket (pin +5V).
>
> We have to set the regulator to "boot-on" and "always-on"
> to output a voltage of 5V on this socket.
>
> Signed-off-by: Pierre-Jean Texier <pjtexier@koncepto.io>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
