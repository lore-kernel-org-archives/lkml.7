Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A5EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71261214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfHTOZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:25:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbfHTOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:25:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E77F7EB8A;
        Tue, 20 Aug 2019 14:25:42 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71D5187A1;
        Tue, 20 Aug 2019 14:25:40 +0000 (UTC)
Date:   Tue, 20 Aug 2019 16:25:37 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Hubert Feurstein <h.feurstein@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 2/4] net: mdio: add PTP offset compensation
 to mdiobus_write_sts
Message-ID: <20190820142537.GL891@localhost>
References: <20190820084833.6019-1-hubert.feurstein@vahle.at>
 <20190820084833.6019-3-hubert.feurstein@vahle.at>
 <20190820094903.GI891@localhost>
 <CAFfN3gW-4avfnrV7t-2nC+cVt3sgMD33L44P4PGU-MCAtuR+XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFfN3gW-4avfnrV7t-2nC+cVt3sgMD33L44P4PGU-MCAtuR+XA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 20 Aug 2019 14:25:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 02:29:27PM +0200, Hubert Feurstein wrote:
> Am Di., 20. Aug. 2019 um 11:49 Uhr schrieb Miroslav Lichvar
> > This is important to not break the estimation of maximum error in the
> > measured offset. Applications using the ioctl may assume that the
> > maximum error is (post_ts-pre_ts)/2 (i.e. half of the delay printed by
> > phc2sys). That would not work if the delay could be occasionally 50
> > microseconds for instance, i.e. the post_ts timestamp would be earlier
> > than the PHC timestamp.
> >
> If the timestamps are taken in the MDIO driver (imx-fec in my case), then
> everything is quite deterministic (see results in the cover letter). Of course,
> it still can be improved slightly, by splitting up the writel into iowmb and
> write_relaxed and disable the interrupts while capturing the timestamps
> (as I did in my original RFC patch). But phc2sys takes by default 5 measurements
> and uses the one with the smallest delay, so this shouldn't be necessary.

The delay that phc2sys sees is the difference between post_ts and
pre_ts, which doesn't contain the actual delay, right? So, I'm not
sure how well the phc2sys filtering actually works. Even if the
measured delay was related to the write delay, would be 5 measurements
always enough to get a "correct" sample?

> Although, by adding 2 * ptp_sts_offset the system timestamp to post_ts
> the timestamp is aligned with the PHC timestamp, but this also increases
> the delay which is reported by phc2sys (~26us). But the maximum error
> which must be expected is definitely much less (< 1us). So maybe it is better
> to shift both timestamps pre_ts and post_ts by ptp_sts_offset.

If you could guarantee that [pre_ts + ptp_sts_offset, post_ts +
ptp_sts_offset] always contains the PHC timestamps, then that would be
great. From what Andrew is writing, this doesn't seem to be the case.

I'd suggest a different approach:
- specify a minimum delay for the write and a minimum delay for the
  completion (if they are not equal)
- take a second "post" system timestamp after the completion
- adjust pre_ts and post_ts so that the middle point is equal to what
  you have now, but the interval contains both
  pre_ts + min_write_delay and post2_ts - min_completion_delay

This way you get the best stability and also a delay that correctly
estimates the maximum error.

-- 
Miroslav Lichvar
