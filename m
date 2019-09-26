Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C967C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0A12146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569538116;
	bh=rZUFsoQvVrC9Thqs802fO93uxeiJR0VRRll9tLwihFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=v9JG/6tqU94CHUvQEBWQ7Ls7v53B2JqolNEiWdp9ndf+1z1utY6JjMn6JUk6zI+lS
	 UXwGbWhXcJ4NXQdtmb786X5e2I+6Ybj3dWts2f3qm1Ql8f442CMhGKk497gv0h6Hba
	 HT1d15iqCMC+YbDwBRQC+xz+0hTHZGQFYQbg8h8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfIZWsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfIZWsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:48:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83DB207FF;
        Thu, 26 Sep 2019 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569538115;
        bh=rZUFsoQvVrC9Thqs802fO93uxeiJR0VRRll9tLwihFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j3nmnooQxycEwo1uKREgSaxDhUb/HNIkhTGY2sQ9DBbbALr/wayasTfVdTMLfPqBr
         xFUQXgVYpYBqRie3+IFJOKiC+MZSpcTChSGyChR50ua98i+36tz12Ft0PG+95AqL0Q
         iYAOxcqtx8MnvSICHVl1FMyilQt03ete43r2IpLQ=
Date:   Thu, 26 Sep 2019 15:48:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Markus Linnala <markus.linnala@gmail.com>, stable@kernel.org,
        Dan Streetman <ddstreet@ieee.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] z3fold: claim page in the beginning of free
Message-Id: <20190926154834.132f40363f5805a7a5cb347a@linux-foundation.org>
In-Reply-To: <20190926104844.4f0c6efa1366b8f5741eaba9@gmail.com>
References: <20190926104844.4f0c6efa1366b8f5741eaba9@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2019 10:48:44 +0200 Vitaly Wool <vitalywool@gmail.com> wrote:

> There's a really hard to reproduce race in z3fold between
> z3fold_free() and z3fold_reclaim_page(). z3fold_reclaim_page()
> can claim the page after z3fold_free() has checked if the page
> was claimed and z3fold_free() will then schedule this page for
> compaction which may in turn lead to random page faults (since
> that page would have been reclaimed by then). Fix that by
> claiming page in the beginning of z3fold_free().
> 

I take it from the email headers that a

Cc: <stable@vger.kernel.org>

was intended?
