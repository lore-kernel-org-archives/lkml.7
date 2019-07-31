Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57895C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CCF208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfGaQuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:50:13 -0400
Received: from foss.arm.com ([217.140.110.172]:51590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfGaQuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:50:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EEE3337;
        Wed, 31 Jul 2019 09:50:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D8EA3F71F;
        Wed, 31 Jul 2019 09:50:09 -0700 (PDT)
Date:   Wed, 31 Jul 2019 17:50:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [RFC v2 0/8] arm64: MMU enabled kexec relocation
Message-ID: <20190731165007.GJ39768@lakrids.cambridge.arm.com>
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
 <20190731163258.GH39768@lakrids.cambridge.arm.com>
 <CA+CK2bAYUFBBGo-LHBK4UWRK1tpx3AZ4Z9NkDxiDK0UYEDozaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAYUFBBGo-LHBK4UWRK1tpx3AZ4Z9NkDxiDK0UYEDozaQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:40:51PM -0400, Pavel Tatashin wrote:
> On Wed, Jul 31, 2019 at 12:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Pavel,
> >
> > Generally, the cover letter should state up-front what the goal is (or
> > what problem you're trying to solve). It would be really helpful to have
> > that so that we understand what you're trying to achieve, and why.

[...]

> > > Here is the current data from the real hardware:
> > > (because of bug, I forced EL1 mode by setting el2_switch always to zero in
> > > cpu_soft_restart()):
> > >
> > > For this experiment, the size of kernel plus initramfs is 25M. If initramfs
> > > was larger, than the improvements would be even greater, as time spent in
> > > relocation is proportional to the size of relocation.
> > >
> > > Previously:
> > > kernel shutdown       0.022131328s
> > > relocation    0.440510736s
> > > kernel startup        0.294706768s
> >
> > In total this takes ~0.76s...
> >
> > >
> > > Relocation was taking: 58.2% of reboot time
> > >
> > > Now:
> > > kernel shutdown       0.032066576s
> > > relocation    0.022158152s
> > > kernel startup        0.296055880s
> >
> > ... and this takes ~0.35s
> >
> > So do we really need this complexity for a few blinks of an eye?
> 
> Yes, we have an extremely tight reboot budget, 0.35s is not an acceptable waste.

Could you please elaborate on your use-case?

Understanfin what you're trying to achieve would help us to understand
which solutions make sense.

Thanks,
Mark.
