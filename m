Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB13C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E2821726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI9syeMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfH3BP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:15:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45664 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfH3BP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:15:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so6048553eda.12;
        Thu, 29 Aug 2019 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPTPnYM7QqtTv8kp2zIYIZIzXRBKXsbo1US92BKrYJI=;
        b=HI9syeMhKbi/Ybi3+Aa5lrIvRtF+Nfhas7LIsdqNFpESoXfoV9TQA+179nyteFNtuT
         Al/XN/b7M3V+MBWH8i14r8uNe4Vicg4hsGbxHgCP63+GMWoIDQqwVgt0Wh/iIkcKfHBk
         71J2a6fI3hoqe2x/JrZo8nSoegiJGh0chovzJ4pzVj/TJtqKyMmjpYz8VlMbOq9Hszj5
         d5+YFI14IZgLuomByyHxuNALpdEo3Y7i3VIv0WjkeX26OUX9w6DrlBIiP16qUhiIG89I
         b79VHuLPteuYgzkY6VHjmpxChoxSIsJneXKiTyzMI4QA3u3U9B3/AlK42wsEVclD+6aR
         pMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPTPnYM7QqtTv8kp2zIYIZIzXRBKXsbo1US92BKrYJI=;
        b=oEsHH5nxbABO+DHeoTBG5KSJQ6Kl/sKaM+l623rX4BK9lUgs/SHsf2L/PWDEGKFXZY
         iXldAvmXhCcCEKnbOG9EYiTLQ+uVRNmRZGcd2lf0r/TzVuTpVqlMC+vG9VdZ36FMJEZG
         VZXmgfkwnMIgkIe7oGnYcioHMQYHet6oYhYEQ15NEyTbmaQllPu04D8ay8M5nBbPraea
         pCtfEM/yE0g1apcP/2gwpiwN2LZmi8Rgi86ni4gnZDMxK8kK2vtQyjakqtOZzEyHTsAX
         BkLIwrVmRuklD6DJrn8CsaRgr/Qn/2rusXcj/mbYZOgckAmoeKgkDxiTp114dyWkaBXL
         Sg+A==
X-Gm-Message-State: APjAAAUXOcSz91Pv2v70NQ0FtcDazjKJJDntOxzWs5Q2WvDirhl8nDO/
        yqESizF+rnpla9uA8qJXErRVmuaj/JkK3rOED2k=
X-Google-Smtp-Source: APXvYqwoVLPFwwCmPAGZ9T681Sa7ddN57yc3d8o9k190kM0ZTgj6dvVaIksZ0sfK7bjJXhEUwOZosf9ZIjHRZ2OCp6M=
X-Received: by 2002:a50:f108:: with SMTP id w8mr13078409edl.44.1567127724526;
 Thu, 29 Aug 2019 18:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190827003335.2494-1-benchuanggli@gmail.com> <99735a03-c698-624d-f5cf-4feed7e6a9ca@intel.com>
 <20190828134714.GA30547@people.danlj.org> <7fcd0fd5-97cb-1dab-7477-666838478541@intel.com>
In-Reply-To: <7fcd0fd5-97cb-1dab-7477-666838478541@intel.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 30 Aug 2019 09:15:13 +0800
Message-ID: <CACT4zj_nzknKWt8yhk8KxDVE0WB27_FosPxu6NUQ5vxanc7CVw@mail.gmail.com>
Subject: Re: [PATCH V6 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Michael K. Johnson" <johnsonm@danlj.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 9:22 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/08/19 4:47 PM, Michael K. Johnson wrote:
> > On Wed, Aug 28, 2019 at 04:13:03PM +0300, Adrian Hunter wrote:
> >> On 27/08/19 3:33 AM, Ben Chuang wrote:
> >> Looks good, one minor comment
> > ...
> >>> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> >>
> >> Arguably CONFIG_MMC_SDHCI_IO_ACCESSORS needs to be removed altogether. i.e.
> >> making the accessors always available.  So for now, I'd prefer to select
> >> MMC_SDHCI_IO_ACCESSORS:
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index 14d89a108edd..c3bd967d8a1a 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
> >>      depends on MMC_SDHCI && PCI
> >>      select MMC_CQHCI
> >>      select IOSF_MBI if X86
> >> +    select MMC_SDHCI_IO_ACCESSORS
> >>      help
> >>        This selects the PCI Secure Digital Host Controller Interface.
> >>        Most controllers found today are PCI devices.
> >
> > Unless I'm missing something, this seems like a separate patch;
> > are you asking for it first, as a predecessor to the GLI patch?
> >
>
> No, it is fine with this patch.

I will remove CONFIG_MMC_SDHCI_IO_ACCESSORS from sdhci-pci-gli.c and
add add `select MMC_SDHCI_IO_ACCESSORS` in Kconfig.
Thank you.
