Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C1FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD4B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CJ0l6l2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfEPQb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:31:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35844 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEPQbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:31:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so6132149edx.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KqJptEE9UZAQB57XWQVEM7jKvQBAFnzvaSb4s/mzn1A=;
        b=CJ0l6l2Mpk+PKRxV6CC3ospkNQL2odmgD/lDcxZ8Ypb4+nGaeq9AZr/uM46GoXb6lq
         7BBRq+kJs+zgScHkY2rvjTkKeeyp8fh/t+AkjcCB4GZJuSfyL/s78vEQTiXXDGPCyEaY
         JYHAmmPZRE66Ly/g5c+HyJluBcBMQK+MGawapqW6L56uRvBwQ5338afFoM4Lkbx4B7Py
         jqgMVoH/dMGK1buK2nvKcUKOpcnjuw36NM3DzNPC0ToKkzMVEZLGddSYdO0LBWydeGyh
         cpfT3sYt+Wm6BvWnOQfFobv+LSfoX9aFLPSgpBIh47MlcvdMoz1ZMlLtgHxOKzm2Yn+1
         7SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqJptEE9UZAQB57XWQVEM7jKvQBAFnzvaSb4s/mzn1A=;
        b=sMMwFvNiOIGCFHF4AdOCHrvbcCrOnjY/0GKO1AlL+s3tUbcciy2dDAlTBVkmV0DnYw
         b7ZfnsDb9zkdOYGGWYRKgzTE62oVu+hplpokDO9+M4qlRK7TLh3YiYSp+6iA8k15J+Yf
         u9T1r+n2CMIu+1fbePkB9FZxKk7nZ2tIZqGCh1rZ97/9mgDyYDYhoutIREJt6i3gAuz1
         APQ2qzlHnHjspJ4UsPqw2mn+QvKakv8AznCzoyJWORcbCNZ/LLRHrs9m840/cKlwywko
         O+neNTp4xtOy03mrahPht7s7lkXHmmHP00RH4HgBxgVMud1lx42XzdBznmyTehQ+ZuOH
         UYwg==
X-Gm-Message-State: APjAAAXnRMMbFMQbxmgdSAOlkiJnneAxsAOxlRMgtb5MNpxPZcMWZwCx
        f/dicKv8DZjVVaqWGBU387ouWA==
X-Google-Smtp-Source: APXvYqzeTBYoUFYZ1O11TQ3R8+6lmBlsFm9sWwzA+jrLepI59sox5KlO8CBEDHOuAsVjIhkRs9x8PQ==
X-Received: by 2002:a50:e40f:: with SMTP id d15mr52428648edm.0.1558024313833;
        Thu, 16 May 2019 09:31:53 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id r20sm1141196ejj.4.2019.05.16.09.31.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 09:31:53 -0700 (PDT)
Date:   Thu, 16 May 2019 18:31:52 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
Message-ID: <20190516163151.urrmrueugockxtdy@brauner.io>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <20190516162259.GB17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516162259.GB17978@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 05:22:59PM +0100, Al Viro wrote:
> On Thu, May 16, 2019 at 12:52:04PM +0100, David Howells wrote:
> > 
> > Hi Linus, Al,
> > 
> > Here are some patches that make changes to the mount API UAPI and two of
> > them really need applying, before -rc1 - if they're going to be applied at
> > all.
> 
> I'm fine with 2--4, but I'm not convinced that cloexec-by-default crusade
> makes any sense.  Could somebody give coherent arguments in favour of
> abandoning the existing conventions?

So as I said in the commit message. From a userspace perspective it's
more of an issue if one accidently leaks an fd to a task during exec.

Also, most of the time one does not want to inherit an fd during an
exec. It is a hazzle to always have to specify an extra flag.

As Al pointed out to me open() semantics are not going anywhere. Sure,
no argument there at all.
But the idea of making fds cloexec by default is only targeted at fds
that come from separate syscalls. fsopen(), open_tree_clone(), etc. they
all return fds independent of open() so it's really easy to have them
cloexec by default without regressing anyone and we also remove the need
for a bunch of separate flags for each syscall to turn them into
cloexec-fds. I mean, those for syscalls came with 4 separate flags to be
able to specify that the returned fd should be made cloexec. The other
way around, cloexec by default, fcntl() to remove the cloexec bit is way
saner imho.

Christian
