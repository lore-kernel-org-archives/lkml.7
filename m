Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67AEC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7108021530
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560781937;
	bh=YVeXqhOTacEiBNpdGFxeX6iKuMZYINJ5rCe1iWJz0vE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P3sKYduiaCm2uJMQK2UVUeSiMCkygnd4pC/HLEV/j5tZi/vFr1uTaU70ZlHm6Fn9o
	 KjDw/HffouCzuKeDnqGn5OJviAruJpvTUFiPWkMyA+OiJaR4B5ETggJukHfSwQ+Bdx
	 ISSfTv1+aaL7jGS9iuPju6lFUdHNkWlU1Q5V877k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfFQOcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQOcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:32:15 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D606208E4;
        Mon, 17 Jun 2019 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560781935;
        bh=YVeXqhOTacEiBNpdGFxeX6iKuMZYINJ5rCe1iWJz0vE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LUUhyHLo9MgYHOLj0zjchSniPPEa++duHCyqMUsC+2KQR5L9XBR8YInRUgb0snjWB
         iy15bMQkEZKLg0uYhznWWOuMC0fTsmusuLUw4keDRmkKstb5StB3z39WZksfDBi5Yc
         oA50f3IAbzHY1Wp6Dtivua5rdlaAkT0sPt7ewcWY=
Received: by mail-qk1-f175.google.com with SMTP id p144so6249589qke.11;
        Mon, 17 Jun 2019 07:32:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUroXL+NiyZv/sk6To4lDnzchwgVUMeVgiPaF0qsxcvfOjxDyAN
        4srZ6CaYEO0ZOPHTTodYnRNR5EMx2ERUmSZiZg==
X-Google-Smtp-Source: APXvYqzypWzH9+FR9vkOBKVJHu+Un0gXYkhnqI88qXB3NL4H9/fIbTzA62+ik8Z0kWUIMebLB0X+tfIaTGYexkCkI1o=
X-Received: by 2002:a05:620a:5b1:: with SMTP id q17mr23213999qkq.174.1560781934347;
 Mon, 17 Jun 2019 07:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190614080317.16850-1-andrew.smirnov@gmail.com> <20190614080317.16850-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190614080317.16850-2-andrew.smirnov@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Jun 2019 08:32:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKqh-iuTk-P7NH2BfEnmnwdB8yMumCd-KeoszCbBNjy7Q@mail.gmail.com>
Message-ID: <CAL_JsqKqh-iuTk-P7NH2BfEnmnwdB8yMumCd-KeoszCbBNjy7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add support for ZII i.MX7 RMU2 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:03 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add support for ZII i.MX7 RMU2 board.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Bob Langer <Bob.Langer@zii.aero>
> Cc: Liang Pan <Liang.Pan@zii.aero>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
