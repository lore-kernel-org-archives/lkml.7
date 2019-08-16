Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E39C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CAB2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1eMypNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfHPBy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:54:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32906 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHPBy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:54:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so7474452otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTBLiXSIuUXd+8NGvTkyeSPJUrRK2Bbf1LlrvKYe2Bs=;
        b=c1eMypNZciY3A2RHemaEo3MmOwfU81fQPf4Ro35MWp58GOMiksnAuGWsDOvT0vTD+J
         Pm152McXNZ+R6kJnBaQIfMXt/hqzfaC/RbQpbN39NVCIZxh8bdHEbKRicdwbMZc0HBHk
         17wMxwDScDGZzYn/fQGKtBfPD1xtCA+DNNQKHetV/Xe0APpTarYVOx7uaAUsuuvDUuXo
         HqwjEouJ87uP1+nOMyVs/nVupjeWmscIqx71esKyhyQ+T9GBYzR3wuGetPH0IdSO57Ia
         BihlodiAuEXo3zgM6pulsz5sM70nnEVS9t5y9L9GT2Kkygo9ae24fU9+aKKnGmSQL7g4
         siCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTBLiXSIuUXd+8NGvTkyeSPJUrRK2Bbf1LlrvKYe2Bs=;
        b=hsHRDtG1b50EuXA09iU+7wRCcL76kPsz4a2Bh/EraF9KnmciDf9jfLQTzgM6i321Su
         XNruY/0O6OF58WLMokr7JadSzx3gHOtLNQQAQpUxDLo+nURFI+VVpMm45Jicu5Vw8/Me
         czmCAnc6SmNeuOmfsIoFbL/hb54isl77Zb1oA7v8kJdW9DLDQEZWsyXCKZ9Zh25gDvID
         DrEf6mKpk7CytX/rTrk54xeXHG6yoI0pKLTive/Ot7pZPEGCvpG70MQWDv9CBR83d81P
         t2IfluPpQZwaSnevmz1pOGdMPVH6iAktalYs5/jUWNeD6R9vuwnyVpmbG0WmOHbrgph+
         gL/Q==
X-Gm-Message-State: APjAAAUaVjYpJRudBqimpeBgkklyqLmTmG8I7av1eJeg9meM96vaH41h
        TG7zHi2F1QCgZ7t/V8vEyaROWjhl89BycW6B+qVksg==
X-Google-Smtp-Source: APXvYqyIhzjv/mzlBeEGYrBrvhv6vf4+oF36WPPG9u45hKnTlVMFItiKqprxNUbwc41ChxrtOG+Tn0kFOtTd7SBW3Zc=
X-Received: by 2002:a05:6830:1e0f:: with SMTP id s15mr6147817otr.231.1565920495218;
 Thu, 15 Aug 2019 18:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com> <b8a6020f-eda5-0c3d-b365-a294c28b9650@linaro.org>
In-Reply-To: <b8a6020f-eda5-0c3d-b365-a294c28b9650@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 15 Aug 2019 18:54:19 -0700
Message-ID: <CAGETcx_pzFj1TSoyCTGgZn_yZGZBMT2c_d74wLA5gBqhmhH8Gw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Introduce Bandwidth OPPs for interconnects
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 9:19 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi,
>
> On 8/8/19 01:31, Saravana Kannan wrote:
> > Interconnects and interconnect paths quantify their performance levels in
> > terms of bandwidth and not in terms of frequency. So similar to how we have
> > frequency based OPP tables in DT and in the OPP framework, we need
> > bandwidth OPP table support in DT and in the OPP framework.
> >
> > So with the DT bindings added in this patch series, the DT for a GPU
> > that does bandwidth voting from GPU to Cache and GPU to DDR would look
> > something like this:
> >
> > gpu_cache_opp_table: gpu_cache_opp_table {
> >       compatible = "operating-points-v2";
> >
> >       gpu_cache_3000: opp-3000 {
> >               opp-peak-KBps = <3000000>;
> >               opp-avg-KBps = <1000000>;
> >       };
> >       gpu_cache_6000: opp-6000 {
> >               opp-peak-KBps = <6000000>;
> >               opp-avg-KBps = <2000000>;
> >       };
> >       gpu_cache_9000: opp-9000 {
> >               opp-peak-KBps = <9000000>;
> >               opp-avg-KBps = <9000000>;
> >       };
> > };
> >
> > gpu_ddr_opp_table: gpu_ddr_opp_table {
> >       compatible = "operating-points-v2";
> >
> >       gpu_ddr_1525: opp-1525 {
> >               opp-peak-KBps = <1525000>;
> >               opp-avg-KBps = <452000>;
> >       };
> >       gpu_ddr_3051: opp-3051 {
> >               opp-peak-KBps = <3051000>;
> >               opp-avg-KBps = <915000>;
> >       };
> >       gpu_ddr_7500: opp-7500 {
> >               opp-peak-KBps = <7500000>;
> >               opp-avg-KBps = <3000000>;
> >       };
> > };
> >
> > gpu_opp_table: gpu_opp_table {
> >       compatible = "operating-points-v2";
> >       opp-shared;
> >
> >       opp-200000000 {
> >               opp-hz = /bits/ 64 <200000000>;
> >       };
> >       opp-400000000 {
> >               opp-hz = /bits/ 64 <400000000>;
> >       };
> > };
> >
> > gpu@7864000 {
> >       ...
> >       operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> >       ...
> > };
> >
> > v1 -> v3:
> > - Lots of patch additions that were later dropped
> > v3 -> v4:
> > - Fixed typo bugs pointed out by Sibi.
> > - Fixed bug that incorrectly reset rate to 0 all the time
> > - Added units documentation
> > - Dropped interconnect-opp-table property and related changes
> > v4->v5:
> > - Replaced KBps with kBps
> > - Minor documentation fix
> >
> > Cheers,
> > Saravana
> >
> > Saravana Kannan (3):
> >   dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
> >   OPP: Add support for bandwidth OPP tables
> >   OPP: Add helper function for bandwidth OPP tables
> >
> >  Documentation/devicetree/bindings/opp/opp.txt | 15 ++++--
> >  .../devicetree/bindings/property-units.txt    |  4 ++
> >  drivers/opp/core.c                            | 51 +++++++++++++++++++
> >  drivers/opp/of.c                              | 41 +++++++++++----
> >  drivers/opp/opp.h                             |  4 +-
> >  include/linux/pm_opp.h                        | 19 +++++++
> >  6 files changed, 121 insertions(+), 13 deletions(-)
> >
>
> For the series:
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks Georgi.

Rob and Viresh, We've settled on one format. Can you pull this series in please?

Do you need me to resent the series with the Ack? Or can you put that
in if you pull in this series?

Thanks,
Saravana
