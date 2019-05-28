Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031ED2182B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IqZUUEJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfE1PtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:49:04 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46458 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfE1PtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:49:02 -0400
Received: by mail-vs1-f68.google.com with SMTP id x8so422303vsx.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVVCM3oss6fFLEowwE8V1IlUxZzOfvY2hKZ39Ilquf4=;
        b=IqZUUEJieiqEbr+TQYYtAXgNVwAK7MzBBm9XlY9GGI+WKamSi1KFzW43xncmxVl8Ui
         N5P4dPR+/E+LhBunyC95WAbkS0Og8TTm+OpBRx5yLU8NnS++izYync66K3+ssPoVmVBp
         41R+hbkwY2q8btHusadzE8i4NyCimBvpQ5KV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVVCM3oss6fFLEowwE8V1IlUxZzOfvY2hKZ39Ilquf4=;
        b=HigTfoXRnuMgakzVPBS3C2nRxx42ZrYZ0tsdgehz+jsa5stEaoBMOByrXwLECL5f4b
         rypcymsnzCkmnEAC4RbfjzmoqMOyK9Kq2gh29F2KAvFbyzinR6DFHy0KrP04clIsL/k3
         TAcHAlvWx8zO4gToEcP261RDw2HBHfAcIH4JYQtOQ9dFJPIBJlmJwAvgQcGRRuaI/aO/
         8iUeR5adg418IbWcBeyEMT8AtapANbfOl/IgPpcGI/+ovUrgRmVGZhfcwwIkzRs7CF5G
         CYQxS5oC61ZUqA7X0nFjGQkk8Jtmo5facrkKc2q7hzErk5IDywj1fbpoeFZp8u6IhfJt
         zLlw==
X-Gm-Message-State: APjAAAUdjrm8s7KjW2aLSk8F/5CVgmpq0EmLsDQ2eqCRtrOh0nbsXCEt
        7XrVmhsFrCJnOzbSCyavYxHj0pMrk00=
X-Google-Smtp-Source: APXvYqywRE9+sVIudp0zsMPD0HY1xX0SFb33591CpPmWIAOvPxZZhUzEK+YqjY0t+H0lZtTANkRyyA==
X-Received: by 2002:a67:7dd1:: with SMTP id y200mr40503606vsc.213.1559058541202;
        Tue, 28 May 2019 08:49:01 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id p20sm4977512uaa.4.2019.05.28.08.49.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:49:00 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id o5so467284vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:49:00 -0700 (PDT)
X-Received: by 2002:a67:f60b:: with SMTP id k11mr68126066vso.111.1559058141025;
 Tue, 28 May 2019 08:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org> <05af228c-139b-2b7f-f626-36fb34634be5@broadcom.com>
 <4f39e152-04ba-a64e-985a-df93e6d15ff8@intel.com> <aa8e526f-b382-f3b7-74a5-e0fee09ae096@broadcom.com>
 <2d6fa51d-27af-4f90-2bd6-144112ce75ad@intel.com>
In-Reply-To: <2d6fa51d-27af-4f90-2bd6-144112ce75ad@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 May 2019 08:42:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XV1oudf-xW_s9CQMgF7MryX-UJRrqsUFDQE0DF8Yf80w@mail.gmail.com>
Message-ID: <CAD=FV=XV1oudf-xW_s9CQMgF7MryX-UJRrqsUFDQE0DF8Yf80w@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 28, 2019 at 4:45 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/05/19 2:21 PM, Arend Van Spriel wrote:
> >
> >
> > On 5/28/2019 12:04 PM, Adrian Hunter wrote:
> >> On 26/05/19 9:42 PM, Arend Van Spriel wrote:
> >>> On 5/18/2019 12:54 AM, Douglas Anderson wrote:
> >>>> Normally when the MMC core sees an "-EILSEQ" error returned by a host
> >>>> controller then it will trigger a retuning of the card.  This is
> >>>> generally a good idea.
> >>>
> >>> Probably a question for Adrian, but how is this retuning scheduled. I recall
> >>> seeing something in mmc_request_done. How about deferring the retuning upon
> >>> a release host or is that too sdio specific.
> >>
> >> Below is what I have been carrying the last 4 years.  But according to
> >> Douglas'
> >> patch, the release would need to be further down.  See 2nd diff below.
> >> Would that work?
> >
> > That makes sense. The loop is needed because the device can be a bit bone
> > headed. So indeed after the loop the device should be awake and able to
> > handle CMD19.

IMO I'd rather not _defer_ the re-tuning.  I believe the correct thing
is to not schedule the re-tuning at all in response to the IO errors.
That's what my patch does.

Specifically the IO errors that come up in this case are not due to
being "out of tune".  They are due to the fact that the other SDIO
card may be in a transitory state and putting garbage on the bus.
Scheduling a retuning for later would be just a waste of time and
needlessly tie up the bus for the retune.

...or am I confused?


> What if tuning is needed to read SBSDIO_FUNC1_SLEEPCSR successfully?

Personally I think this would be pretty unlikely.  If we're at this
point we've already talked to the card quite a bit so we should have a
tuning that's pretty good.  If we're just slightly out of tune then we
should still get through the loop with a few retries and then we can
detect that we're out of tune later, with a more reliable command.

However, if you're worried about this, I can always re-enable the old
behavior if we have already looped a few times.  I suppose I could
increase the loop duration/count slightly too...  Please let me know
one way or the other.


-Doug
