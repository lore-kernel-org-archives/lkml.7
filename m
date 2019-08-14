Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A0C205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfHNI4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:56:02 -0400
Received: from 8bytes.org ([81.169.241.247]:49216 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfHNI4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:56:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2F9242E2; Wed, 14 Aug 2019 10:55:59 +0200 (CEST)
Date:   Wed, 14 Aug 2019 10:55:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge
 systems
Message-ID: <20190814085557.GB24321@8bytes.org>
References: <20190808101707.16783-1-kai.heng.feng@canonical.com>
 <20190809153931.GG12930@8bytes.org>
 <9CDD544D-DE4C-4AC6-B0DC-CD30C99EA71C@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9CDD544D-DE4C-4AC6-B0DC-CD30C99EA71C@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:58:48AM +0800, Kai-Heng Feng wrote:
> at 23:39, Joerg Roedel <joro@8bytes.org> wrote:
> 
> > On Thu, Aug 08, 2019 at 06:17:07PM +0800, Kai-Heng Feng wrote:
> > > Raven Ridge systems may have malfunction touchpad or hang at boot if
> > > incorrect IVRS IOAPIC is provided by BIOS.
> > > 
> > > Users already found correct "ivrs_ioapic=" values, let's put them inside
> > > kernel to workaround buggy BIOS.
> > 
> > Will that still work when a fixed BIOS for these laptops is released?
> 
> Do you mean that we should stop applying these quirks once a BIOS fix is
> confirmed?

My concern is just that these quirks break some systems that don't need
them.

> We can modify the quirk to compare BIOS version, if there’s an unlikely BIOS
> update really fixes the issue.
> Before that happens, I think it’s OK to let the quirks stay this way.

A BIOS version check is not making things better here as it might lock
out systems that need the quirk. I think we can leave it as it for now,
but can you create a new file amd_iommu_quirks.c and move the code
there. And in the struct and function names please make clear that it is
about ivrs-quirks.


Regards,

	Joerg
