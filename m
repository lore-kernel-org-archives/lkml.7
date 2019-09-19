Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF009C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D96218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg5JsREB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfISBup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:50:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44859 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387604AbfISBuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:50:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id r16so1650608edq.11;
        Wed, 18 Sep 2019 18:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVWaU8MWb+toZ7pw699s706Y6cCfK7IRI+Up5RZDOwg=;
        b=Rg5JsREBofDUaBlAvP5owFysYBFRDKdVXy2dqYT2vvJVD0Oy1qSyT8BsrmzIHwpRd4
         nWgadBICoQTexCfqiqq5SMXb775GOFLELw8lhBb602ndu+HP6PZyo9qoMWiIfU/i3Gkc
         3T2yOUlI84QXTz5bQHvYyS7L8L5nFvm6MTJpYksAnIwRY8Mh7YbE3z1GN9nvts0nHRNs
         oOMavBX/a6I1PHxpb6letKNsCMEJNftyS8ZgwQAt9fnxM3E+GB6njFn90kD9gRvSzOuP
         PxRBGmaFqR6EVq/r5WNyFHzABHPFAnRGSGbzsXvJmPuhth+t+rU52ddf3PwpYw7mh0Rr
         PZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVWaU8MWb+toZ7pw699s706Y6cCfK7IRI+Up5RZDOwg=;
        b=M7H1cg1tBDcohT4L7JgqYEj2Af5vzfVWr7hdO8g8gyNd+4dX6csAybwKImdd8dxCX9
         /N4SMGOIwB0DEfjmLXr30irL+nhhjsrjiKQ47ybZS8YPpYg/tPIzVLSFIaVp34vIKOBN
         ppR2GyGyBbAXhsOGKi1aO4X9Yx9i5GWjqi6KYLt7roqOrZ3LB3HGsVQYLXsf+f19OoR3
         uEX12UoJ3sSe5xmm1otZz0qrjtzawOcvS6VIiaSU7u5PqW4GdBVxpGZzdfyBTH0pI0Tj
         qJuh47NQnmJGW+1LvLtFda7lQzdz5fqVgZP2dA9hI2FO1uvRHw+ZTKPRBZMzzXC9sVPA
         xgMA==
X-Gm-Message-State: APjAAAXB8In6MopM/4PIwxYOCfodF1lAnCL687Q3+esbREY8Jdm+LFJH
        Zh6kpMXH2ES4t17uZ9i3m4cH69qJb3rdnvFbAQ0=
X-Google-Smtp-Source: APXvYqwBzDvo3So9aOLPuP1xdqn6CBt2iBHyxzmiOo8rKxFPijZ9V1be7JK1QZNLnMD1wndzERyiuZfXR7lcteUZfUQ=
X-Received: by 2002:a17:906:5fc4:: with SMTP id k4mr12305306ejv.300.1568857842724;
 Wed, 18 Sep 2019 18:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568184581.git.benchuanggli@gmail.com> <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
 <20190918104734.GA3320@people.danlj.org> <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
In-Reply-To: <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Thu, 19 Sep 2019 09:50:31 +0800
Message-ID: <CACT4zj8dyLWfQ5uDafwXxd7A09S522j1nQTGHV0p5gn8nUzbRQ@mail.gmail.com>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Michael K. Johnson" <johnsonm@danlj.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 7:09 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 18/09/19 1:47 PM, Michael K. Johnson wrote:
> > I see that the first four patches made it into Linus's kernel
> > yesterday. Is there any chance of this final patch that actually
> > enables the hardware making it into another pull request still
> > intended for 5.4?  Waiting on additional acked-by on Ben's work
> > addressing all the review comments?
> >
> > Thanks.
> >
> > On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
> >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>
> >> Add support for the GL9750 and GL9755 chipsets.
> >>
> >> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> >> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> >> tuning flow for GL9750.
> >
>
> It is OK by me:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you. Also thanks to other people who have given me their comments.
Ben
