Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D834C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFEE21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gPGWsWd3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OwqJ9D6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390141AbfIIWtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:49:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfIIWtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:49:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2AA706063A; Mon,  9 Sep 2019 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568069360;
        bh=hyrKwj9FsNnKEJJvZNmfObjHJ2EoQlnM3HeyUSqoDcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gPGWsWd3lc9D17F205jQhOCzR+NuoRJyBrFOS19ItKyteJGkuCiDTgkuJx7LtC+Fs
         zXznvnBlst9XR/VFe2CEpCMDEc5zpU1lOKhnPvTYNmPLw5/pE+23aGqL/liRTQPQc/
         2LJZnK+LnVq3CLCbvlp05awQglVeZSPXE+SgOKaE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C7684602BC;
        Mon,  9 Sep 2019 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568069359;
        bh=hyrKwj9FsNnKEJJvZNmfObjHJ2EoQlnM3HeyUSqoDcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OwqJ9D6JwHj0MYzLLI+aQnUIsoAD386KwWnmAUCAUaV0PO0rPeu3Pcp80AtkEPd6a
         aeMxwNPjB7Cdp2KM+20kSHiY3AaQnO92CDny58tPFx/yEc/IkSN7x5KpN644XOC08l
         6uVkXpdieIw/lvRKRszrBv1Rb1atuYrny4WduQVM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Sep 2019 15:49:19 -0700
From:   rishabhb@codeaurora.org
To:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tsoni@codeaurora.org, psodagud@codeaurora.org,
        jshriram@codeaurora.org
Subject: Re: Bug at kernel/cred.c +443
In-Reply-To: <083b3f61efeca1d73839ac96e396748e@codeaurora.org>
References: <083b3f61efeca1d73839ac96e396748e@codeaurora.org>
Message-ID: <7e14f9c6fa089da67ebc28d7048c369a@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-09 15:47, rishabhb@codeaurora.org wrote:
> Hi Miklos
> 
> In 4.19 kernel when we write to a file that doesn't exist we see the
> following stack:
> [  377.382745]  ovl_create_or_link+0xac/0x710
> [  377.382745]  ovl_create_object+0xb8/0x110
> [  377.382745]  ovl_create+0x34/0x40
> [  377.382745]  path_openat+0xd44/0x15a8
> [  377.382745]  do_filp_open+0x80/0x128
> [  377.382745]  do_sys_open+0x140/0x250
> [  377.382745]  __arm64_sys_openat+0x2c/0x38
> 
> If the override_cred flag = off, the ovl_override_cred and
> ovl_revert_cred just returns NULL.
> But there is another override_cred in between these two functions;
> 		put_cred(override_creds(override_cred));
> 		put_cred(override_cred);
> 
> This will override the credentials permanently as there is no
> corresponding revert_cred associated.
> So whenever we do commit_creds for this task, we see a BUG_ON at
> kernel/cred.c +443.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/cred.c#n443
> 
> Should this override_cred be changed to ovl_override_cred to maintain
> consistency and avoid this
> BUG_ON?
> 
> 
> Thanks,
> Rishabh

Corrected line number in the subject.
