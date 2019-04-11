Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA5C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0633C2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554999802;
	bh=uRaUuNgJy+ETLKY+TrZW6hwLlPxxWHbreqSGUu3Em/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1AFCe0qnPt+wHTWPRiDZvLevy1H5a6d35lKwza3di6fJ2PN+pkGNorqkVGTPMF6jT
	 7+9wolUN9UtfS0cbCg2bsNqUFjQsu9gkVikjxigLSYfAbwlyFm4zbCojsnCyGH2wpY
	 kr53iJS/Bt6/hfC4PqS5jbUJBcptD8O8/mOpUxWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDKQXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:23:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35539 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfDKQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:23:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so5197577lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQG3fAkiUV20bO26Ld6sJCHOpwS1q4hdpfdFqRoHxoM=;
        b=Z0Q1fOHSPCHOhBg1JKd5iEmmQ0/jsnNt7NEQOMpZAIi6DdydVfjj6QnQaEXX8Gz+7s
         YA+8bHIkuUumGy6mZX/ZcdzE9pt3vuwrZDx20oUfvX5bVG0wUueotFvbNY6WU+TbLZyz
         Wi3ZJegqCN6RjJ9Nr2IbBVaSy0zQ/mtMc35l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQG3fAkiUV20bO26Ld6sJCHOpwS1q4hdpfdFqRoHxoM=;
        b=lafeijIsMCaZo1LaSR3p5FJnoB7Z4teiFKy1wyiyLxx6WCeYyZd/yDlv211/vvwAYb
         ukqM+17+HyQ5BuPuF6S9x54x9gERvJhB6e7Dg28qKLHm45qgM9NmytNpzzGjEOiWRPix
         c0Ck6vyzFCrTiX7vvccAzXEDmnQ41obeEv6YWcGneI7cJPOq8Wzuk7i3AQCEjU+IyYKX
         xMRCUvBJTvFv3DZU9Jj4CBMVER5RmJ87g7pDVGS65fb5tPLnZSCadXOLyGqXvlwfrolq
         c2LxmkhBVWycdslgrhDvPuO0NbSdsxttLhgcpFCDa1Y41BNnes04JgxEu0XKSdUX+8Yc
         iZmA==
X-Gm-Message-State: APjAAAWH+wQrdGS9M1uszJqKR4YTY5nXyEM37vXxkXH5hNgNkFMfOysc
        52tQxckTBHAKJBkCv9GdHhxJSkPD6II=
X-Google-Smtp-Source: APXvYqyYiwHEQ7PeNuYWQ5whK4CTr6I3/nwCw3fMMWLD6l2NnLzltEXWbiFqsRZDZU4PeZMbR9yAWQ==
X-Received: by 2002:a19:2d57:: with SMTP id t23mr6437198lft.99.1554999797881;
        Thu, 11 Apr 2019 09:23:17 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id g24sm7683159lfb.49.2019.04.11.09.23.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:23:13 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id o19so838372lfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:23:13 -0700 (PDT)
X-Received: by 2002:a19:a40b:: with SMTP id q11mr27540073lfc.33.1554999793169;
 Thu, 11 Apr 2019 09:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
 <4c4651e2-167e-bfcc-7b3e-cda118f98a69@rasmusvillemoes.dk> <20190409203807.GA13855@deco.navytux.spb.ru>
 <d8c23d05-8810-13a2-cc50-7a47ff35e90b@rasmusvillemoes.dk> <20190411123816.GA18309@deco.navytux.spb.ru>
In-Reply-To: <20190411123816.GA18309@deco.navytux.spb.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Apr 2019 09:22:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJtZt52SnhBGrNMnuxFn3GE9X_e02x8BPxtkqrfyZukw@mail.gmail.com>
Message-ID: <CAHk-=whJtZt52SnhBGrNMnuxFn3GE9X_e02x8BPxtkqrfyZukw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so
 that read and write can run simultaneously without deadlock
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 5:38 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> However file->f_pos writing is still there and it will bug under race
> detector, e.g. under KTSAN because read and write can be running
> simultaneously. Maybe it is not only race bug, but also a bit of
> slowdown as read and write code paths write to the same memory thus
> needing inter-cpu synchronization if read and write handlers are on
> different cpus. However for this I'm not sure.

I doubt it's noticeable, but it would probably be good to simply not
do the write for streams.

That *could* be done somewhat similarly, with just changing th address
to be updated, or course.

In fact, we *used* to (long ago) pass in the address of "file->f_pos"
itself to the low-level read/write routines. We then changed it to do
that indirection through a local copy of pos (and
file_pos_read/file_pos_write) because we didn't do the proper locking,
so different read/write versions could mess with each other (and with
lseek).

But one of the things that commit 9c225f2655e36 ("vfs: atomic f_pos
accesses as per POSIX") did was to add the proper locking at least for
the cases that we care about deeply, so we *could* say that we have
three cases:

 - FMODE_ATOMIC_POS: properly locked,
 - FMODE_STREAM: no pos at all
 - otherwise a "mostly don't care - don't mix!"

and so we could go back to not copying the pos at all, and instead do
something like

        loff_t *ppos = f.file->f_mode & FMODE_STREAM ? NULL : &file->f_pos;
        ret = vfs_write(f.file, buf, count, ppos);

and perhaps have a long-term plan to try to get rid of the "don't mix"
case entirely (ie "if you use f_pos, then we'll do the proper
locking")

(The above is obviously surrounded by the fdget_pos()/fdput_pos() that
implements the locking decision).

           Linus
