Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9447DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683412071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqi9aJN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKULka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:40:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42952 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKULka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:40:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id j12so1442454plt.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 03:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:in-reply-to:references:mime-version:content-id
         :date:message-id;
        bh=2YUMlMHb1jsKR64RBdqNyDWxhhWO2c6n/6/y+QUhsXs=;
        b=cqi9aJN5DS0t4kkWvzHf371mrRDQEFi6edvi7gt7M2M6PK1KmBjZGob0y8YhejBq6s
         JqRp3f+N/+TTqnYCR/eObOuBWKW5qKsLDnHQTfp02k6dLoUdBToTmwTXYdcq0S0Lph0z
         MgynN+SHIKGuuXuEWdwTt8suSRgn+iseddJN13Q9bDsqafTMTpTpwNWnQ6Dfo3ZOsYwz
         SGIEO0FLaLODJHvkVW8uMjv+mN2lvhJHA73Y1l+U8RjGnpf0OYl4OSODhBxeeHtDLK7e
         MFF6GRbh5wTC6G05/+pDfNPJZKGD0zrOzw7hsPzk7VHICglQmR9hZGv5xX6iG64qjX8G
         oHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:in-reply-to:references
         :mime-version:content-id:date:message-id;
        bh=2YUMlMHb1jsKR64RBdqNyDWxhhWO2c6n/6/y+QUhsXs=;
        b=tuqAXzo2dnV6yjqon+Z2clCFq5/BCdQHiOtvxfZGPbtM57P1T3qRVNFt0OFkVz/+UQ
         eMn9fDLTDdNDFb3vK0U96rh+7UxrE413snDoWfP5rIIJUuZvw/kPksJkDaF0M4NISKY8
         X5PBQmPWNa98farBjLDJ58D8f3o1POEKn/ezBPQncV7nXZYF6JosSBliYPwSRHmRYpaX
         gSsgJ5IwaJtnEy/GLTuku67/TFA1dE1Pw/V1gMdcoNHHQ5ErgHkGr8OsF5Ty6A9Wp+i3
         RnfsRERDl7xIQVq5zVoQ5DOSxZO/sz76iEd0LujRktROqk54zFSKSbx0fh0ELJKTl8qS
         RCxA==
X-Gm-Message-State: APjAAAVF/y4aqiJ69VfAd5C0mE0hdix9rMhOZswgSONV9pQ4twyN/giU
        ELPyQ9SsQnRCUElIlv38jNA=
X-Google-Smtp-Source: APXvYqwnj3iKGjyfCCyI5DdM5aWt57GIEXEiZbqYsrlc2X4heRPhPlIhOq2c0fech8/hXVhHT2WS2w==
X-Received: by 2002:a17:902:76c8:: with SMTP id j8mr8348835plt.122.1574336429325;
        Thu, 21 Nov 2019 03:40:29 -0800 (PST)
Received: from jromail.nowhere (h219-110-240-055.catv02.itscom.jp. [219.110.240.55])
        by smtp.gmail.com with ESMTPSA id o129sm3441035pfg.75.2019.11.21.03.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 03:40:28 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1iXkp0-0008NB-AW ; Thu, 21 Nov 2019 20:40:26 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] tmpfs: use ida to get inode number
To:     Hugh Dickins <hughd@google.com>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com
In-Reply-To: <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com> <20191120154552.GS20752@bombadil.infradead.org> <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com> <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32187.1574336426.1@jrobl>
Date:   Thu, 21 Nov 2019 20:40:26 +0900
Message-ID: <32188.1574336426@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins:
> Internally (in Google) we do rely on good tmpfs inode numbers more
> than on those of other get_next_ino() filesystems, and carry a patch
> to mm/shmem.c for it to use 64-bit inode numbers (and separate inode
> number space for each superblock) - essentially,
>
> =09ino =3D sbinfo->next_ino++;
> =09/* Avoid 0 in the low 32 bits: might appear deleted */
> =09if (unlikely((unsigned int)ino =3D=3D 0))
> =09=09ino =3D sbinfo->next_ino++;

I agree with that "per superblock inum space", but I don't see your
point.  How can you manage it fully?  I mean how can you decide whether
the new inum is in use or not?
For example,
- you create a file which is assigned inum#10.
- you or other people create and unlink over and over on the same tmpfs.
- then sbinfo->next_ino will become zero, skipped, ok.
- and then it will be 10.
I don't think you want to share the same inum by two inodes.

Moreover, SysV SHM uses tmpfs and shmget(2) overwrite inum internally.
It will be another seed of a similar problem.


J. R. Okajima

