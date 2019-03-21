Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368A6218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZeZRuV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfCUNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:21:19 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34513 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfCUNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:21:18 -0400
Received: by mail-yw1-f67.google.com with SMTP id x129so4747207ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQN6mlVj7UJi/bSQxMfedD+miKa9mZhfp1WbZyWESb4=;
        b=CZeZRuV7AxKatfRdNx8WBo4p7RCe1M6+56wI7xC6GUPJpFBnhv+n2RYcTTd6T594Ue
         yePbRcTz5ecey+zTHFHt3SGgfVZKNdKOuVfR3zQoDlp0emnfs+/xDIyuz20uxOcrRT4B
         KPuFmPMth3DQUREu8ackDHXobUtRH4oSEumWoY5ZZZsz7Wv4Nya6lx70YH8pzXrMWIxB
         Gdcck4+K2aaFpPlyqXxjrX/EPe5bszaSqAwrgjqWrcOsL+OS95TpASTVlHZo37TtWMR8
         KnPPXekLNq3HZQz7ecALdC6DkdsJg58nJSj3oQqj3J5YBhfEz7k+8hwYGkiPCQFkYkjS
         KDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQN6mlVj7UJi/bSQxMfedD+miKa9mZhfp1WbZyWESb4=;
        b=RRNEqq055+KwLATbGBEhEimRJUuCcLOgKWPa74hddHiBYxx3dtkPAwCVWVQqLCrzeN
         mH+Pho5ZlhGUJpSmusULJPWwu2Cu9ohKraAZLzc3ZOKi0o9TFII2DublQlkMC8ZVqLEw
         lWCteey+rmhu7jAyQ/aD4yu0pWNKiE+lb491/5YJJvKzdoLMsYMAqNIzlpZilqfaJBUV
         cSFsbXPEET640HE4m7ayg219E2QCMelPW+Zfr6uk7wmPAyAdNu7CpWjiMg4FGsisOQHQ
         z4b81pBs90HTTZ3yvQgEg7JIuUl4oeMOIljcJGjmFPU3C3FsqpgU88dWTVkRHaj+jSXX
         eA0Q==
X-Gm-Message-State: APjAAAV0goHlNeebLy92hdLk2Pz2WZh3XRhynRa10yYE9yQsrKT0zPuN
        FYpMLwc01BkYy9vnEon8G/qChZ1eaSvNRTZt6Vd5+Q==
X-Google-Smtp-Source: APXvYqz4VuRUbx+cdkSWQSyxCGMOylhFpn/R315ynT10ij6KRnYrrCiQaIvkeyeg7s2AXKNb0nKq4EONbHCCpfm6GAk=
X-Received: by 2002:a25:102:: with SMTP id 2mr2903960ybb.256.1553174477722;
 Thu, 21 Mar 2019 06:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190321125034.22697-1-anders.roxell@linaro.org> <1553174301.30977.85.camel@mtkswgap22>
In-Reply-To: <1553174301.30977.85.camel@mtkswgap22>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 21 Mar 2019 14:21:06 +0100
Message-ID: <CADYN=9LX9opLm9_zJ-NMkRqTW4H=waQCkq-te5CGkLgri3fgog@mail.gmail.com>
Subject: Re: [PATCH] drivers: ufs: Add missing MODULE_* information
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, peter.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 at 14:18, Stanley Chu <stanley.chu@mediatek.com> wrote:
>
> Hi Anders,
>
> On Thu, 2019-03-21 at 13:50 +0100, Anders Roxell wrote:
> > When building the ufs-mediatek module the following warning shows up:
> >
> > WARNING: modpost: missing MODULE_LICENSE() in
> >   drivers/scsi/ufs/ufs-mediatek.o
> >
> > Rework to add MODULE_LICENSE,MODULE_AUTHOR and MODULE_DESCRIPTION.
> >
> > Fixes: ddd90623ce26 ("scsi: ufs-mediatek: Add UFS support for Mediatek SoC chips")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  drivers/scsi/ufs/ufs-mediatek.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
> > index c3b78fc83d3f..ce4767784937 100644
> > --- a/drivers/scsi/ufs/ufs-mediatek.c
> > +++ b/drivers/scsi/ufs/ufs-mediatek.c
> > @@ -364,4 +364,9 @@ static struct platform_driver ufs_mtk_pltform = {
> >       },
> >  };
> >
> > +MODULE_AUTHOR("Stanley Chu <stanley.chu@mediatek.com>");
> > +MODULE_AUTHOR("Peter Wang <peter.wang@mediatek.com>");
> > +MODULE_DESCRIPTION("Mediatek UFS Driver");
>
> Thanks for sending this.
>
> Could you fix it as "MediaTek UFS Host Driver" ?

Yes, I'll update it and sending out a v2 shortly.

Cheers,
Anders

>
> > +MODULE_LICENSE("GPL v2");
> > +
> >  module_platform_driver(ufs_mtk_pltform);
>
> Thanks,
> Stanley
>
