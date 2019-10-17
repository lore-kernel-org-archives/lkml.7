Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E2EFA3732
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1FC20869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408492AbfJQJ04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:26:56 -0400
Received: from [217.140.110.172] ([217.140.110.172]:36650 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1732676AbfJQJ0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:26:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A3D1993;
        Thu, 17 Oct 2019 02:26:30 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D84F3F718;
        Thu, 17 Oct 2019 02:26:30 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:26:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191017092628.GD8978@bogus>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-3-sudeep.holla@arm.com>
 <20191017023936.vgkdfnyaz3r4k74z@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017023936.vgkdfnyaz3r4k74z@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 08:09:36AM +0530, Viresh Kumar wrote:
> On 16-10-19, 12:03, Sudeep Holla wrote:
> > arm_big_little cpufreq driver was designed as a generic big little
> > driver that could be used by any platform and make use of bL switcher.
> > Over years alternate solutions have be designed and merged to deal with
> > bL/HMP systems like EAS.
> >
> > Also since no other driver made use of generic arm_big_little cpufreq
> > driver except Vexpress SPC, we can merge them together as vexpress-spc
> > driver used only on Vexpress TC2(CA15_CA7) platform.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  MAINTAINERS                            |   5 +-
> >  drivers/cpufreq/Kconfig.arm            |  12 +-
> >  drivers/cpufreq/Makefile               |   2 -
> >  drivers/cpufreq/arm_big_little.c       | 658 ------------------------
> >  drivers/cpufreq/arm_big_little.h       |  43 --
> >  drivers/cpufreq/vexpress-spc-cpufreq.c | 661 ++++++++++++++++++++++++-
> >  6 files changed, 652 insertions(+), 729 deletions(-)
> >  delete mode 100644 drivers/cpufreq/arm_big_little.c
> >  delete mode 100644 drivers/cpufreq/arm_big_little.h
>
> The delta produced here is enormous probably because you copy/pasted things. I
> am wondering if using git mv to rename arm_big_little.c and then move spc bits
> into it will make this delta smaller to review ?
>

Yes, I did a quick try but slightly different order. As I need the final
driver to be vexpress-spc-cpufreq.c, I am thinking of first merging
vexpress-spc-cpufreq.c into arm_big_little.c and then renaming it back
later. Does that sound good ?

drivers/cpufreq/arm_big_little.c       | 78 ++++++++++++++++++++------
drivers/cpufreq/arm_big_little.h       | 43 --------------
drivers/cpufreq/vexpress-spc-cpufreq.c | 71 -----------------------
6 files changed, 68 insertions(+), 145 deletions(-)
delete mode 100644 drivers/cpufreq/arm_big_little.h
delete mode 100644 drivers/cpufreq/vexpress-spc-cpufreq.c

If we first rename arm_big_little.c, then we need change the final name
otherwise we end up with same delta as the new name file will be merged
into vexpress-spc-cpufreq.c

--
Regards,
Sudeep
