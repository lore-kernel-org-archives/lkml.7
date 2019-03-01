Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F53D20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbfCARPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:15:22 -0500
Received: from foss.arm.com ([217.140.101.70]:39394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbfCARPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:15:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0254780D;
        Fri,  1 Mar 2019 09:15:22 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E330F3F575;
        Fri,  1 Mar 2019 09:15:19 -0800 (PST)
Date:   Fri, 1 Mar 2019 17:15:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        marc.zyngier@arm.com, suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] arm64: add sysfs vulnerability show for meltdown
Message-ID: <20190301171517.GB130541@arrakis.emea.arm.com>
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-4-jeremy.linton@arm.com>
 <c98ff98e-30e2-596b-39c5-8505ddef9496@foss.arm.com>
 <9cfb9cff-6a26-fff7-9374-82eea0f63a21@arm.com>
 <20190301162050.GB28687@arrakis.emea.arm.com>
 <bd5677d7-a520-c6a4-b97f-d76d48e511a7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd5677d7-a520-c6a4-b97f-d76d48e511a7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:53:50AM -0600, Jeremy Linton wrote:
> On 3/1/19 10:20 AM, Catalin Marinas wrote:
> > On Fri, Mar 01, 2019 at 10:12:09AM -0600, Jeremy Linton wrote:
> > > On 3/1/19 1:11 AM, Andre Przywara wrote:
> > > > On 2/26/19 7:05 PM, Jeremy Linton wrote:
> > > > > +ssize_t cpu_show_meltdown(struct device *dev, struct
> > > > > device_attribute *attr,
> > > > > +        char *buf)
> > > > > +{
> > > > > +    if (arm64_kernel_unmapped_at_el0())
> > > > > +        return sprintf(buf, "Mitigation: KPTI\n");
> > > > > +
> > > > > +    if (__meltdown_safe)
> > > > > +        return sprintf(buf, "Not affected\n");
> > > > 
> > > > Shall those two checks be swapped? So it doesn't report about a KPTI
> > > > mitigation if the CPU is safe, but we enable KPTI because of KASLR
> > > > having enabled it? Or is that a different knob?
> > > 
> > > Hmmm, I think having it this way reflects the fact that the machine is
> > > mitigated independent of whether it needed it. The force on case is similar.
> > > The machine may not have needed the mitigation but it was forced on.
> > 
> > So is this patchset about showing vulnerabilities _and_ mitigations or
> > just one of them?
> 
> Well, I don't think there is a way to express a mitigated but not vulnerable
> state in the current ABI. This set is mostly just to bring us in line with
> the current ABI expectations.

Looking at the ABI doc, it states:

	"Not affected"	  CPU is not affected by the vulnerability
	"Vulnerable"	  CPU is affected and no mitigation in effect
	"Mitigation: $M"  CPU is affected and mitigation $M is in effect

So, yes, we don't have mitigated but not vulnerable. Therefore I think
we should stick to "not affected" and swap the lines above as per
Andre's comment. This file is about Meltdown vulnerability and
mitigation, not KASLR hardening.

-- 
Catalin
