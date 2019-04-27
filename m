Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8653AC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BB02077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JwWXoppa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfD0USs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:18:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44105 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfD0USs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:18:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id d24so5487725otl.11;
        Sat, 27 Apr 2019 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twUn9tNCSqAO/LrZW7/v2g0R5QVO38tE+guDykXOQXg=;
        b=JwWXoppaPfjp8CMQp3BSi9WZ+Pzxhd74Yddyg81FymbGqWd4EmAEvX1MLsuFEGV5J0
         tDD/7KCTlPuKhAYDFth/I9+U8ih025ukIl7os5NEsRvcMhSE3Goh2235sfb0PXpPyK2M
         S0jnP3SQnLG3FjMugx0ggIHu2h4oHmlmvzAoFySJxNwbVy2enofTc+NRsYHQH7uFUWUu
         hb5dmMnyT7lnsWLHbez6YbTQ9R5j9H4JzMjygZgVm7YSUpwWUWiAqT7tk1EuVLWlQInr
         94nwC7zYRoxzlkJZxLDDsZNLqasuJSG7jyhNqyqvqOdupiiTO9Db+t5xXMVn5tC8LIJy
         ltbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twUn9tNCSqAO/LrZW7/v2g0R5QVO38tE+guDykXOQXg=;
        b=o4E5t3ZMWBMJuWEogP5w8vO6s9bJveT5SvJM6IBNlA4AeYamEr/wW9iIa3cvFDipoO
         gNTb/olpSvhl3+6s7vcPI5nEZ4+YbXeveglTESGBCrbQdC4BTrt4LnwQaRcEtD+nmJl/
         KcODdvltbT/5NPN8CNlU8gAM/oRR1rYGOUAvIScPOiiQl3Kqh+UTUVS0TQhcrQ2NZoat
         sDnMAQrBwqqymbHJ1ztBFa6F3Ro3V5sQGkpcQdfMyz8bqDXbgbldyNynT0foSv9pxQ1N
         7FZu3DwGZioe3AUXhI2w1auOsFCVBuzg5sYrgPFYjUG35oHNTCpbypjYpEM/F9MBpi91
         ON3g==
X-Gm-Message-State: APjAAAXIR3wgPt+M+yBg/Pxd+oghorPEt4ByfcNLovT6V/2JMHHbtToM
        LHjCFCiDjRBWHAS3VxcLpDowIQi20j0bSo4AtdM=
X-Google-Smtp-Source: APXvYqzK2zosCn+VdAEkx740ufgWCPVDzpsEQ/2ZYaMULtPACgGqgWIHmO7qGAzt2uNh89LOVX0U5GsmbU7Wspt45nc=
X-Received: by 2002:a9d:3db4:: with SMTP id l49mr32891026otc.131.1556396327567;
 Sat, 27 Apr 2019 13:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190423091503.10847-1-narmstrong@baylibre.com> <20190423091503.10847-2-narmstrong@baylibre.com>
In-Reply-To: <20190423091503.10847-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:18:36 +0200
Message-ID: <CAFBinCCV6DWFM-nynSUGGmdvo1R6Lfno7V4d2+Fc17iS3+DSig@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: clk: meson: add g12b periph clock
 controller bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        jbrunet@baylibre.com, Rob Herring <robh@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:15 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch adds the specific Amlogic G12B clock driver compatible.
>
> G12B clock driver is very close, the main differences are :
> - the clock tree is duplicated for the both clusters, and the
>   SYS_PLL are swapped between the clusters
> - G12A has additional clocks like for CSI an other components
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
