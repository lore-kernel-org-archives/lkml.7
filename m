Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5509ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA921835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328080;
	bh=hW6huek/OCNo03LBsH5IaDKCEp+GDUUB0WU02dwM/i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z6y/jbIRMO51LCXPItnpEVa1lmUgrhKQbCqEyyfpvXHmVt4P2g3GsLKADT6vyGYO7
	 iedvCYpDMcrmd8gzQXpqpuRClOBL6lmUamisCShQM0cMdJlrDvqQOCJD8bRmJTPtmO
	 gfZDYtITnwJyxuXCWNIo9NM9aeZM0DO4TNH3eo0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439513AbfJQQBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436580AbfJQQBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:01:18 -0400
Received: from localhost (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A39620872;
        Thu, 17 Oct 2019 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328078;
        bh=hW6huek/OCNo03LBsH5IaDKCEp+GDUUB0WU02dwM/i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fU38KlaRL7+XxryfBW2q/qTk9vRR7R2oGrGGuM+F4hhU4Rp48QFtSbl+PgEnSVz8a
         p10R9pwGqbyRa2y8tCIzQ5ZYTi8TSEEBxUQlcElVRzIKp/TWQNkkLrvLSV51NbNNA2
         0jG6bjMZ5/WakDxSy+bm3uFQIk/nH+RQNWhvkYiM=
Date:   Thu, 17 Oct 2019 09:01:17 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dave Wysochanski <dwysocha@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 4.19 62/81] cifs: use cifsInodeInfo->open_file_lock while
 iterating to avoid a panic
Message-ID: <20191017160117.GA1083277@kroah.com>
References: <20191016214805.727399379@linuxfoundation.org>
 <20191016214843.979454273@linuxfoundation.org>
 <20191017085538.GA5847@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017085538.GA5847@amd>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:55:39AM +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Dave Wysochanski <dwysocha@redhat.com>
> > 
> > Commit 487317c99477 ("cifs: add spinlock for the openFileList to
> > cifsInodeInfo") added cifsInodeInfo->open_file_lock spin_lock to protect
> 
> > Fixes: 487317c99477 ("cifs: add spinlock for the openFileList to cifsInodeInfo")
> > 
> > CC: Stable <stable@vger.kernel.org>
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
> > Signed-off-by: Steve French <stfrench@microsoft.com>
> 
> This is missing upstream commit ID and a signoff.

Good catch, Sasha forgot to do that :(

I'll go fix that now, thanks.

greg k-h
