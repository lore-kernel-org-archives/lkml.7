Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346CC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B720644
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFZQmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:42:04 -0400
Received: from foss.arm.com ([217.140.110.172]:36934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZQmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:42:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEB212B;
        Wed, 26 Jun 2019 09:42:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C75D3F706;
        Wed, 26 Jun 2019 09:42:02 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:42:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux@arm.linux.org.uk, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH arm] Use common outgoing-CPU-notification code
Message-ID: <20190626164159.GI20635@lakrids.cambridge.arm.com>
References: <20190611192410.GA27930@linux.ibm.com>
 <20190617115809.GA3767@lakrids.cambridge.arm.com>
 <20190617130657.GL26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617130657.GL26519@linux.ibm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:06:57AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 17, 2019 at 12:58:19PM +0100, Mark Rutland wrote:
> > On Tue, Jun 11, 2019 at 12:24:10PM -0700, Paul E. McKenney wrote:
> > > This commit removes the open-coded CPU-offline notification with new
> > > common code.  In particular, this change avoids calling scheduler code
> > > using RCU from an offline CPU that RCU is ignoring.  This is a minimal
> > > change.  A more intrusive change might invoke the cpu_check_up_prepare()
> > > and cpu_set_state_online() functions at CPU-online time, which would
> > > allow onlining throw an error if the CPU did not go offline properly.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > 
> > FWIW:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > On the assumption that Russell is ok with this, I think this should be
> > dropped into the ARM patch system [1].
> > 
> > Paul, are you familiar with that, or would you prefer that someone else
> > submits the patch there? I can do so if you'd like.
> 
> I never have used this system, so please do drop it in there!  Let me
> know when you have done so, and I will then drop it from -rcu.

After testing that multi_v7_defconfig built, I've just submitted this as
8872/1:

  https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8872/1

Thanks,
Mark.
