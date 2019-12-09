Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1204FC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1C6207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575887678;
	bh=J+F+a3mv9evZz/xMVs7tWTVa5ygDM4L/pYf6W5zxScI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k+gCgRvRmv9hz8iD23qsFGinhro3EXViy78M7o1defLsPzqhtuiEM2Yw+1SO2Sia0
	 0MBc5NpJwTKplzAf0D0WGp1vw4WG9pQkASmfRpQQNWCHY5BloHaqMDCtxjsd+Vkfsn
	 icxKddYGEBt9WZ2Fz21Y1ZipUcDcp21LDkHu7zdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLIKeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbfLIKeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:34:37 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD7B2077B;
        Mon,  9 Dec 2019 10:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575887676;
        bh=J+F+a3mv9evZz/xMVs7tWTVa5ygDM4L/pYf6W5zxScI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z6OjGbvd5UndR5pdeV8AyJbhe2sMngS6qmECGpWC5XD3b7hnQaGnElOEXo/4w+1nO
         n7cbbH1Mdno3rxiEtsD5vlTDN0+rgTIVFVD4yEHLXLgepQK9FGUEYFl8p1PMkIVw+S
         TH3oUBrtbr8AWct+gZFynCsmyBciAWz3/Gp+ac+U=
Date:   Mon, 9 Dec 2019 10:34:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Jeffrin Jose <jeffrin@rajagiritech.edu.in>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Subject: Re: [PROBLEM]:  WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191209103432.GC3306@willie-the-truck>
References: <20191207173420.GA5280@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207173420.GA5280@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[expanding cc list]

On Sat, Dec 07, 2019 at 11:04:20PM +0530, Jeffrin Jose wrote:
> i got the following  output related from typical dmesg output from 5.4.1 kernel

Was this during boot or during some other operation?

> ================================================
> WARNING: lock held when returning to user space!
> 5.4.1 #16 Tainted: G            E    
> ------------------------------------------------
> tpm2-abrmd/691 is leaving the kernel with locks still held!
> 2 locks held by tpm2-abrmd/691:
>  #0: ffff8881ee784ba8 (&chip->ops_sem){.+.+}, at: tpm_try_get_ops+0x2b/0xc0 [tpm]
>  #1: ffff8881ee784d88 (&chip->tpm_mutex){+.+.}, at: tpm_try_get_ops+0x57/0xc0 [tpm]

Can you reproduce this failure on v5.5-rc1?

Thanks,

Will
