Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09016C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05C82082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554299802;
	bh=Uxridx6mLPI72ZCwRUeIg1oCtYd0ZThGlY0eYAaFEcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fuwRPEk0dnqIDirZShF9oGYMh6NIGjCQoxJSDLr9E5ZYe3hTP0svZyuzkjgP2YG7U
	 HtE5uWU3Rxzvb2LAnRnCge0+umd7A/SZcFRZtpnA1kjBpSfijTL9teaQ17loQay/Zp
	 SMa8tm9ptzb76k+Jc8fY/JlPZi4MjK85bavmCVwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDCN4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCN4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:56:41 -0400
Received: from localhost (217-101-180-136.cable.dynamic.v4.ziggo.nl [217.101.180.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112382084B;
        Wed,  3 Apr 2019 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554299800;
        bh=Uxridx6mLPI72ZCwRUeIg1oCtYd0ZThGlY0eYAaFEcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQIgZADDqoxCRLPUGFk1ksqmOcnOLNoIYoDn4uCI0w/QIG/QTLV7GAyqVmR4kn03V
         wKxEGICk6P3Py1dy8JKG5YqTNsuuy8UtKvIzq4N3ls0PVrU0nE0cAgNip3VC3YO+zs
         8d2jA9W3MV9ndg9LKuGG/kq2IcXJGSYdK0NrhE80=
Date:   Wed, 3 Apr 2019 15:56:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4.19 BACKPORT] arm64: debug: Don't propagate UNKNOWN FAR
 into si_code for debug signals
Message-ID: <20190403135638.GA8633@kroah.com>
References: <20190403103408.29209-1-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403103408.29209-1-will.deacon@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:34:08AM +0100, Will Deacon wrote:
> Commit b9a4b9d084d978f80eb9210727c81804588b42ff upstream.
> 
> FAR_EL1 is UNKNOWN for all debug exceptions other than those caused by
> taking a hardware watchpoint. Unfortunately, if a debug handler returns
> a non-zero value, then we will propagate the UNKNOWN FAR value to
> userspace via the si_addr field of the SIGTRAP siginfo_t.
> 
> Instead, let's set si_addr to take on the PC of the faulting instruction,
> which we have available in the current pt_regs.
> 
> Cc: <stable@vger.kernel.org> # 4.19.y
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/mm/fault.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Thanks for all 5 of these patches, now queued up.

greg k-h
