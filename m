Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1893F206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDvYpVhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfJUGTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:19:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41751 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:19:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id t3so7104935pga.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=npNayPk5J2u1XBbRL1kMyLo7Xv1HpI8J+9mr55B2g9k=;
        b=QDvYpVhOa9llomgrWhkQTV7AvVq+a5nmiWzxknp7M34fEjVS0v79bpDXYYSHLu1xsh
         3r2LrOxWZCd+j+SAZnX3yRG89haB45hBUtUWfOXkCUWRQjipPwvece8OYwGhB5XPEMcD
         c23ua7i3PrboPvRFsD5ptap2coA5uv0FIuyTXAuCEXxI5d4XDx9p57AaYol3GG+DWot8
         rOcaEGRFXQi6qMDjK8Ia0W2wdzqRJnHDWluTgedOmC4Cg7Ox1ipLSdIXb1pVuHVDr6DC
         5EU+++ld2CJkiSlsN66IxR3O3iwDLczgHbsaQSPQ7rnFNDV0pmIVa35r8FugJDDtWKTi
         9Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=npNayPk5J2u1XBbRL1kMyLo7Xv1HpI8J+9mr55B2g9k=;
        b=It/QgrdtvbIWit/QFfG/7Q3gdE5Rdib+hVZ2pg/+JcAxkRNZNWPuFIzDdYoQaMTPqJ
         ZKHiLFHN1VvAalZbxVtGsHW2Ue54B9Cj4BPyzkgOm/K5eJJw8Ij64Uy4PJ8uQF7TbZoF
         hgRsEJJzRSTnGA78Ie6UNkpObs2hdpMlojwdg7Qwr7IF50tv2hF0ChmTjBbu7InMQRs9
         xeqzTnOqhK3RzmzxkD2xp+O8lpci1S1F+GkOwz8Arx9ZgWtNXEWtN0nf5D0RBQ24SNxg
         8xdld7qvNJ1A8g/vJ69xBcG4Xi9UE9ssINhXCzD6W7MxyRVjyvqQghGQ8l355H1yquG/
         yYwQ==
X-Gm-Message-State: APjAAAWgFxiNFaO7Y4eUE7NQV1i7u9HXczsAV95iG1KWIkUtv0kZMns7
        SznFITTYSSKM6D47ovgGEGA2
X-Google-Smtp-Source: APXvYqwa4lMT7wTGnd2y2szR63pKR1Kh4XWszfDbs08XxK1GjzoN2xaHY4ePYHjDl7fkNdK2QUchbw==
X-Received: by 2002:a62:5c07:: with SMTP id q7mr20788083pfb.159.1571638773575;
        Sun, 20 Oct 2019 23:19:33 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:700f:8db6:2442:890f:ac37:8127])
        by smtp.gmail.com with ESMTPSA id x65sm14911120pgb.75.2019.10.20.23.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Oct 2019 23:19:32 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:49:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: Add RDA Micro GPIO controller support
Message-ID: <20191021061926.GB12001@Mani-XPS-13-9360>
References: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org>
 <20191015173026.9962-4-manivannan.sadhasivam@linaro.org>
 <CACRpkdZRY138RAf8N2xGam89r66ik2vW44OZx0bDcCt4P2GBLA@mail.gmail.com>
 <20191019160513.GA17631@Mani-XPS-13-9360>
 <CACRpkdbgFGciZMBF-_h5Wi47Hmco7tA9Pr7XegM8SpWxhqLT1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbgFGciZMBF-_h5Wi47Hmco7tA9Pr7XegM8SpWxhqLT1A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Oct 21, 2019 at 02:57:31AM +0200, Linus Walleij wrote:
> On Sat, Oct 19, 2019 at 6:05 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Wed, Oct 16, 2019 at 02:41:32PM +0200, Linus Walleij wrote:
> 
> > > select GPIO_GENERIC
> >
> > hmm.. I don't think this driver can use it. Please see the justification
> > below.
> (...)
> > As you can see in this driver, there are 2 separate registers needs to be
> > read in order to get the value. RDA_GPIO_VAL needs to be read when the pin
> > is in input state and RDA_GPIO_SET needs to be read when the pin is in output
> > state.
> >
> > The MMIO driver relies on a single `dat` register to read the GPIO state and
> > this won't fit for this driver and hence my justification for not using it.
> 
> Use RDA_GPIO_VAL for dat, then set BGPIOF_READ_OUTPUT_REG_SET
> and the mmio core will do what you want I think? That's what the flag is
> for IIUC.
> 

Ah, this should work. Sorry for missing this earlier.

> Maybe we should document it better :/
> 

That's how everything is in kernel for me... If you don't look closer, you'll
not get it.

Thanks,
Mani

> Yours,
> Linus Walleij
