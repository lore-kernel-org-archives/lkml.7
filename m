Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F9ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F212245C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB2/6gRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407629AbfJRFUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:20:44 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34905 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJRFUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:20:44 -0400
Received: by mail-yw1-f66.google.com with SMTP id r134so1754021ywg.2;
        Thu, 17 Oct 2019 22:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsX/qftxhkazt9hFT8dF57W5m8I435Z6GlII9cy+ECY=;
        b=LB2/6gRPtiwyOpmLwPi7yLfXzO/o74TSfvJfCt2GXYIAZXk8+Pf8VSZlmSRym9BhXU
         U5be31A1gQfNPmpGHHuUtf9B7X3L9QIQN6VdP1M/ufmL7MCuXFikuhLTDWjzGAhBq3V8
         mXga5/iHEYkl2fY5yH5MoccwlTwfjuJP2JeTKpSPLCsJWiY1E0UuEl7vL8htolCtAIVi
         yXEq15oEn0F6yyhSH+A8h2la3ySKUlKrFxDil1lNU2ahbL8u0jqtpXCEh0tEDer8H7nd
         6Y+CxLkBrQxqbAUGA7BoVFLcXfWMW90K61E+pYHK+otV2dkI5Yr3+lyuIc5InASL/zeV
         eXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsX/qftxhkazt9hFT8dF57W5m8I435Z6GlII9cy+ECY=;
        b=Pc7sZ+eKVMeKVtKXPQ6MLqpWQ7ObGArYB2GM3WGC6+HDkiHFxj7fUrATgEMC7xK9am
         xNPiPfApJQIzgAcW/jyVW5qI3mRvJtHeoOaROMvmYrMSpVjsJXf5wi0gaW8rNpSLxNY5
         eNYty7GzceupC+zNUwFZOIhrH6i8V+RZ7Mn16/8msnoYC4fQQ+dA202tArCq1mswoWW0
         YuE5KTJC69rWi9Dc7k5eHtO50MQeakH223gUGomUxxPShgWyVtxwgDaHiHe5ujbVyZ64
         M/8SuYUv1VkYVd13RAwEf0MdGlgPpMTRmCpfVPpGdBZ17nrGwsI9l87QnmAh3T1TZe+7
         VwUQ==
X-Gm-Message-State: APjAAAUwavxPiGzLeI1FOMGgWuxgZW/I7wM0lzcwemiwyEqGM69OJdZ+
        YOrNxB38F6JICXoABI5Ab+9G8fvA+Ajn8M7bAco=
X-Google-Smtp-Source: APXvYqxwvxHZjKJg/YnuStSLc4n0H5LSqtfMOTfh+SFjPsB+sGtqQKsOlHWmrzk0Hkx+oX8i4/YwLHRT6gmxcwX16E8=
X-Received: by 2002:a0d:d605:: with SMTP id y5mr5180535ywd.13.1571372506022;
 Thu, 17 Oct 2019 21:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
 <1571218608-15933-3-git-send-email-gkulkarni@marvell.com> <b8e1a637-faf4-4567-7d3e-a4f13dfa1cf0@huawei.com>
 <CAKTKpr4QoTDjbSxO4CvSH2sNvmrTJKjxi+RZH4mYfyDaaN96Sw@mail.gmail.com> <20191017154750.jgn6e3465qrsu53e@willie-the-truck>
In-Reply-To: <20191017154750.jgn6e3465qrsu53e@willie-the-truck>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 18 Oct 2019 09:51:34 +0530
Message-ID: <CAKTKpr5ntp5X6Lvp=rKT_F1E1ftdqtjSWTgpEOqEwaDMH2kc1w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
To:     Will Deacon <will@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jan Glauber <jglauber@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Thu, Oct 17, 2019 at 9:17 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Oct 17, 2019 at 12:38:51PM +0530, Ganapatrao Kulkarni wrote:
> > On Wed, Oct 16, 2019 at 7:01 PM John Garry <john.garry@huawei.com> wrote:
> > > > +TX2_EVENT_ATTR(req_pktsent, CCPI2_EVENT_REQ_PKT_SENT);
> > > > +TX2_EVENT_ATTR(snoop_pktsent, CCPI2_EVENT_SNOOP_PKT_SENT);
> > > > +TX2_EVENT_ATTR(data_pktsent, CCPI2_EVENT_DATA_PKT_SENT);
> > > > +TX2_EVENT_ATTR(gic_pktsent, CCPI2_EVENT_GIC_PKT_SENT);
> > > > +
> > > > +static struct attribute *ccpi2_pmu_events_attrs[] = {
> > > > +     &tx2_pmu_event_attr_req_pktsent.attr.attr,
> > > > +     &tx2_pmu_event_attr_snoop_pktsent.attr.attr,
> > > > +     &tx2_pmu_event_attr_data_pktsent.attr.attr,
> > > > +     &tx2_pmu_event_attr_gic_pktsent.attr.attr,
> > > > +     NULL,
> > > > +};
> > >
> > > Hi Ganapatrao,
> > >
> > > Have you considered adding these as uncore pmu-events in the perf tool?
> > >
> > At the moment no, since the number of events exposed/listed are very few.
>
> Then sounds like a perfect time to nip it in the bud before the list grows
> ;)

I had internal discussion with architecture team, they have confirmed
that, these are the only published events and no plan to add new.
However, If any such request comes from HW team in future, i will add
them to JSON files.

I have incorporate all your previous comments, Can you please Ack and
queue it to 5.5?

>
> If you can manage with these things in userspace, then I agree with John
> that it would be preferential to do it that way. It also offers more
> flexibility if we get the metricgroup stuff working properly (I think it's
> buggered for big/little atm).
>
> Will

Thanks,
Ganapat
