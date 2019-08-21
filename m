Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0953EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3042339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566406426;
	bh=8EpYXOIJQ7TePwZ/ZCJnzDEkdpUgKmzzxBX02HTYDWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eP1ObTpdXYkFsOmF5JUiYE0/F6G0sar+QPy83xI1K5bA8Q0EhhctkvQBD4YCjt2tQ
	 HwXCvzDi8TEKFRIu+o/wTaDB0nRKDpxTDByaWjuodKUwcfjkmMwUhAKaouck+FU+VH
	 vv9G7wTH+lJBspfVkFsjGgTFSRbn23kS2EnpfyeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfHUQxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfHUQxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:53:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9699122DD3;
        Wed, 21 Aug 2019 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566406424;
        bh=8EpYXOIJQ7TePwZ/ZCJnzDEkdpUgKmzzxBX02HTYDWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfA3TYZ5mReb6a41G+2FUsWZ4XDr3vM5MuLTd+xih2gFnd/B+p3syzRto7GLy1yCP
         yNbNLlyJluiuGn/UDS0ljvkiKAsdh75khbDmuBybOByPBaXAfA3M/PM56Bd93ckdf7
         Uz4JeqWNifNtxOjNgPEvRWiDgS+Ymy2V+CFJCsZE=
Date:   Wed, 21 Aug 2019 17:53:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ganapatrao Kulkarni <gklkml16@gmail.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Message-ID: <20190821165339.7gu4rxkvdjcr4mta@willie-the-truck>
References: <1563873380-2003-1-git-send-email-gkulkarni@marvell.com>
 <1563873380-2003-3-git-send-email-gkulkarni@marvell.com>
 <20190812120125.GA50712@lakrids.cambridge.arm.com>
 <CAKTKpr7juHd9Bgam28LESadihFadEAevRAhc-7w3PTMYY7HLNw@mail.gmail.com>
 <20190813110345.GD866@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813110345.GD866@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:03:45PM +0100, Mark Rutland wrote:
> On Tue, Aug 13, 2019 at 04:25:15PM +0530, Ganapatrao Kulkarni wrote:
> > On Mon, Aug 12, 2019 at 5:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Tue, Jul 23, 2019 at 09:16:28AM +0000, Ganapatrao Kulkarni wrote:
> > > > CCPI2 is a low-latency high-bandwidth serial interface for connecting
> > > > ThunderX2 processors. This patch adds support to capture CCPI2 perf events.
> > >
> > > It would be worth pointing out in the commit message how the CCPI2
> > > counters differ from the others. I realise you have that in the body of
> > > patch 1, but it's critical information when reviewing this patch...
> > 
> > Ok, I will add in next version.
> > >
> > > >
> > > > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> > > > ---
> > > >  drivers/perf/thunderx2_pmu.c | 248 ++++++++++++++++++++++++++++++-----
> > > >  1 file changed, 214 insertions(+), 34 deletions(-)
> > > >
> > > > diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> > > > index 43d76c85da56..a4e1273eafa3 100644
> > > > --- a/drivers/perf/thunderx2_pmu.c
> > > > +++ b/drivers/perf/thunderx2_pmu.c
> > > > @@ -17,22 +17,31 @@
> > > >   */
> > > >
> > > >  #define TX2_PMU_MAX_COUNTERS         4
> > >
> > > Shouldn't this be 8 now?
> > 
> > It is kept unchanged to 4(as suggested by Will), which is same for
> > both L3 and DMC.
> > For CCPI2 this macro is not used.
> 
> Hmmm....
> 
> I disagree with that suggestion given that this also affects the
> active_counters bitmap size (and thus it is not correctly sized as of
> this patch), and it doesn't really save us much.
> 
> I think it would be better to bump this to 8 and always update the
> events array, even though it will be unused for CCPI2. That's less
> surprising, needs fewer special-cases, and we can use the hrtimer
> function pointer alone to determine if we need to do any hrtimer work.

tbf, my complaint was actually about some macros applying to the whole
PMU whilst others refer only to DMC/L3C and this not being apparent from
the naming:

https://lkml.org/lkml/2019/6/27/250

so I'm fine having TX2_PMU_DMC_L3C_MAX_COUNTERS and
TX2_PMU_CCPI2_MAX_COUNTERS, but that sort of naming needs to be consistent
unless the macro/definition really applies to both. That fed the suggestion
that GET_EVENTID could be generic and switch on the event type internally
instead of at the caller.

Will
