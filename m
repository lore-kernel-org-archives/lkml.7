Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38379C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33D9218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564100528;
	bh=qbBj7OK+JBPLYP01N8KWTpFy7N4FUHl1S5D2xuDD1KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xLD767kJOY0wHYnRYIMW8SIrRuf3hWuXaTJnxT6aC/5g3dWtJgSWexD4FtNKjeZ3e
	 nVsC/JcsBBQbS/s5zTjBRClyAwQrLlMcIs1oAQZnPHr1jy/fh5rptOUIpyJQgZmO4z
	 woSXn2Rt9BMq3kLOKdzgU1MKYRZMJ+O5l3fW9XnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfGZAWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfGZAWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:22:06 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24C1218DA;
        Fri, 26 Jul 2019 00:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564100525;
        bh=qbBj7OK+JBPLYP01N8KWTpFy7N4FUHl1S5D2xuDD1KQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JXUuKhtGgGtb669YOp2QBlD7LmIXEQ/hub49Erq+Aqc6px2gPik+lP5Mhna2fbDsd
         8DaDglRcUJDAE+XHGuLXgtEZjs/EEJ4FAtz/+ZdQGPGGxNrIKNXZDrVEY0FZhPIdIp
         bymJetball5a78cnNGqvFLbWjmZcxo+JR+tG4MBY=
Date:   Thu, 25 Jul 2019 17:22:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2] checkpatch.pl: warn on invalid commit id
Message-Id: <20190725172205.6d5a3b5896e64f88116c0b21@linux-foundation.org>
In-Reply-To: <CAGnkfhxZUw7wUgE6FRetc52HywgwnucZpqcvg3MTUU0M8O158w@mail.gmail.com>
References: <20190711001640.13398-1-mcroce@redhat.com>
        <20190724200707.2ba88e3affd73de1ce64fab6@linux-foundation.org>
        <CAGnkfhxZUw7wUgE6FRetc52HywgwnucZpqcvg3MTUU0M8O158w@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 11:26:04 +0200 Matteo Croce <mcroce@redhat.com> wrote:

> On Thu, Jul 25, 2019 at 5:07 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > What does it do if we're not operating in a git directory? For example,
> > I work in /usr/src/25 and my git repo is in ../git26.
> >
> 
> If .git is not found, the check is disabled

We could permit user to set an environment variable to tell checkpatch
where the kernel git tree resides.

> > Also, what happens relatively often is that someone quotes a linux-next
> > or long-term-stable hash.  If the user has those trees in the git repo,
> > I assume they won't be informed of the inappropriate hash?
> >
> 
> In this case it won't warn, but this should not be a problem, as the
> hash doesn't change following a merge.
> The problem is just if the other tree gets rebased, or if the other
> tree gets never merged, e.g. stable/linux-*

linux-next patches get rebased quite often.  I guess this is acceptable
- failing to warn about an error is better than warning about
not-an-error.

