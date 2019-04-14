Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F60C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAF220850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNnow3fL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfDNHK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 03:10:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36999 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfDNHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 03:10:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so4928818ywd.4;
        Sun, 14 Apr 2019 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dopavWQTSlpzv4wKGexw1UjZUyWhobeaR088W7CR5S0=;
        b=FNnow3fLRzVn0Ij/MuSoONf5XZ2qUNe7xpQw5jYRoMymKZvDG3jEasFyCPOhita18V
         C5Pocx+64OfvSa62oZJR1JqPid8RB5WFUoXNJhYbY6H+OwVwGYYrZGSA4cLaca9KF/LE
         ShG7nT0UuQc98jQUEn03Uvfwit+GSq5oi656DQqxcQUIgk3jpSpoXLLpf6VEGRXF0RvP
         8ZwStE/OHTUS8jlDEOiqb20A7Bfp0qPgNofyHYJbk+QdsB3FZyqNgzM2d7ZcV8n6gj3t
         Om2ELHBgJ1xnavKCp+vN6uHOgaHYn3MQNhrVZ3DwngNniHs0FX9Iy6+nKLGpriccFzHI
         Auzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dopavWQTSlpzv4wKGexw1UjZUyWhobeaR088W7CR5S0=;
        b=LV2kFHbBEdHRVzZgbw05ExJfpxmh6ygx0pBJwvlZAgZG4Pq8sZ2QCWENJstYR9qHtX
         dcRQzjyp948PE+Wbxcs/4n7U/6uJYv4KEmN4d4kuvyuBgx3HObxU1iF62P9gX8nj92cB
         6QiIPJ3BnfF/gxq1y7FMGOEzjRZbhRGHsQpE6ZOuXtT5JX3DsCA6RUy+PYszSke5GWFP
         dOwyKaUII9APIMymA3YK2nccFrA1C7fWO2QdJ0DigAspXNH572Tr7O9TECtXtejvrT/Q
         Bn6WFRT16lw9EPageu8vtcoKMe9nNWR2xPjahVrRf9VIY1nvmGcI6OMRPvefJpSbmVhM
         UuEA==
X-Gm-Message-State: APjAAAWsiLOAv16ge6ivS6zqXV58q78GOrJGMGxO886pvQxxKkj1Zcl7
        oA5k5p+ZeKWrjcAhY0WoEsbL2Mellu7ZYSLPohs=
X-Google-Smtp-Source: APXvYqx3IDLqWrSlHWPJeYniRZ9ruRFpYT2HjMTWW1qBa30d3e/XbPUqhYOgLB67pmDT5LxeGTzEJx5alaxhZMhRyFQ=
X-Received: by 2002:a81:b554:: with SMTP id c20mr51312047ywk.169.1555225827636;
 Sun, 14 Apr 2019 00:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190413205439.9623-1-shawn@git.icu> <20190414010254.GA7408@magnolia>
In-Reply-To: <20190414010254.GA7408@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 14 Apr 2019 10:10:16 +0300
Message-ID: <CAOQ4uxgkE+Ls+Sff1ptWtFwpT3dZrRayXsr4wX4Z9bZ=28Vxhw@mail.gmail.com>
Subject: Re: [PATCH] new flag COPY_FILE_RANGE_FILESIZE for copy_file_range()
To:     Shawn Landden <shawn@git.icu>
Cc:     linux-api@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 4:04 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Sat, Apr 13, 2019 at 03:54:39PM -0500, Shawn Landden wrote:
>
> /me pulls out his close-reading glasses and the copy_file_range manpage...
>
> > If flags includes COPY_FILE_RANGE_FILESIZE then the length
> > copied is the length of the file. off_in and off_out are
> > ignored.  len must be 0 or the file size.
>
> They're ignored?  As in the copy operation reads the number of bytes in
> the file referenced by fd_in from fd_in at its current position and is
> writes that out to fd_out at its current position?  I don't see why I
> would want such an operation...
>
> ...but I can see how people could make use of a CFR_ENTIRE_FILE that
> would check that both file descriptors are actually regular files, and
> if so copy the entire contents of the fd_in file into the same position
> in the fd_out file, and then set the fd_out file's length to match.  If
> @off_in or @off_out are non-NULL then they'll be updated to the new EOFs
> if the copy completes succesfully and @len can be anything.
>

IDGI. In what way would that be helpful?
Would the syscall fail if it cannot copy entire file (like clone_file_range)
or return bytes copied?
If latter, then user will have to call syscall again until getting 0
return value.
User can already call copy_file_range with len=SSIZE_MAX and get almost
the same thing.
Unless the idea is to optimize for less syscalls for copying very large files??
In that case, MAX_RW_COUNT limit for this syscall would need to be relaxed.

While on the subject, something that has been discussed in the past is that
copy_file_range() and sendfile() of a large file are not killable, so that is
that should be fixed, especially if the interface is going to be used to copy
more data in-kernel.

IOW, the motivation of the patch is not clear to me:

> This implementation saves a call to stat() in the common case

What is the real life workload where this micro optimization would
have any affect?

> It does not fix any race conditions, but that is possible in the future
> with this interface.

Then please present a plan or an implementation of how that interface
can solve race conditions and if that is the only motivation for the
interface than I do not see why we should merge the interface before
the implementation.

Please let me know if I am missing something.

Thanks,
Amir.
