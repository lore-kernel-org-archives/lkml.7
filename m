Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A0C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3167D2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZNmgeWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfKGJ4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:56:47 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41146 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKGJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:56:46 -0500
Received: by mail-yb1-f196.google.com with SMTP id d95so222105ybi.8;
        Thu, 07 Nov 2019 01:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fm76nR80a/OQAHDl6S+Q4Z7EZeWE8/XJctFepQj3/cI=;
        b=iZNmgeWrVLHUyf1/kz3lZiIqCRpishYYNgkmMmGuWYewId7m3ntRjswTyhLcujBldQ
         a7RwMQ3Skm2bOSrpDjA7MyDMKv9wqboaX7nk3g4jvq6GelKxWZp9PEIE6vuD6wvZQU5q
         RikVdr/gG1czRpgbEwBok3MXtY73J+Y8LQkkeFjV1hjDEw7XWJdI9+mrjZZOPhJpUopB
         nh9pN6SpL3w4UpUxCYKD+p06vT+B1XdMcCmHIy6kj9n6RDKhiOgb2EfmYDfEjOHtE0LG
         AD+/2Tlke5oTjj872M0nFJRDM1wV99jykwGy4pvW2+ilIgUGD3JaHvJva9a7N25nxkaE
         mQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fm76nR80a/OQAHDl6S+Q4Z7EZeWE8/XJctFepQj3/cI=;
        b=aX+kS5vLIr2Eq+KhNDRrwQzpRTu5c9wKsvKYU6Pv2wI5gIaXaCxiYGPWX3PR6fcK4A
         DHO1d3RUc1sryBYBYz6DHDpqfE3hYYhisk67Pi7hltl7Xgwx6twOP6vKzVlnZL/uSVvh
         1MKl3RgZx8Gub8HY9/3eZn4AdILUPb3MdBBcS7Gf1vi6hEFB2FG1Ktr62Fu+9N45oqCk
         HtZ7GtF3sUZXPthAGqV+Ba0OJ1tBw3lnSvsSQDcFHdaW4idxQNSdZ3OyQG7BrOuTi6Vo
         k1AgMaqNUZhhJH3O+L6mOSIl9vRSg0J3Yge6uSni4S2NYb8pNhLleUOXgFNbTOhhET8b
         S3aA==
X-Gm-Message-State: APjAAAUXbIqeNg8qm14HdOWkzup87AEAp+sUuT73Rtl6Hp4uAXVtt39Z
        SOe/0sDHQwY2Hn93YF9oNqGGFxbU7eQPowF2OuI=
X-Google-Smtp-Source: APXvYqzLcmHYbQsOo9koCOUEttSezPItam+DnmJ+3DcDBLpEKbzLbwNf2xc57fFuFRVqjFVOx6hLOIyZ2xkZrMw4FFw=
X-Received: by 2002:a25:3344:: with SMTP id z65mr2308285ybz.439.1573120604298;
 Thu, 07 Nov 2019 01:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20191106234301.283006-1-colin.king@canonical.com>
 <CAOQ4uxhT4pFzHjjKyoMOc3xVXXqyqc37zd=-pCx2+keA4e6NAg@mail.gmail.com>
 <02adb5f3-10be-1827-f48b-b621bd61783a@canonical.com> <f88a4ef7-3e2a-9e17-1573-3594288091cd@canonical.com>
 <bba96a64-a9f7-cd03-e00b-8ee369520ae7@canonical.com>
In-Reply-To: <bba96a64-a9f7-cd03-e00b-8ee369520ae7@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 7 Nov 2019 11:56:33 +0200
Message-ID: <CAOQ4uxgj8FO-yqtHsjh2OaTGvcF3HA5OekqiUuZEFE+LGGaTCg@mail.gmail.com>
Subject: Re: [PATCH] ovl: create UUIDs for file systems that do not set the
 superblock UUID
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 11:44 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 07/11/2019 09:12, Colin Ian King wrote:
> > On 07/11/2019 08:45, Colin Ian King wrote:
> >> On 07/11/2019 07:08, Amir Goldstein wrote:
> >>> On Thu, Nov 7, 2019 at 1:43 AM Colin King <colin.king@canonical.com> wrote:
> >>>>
> >>>> From: Colin Ian King <colin.king@canonical.com>
> >>>>
> >>>> Some file systems such as squashfs do not set the UUID in the
> >>>> superblock resulting in a zero'd UUID.  In cases were two or more
> >>>> of these file systems are overlayed on the lower layer we can hit
> >>>> overlay corruption issues because identical zero'd overlayfs UUIDs
> >>>> are impossible to differentiate between.  This can be fixed by
> >>>> creating an overlayfs UUID based on the file system from the
> >>>> superblock s_magic and s_dev fields.  (This currently seems like
> >>>> enough information to be able create a UUID, but the could be
> >>>> scope to use other super block fields such as the pointer s_fs_info
> >>>> but may need some obfuscation).
> >>>>
> >>>
> >>> The fix is incorrent. uuid stored in xattr needs to have persistent properties.
> >>> In the use case that you describe, the origin file handle should simply be
> >>> ignored.
> >>>
> >>> Please test attached patch.
> >>
> >> Thanks for the patch. Tested, and the error still occurs:
> >>
> >> [  163.959633] overlayfs: invalid origin (etc/.pwd.lock, ftype=8000,
> >> origin ftype=4000).
> >
> > Added debug, seems like nouuid is not being set to true, nouuid is false
> > on the layers 0 and 1.
>
> So nouuid is not being set in ovl_lower_uuid_ok() because the code is
> returning early because of the following statement:
>
> if (!ofs->config.nfs_export && !(ofs->config.index && ofs->upper_mnt))
>         return true;
>
> ..and not getting to the following for-loop.
>

Indeed. I had this bit of information in my mind for a brief moment
and forgot about it..

Please remove this optimization and change the call to:

       if (ofs->upper_mnt && !ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {
...

Maybe change the language of "falling back to index=off..." to
"enforcing index=off..."

You may then submit the patch with my Signed-off and yours.
Please also change the name nouuid to bad_uuid per Dan's review comment.

Thanks,
Amir.
