Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97028C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1AE205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utoZSJvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfEGMhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:37:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42446 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfEGMhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:37:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so367206qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BmUAXf3w3lUWjIG5MCP+ObcqnAZPTJqLAABuKptsGWI=;
        b=utoZSJvfs05uD4OUOqhPincz36/jF7KEYxS1N5u0jbxqxVffPWDOcJDJ5VwviBr9Df
         5mT1MDrRWVjA+fWJbzKQkM3W+IMxJRDuEhQnMEIq6KAGPoZgm9FndS2/ey2HKh6jQ+et
         wQcacxyvEVaqL5dg8yd3/YMTrSJFmkTfjBjF30WdzFQtys1MLz6gS/kVqkt3cdi+UB7/
         SaMy/O1wdfdlTTwmCj/zytMZyL/v022L+gHMmAsfEM+uATZAkzMAqqlYaJbvWNUhSp1v
         ScoLbrIAOLXlKxctfA+tBa/dcmLg0uS4ZIiz4oO11OCIh8AQcw9bj6fdqU11R/Ac4r+3
         prgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BmUAXf3w3lUWjIG5MCP+ObcqnAZPTJqLAABuKptsGWI=;
        b=moEqvxMtUpif0IeTVcj+PNX4nsR8j9iIlno2UOB9lePlU5jm1PbsttqyySEQWLas4A
         69HUswWH7KOU5OoT+CIeH16GXfss2qIvcvRITChgKQqNW7Q22whogrKlfImYoTeeBHiJ
         /EJ0A+5G2qHvTJTVqvcdioD/6cspaFj8sPcWMHDnKaJguKtft6/u2IU3WPeMNwwHLkH5
         2lPB4YvZQmHIIchTxulUBEw3n0ytx0zBCKEW2xXgzo4YZHGPcyxIjxbak3VeVE8DpA3N
         X/UCuTs79Oy43lb9bXHCoVgEqgQhmbEas4C1Gsv8HFynGR3euHCDfW2ZEqpep1nkMYz6
         1hMw==
X-Gm-Message-State: APjAAAXV1h1hrTxUFkFnnKa1BScqS7RzMEUlyN0134lj7HxzwISeQPJD
        SbVt7kXcFEwFeDLYsxKaO6frJm4t7v9FcHuriGsrKA==
X-Google-Smtp-Source: APXvYqxzEEY3udrVePkgazPG3496eLQSQxbvlpGQHKpnE9guF5wQuzNAbGB400oIN9bMhYCGv0HG/j0mBXlsHJYEl9o=
X-Received: by 2002:aed:306c:: with SMTP id 99mr25711109qte.38.1557232638409;
 Tue, 07 May 2019 05:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190507091224.17781-1-benjamin.gaignard@st.com> <20190507101729.GA3420@icarus>
In-Reply-To: <20190507101729.GA3420@icarus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 7 May 2019 14:37:07 +0200
Message-ID: <CA+M3ks4LhOFTeArnh3d=C02qLJWj_u6tWDDOhD8kZnJPRkXC8w@mail.gmail.com>
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 7 mai 2019 =C3=A0 12:19, William Breathitt Gray
<vilhelm.gray@gmail.com> a =C3=A9crit :
>
> On Tue, May 07, 2019 at 11:12:24AM +0200, Benjamin Gaignard wrote:
> > Quadrature feature is now hosted on it own framework.
> > Remove quadrature related code from stm32-trigger driver to avoid
> > code duplication and simplify the ABI.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> Although this functionality is now provided by the Counter subsystem, we
> should keep the IIO Counter interface for this driver intact since
> existing user applications may depend on it; this is the same reason why
> the IIO Counter code in the 104-QUAD-8 device driver was not removed
> despite moving to the Counter subsystem.
>
> Once user applications have had enough time to migrate to the Generic
> Counter interface, we can consider removing the deprecated IIO Counter
> interface.

Hi William,

This SoC is not yet in production so their is no legacy on the old interfac=
e
and I would like to avoid to create one.

Benjamin

>
> William Breathitt Gray
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
