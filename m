Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F8DC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751A2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564683596;
	bh=q+8ENR75Wy6t1l+2MP7lncHhAHQqOj5Ajtb+pAArq+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hsZXxa+gri1LvT1Ag8m4OwnElyIy3cpxNiB9dIgCWPnSJpJ8S+BaGJx2RpS940LB+
	 KImB39rnMvR19Nbca0I+sPC7OpXD32tiudmgAqb4+U2tEgGSaQkrhUuSTDv8SF0Veh
	 B7yOKauM0f4asqnZyZTrrblJ1j3x1ggRVijVE1BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfHASTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfHASTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:19:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6429C20644;
        Thu,  1 Aug 2019 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564683594;
        bh=q+8ENR75Wy6t1l+2MP7lncHhAHQqOj5Ajtb+pAArq+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlM3xjHDnfgu7lCpxFF7/2BzBSM1XM0GtsPJAEmUfWWJJ7gKt0QaaSWHN17Uuk/fq
         2dkuzuyXO0Bd8Twz7KMdE/VurZ/7pDM272K0QTEyne7qnWTy9o9IHGYocVBjUzOY0N
         tjYmdI27Vi8b9ktGRAtYe2yk+mMYtSxiVxZcKFaQ=
Date:   Thu, 1 Aug 2019 20:19:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masoud Sharbiani <msharbiani@apple.com>
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190801181952.GA8425@kroah.com>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:04:14AM -0700, Masoud Sharbiani wrote:
> Hey folks,
> I’ve come across an issue that affects most of 4.19, 4.20 and 5.2 linux-stable kernels that has only been fixed in 5.3-rc1.
> It was introduced by
> 
> 29ef680 memcg, oom: move out_of_memory back to the charge path 
> 
> The gist of it is that if you have a memory control group for a process that repeatedly maps all of the pages of a file with  repeated calls to:
> 
>    mmap(NULL, pages * PAGE_SIZE, PROT_WRITE|PROT_READ, MAP_FILE|MAP_PRIVATE, fd, 0)
> 
> The memory cg eventually runs out of memory, as it should. However,
> prior to the 29ef680 commit, it would kill the running process with
> OOM; After that commit ( and until 5.3-rc1; Haven’t pinpointed the
> exact commit in between 5.2.0 and 5.3-rc1) the offending process goes
> into %100 CPU usage, and doesn’t die (prior behavior) or fail the mmap
> call (which is what happens if one runs the test program with a low
> ulimit -v value).
> 
> Any ideas on how to chase this down further?

Finding the exact patch that fixes this would be great, as then I can
add it to the 4.19 and 5.2 stable kernels (4.20 is long end-of-life, no
idea why you are messing with that one...)

thanks,

greg k-h
