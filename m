Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDEEC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D18A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560191437;
	bh=ohK4n4b1EpBzFuYCAPxK1UhSnRZ6JiT2DsSBhq0Kuec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vn1a2Vshfc82DXbkG+HajzZ3k4bgBDepSi+nW3gxzB5FkxmUN5RfrQsS2JPBTVYQj
	 CGx68qe561W/WxC0NI8nEtPIwhnWty8gRFm6JC1VBIPW9hYbFhqmn5vZh+qvqyvRGt
	 xTymewvk4y9gvHZNcrbnNcaJVK6sbzt76KUcDIWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfFJSaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387425AbfFJSae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:30:34 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0570D2082E;
        Mon, 10 Jun 2019 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560191434;
        bh=ohK4n4b1EpBzFuYCAPxK1UhSnRZ6JiT2DsSBhq0Kuec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jV6eylv2gneDFF28UAnW0Bl5g/y+cDC7sNrwqd9k01Zh3l57SQM9oA2oeMbq3B4Ue
         qmByOcsZd7IJiV9Tp4/RTv2yrB7z7NnJwLFAswEvrKqfhD/3AwnWkJx/09oR1eEwkY
         7NJ1Its8t1y+v+W2XHpMTyIIQRQ52ngBiyqb4Kdg=
Date:   Mon, 10 Jun 2019 11:30:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: "Dentry still in use" splats in v5.2-rc3
Message-ID: <20190610183031.GE63833@gmail.com>
References: <20190605135401.GB30925@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605135401.GB30925@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 02:54:01PM +0100, Mark Rutland wrote:
> Hi All,
> 
> While fuzzing arm64 v5.2-rc3, Syzkaller started hitting splats of the
> form:
> 
>     BUG: Dentry (____ptrval____){i=1,n=/}  still in use (2) [unmount of bpf bpf]
> 
> ... which I can reliably reproduce with the following C program
> (partially minimized from what Syzkaller auto-generated).
> 
> It looks like any filesystem will do. I've seen splats with "bpf",
> "hugetlbfs", "rpc_pipefs", and "tmpfs", and can reproduce the problem
> with any of these.
> 
> Any ideas?
> 
> I'm using the config from my fuzzing/5.2-rc3 branch on kernel.org [1].
> 
> Thanks,
> Mark.
> 
> ----
> #include <unistd.h>
> #include <sys/syscall.h>
> 
> /*
>  * NOTE: these are the arm64 numbers
>  */
> #ifndef __NR_fsconfig
> #define __NR_fsconfig 431
> #endif
> #ifndef __NR_fsmount
> #define __NR_fsmount 432
> #endif
> #ifndef __NR_fsopen
> #define __NR_fsopen 430
> #endif
> 
> int main(void)
> {
>         int fs, mnt;
> 
>         fs = syscall(__NR_fsopen, "bpf", 0);
>         syscall(__NR_fsconfig, fs, 6, 0, 0, 0);
>         mnt = syscall(__NR_fsmount, fs, 0, 0);
>         fchdir(mnt);
> 
>         close(fs);
>         close(mnt);
> }
> 

David and Al, is sys_fsmount() missing a call to mntget()?

- Eric
