Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6921BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 19:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DF1217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 19:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auBg69zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfI2Tyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 15:54:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36050 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfI2Tyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 15:54:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so10422789wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=q1ON0aXacT8z1vG03SZjDsu34Gfj0TYUtDN5631jPYw=;
        b=auBg69zvIbsLVlr2Uf1mokhNt9wmjOgIhUfHdXjR0EkyI1sD14NDEYq4Iracef+e4p
         u786HmQ7sAvc9O+oSmvblbk8+vp+mTSTaaJbjVdALjHeELEHng87lDR25+QTWCqBpead
         a6kRQxBWuXkK1xCSu5Psy/JooosayiOmZNdKuKU0IUj7jT4+v6jzEaGjpJMESTGXivZO
         itaSizzrPMS2XR3IisHDyrmrIx1uGbgoNdId9UQcnAzLPrcXu/RGcbNU5C9EMD+EurK6
         ylX73p6DYQmstvdxqV+qZOh75zx0pbCannWgphewEfuIaw2XoIa4ec2+ZBRFCXuyLYPM
         M1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q1ON0aXacT8z1vG03SZjDsu34Gfj0TYUtDN5631jPYw=;
        b=NvyoZcFtRtbvSWYRqMuF/zLnsMS9ZsUgGWpl+tbi9wgV5tP4PUaYbrVAMtpMtOl1ji
         YLAM55OP1CWWA+B+tyiCJ9VMkYca/bhL4bnsxHeZchyn6yv4M2fQRxEPeIORrArflMJY
         68tT9YjDn1yZKmolhCASfsw84Ui1fzoZK5cy2tbgVdJgURc5KUZ8Aczx9MRcFJhkT6Cn
         qpq1/qtpU1xWb+WWA8TbTUB0sF3U27DdwhSsqOCFLByEwRWNGWocIf88to8SI6M+W1BU
         dE3xHPN5e+FcDB0l1vgTuK967SisNJwbzyIa7DeQzQ/6Pc/B8hrl8N0DmHg8qKslwlGw
         tORg==
X-Gm-Message-State: APjAAAXthBGlb6mVqwdKH5p4JxGjHCYtHA9hk1kwTUpPpLK8uYhMbKv8
        FzPEIYq77ab6JrXcggIb5G5PwwkbyvE2nD29B2bfbw==
X-Google-Smtp-Source: APXvYqyfN7aSfxOmgYcm/3uZMfO+wIqMoSX/MNBU/y3bEAiI1bO4xyLR+cQJrr5ZpiTPiSHsxDoSdFU0AXHDqMAkDzg=
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr14876102wmh.112.1569786883763;
 Sun, 29 Sep 2019 12:54:43 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Sun, 29 Sep 2019 12:54:33 -0700
Message-ID: <CAGRSmLtvCBNFX0ronxKFAYnDz3Lw4g=uJ8Uqyn53FncioEEO+w@mail.gmail.com>
Subject: Why does /proc/partitions have sr0 and fd0 in it?
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was updating some tools such as udev, mdadm, lvm, and came across a
hang and messages about unable to read fd0 which wasn't occurring with
the old tools, but using same kernel.  So I've found that in the old
version the /proc/partitions didn't have fd0 whereas now it does.  But
both have sr0 in it.  So that leads me to who populates the
/proc/partitions, from the limited info you can find searching the
Internet, it looks like the kernel.   But obviously not since same
kernel used with different results.

The difference is the old system udev used the old debian
create_static_nodes and didn't use devtmpfs, the new udev (eudev),
uses devtmpfs and the create_static_nodes is a bash function instead
of separate binary.     I wonder if that has something to do with it.

But since cd and floppy devices aren't partitioned traditionally
(technically any block device could be but it would be non-standard)
why are they in the /proc/partitions file (also the device, e.g. sda,
is in there and it's not a partition).   So is it not partitions but
just block devices?   If so, maybe /proc/partitions should be a
symlink to a new /proc/blockdevices, so everyone is clear what
actually goes in there (leave the old name just for backwards
compatibility) ?

Is there any docs on all this?

Thanks!
