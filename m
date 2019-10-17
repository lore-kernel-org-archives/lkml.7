Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C443ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38D621835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571327279;
	bh=Na2Nvhl68xsqY/U1vzcF8y2RoUFJ7tB0brqS8GUuIDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZF5lhHbRP3VkhlsIeqyjnuwBdqEh1tucu6FZPtC+CsUnuXj7zuZaMNCjs68/xBBWq
	 hPCEB5apxqekuSjEa9txcW9V2m7t603liwXK8ixC8ynYQomp9XImo2cXxBmILlj8VR
	 ukwLnTWC+JJLM4DvbKzNunJFddskGTZMjblVgcfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394038AbfJQPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732271AbfJQPr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:47:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7210420869;
        Thu, 17 Oct 2019 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571327276;
        bh=Na2Nvhl68xsqY/U1vzcF8y2RoUFJ7tB0brqS8GUuIDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTBMsaYsj30+pvrvhsp5QMa9LHG/KT/wnaeWiosKOwEZwGC+bmFOedbNB8Dqc9NQY
         c9VZYT5ZEy3xT/lud+/9DZyEDKsXI9OMgr8RXJ8CgHpPyddwRVe/Znv/cOnqT8kH8l
         +vUOjRyx2SzPb3fuHh8F4WPfYg9JOqsSH6/4mqCM=
Date:   Thu, 17 Oct 2019 16:47:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
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
Subject: Re: [PATCH v6 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Message-ID: <20191017154750.jgn6e3465qrsu53e@willie-the-truck>
References: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
 <1571218608-15933-3-git-send-email-gkulkarni@marvell.com>
 <b8e1a637-faf4-4567-7d3e-a4f13dfa1cf0@huawei.com>
 <CAKTKpr4QoTDjbSxO4CvSH2sNvmrTJKjxi+RZH4mYfyDaaN96Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTKpr4QoTDjbSxO4CvSH2sNvmrTJKjxi+RZH4mYfyDaaN96Sw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:38:51PM +0530, Ganapatrao Kulkarni wrote:
> On Wed, Oct 16, 2019 at 7:01 PM John Garry <john.garry@huawei.com> wrote:
> > > +TX2_EVENT_ATTR(req_pktsent, CCPI2_EVENT_REQ_PKT_SENT);
> > > +TX2_EVENT_ATTR(snoop_pktsent, CCPI2_EVENT_SNOOP_PKT_SENT);
> > > +TX2_EVENT_ATTR(data_pktsent, CCPI2_EVENT_DATA_PKT_SENT);
> > > +TX2_EVENT_ATTR(gic_pktsent, CCPI2_EVENT_GIC_PKT_SENT);
> > > +
> > > +static struct attribute *ccpi2_pmu_events_attrs[] = {
> > > +     &tx2_pmu_event_attr_req_pktsent.attr.attr,
> > > +     &tx2_pmu_event_attr_snoop_pktsent.attr.attr,
> > > +     &tx2_pmu_event_attr_data_pktsent.attr.attr,
> > > +     &tx2_pmu_event_attr_gic_pktsent.attr.attr,
> > > +     NULL,
> > > +};
> >
> > Hi Ganapatrao,
> >
> > Have you considered adding these as uncore pmu-events in the perf tool?
> >
> At the moment no, since the number of events exposed/listed are very few.

Then sounds like a perfect time to nip it in the bud before the list grows
;)

If you can manage with these things in userspace, then I agree with John
that it would be preferential to do it that way. It also offers more
flexibility if we get the metricgroup stuff working properly (I think it's
buggered for big/little atm).

Will
