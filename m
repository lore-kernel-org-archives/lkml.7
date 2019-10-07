Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11874C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37D121655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453712;
	bh=vxO/s54dTSEzl5R7GT884moYyXRk4GkYf/RtZPNdPqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s59Xuq3gSZQ3bBkDJwgTuclirEmCahfrkQEYPZr2Nkc2oSZ2AUM8ItevwVDdmZ/QO
	 tKlkYdIRoNA/BCHZ6mkZwL2/KOWKApb4yOdyRR/LN9JcCJ4IC3TTcKUWySGFDGhhj2
	 C2R0EqQsBOxL2ut5s9emb0SyJ4lI5vYWwKvZZimY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfJGNIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfJGNIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:08:32 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E61B21655;
        Mon,  7 Oct 2019 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570453711;
        bh=vxO/s54dTSEzl5R7GT884moYyXRk4GkYf/RtZPNdPqM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E24C54eS5QstHHB+h3eQVSYk65KL+h5v4BqBRUMw7SxYY+pIuIpbwYFaEImNXipDy
         SA+nl++VUFDCuNX/xtbtrfM6UohU5jGE32dgwZ4bQ/Vvi/aYvVNnDKzBWR20jCFiLj
         BEJh7BCjEdlmWmsOF8XS1LALokCjjlxmb3RQXVV0=
Received: by mail-qt1-f178.google.com with SMTP id u22so18942524qtq.13;
        Mon, 07 Oct 2019 06:08:31 -0700 (PDT)
X-Gm-Message-State: APjAAAWNos+PVt72+dHMdk9l+n+ANUjFYkKAQ9eckzFXMz9QRovl2PEa
        GzaYC3XTeYD/SN6CZWWPljZU7Vji5XbaaD6dvg==
X-Google-Smtp-Source: APXvYqyB1UEckrXSNhW8ewZ0xc0k0Qus+VSf2iK+Ax2D9HPzusjNm4QHm8QWK0UP3BYJ4kDT5C8PYG3hvZjHRXzJiL8=
X-Received: by 2002:a05:6214:1590:: with SMTP id m16mr26758627qvw.20.1570453710240;
 Mon, 07 Oct 2019 06:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191007102552.19808-1-alexandre.torgue@st.com> <20191007102552.19808-4-alexandre.torgue@st.com>
In-Reply-To: <20191007102552.19808-4-alexandre.torgue@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Oct 2019 08:08:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL3sAwjKAJPZbbqg8k_R80kE9d9nbBaxWGt76RCMVMZFQ@mail.gmail.com>
Message-ID: <CAL_JsqL3sAwjKAJPZbbqg8k_R80kE9d9nbBaxWGt76RCMVMZFQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: regulator: Fix yaml verification for
 fixed-regulator schema
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Alexandru Ardelean <alexaundru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 5:26 AM Alexandre Torgue <alexandre.torgue@st.com> wrote:
>
> This commit fixes an issue seen during yaml check ("make dt_binding_check").
> Compatible didn't seem to be seen as a string.
>
> Reported issue:
> "properties:compatible:enum:0: {'const': 'regulator-fixed'}
> is not of type 'string'"
> And
> "properties:compatible:enum:1: {'const': 'regulator-fixed-clock'}
> is not of type 'string'"
>
> Fixes: 9c86d003d620 ("dt-bindings: regulator: add regulator-fixed-clock binding")
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

There's already a fix queued up.

Rob
