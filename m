Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA322068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574368787;
	bh=GbWBSZwXy5//YxtxQhup5maUlZh8jchQMsa14kDzrMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=byWb0+CxemOJBxyku30cPT2HMr0hB9U5tzveudd1NKA81S2qikFzni9pI0kcppI8T
	 HIb2TE7e8JOM/URK405Hx6Iq5MrnCK89BuODXaTAfHzDLLD5Dm5yq5zPNIGmfPdtIJ
	 iN3CcO2oaURcB/KriPRvo/3svC9mGjWoj8qTuPfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKUUjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUUjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:39:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 092F12068D;
        Thu, 21 Nov 2019 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574368784;
        bh=GbWBSZwXy5//YxtxQhup5maUlZh8jchQMsa14kDzrMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tuc6KGOL1LevDc9/W8fpCdLMZoDB4P1MfJtLy0gOHTkQ4aZ9w62ahm7ADjfMnK0Pj
         130bu0jpXGPTZHcbcCWWu9iqfGAyq9bZwhXj/4oX6IkgldabWEDLCUDMvZp/20Vaa9
         Acjk6oodsLxNBlV009yAVMQ4O+NP3vr2B6VYwNuc=
Date:   Thu, 21 Nov 2019 21:39:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: perf: Accommodate big-endian CPU
Message-ID: <20191121203942.GF813260@kroah.com>
References: <20191022140411.10193-1-abrodkin@synopsys.com>
 <20191026131042.73A7E206DD@mail.kernel.org>
 <CY4PR1201MB01208D47B2BEB18DA6E1382AA17E0@CY4PR1201MB0120.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1201MB01208D47B2BEB18DA6E1382AA17E0@CY4PR1201MB0120.namprd12.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 07:52:16PM +0000, Alexey Brodkin wrote:
> Hi Sasha, Greg,
> 
> > -----Original Message-----
> > From: Sasha Levin <sashal@kernel.org>
> > Sent: Saturday, October 26, 2019 4:11 PM
> > To: Sasha Levin <sashal@kernel.org>; Alexey Brodkin <abrodkin@synopsys.com>; linux-snps-
> > arc@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH] ARC: perf: Accommodate big-endian CPU
> > 
> > Hi,
> > 
> > [This is an automated email]
> > 
> > This commit has been processed because it contains a -stable tag.
> > The stable tag indicates that it's relevant for the following trees: all
> > 
> > The bot has tested the following trees: v5.3.7, v4.19.80, v4.14.150, v4.9.197, v4.4.197.
> > 
> > v5.3.7: Build OK!
> > v4.19.80: Failed to apply! Possible dependencies:
> >     0e956150fe09f ("ARC: perf: introduce Kernel PMU events support")
> >     14f81a91ad29a ("ARC: perf: trivial code cleanup")
> >     baf9cc85ba01f ("ARC: perf: move HW events mapping to separate function")
> > v4.14.150: Failed to apply! Possible dependencies:
> > v4.9.197: Failed to apply! Possible dependencies:
> > v4.4.197: Failed to apply! Possible dependencies:
> 
> Indeed the clash is due to
> commit baf9cc85ba01f ("ARC: perf: move HW events mapping to separate function") as tmp variable "j" was changed on "i". So that's a fixed hunk:
> -------------------------------->8------------------------------
> diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
> index 8aec462d90fb..30f66b123541 100644
> --- a/arch/arc/kernel/perf_event.c
> +++ b/arch/arc/kernel/perf_event.c
> @@ -490,8 +490,8 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
>         /* loop thru all available h/w condition indexes */
>         for (j = 0; j < cc_bcr.c; j++) {
>                 write_aux_reg(ARC_REG_CC_INDEX, j);
> -               cc_name.indiv.word0 = read_aux_reg(ARC_REG_CC_NAME0);
> -               cc_name.indiv.word1 = read_aux_reg(ARC_REG_CC_NAME1);
> +               cc_name.indiv.word0 = le32_to_cpu(read_aux_reg(ARC_REG_CC_NAME0));
> +               cc_name.indiv.word1 = le32_to_cpu(read_aux_reg(ARC_REG_CC_NAME1));
> 
>                 /* See if it has been mapped to a perf event_id */
>                 for (i = 0; i < ARRAY_SIZE(arc_pmu_ev_hw_map); i++) {
> -------------------------------->8------------------------------
> 
> Should I send a formal patch with it or it's OK for now?

We need a "formal" patch that we can apply if you want it applied.

thanks,

greg k-h
