Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8322C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C852070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIw21fDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfDBHTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:19:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46418 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDBHT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:19:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id s24so11052917otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFy5rTYcYk8rjQGuXc5vGRbwI6kOawbU+git35aHVzU=;
        b=xIw21fDamoRHksmfDf2zFtTdSJ/3f3jsI2xmx/RRhc8gD/24d0UlXLVhXNbyD6KYTy
         lnKz5ZAfqYiL04qD4/ltDzPdxXM7N8u97FTn0A8onbJ/3Z3hF1gt/BbipgjaMDGkguvU
         c20VGr95nfTZyE4JdbmJOnyIJl88aA1HTyykr+MvhyKF4LlgpQvQouDdmb6ZFYSyX6eS
         hbb69ad0V+HmIJ5Phn8NoDVmv84bM40ooEwuG8EPvGVqFcci9677IAhGhvC6QH60bcI7
         ldXsaFfHEevDwdjJaadpb3vkagfTVP7NK5SMuzY5Pehr/TxaZeZ1UMnY7NJxwvpVqC1L
         dLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFy5rTYcYk8rjQGuXc5vGRbwI6kOawbU+git35aHVzU=;
        b=oFDHGBbWeiFdxgHjItr6KphoqKVWCP0pnXex0Vv/Jbg5It8rQB1lcSv9HhbjGPIIvY
         hVZTi0Ig99urmNRmGujJ+oOBdUKxz9qlFjQMP/0N9E0Z4FQ30QlFftRTUypoiFuEjoO0
         9DN35XfoUowxVghO6dT0Foh87Kmxp++WDhxu+9X/hRJSQMh4vsc52JtGAv9EQOXLxfSm
         7gZAp/RO0xivi+kogWT+0jj5038kU7a0GEPrlm6Ynh9PR/1wzWl9O6XmK7pTmMq8qlQ3
         LAeNxq6oylpWn4zBe/5R+x1sJtZVqdBZ1H+uGlDUSkYj3ggiJv64H4OX8+1Ys24qI5Om
         xEtw==
X-Gm-Message-State: APjAAAVu8DBa6JBMDwnfwUzcCCzXpjpW4ppKxlm80lLsYvNdCMm0wj2C
        xxV1EmvuqVACfQXIPCLziApdC/glGheDPC2RsDlNRw==
X-Google-Smtp-Source: APXvYqyGpLRnf1EVhW9Hg5THf7n2d9iBwW0aOLjDXhxhDuJrBrR/usE2UEM+Ls1S6HSBntyYV40r9Bsp+vWsZU09QB8=
X-Received: by 2002:a05:6830:1446:: with SMTP id w6mr35721881otp.157.1554189569181;
 Tue, 02 Apr 2019 00:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <af33f66a602462f14431e99433324b8523f74f78.1552879519.git.baolin.wang@linaro.org>
 <20190402045829.GQ4187@dell>
In-Reply-To: <20190402045829.GQ4187@dell>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 2 Apr 2019 15:19:16 +0800
Message-ID: <CAMz4kuJaWg0kE1TEHnK-cv1N92mQmZ_J5A5799iR5YQJwz9dBA@mail.gmail.com>
Subject: Re: [RESEND PATCH] mfd: sc27xx: Use SoC compatible string for PMIC devices
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 at 12:58, Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 18 Mar 2019, Baolin Wang wrote:
>
> > We should use SoC compatible string in stead of wildcard string for
> > PMIC child devices.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Hi Lee,
> >
> > Could you merge this patch into v5.1-rc if no objection from you?
> > Since our DTS patches had been merged into v5.1, our PMIC can not
> > work without this patch. Thanks.
>
> Oh dear, what a pickle.  Really you should have pushed these change
> though one tree, in either a single patch or at the very least a
> single patch-set.  I will see what I can do, so that this doesn't
> break for an entire kernel version (but I make no promises).

Sorry for troubles. Thanks.

-- 
Baolin Wang
Best Regards
