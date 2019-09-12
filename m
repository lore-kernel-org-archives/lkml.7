Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D0EC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE82A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH+33i++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfILXv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:51:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33072 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfILXv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:51:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id t11so12446333plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jwH7MEoAJ00c+7yFxXFsE0JEMDQRkeWQsif61Jhqi3M=;
        b=CH+33i++1Luzxl8HYawv8HE2blbAZ7swcTEJAA7tWhmDd6HBta3K9TBY1havYrrodJ
         7+wkJA0vugEJi+fuHOJLp/jNbRghNgF+owPo44A17sTvEiyTUWvxtD0KUsPdLov77ETE
         OjYMwTAAZV3vwkDzfhKUJVKbmZKGKwYbQk0kqGkGZta360oMD/mAHbxQhitLNDR53Ze4
         SU3HZZBIVazFcwyYjFmcc25pa7ILwXvs1ASWa6lXm+0opNIxy7ZFRchNNFkX/gIve+fu
         VhqfI5XkvWQj6su1zQCV3UB+uISGEbLxFeNhbQADYmagwaZTIUIIBmjZfZzWbiBWpD0s
         MiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jwH7MEoAJ00c+7yFxXFsE0JEMDQRkeWQsif61Jhqi3M=;
        b=SEhu0NDUOfq6WnyzuK+rvFWIBjA7Mtj9GYdHTPsmBaIxOXJ+AlQ+Ln0WOxRlYjlfz1
         t44k9dT6AUpWcVqo060zhNW62EXUnRWPDujya2iCNpXkIVMr6iste4BPHNy0qfQHyL4T
         wU9l9aJgO37YS5XYEWIAwtPJ0/8HDJro2YIAfR2SKaOMySpjD/kbawWBnjlflbJdHi1F
         VTewTvLq/85yg6eDQQXT4ouw8lKBAzO5/bGJe74igFarmR3zrL1WjpTxU7/CIdcVIKhe
         i0379wKkb06LdGwCVaWHxK1YanKg7nqcxl7aWXHrzLZVlVUr+uBHYLHellIKjQHOcThZ
         aA1Q==
X-Gm-Message-State: APjAAAWsRrlVjCDrzX8RsuJVTN+HHvun0Vh3fbGK1WHeYkxyTzYWJsfJ
        tZ8wkll50c2vUDRlJMAEQ3s=
X-Google-Smtp-Source: APXvYqw8JsAO/ku52ctAh426YyLkFzzTSBnKNOrqkT8cXxA2Fn6w0cpGB8xMIpxVpQYBQQwfczK2/A==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr31734884pll.312.1568332285454;
        Thu, 12 Sep 2019 16:51:25 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u5sm27193129pfl.25.2019.09.12.16.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 16:51:25 -0700 (PDT)
Date:   Thu, 12 Sep 2019 16:51:03 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_asrc: update supported sample format
Message-ID: <20190912235103.GD24937@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB64791308D87F91C51412DF53E3B60@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64791308D87F91C51412DF53E3B60@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:07:25AM +0000, S.j. Wang wrote:
> > On Mon, Sep 09, 2019 at 06:33:20PM -0400, Shengjiu Wang wrote:
> > > The ASRC support 24bit/16bit/8bit input width, so S20_3LE format
> > > should not be supported, it is word width is 20bit.
> > 
> > I thought 3LE used 24-bit physical width. And the driver assigns
> > ASRC_WIDTH_24_BIT to "width" for all non-16bit cases, so 20-bit would go
> > for that 24-bit slot also. I don't clearly recall if I had explicitly tested
> > S20_3LE, but I feel it should work since I put there...
> 
> For S20_3LE, the width is 20bit,  but the ASRC only support 24bit, if set the
> ASRMCR1n.IWD= 24bit, because the actual width is 20 bit, the volume is
> Lower than expected,  it likes 24bit data right shift 4 bit.
> So it is not supported.

Hmm..S20_3LE right-aligns 20 bits in a 24-bit slot? I thought
they're left aligned...

If this is the case...shouldn't we have the same lower-volume
problem for all hardwares that support S20_3LE now?
