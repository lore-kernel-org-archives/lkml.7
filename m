Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765ADC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBD22147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/vgFVWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfENNAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:00:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46527 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENNAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:00:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so9864007qtz.13;
        Tue, 14 May 2019 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BhsK+eo4cfgsABTDaKyZZLGnDjzqAMBsSpSQSago0V0=;
        b=L/vgFVWkKewZ35FT6bCjdnnfjXC53Winv5N2lcJUFxc2OdsPF9BfuqvuyTRZ/qAm1a
         Of2uQ6Dxz4zsXbhexZ5G7J1N9KHk7791dDTDVh2/OkeYkCTMbSR4PcNO4qLFmxGQDgcq
         VRXNJUG18zT4eAKGTEuf6LoIYbBjCZCP4kK6eOLRrGEXLtRWLM1oG731AF4Dvl+qcrLv
         Q46KEHzMYh+wO7kRjaqY4id8BhbkbpBrr0Ix12PLd7HK1cBZmg8JU+gYgamilD+Xv2xr
         RHwvEjbp4R0BCR0Vo/0CBJzEUadiUh682F/TdcSc5HLD10x9JZU428JGMA6Vwus/SfIm
         369Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BhsK+eo4cfgsABTDaKyZZLGnDjzqAMBsSpSQSago0V0=;
        b=Ys5xNtaSMbvNSad8UjsCH+07OGRDmd4wG5Dz6cVQEa23WfElMYyEgsDU4pJ76lPnCM
         fWh67cXAZmQwioGXACz1PU1vZE8PA53Ig7bSPBGeJp02ImzfS5M0MMfRl1125xOvbHBk
         m6FVAwiXIrU0XUaxWY3DZHLT09oVoOtbDn2Nlid/AKuDS6Rg/gi4gdrAlS2550wP5DjI
         hQZRTyuzd//+B1C7vCKq6DFupfyJt8Jsdh2q+zVEJU6EUMlbw6G8NnYpjHpwbw/WrzuN
         43sO4jgG1EqZ4ulOyil3AVeIwZRPWGIUBLK7CZemnPRgkf705DGRLuUebBjPwUcMtQpD
         WbeA==
X-Gm-Message-State: APjAAAWQHsU+6BFQBqDFKtio20SP5dNhpvfMaW5lH52hpYpNE4YYc0Z3
        2I5Dyscph3ITQqOQ8Clejh9/Zgej
X-Google-Smtp-Source: APXvYqxdLiWmxp7Ms2KuEXgya1zfgvbl3zs+Bx742OnALymyk5UHS+nHSTDcc42ec9A3MHtmTxJywA==
X-Received: by 2002:ac8:3157:: with SMTP id h23mr29587117qtb.248.1557838802122;
        Tue, 14 May 2019 06:00:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.210])
        by smtp.gmail.com with ESMTPSA id t58sm10094512qtj.4.2019.05.14.06.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:00:01 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63244403AD; Tue, 14 May 2019 09:59:56 -0300 (-03)
Date:   Tue, 14 May 2019 09:59:56 -0300
To:     Kan Liang <kan.liang@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf vendor events intel: Add uncore_upi JSON support
Message-ID: <20190514125956.GG3198@kernel.org>
References: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com>
 <9e816fed-5d00-c490-21b3-ad9c56dac446@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e816fed-5d00-c490-21b3-ad9c56dac446@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 13, 2019 at 05:29:30PM -0400, Liang, Kan escreveu:
> Hi Arnaldo,
> 
> Could you please apply this fix?

Sure, please next time specify which arch this should be tested on, as I
tried it here on a skylake notebook (lenovo t480s) before your patch and
got:

[root@quaco ~]# perf stat -e UPI_DATA_BANDWIDTH_TX
event syntax error: 'UPI_DATA_BANDWIDTH_TX'
                     \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
[root@quaco ~]#

Then, looking at 'perf list' /UPI I got just these:

Pipeline:
<SNIP>
  UPI
       [Uops Per Instruction]

Which already probably told me a bit about what this is about, its under
the "METRIC groups" header

After your patch applied I get:

[root@quaco ~]# perf stat -e UPI_DATA_BANDWIDTH_TX
event syntax error: 'UPI_DATA_BANDWIDTH_TX'
                     \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
[root@quaco ~]# 

I.e. nothing seem to have changed, but then, to further look at this I
tried:

# strings ~/bin/perf | grep -i upi
<SNIP>
Data Response packets that go direct to Intel UPI. Unit: uncore_upi 
Counts Data Response (DRS) packets that attempted to go direct to Intel Ultra Path Interconnect (UPI) bypassing the CHA 
Cycles Intel UPI is in L1 power mode (shutdown). Unit: uncore_upi 
Counts cycles when the Intel Ultra Path Interconnect (UPI) is in L1 power mode.  L1 is a mode that totally shuts down the UPI link.  Link power states are per link and per direction, so for example the Tx direction could be in one state while Rx was in another, this event only coutns when both links are shutdown
Cycles the Rx of the Intel UPI is in L0p power mode. Unit: uncore_upi 
Counts cycles when the the receive side (Rx) of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode where we disable 60% of the UPI lanes, decreasing our bandwidth in order to save power
FLITs received which bypassed the Slot0 Receive Buffer. Unit: uncore_upi 
Valid data FLITs received from any slot. Unit: uncore_upi 
<SNIP>

So this "UPI" TLA, here, should not mean "UOPS per instruction", but
Intel's "Ultra Path Interconnect", right? Lemme update the changelog...

/me googles... https://en.wikipedia.org/wiki/Intel_Ultra_Path_Interconnect

So I'd need a Skylake-SP test machine to test this...

Please add such notes in the future, helps reviewing and testing this.

At some point I'd like to have 'perf test' test such stuff with a
Requires_cpuid/arch, etc.

- Arnaldo
 
> Thanks,
> Kan
> 
> On 5/7/2019 9:16 AM, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Perf cannot parse UPI events.
> > 
> >      #perf stat -e UPI_DATA_BANDWIDTH_TX
> >      event syntax error: 'UPI_DATA_BANDWIDTH_TX'
> >                       \___ parser error
> >      Run 'perf list' for a list of valid events
> > 
> > The JSON lists call the box UPI LL, while perf calls it upi.
> > Add conversion support to json to convert the unit properly.
> > 
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >   tools/perf/pmu-events/jevents.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > index 68c92bb..daaea50 100644
> > --- a/tools/perf/pmu-events/jevents.c
> > +++ b/tools/perf/pmu-events/jevents.c
> > @@ -235,6 +235,7 @@ static struct map {
> >   	{ "iMPH-U", "uncore_arb" },
> >   	{ "CPU-M-CF", "cpum_cf" },
> >   	{ "CPU-M-SF", "cpum_sf" },
> > +	{ "UPI LL", "uncore_upi" },
> >   	{}
> >   };
> > 

-- 

- Arnaldo
