Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC7EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561E5208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561712934;
	bh=Qibb5cHDh93A09zMK1z8VLBtdEagC8Bss71IgS2q6T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XjAtTeemvCFmBeAUqJrGICDJzWApjBDRopvd1uO+ETk9AedUYS+Safeti8djcbd/S
	 f4oz8HB/ZS0oXE/csrbA/ktXfpOiOH1kqxCH/IRdrTXoiKu4/RwcCGqyl6l7GDkkWD
	 nUeG6jD00I6e9UeNnOf8pkg8N5U/hdVeAvYk4f3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfF1JIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfF1JIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:08:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C08208CB;
        Fri, 28 Jun 2019 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561712931;
        bh=Qibb5cHDh93A09zMK1z8VLBtdEagC8Bss71IgS2q6T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Anw5BxsSdhuy+YQas/z6oihpG1mRsxLO8wlKwR9qAcC9tfe+Z1QVCkcDn5PRSmWtQ
         GMhoNAEAKyrBjfWX8XysBJhxVHoM77JmPY3o3hNeCNIA3XsukgNhYqfi1/iA3Wq4J9
         pXWa/1DX3J0PyIjW6hAIWIfgYKlARmoeTjsnBkx4=
Date:   Fri, 28 Jun 2019 10:08:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>, jnair@marvell.com,
        rrichter@marvell.com, jglauber@marvell.com
Subject: Re: [PATCH 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Message-ID: <20190628090845.rv6urqwfcwz4xxce@willie-the-truck>
References: <1560534144-13896-1-git-send-email-gkulkarni@marvell.com>
 <1560534144-13896-3-git-send-email-gkulkarni@marvell.com>
 <20190627095730.nf5kkataptfobzue@willie-the-truck>
 <CAKTKpr7PXFzQBHrJt+Ko=JaB+-5FdpNu+ByfkWmAm8OeiPem3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTKpr7PXFzQBHrJt+Ko=JaB+-5FdpNu+ByfkWmAm8OeiPem3w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Ganapat,

Thanks for the quick reply.

On Fri, Jun 28, 2019 at 11:09:33AM +0530, Ganapatrao Kulkarni wrote:
> On Thu, Jun 27, 2019 at 3:27 PM Will Deacon <will@kernel.org> wrote:
> > On Fri, Jun 14, 2019 at 05:42:46PM +0000, Ganapatrao Kulkarni wrote:
> > > CCPI2 is a low-latency high-bandwidth serial interface for connecting
> > > ThunderX2 processors. This patch adds support to capture CCPI2 perf events.
> > >
> > > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> > > ---
> > >  drivers/perf/thunderx2_pmu.c | 179 ++++++++++++++++++++++++++++++-----
> > >  1 file changed, 157 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> > > index 43d76c85da56..3791ac9b897d 100644
> > > --- a/drivers/perf/thunderx2_pmu.c
> > > +++ b/drivers/perf/thunderx2_pmu.c
> > > @@ -16,7 +16,9 @@
> > >   * they need to be sampled before overflow(i.e, at every 2 seconds).
> > >   */
> > >
> > > -#define TX2_PMU_MAX_COUNTERS         4
> > > +#define TX2_PMU_DMC_L3C_MAX_COUNTERS 4
> >
> > I find it odd that you rename this...
> 
> i am not sure, how to avoid this since dmc/l3c have 4 counters and ccpi2 has 8.
> i will try to make this better in v2.
> >
> > > +#define TX2_PMU_CCPI2_MAX_COUNTERS   8
> > > +
> > >  #define TX2_PMU_DMC_CHANNELS         8
> > >  #define TX2_PMU_L3_TILES             16
> > >
> > > @@ -28,11 +30,22 @@
> > >    */
> > >  #define DMC_EVENT_CFG(idx, val)              ((val) << (((idx) * 8) + 1))
> > >
> > > +#define GET_EVENTID_CCPI2(ev)                ((ev->hw.config) & 0x1ff)
> > > +/* bits[3:0] to select counters, starts from 8, bit[3] set always. */
> > > +#define GET_COUNTERID_CCPI2(ev)              ((ev->hw.idx) & 0x7)
> > > +#define CCPI2_COUNTER_OFFSET         8
> >
> >
> > ... but leave GET_EVENTID alone, even though it only applies to DMC/L3C
> > events. Saying that, if you have the event you can figure out its type,
> > so could you avoid the need for additional macros entirely and just use
> > the correct masks based on the corresponding PMU type? That might also
> > avoid some of the conditional control flow you're introducing elsewhere.
> 
> sure, i will add mask as argument to macro.
> >
> > >  #define L3C_COUNTER_CTL                      0xA8
> > >  #define L3C_COUNTER_DATA             0xAC
> > >  #define DMC_COUNTER_CTL                      0x234
> > >  #define DMC_COUNTER_DATA             0x240
> > >
> > > +#define CCPI2_PERF_CTL                       0x108
> > > +#define CCPI2_COUNTER_CTL            0x10C
> > > +#define CCPI2_COUNTER_SEL            0x12c
> > > +#define CCPI2_COUNTER_DATA_L         0x130
> > > +#define CCPI2_COUNTER_DATA_H         0x134
> > > +
> > >  /* L3C event IDs */
> > >  #define L3_EVENT_READ_REQ            0xD
> > >  #define L3_EVENT_WRITEBACK_REQ               0xE
> > > @@ -51,9 +64,16 @@
> > >  #define DMC_EVENT_READ_TXNS          0xF
> > >  #define DMC_EVENT_MAX                        0x10
> > >
> > > +#define CCPI2_EVENT_REQ_PKT_SENT     0x3D
> > > +#define CCPI2_EVENT_SNOOP_PKT_SENT   0x65
> > > +#define CCPI2_EVENT_DATA_PKT_SENT    0x105
> > > +#define CCPI2_EVENT_GIC_PKT_SENT     0x12D
> > > +#define CCPI2_EVENT_MAX                      0x200
> > > +
> > >  enum tx2_uncore_type {
> > >       PMU_TYPE_L3C,
> > >       PMU_TYPE_DMC,
> > > +     PMU_TYPE_CCPI2,
> > >       PMU_TYPE_INVALID,
> > >  };
> > >
> > > @@ -73,8 +93,8 @@ struct tx2_uncore_pmu {
> > >       u32 max_events;
> > >       u64 hrtimer_interval;
> > >       void __iomem *base;
> > > -     DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
> > > -     struct perf_event *events[TX2_PMU_MAX_COUNTERS];
> > > +     DECLARE_BITMAP(active_counters, TX2_PMU_CCPI2_MAX_COUNTERS);
> > > +     struct perf_event *events[TX2_PMU_DMC_L3C_MAX_COUNTERS];
> >
> > Hmm, that looks very odd. Why are they now different sizes?
> 
> events[ ] is used to hold reference to active events to use in timer
> callback, which is not applicable to ccpi2, hence 4.
> active_counters is set to max of both. i.e, 8. i will try to make it
> better readable in v2.

Thanks. I suspect renaming the field would help a lot, or perhaps reworking
your data structures so that you have a union of ccpi2 and dmc/l2c
structures where necessary.

> > >       struct device *dev;
> > >       struct hrtimer hrtimer;
> > >       const struct attribute_group **attr_groups;
> > > @@ -92,7 +112,21 @@ static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
> > >       return container_of(pmu, struct tx2_uncore_pmu, pmu);
> > >  }
> > >
> > > -PMU_FORMAT_ATTR(event,       "config:0-4");
> > > +#define TX2_PMU_FORMAT_ATTR(_var, _name, _format)                    \
> > > +static ssize_t                                                               \
> > > +__tx2_pmu_##_var##_show(struct device *dev,                          \
> > > +                            struct device_attribute *attr,           \
> > > +                            char *page)                              \
> > > +{                                                                    \
> > > +     BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);                     \
> > > +     return sprintf(page, _format "\n");                             \
> > > +}                                                                    \
> > > +                                                                     \
> > > +static struct device_attribute format_attr_##_var =                  \
> > > +     __ATTR(_name, 0444, __tx2_pmu_##_var##_show, NULL)
> > > +
> > > +TX2_PMU_FORMAT_ATTR(event, event, "config:0-4");
> > > +TX2_PMU_FORMAT_ATTR(event_ccpi2, event, "config:0-9");
> >
> > This doesn't look right. Can perf deal with overlapping fields? It seems
> > wrong that we'd allow the user to specify both, for example.
> 
> I am not sure what is the issue here? both are different PMUs
> root@SBR-26> cat /sys/bus/event_source/devices/uncore_dmc_0/format/event
> config:0-4
> root@SBR-26> cat /sys/bus/event_source/devices/uncore_ccpi2_0/format/event
> config:0-9

Ah, sorry about that. I got _var and _name the wrong way around and thought
you were introducing a file called event_ccpi2! What you have looks fine.

Will
