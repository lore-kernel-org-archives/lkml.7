Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E2C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962232082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTFmKs0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfK3TRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:17:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46883 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfK3TRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:17:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id k20so9813632pll.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 11:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w6sz1koi+oWODmAL9BltmsOi1SxUB2G7IQOPMekJvLM=;
        b=aTFmKs0g3k6pzTrYN3zZEUzHUufU4JIC7CQJPz9eZju5t4sxwgWAejCEfglHL7mra/
         lQgPqw9MBSBCxAtgNuaNek1LIP+ZTbEduS1UpjWxH2FPi6OSTw4cFlHjX9eN9ioIRv8d
         aqyqdEEBjiyOS+/2ap3RGbCVJVKwOtmAa74EO3iVm8Z7Msm2SS/q3BiLR3SgUBUyRSRq
         vEhxDwXQocaTtqtW6yKzuYWaZhjpTeh0VWJcfGpaymXva1RzBZPzLcfxHq1EDaz7/L3Y
         X6HTxCFIyHqF0W969RSj0aKmXjnT56yxjiJoVkmkQhhzk/ouUQPr2cRgnjc8agmnqUEb
         Gn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w6sz1koi+oWODmAL9BltmsOi1SxUB2G7IQOPMekJvLM=;
        b=nzqHlzNYAoU7PXbqITIyGL1uhDdQJLc5a10qp9hpsTiWrzW77wI6LaVNLneJtWwxh6
         WG6aMB4COGnHV/JuB9RaCPjKoKnLX0JlOTiYTwTWPDKoxBTEB50RaT1d5oNtPB553SFe
         7s9slgS4bkdZoeJ//E8qN2+uAe6susXGLiETm33ZE5O7Fwv0/pHzdetnZ+7SKwdeFY5T
         o4yGcuIzEtFZFkAWZSRU5ndqeWg0XHTzRAqP9FuvWKXndqde404hVFJ4gEXLJpyGNmsW
         pP/Ox/lkjgRnW+PHR4sb7y+TKELwDFOvLM2nAIhQxoxWr/0fitQ36FcV/cgjxBndPCNC
         CbyA==
X-Gm-Message-State: APjAAAVXcxDIHnfvExoY3cTaezYMzjGOpX290glBO4/shY63N0SpeabV
        e7gfFpZqGnR7Fl5l+H6eGp+YhkaNxj0=
X-Google-Smtp-Source: APXvYqz93OnGJHulHOb9jrNxJLT5EJYEPikxu37TX1FLVg8KouN4Nqquhrbj4x8PJeKWjZlhzUQ0bg==
X-Received: by 2002:a17:902:8343:: with SMTP id z3mr20359336pln.200.1575141428121;
        Sat, 30 Nov 2019 11:17:08 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y128sm2660801pfg.17.2019.11.30.11.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 11:17:07 -0800 (PST)
Date:   Sat, 30 Nov 2019 11:17:05 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>
Subject: Re: linux-next: manual merge of the rpmsg tree with the devicetree
 tree
Message-ID: <20191130191705.GA133384@yoga>
References: <20191122145018.5f8a3187@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122145018.5f8a3187@canb.auug.org.au>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Nov 19:50 PST 2019, Stephen Rothwell wrote:

> Hi all,
> 
> Today's linux-next merge of the rpmsg tree got a conflict in:
> 
>   Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> 
> between commit:
> 
>   34376eb1b084 ("dt-bindings: remoteproc: convert stm32-rproc to json-schema")
> 
> from the devicetree tree and commit:
> 
>   14ea1d04ed0f ("dt-bindings: remoteproc: stm32: add wakeup-source")
> 
> from the rpmsg tree.
> 
> I fixed it up (I just deleted the file - more updates may be required)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 

Thanks for catching this Stephen!

Regards,
Bjorn
