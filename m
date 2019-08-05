Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C868C214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565036331;
	bh=pRLkhlS1bIfbTqQwY8PiDF9HnJcn2wazvkc3C6n7Eyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0k6cwUdkncZOrd4v6d6NKeQrfXpSAKanoiMsxmvtLddvREI4XSaka6CdFsfgyKD3T
	 vpDmBgPWNGOMJP39jfZRbUrG0DUrNDKJVd95HZhJYdjYQ+gND4DhQqJ55C9X5eEoAU
	 ShHTLj2hKAyYtk9xOU0ZLXAUYjZbLwMWoKWtXG2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfHEUSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfHEUSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:18:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DE520C01;
        Mon,  5 Aug 2019 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565036329;
        bh=pRLkhlS1bIfbTqQwY8PiDF9HnJcn2wazvkc3C6n7Eyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maijMol2GFjxuAcla8iNE9/Kt0UoL0FRBdXdMVirjWp7FNXwH7hBasdELw5rtfnOY
         aYeTQ3GmRDyK+RWN+0nh/LOSXJqjLpThs+2PiyPpx2Gq+BnrhIWDPIa7H6DSjgwGAD
         59IfsJfxnyB86nL24j7yj5JfnAWk+0A+aPC7XH9A=
Date:   Mon, 5 Aug 2019 22:18:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jariruusu@users.sourceforge.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4.9 00/42] 4.9.188-stable review
Message-ID: <20190805201847.GA31714@kroah.com>
References: <20190805124924.788666484@linuxfoundation.org>
 <5D488D55.B84FC098@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D488D55.B84FC098@users.sourceforge.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:11:01PM +0300, Jari Ruusu wrote:
> Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.188 release.
> 
> Peter Zijlstra's "x86/atomic: Fix smp_mb__{before,after}_atomic()"
> upstream commit 69d927bba39517d0980462efc051875b7f4db185 seems to
> be missing/lost from 4.9 and older stable kernels.
> 
> That patch has 10 hunks, first one of those does not apply cleanly to
> 4.9 kernel because it attempts to modify Documentation/atomic_t.txt
> file which does not exist in older kernels. Other 9 hunks apply with
> small offsets and fuzz, but modifications find their correct places anyway.
> Those other 9 hunks are the important ones, first hunk can be ignored.
> 
> Greg,
> Please take Peter Zijlstra's original patch and "force" apply it like this
> to 4.9 kernels:
> 
>   patch -p1 -f <ORIGINAL.patch
> 
> and for 4.4 kernels like this:
> 
>   cat ORIGINAL.patch | sed -e 's/__smp_mb__/smp_mb__/' | patch -p1 -f -l

Can you send properly backported and tested patches?

thanks,

greg k-h
