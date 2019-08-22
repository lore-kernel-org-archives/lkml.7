Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E304C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0B022CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7vQ3Zm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfHVEBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:01:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45453 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfHVEBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 00:01:08 -0400
Received: by mail-io1-f67.google.com with SMTP id t3so9042940ioj.12;
        Wed, 21 Aug 2019 21:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BybcKrDqDsV1vLqaW8rNec228gnkGTbH03h7q1YFv58=;
        b=Y7vQ3Zm+wj8+Yuzw3JUYDonuE6oRk7m8wI4gRuWHwKlAAMlW717d5+hrRvZn9ANlMc
         8mI6Mhx7E1KK8+LRauJkSBRDFUAMFm3T0YTvhsKOZS0eLrltn96jn57ZJw/sVyFIsNkj
         A7i+7VkiC1VDAve32spDxJwfpP65doQtBTAzBnaKGNmcczqaTmixrA4tLXTuOdR6mI6h
         fcCcSZ4LAZyu3erb/LqIpUpiQowiccIrAOp5Q02/uTbLqRkS9d/xiMnf25aSBrHr8N8X
         redTAM3ldbRT7bBIQLLPNBw2cg0O7HvhxawnZOekNdCDkej+HNc30U1TI4PGTz3eCol9
         TEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BybcKrDqDsV1vLqaW8rNec228gnkGTbH03h7q1YFv58=;
        b=hn1Y7CEFvbsgj6SXxhtLvcJGuYODXgOgyttekuilXcyPxVbbiQ3/8qFbUacZoM/n1r
         AYbErTkgM0tyB4K1gm64HhhhGjvNm35EGNY5040DA2EU92K71KfXSzGDcZmrizzGJdKr
         n7fmNE6XA0SmhNg9cJkG3dLRfWdWRXAhCGJUixN8gdjO6hJeZ4qsDl+vnznJAo/6NxJq
         5q6CIcP0KvQLz/BjVp63H3+Zo4z0R7uhKqsbE5ytECFw6xq4HWlJ6uvGa7AjtVNwBE71
         NL0PC0ZHIXz8Y180UcFcyo6GKtSfVQILbYt0zQDoTtUSx/DAYMY3y+ucV7bg04RHXuB9
         2Rvg==
X-Gm-Message-State: APjAAAUkGjMGXYAD2hjgJasHRyLSKFhtITPAyPD/UviYsHERIaUyeOLF
        8LhW6XNq5Je//PcROpsuhnSb7fp0y56szbLJJHg=
X-Google-Smtp-Source: APXvYqxTBiRXARJgZzQt0mN0CCKgd09Sfxj9MwGfaPw58BNsM2WnEWudKSMOy2KZVA6yswYrCsPxKMh7jPQrukzwxks=
X-Received: by 2002:a02:b713:: with SMTP id g19mr13929241jam.77.1566446467556;
 Wed, 21 Aug 2019 21:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <1563873380-2003-1-git-send-email-gkulkarni@marvell.com>
 <1563873380-2003-3-git-send-email-gkulkarni@marvell.com> <20190812120125.GA50712@lakrids.cambridge.arm.com>
 <CAKTKpr7juHd9Bgam28LESadihFadEAevRAhc-7w3PTMYY7HLNw@mail.gmail.com>
 <20190813110345.GD866@lakrids.cambridge.arm.com> <20190821165339.7gu4rxkvdjcr4mta@willie-the-truck>
In-Reply-To: <20190821165339.7gu4rxkvdjcr4mta@willie-the-truck>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 22 Aug 2019 09:30:56 +0530
Message-ID: <CAKTKpr48Cmcs8u81EZeMMndP1XwaNOMCE-r00vhE6ysK3CUsrw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 10:23 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Aug 13, 2019 at 12:03:45PM +0100, Mark Rutland wrote:
> > On Tue, Aug 13, 2019 at 04:25:15PM +0530, Ganapatrao Kulkarni wrote:
> > > On Mon, Aug 12, 2019 at 5:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2019 at 09:16:28AM +0000, Ganapatrao Kulkarni wrote:
> > > > > CCPI2 is a low-latency high-bandwidth serial interface for connecting
> > > > > ThunderX2 processors. This patch adds support to capture CCPI2 perf events.
> > > >
> > > > It would be worth pointing out in the commit message how the CCPI2
> > > > counters differ from the others. I realise you have that in the body of
> > > > patch 1, but it's critical information when reviewing this patch...
> > >
> > > Ok, I will add in next version.
> > > >
> > > > >
> > > > > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> > > > > ---
> > > > >  drivers/perf/thunderx2_pmu.c | 248 ++++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 214 insertions(+), 34 deletions(-)
> > > > >
> > > > > diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> > > > > index 43d76c85da56..a4e1273eafa3 100644
> > > > > --- a/drivers/perf/thunderx2_pmu.c
> > > > > +++ b/drivers/perf/thunderx2_pmu.c
> > > > > @@ -17,22 +17,31 @@
> > > > >   */
> > > > >
> > > > >  #define TX2_PMU_MAX_COUNTERS         4
> > > >
> > > > Shouldn't this be 8 now?
> > >
> > > It is kept unchanged to 4(as suggested by Will), which is same for
> > > both L3 and DMC.
> > > For CCPI2 this macro is not used.
> >
> > Hmmm....
> >
> > I disagree with that suggestion given that this also affects the
> > active_counters bitmap size (and thus it is not correctly sized as of
> > this patch), and it doesn't really save us much.
> >
> > I think it would be better to bump this to 8 and always update the
> > events array, even though it will be unused for CCPI2. That's less
> > surprising, needs fewer special-cases, and we can use the hrtimer
> > function pointer alone to determine if we need to do any hrtimer work.
>
> tbf, my complaint was actually about some macros applying to the whole
> PMU whilst others refer only to DMC/L3C and this not being apparent from
> the naming:
>
> https://lkml.org/lkml/2019/6/27/250
>
> so I'm fine having TX2_PMU_DMC_L3C_MAX_COUNTERS and
> TX2_PMU_CCPI2_MAX_COUNTERS, but that sort of naming needs to be consistent
> unless the macro/definition really applies to both. That fed the suggestion
> that GET_EVENTID could be generic and switch on the event type internally
> instead of at the caller.

Thanks Will for the clarification.
I will send new version with changes as suggested.

>
> Will

Thanks,
Ganapat
