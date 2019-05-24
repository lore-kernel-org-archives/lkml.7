Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D207FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECFB217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558668926;
	bh=GbrlHKi71gaVsN79M3+9tkZQr3yHgBtNIIbYV9ulLS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H8SCZ+4SkoukN3tFss73b7oiE98s8XYrjUU2NllPArGiI0LQHGvrcOQKAO7Mz0fo3
	 pBXjJC4V9aHcoimatCUF4nnSmWympenmcxd4EP1CY7l3xeGlp9QvfeyknHTWFjvmmO
	 wCmzynFXLwEp9YbcOogHLUG7HAGY/igz6dgx85nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfEXDfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387559AbfEXDfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:35:25 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F32F42133D;
        Fri, 24 May 2019 03:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558668924;
        bh=GbrlHKi71gaVsN79M3+9tkZQr3yHgBtNIIbYV9ulLS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jDvnv6tpy2BH/IrlaiJ8KlyFoOOljEmmW5ldVVIqoKOdBfDVA5/5n+eWzf29LjIXF
         /C/g7IqdobNb0zQtemFkAjy7UP66ezdDoX+0GHtiIQL5BiEWE/VEBErHnmXjuBSaze
         b2uGxIwsCPkUNuxboZF+aIC0bPy92DqHazUsWteY=
Date:   Thu, 23 May 2019 20:35:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     rppt@linux.ibm.com, david.engraf@sysgo.com, steven.price@arm.com,
        osandov@fb.com, luc.vanoostenryck@gmail.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] initramfs: Fix a missing-chek bug in dir_add()
Message-Id: <20190523203523.8f638f378b54df0ef7a18f9d@linux-foundation.org>
In-Reply-To: <20190524033045.GA6628@zhanggen-UX430UQ>
References: <20190524033045.GA6628@zhanggen-UX430UQ>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 11:30:45 +0800 Gen Zhang <blackgod016574@gmail.com> wrote:

> In dir_add() and do_name(), de->name and vcollected are allocated by
> kstrdup(). And de->name and vcollected are dereferenced in the following
> codes. However, memory allocation functions such as kstrdup() may fail. 
> Dereferencing this null pointer may cause the kernel go wrong. Thus we
> should check these two kstrdup() operations.
> Further, if kstrdup() returns NULL, we should free de in dir_add().

We generally assume that memory allocations within __init code cannot
fail.  If one does fail, something quite horrid has happened.  The
resulting oops will provide the same information as the proposed panic()
anyway.
