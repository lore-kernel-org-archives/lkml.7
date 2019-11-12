Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA814C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25D21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573537269;
	bh=SO9uoJYo2XebAwnIuAyl62dyNLULb9df4t2DlUDP9aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D6bn6z+1v7Fe5VAq65d8wFp7elKtcEcfah7Zdy1vcK5/l1AxXIKFxQAtqh9UMm9Hv
	 FVtTDU1lDCbbxSbo7lVcPLNt1yz9TQ9nxQ7CbzMQdUz5d+QaWIA7JZ0eDWP3lsC27G
	 US5ojPsWAbQDULz/TFYhvmcdrdsQ4LW9/xPVFapc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKLFlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfKLFlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:41:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6B32084F;
        Tue, 12 Nov 2019 05:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573537267;
        bh=SO9uoJYo2XebAwnIuAyl62dyNLULb9df4t2DlUDP9aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4DW+gaJVnWYgf7pOhohTsD1sgJ0cYiJTEHKudfm4zTGfvfmp3MwtHOFVUUFhwNyG
         HdNgOF+/aR+5G/MnKE6zjT2DzD6gV2p9uGUmDTKnWmwyvn7yVjx0NRd0aHfQF/TbB5
         Dt4MkUtt7UIHal07uyjLM4g9YwnqtJ3X4s0aAai8=
Date:   Tue, 12 Nov 2019 06:41:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, stable@kernel.org,
        Chris.Paterson2@renesas.com
Subject: Re: patch in 4.4.201-rc1 breaks build (mm, meminit: recalculate pcpu
 batch and high limits after init completes)
Message-ID: <20191112054104.GA1211223@kroah.com>
References: <20191111132451.GA1208@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111132451.GA1208@duo.ucw.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 02:24:52PM +0100, Pavel Machek wrote:
> Hi!
> 
> This seems to break our build with particular
> .config. (cip-kernel-config/4.4.y-cip/arm/moxa_mxc_defconfig).
> 
> commit df82285ab4b974f2040f31dbabdd11e055a282c2
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Tue Nov 5 21:16:27 2019 -0800
> 
>     mm, meminit: recalculate pcpu batch and high limits after init completes
>     
>     commit 3e8fc0075e24338b1117cdff6a79477427b8dbed upstream.
> 
> 
> 
> Quoting Chris Peterson:
> 
> > I've seen a failure this morning with our linux stable-rc build
> > testing.
> 
> > Version: 4cb9b88c651a2fff886dd64b6d797343e7ddb4dd Linux 4.4.201-rc1
> > Arch: arm
> > Config: moxa_mxc_defconfig
> 
> > Pipeline: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/95016985
> > Failure: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/95016985/failures
> > Log: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
> > Config: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
> 
> > All other configurations that we build were successful.

Sorry, my fault, should now be fixed.

thanks,

greg k-h
