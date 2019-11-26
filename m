Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0492C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61E4207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574762863;
	bh=zkccDc+FupovoQnUaEh1hmu/xJpNTXvuPbxVexrO9d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1LNIjvXypwT6fmasC5cVjEyLYP/Rt/AXkIVaUGmmMf5GuWEaMsRs6KNelB+I/H93Q
	 D6Ppf0kOPCFcthbZ53XhX2BzJhWftV8cSx4HK+vgzaq7IAmZGmW0e9F/nEPqfQg0v3
	 YturK8EQnfhG/ERqd5x46UBM2MPyS+srlhYlXLQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfKZKHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbfKZKHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:07:42 -0500
Received: from localhost (unknown [84.241.194.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05CEC206BF;
        Tue, 26 Nov 2019 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574762861;
        bh=zkccDc+FupovoQnUaEh1hmu/xJpNTXvuPbxVexrO9d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/kxRbCKAiSjvsh6cjc9PY2YUmqC8mQrpzLqfJzgTN+Z8D0Zcs08ehlV3b0RaclUE
         nAlUvBsJVLZB+RVGf/pt348aB8VGJoHHFbDwmLxf1uS6NbGMJmgD778oYcrpxITgHs
         Bwl/S3SCXeBsTudFIZxhQxdAHLyR985vldRc+M54=
Date:   Tue, 26 Nov 2019 11:07:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: "statsfs" API design
Message-ID: <20191126100737.GA1416107@kroah.com>
References: <20191109184441.GA5092@avx2>
 <20191110091435.GC1435668@kroah.com>
 <20191110153424.GA5141@avx2>
 <9fe3a096-20b9-979a-d4d7-48a37b059dff@redhat.com>
 <20191111204032.GA14256@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111204032.GA14256@avx2>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:40:32PM +0300, Alexey Dobriyan wrote:
> On Sun, Nov 10, 2019 at 09:58:14PM +0100, Paolo Bonzini wrote:
> > On 10/11/19 16:34, Alexey Dobriyan wrote:
> > > In the other direction: describe every field of /proc/*/stat file
> > > without looking to the manpage:
> > > 
> > > $ cat /proc/self/stat
> > > 5349 (cat) R 5342 5349 5342 34826 5349 4210688 91 0 0 0 0 0 0 0 20 0 1 0 864988 9183232 184 18446744073709551615 94352028622848 94352028651936 140733810522864 0 0 0 0 0 0 0 0 0 17 5 0 0 0 0 0 94352030751824 94352030753376 94352060055552 140733810527527 140733810527547 140733810527547 140733810532335 0
> > 
> > That's why this is not what I am proposing, and also not what Greg has
> > mentioned.
> 
> The argument was that text is somehow superior to binary. Experiment shows
> that userspace can make a mess of both modes therefore preferring one
> to another should be based on something else (preferably objective).

No, that was NOT what my argument was.

My argument is that you have to have self-describing data somehow,
otherwise you will always get out of sync with what the kernel is
exporting and what userspace expects.  The above crazy procfs example
proves my point very well :)

sysfs "solves" this problem by requiring one value per file.  If the
file is not present, userspace "knows" that the value isn't there at
all.  It a simple solution for the problem that procfs has with multiple
values in single files and is why we did it that way.

Now that's not to say this is the only way to solve the issue here, it's
just the one that we decided to use at the time.  statfs can choose to
do it differently, but it can NOT just ignore the problem here,
otherwise we end up with the old procfs problems as you show above.

> /proc have these two problems:
> First, noticeably slow:
> 
> 	https://news.ycombinator.com/item?id=21414882

Yes, opening thousands of files is "slow", that's known :)

> Second, overinstantiating inodes and dentries:
> 
> 	https://lore.kernel.org/lkml/20180424022106.16952-1-jeffm@suse.com/

Exporting hundreds of thousands of files, what could go wrong? :)

> statfs maybe never get to that level but it is not hard to see what lies
> at the end of the tunnel.

Those are nice things to think about while doing this, but I think we
are a long ways off from these types of issues.

thanks,

greg k-h
