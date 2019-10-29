Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D410CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D308220874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572347762;
	bh=PYpYmLCcRCDnvoNd2S0sMHcaEM2JronWu9CsKftbO3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0KbWBzi+tdrr821XHSleGmTFAsifFH5JqAEjVeCVGBjlqGwVULaVsm8WvHYyOSPZt
	 EY7JxkTa3vPs7CnFuHW0jvBuFdDRiHJ2jCL7fGowCm/iVcudS1ViJ2RWRQJMqIteIx
	 hKlq1BLtU4lI5rECky8/W7GQ8jSALfGIfNgYAPYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfJ2LQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2LQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:16:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12913208E3;
        Tue, 29 Oct 2019 11:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572347760;
        bh=PYpYmLCcRCDnvoNd2S0sMHcaEM2JronWu9CsKftbO3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdaMUmmgMjWuXCjwK0dWZlcoWZbdkss1hf/IPKcAItun5DvAeYWYvYEXepIKuV8F4
         Cgj6BmO5LCR5kVQSqH6TeJrA5sMtyubLtUhcJCViQ3HQZ9x8ffrdD48QttQIxJTdvs
         cKuoCU3Lo8JRJ8savTdPFUcs8+VjcCEB/d/GTobo=
Date:   Tue, 29 Oct 2019 11:15:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: fix "hang" when games exit
Message-ID: <20191029111555.GF11590@willie-the-truck>
References: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
 <20191007204906.19571-1-robdclark@gmail.com>
 <20191028222042.GB8532@willie-the-truck>
 <CAJs_Fx7zRWsTPiAg0PFt+8nJPpHpzSkxW6XMMJwozVO6vyB78A@mail.gmail.com>
 <e3fc88d9-4934-0227-d9c7-b1cb37a8811e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fc88d9-4934-0227-d9c7-b1cb37a8811e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:51:53PM +0000, Robin Murphy wrote:
> On 2019-10-28 10:38 pm, Rob Clark wrote:
> > On Mon, Oct 28, 2019 at 3:20 PM Will Deacon <will@kernel.org> wrote:
> > > On Mon, Oct 07, 2019 at 01:49:06PM -0700, Rob Clark wrote:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > > 
> > > > When games, browser, or anything using a lot of GPU buffers exits, there
> > > > can be many hundreds or thousands of buffers to unmap and free.  If the
> > > > GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
> > > > for each buffer, resulting 5-10 seconds worth of reprogramming the
> > > > context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
> > > > To the user it would appear that the system just locked up.
> > > > 
> > > > A simple solution is to use pm_runtime_put_autosuspend() instead, so we
> > > > don't immediately suspend the SMMU device.
> > > 
> > > Please can you reword the subject to be a bit more useful? The commit
> > > message is great, but the subject is a bit like "fix bug in code" to me.
> > 
> > yeah, not the best $subject, but I wasn't quite sure how to fit
> > something better in a reasonable # of chars.. maybe something like:
> > "iommu/arm-smmu: optimize unmap but avoiding toggling runpm state"?
> 
> FWIW, I'd be inclined to frame it as something like "avoid pathological RPM
> behaviour for unmaps".

LGTM!

Will
