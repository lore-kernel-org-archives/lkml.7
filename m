Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A5C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD87221897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plVbJjlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfH3BXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:23:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37883 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfH3BXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:23:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id f22so6129861edt.4;
        Thu, 29 Aug 2019 18:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NTX+N7YX+s0tiTeWxFUIwz+t3GquKMdWCVhe8zw+xM=;
        b=plVbJjlSoo+OTWp0YBJz/fczIOBhrv7Ildive659bH2fqxjIWm9WCEGfEgW1/9xg6V
         Hqn6b7iwcmzhgmx//M694eew9W4t1cttTyCdUT+06kVjkyuICG9WadL1ObDk9EYyH85g
         NuVwXWBNZ0Sj07Te5ADKzVVsWubNT93ryJyRkisOkmO2uGiFXYsmYkonNpgVEeJxNbHU
         UACLrnqRFWlLyjSm3QQTczGv8l+eWZH1ogKg6PD3vZRYWZOfBmoJkNXtod0YSmj6PnFF
         bHLCeudXKgmYT+NvCxIukbsliyJlYKCAFsroOgGxBHkzamEfWcneXJUJuHVzyRhPC1U+
         YLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NTX+N7YX+s0tiTeWxFUIwz+t3GquKMdWCVhe8zw+xM=;
        b=P/SSMQBG6afG/Q6psFC1t57chVEszkryUn0X7759lKKsZWu47xWvW4vwkuUSADujOa
         gG+EU1onsAUQ9XcAwmWwcUIhG1uAdTokCJoAaeJ0nNub/lrmXu9XIk5lI45Hlph4HirP
         eXC4No5fQ4bf46RHP33UpRvWAuK9EnuNxu5ecljiEEbJDEXtQuPrYUhTsGqdn6b54OrX
         DBzXGV6oIr3oyX6OSaANeqm56Lw979++9G7e5iqUAJuBv5ArmPh9oT++io35p0gTpX2x
         seTtzAQ2yqZwIcr20ceZZFZgNT7tsj/TvK6cRofbTjk6qbw2oiZYIZ6lNPgfb+NIovEG
         sQkw==
X-Gm-Message-State: APjAAAValBBpH6PKZaxGEBftIlApM6MUzYhwmGgzThrFV2gvUUeIsvFa
        PSWIexfTp6NQNYq+dMaYLwTd82qXJuIMbl1DAcO0fjFi
X-Google-Smtp-Source: APXvYqyEaTdk0ihbHgYUlYhmRSYqhbDBWXjvaRt7LA3g+vd8DdulSmfcVZs2Lybe53Y76LGnInRMJgB8JeT4w4UUXWA=
X-Received: by 2002:a17:906:489a:: with SMTP id v26mr10930002ejq.234.1567128194903;
 Thu, 29 Aug 2019 18:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190827003145.2249-1-benchuanggli@gmail.com> <CAPDyKFpL0AibOOu571J6Trad=SddxFZ5JaMLRu23K4-OkcEEZw@mail.gmail.com>
In-Reply-To: <CAPDyKFpL0AibOOu571J6Trad=SddxFZ5JaMLRu23K4-OkcEEZw@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 30 Aug 2019 09:23:04 +0800
Message-ID: <CACT4zj-43ShHd4YrUahJ+tza-b18AtB9TYgTk74HonXd7iKEpw@mail.gmail.com>
Subject: Re: [PATCH V6 0/5] Add Genesys Logic GL975x support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael K. Johnson" <johnsonm@danlj.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 9:34 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 27 Aug 2019 at 02:32, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > The patches modify internal clock setup to match SD Host Controller
> > Simplified Specifications 4.20 and support Genesys Logic GL9750/GL9755 chipsets.
> >
> > V6:
> >  - export sdhci_abot_tuning() function symbol
> >  - use C-style comments
> >  - use BIT, FIELD_{GET,PREP} and GENMASK to define bit fields of register
> >  - use host->ops->platform_execute_tuning instead of mmc->ops->execute_tuning
> >  - call sdhci_reset() instead of duplicating the code in sdhci_gl9750_reset
> >  - remove .hw_reset
> >  - use condition define CONFIG_MMC_SDHCI_IO_ACCESSORS for read_l
>
> Applied patch 1-4, deferring patch5 for another version to fix Adrian's comment.
>
> Kind regards
> Uffe

Hi, Uffe,

So happy to get the good news.
 Thank you and Adrian for reviewing and helping.

Sincerely yours,
Ben Chuang
