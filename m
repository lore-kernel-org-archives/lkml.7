Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBCDC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375ED22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfHTJtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:49:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbfHTJtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:49:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 642362F3670;
        Tue, 20 Aug 2019 09:49:08 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 787376092F;
        Tue, 20 Aug 2019 09:49:06 +0000 (UTC)
Date:   Tue, 20 Aug 2019 11:49:03 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Hubert Feurstein <h.feurstein@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 2/4] net: mdio: add PTP offset compensation
 to mdiobus_write_sts
Message-ID: <20190820094903.GI891@localhost>
References: <20190820084833.6019-1-hubert.feurstein@vahle.at>
 <20190820084833.6019-3-hubert.feurstein@vahle.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820084833.6019-3-hubert.feurstein@vahle.at>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 20 Aug 2019 09:49:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:48:31AM +0200, Hubert Feurstein wrote:

> +	/* PTP offset compensation:
> +	 * After the MDIO access is completed (from the chip perspective), the
> +	 * switch chip will snapshot the PHC timestamp. To make sure our system
> +	 * timestamp corresponds to the PHC timestamp, we have to add the
> +	 * duration of this MDIO access to sts->post_ts. Linuxptp's phc2sys
> +	 * takes the average of pre_ts and post_ts to calculate the final
> +	 * system timestamp. With this in mind, we have to add ptp_sts_offset
> +	 * twice to post_ts, in order to not introduce an constant time offset.
> +	 */
> +	if (sts)
> +		timespec64_add_ns(&sts->post_ts, 2 * bus->ptp_sts_offset);

This correction looks good to me.

Is the MDIO write delay constant in reality, or does it at least have
an upper bound? That is, is it always true that the post_ts timestamp
does not point to a time before the PHC timestamp was actually taken?

This is important to not break the estimation of maximum error in the
measured offset. Applications using the ioctl may assume that the
maximum error is (post_ts-pre_ts)/2 (i.e. half of the delay printed by
phc2sys). That would not work if the delay could be occasionally 50
microseconds for instance, i.e. the post_ts timestamp would be earlier
than the PHC timestamp.

-- 
Miroslav Lichvar
