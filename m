Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93751C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB0214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCMNAc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:00:32 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42160 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCMNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:00:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0DA5B609184E;
        Wed, 13 Mar 2019 14:00:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Rr70O0kMJH_J; Wed, 13 Mar 2019 14:00:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9C839609186C;
        Wed, 13 Mar 2019 14:00:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KvybbR3tQ9HN; Wed, 13 Mar 2019 14:00:29 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E8121609184E;
        Wed, 13 Mar 2019 14:00:28 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: overlayfs vs. fscrypt
Date:   Wed, 13 Mar 2019 14:00:28 +0100
Message-ID: <1854703.ve7plDhYWt@blindfold>
In-Reply-To: <CAJfpegvrG4LfnuC62JNtdXpCf4vb+aEiDre5YCxe7xUSQP8yjw@mail.gmail.com>
References: <4603533.ZIfxmiEf7K@blindfold> <1852545.qrIQg0rEWx@blindfold> <CAJfpegvrG4LfnuC62JNtdXpCf4vb+aEiDre5YCxe7xUSQP8yjw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. März 2019, 13:58:11 CET schrieb Miklos Szeredi:
> On Wed, Mar 13, 2019 at 1:47 PM Richard Weinberger <richard@nod.at> wrote:
> >
> > Am Mittwoch, 13. März 2019, 13:36:02 CET schrieb Miklos Szeredi:
> > > I don't get it.  Does fscrypt try to check permissions via
> > > ->d_revalidate?  Why is it not doing that via ->permission()?
> >
> > Please let me explain. Suppose we have a fscrypto directory /mnt and
> > I *don't* have the key.
> >
> > When reading the directory contents of /mnt will return an encrypted filename.
> > e.g.
> > # ls /mnt
> > +mcQ46ne5Y8U6JMV9Wdq2C
> 
> Why does showing the encrypted contents make any sense?  It could just
> return -EPERM on all operations?

The use case is that you can delete these files if the DAC/MAC permissions allow it.
Just like on NTFS. If a user encrypts files, the admin cannot read them but can
remove them if the user is gone or loses the key.

Thanks,
//richard



