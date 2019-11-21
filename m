Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC55C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6B320672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWaVFGqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUUHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:07:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33027 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:07:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id o14so1994857pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7gJkYA2Ya9RG5lGDwn1afx4TWUN9AxI8xhu9u772h5Y=;
        b=WWaVFGqW2/oLxe+xGDL8ESIk7ySRmIkSvNHhrf3ay4rMeCqCreUEnGYrb3YqkcRzo4
         yRUMbJqjYpaWyd/M3ApB49phxSn22Tkt/DEwr2CVkF2PVed8jfyG2lSW7K3zDd33oJzF
         tQIOItlo/zsfuWmI7lb647H81Tr6LFN6RYD/3JCGBtVLLR6G5aPrpY6ZapVYE9oA/qPW
         a7wk3oS+mOfc0L7UWgYe3GNkXEndoeAsEE1wla1/BHD9tneTq8XfW6orHSB6TWBr3KUp
         TLHs6XQA789q2a8MMiZtp/LM3c06I0HNlkUd1vXg2LJ2ukqy+jS41qevVnmv5kaV1rsg
         3/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7gJkYA2Ya9RG5lGDwn1afx4TWUN9AxI8xhu9u772h5Y=;
        b=dQ9OASASzSQlhPckDsirFjeaOVFn86MuEAmKFjSQ0lrKXjIVjI0syb6d5ZXNw30rzu
         pIP8BIIqODFuaH0c0O0eIjsJ0trNVh1r9CUp5/YSGBrFTgIWfrDWVpzGBfBfE84i0tSm
         aGMXu4gTf4cyTODMBKIO08dwPJcbxkLyq7HW/C2lvHjAi8ZTNoly7hhuJRgYKe5C6ulv
         /abW9I320aCuwPH9sfPWJEo5EL4bhi5GjQgLth1xHXH32IZuP0T/4+rof7hbgvcW3OJW
         XoAtLZK9oCjgaku4BOQY5n17tUeU6SdjXzlSK79ryp5BFN6f5DgFKVZsHvAB3gDINTQW
         nEIA==
X-Gm-Message-State: APjAAAWwZIeKUgm/luIXxlU7fIwkn2oypDyVl0Hy2N+rVRvcYoCK4CQo
        pXWnm+LHSmfuaxQ5pw/qv52QWw==
X-Google-Smtp-Source: APXvYqxUxbUKUpPLEZrPIO8I4uqq5S/MzKrg3wGpWFWZ9doKJbjnTEvfxpwZYA7Jy5jZgjH0PX8+tg==
X-Received: by 2002:a17:902:8502:: with SMTP id bj2mr10719141plb.303.1574366865400;
        Thu, 21 Nov 2019 12:07:45 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id b24sm4411116pfi.148.2019.11.21.12.07.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 12:07:44 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:07:43 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "J. R. Okajima" <hooanon05g@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        "zhengbin (A)" <zhengbin13@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] tmpfs: use ida to get inode number
In-Reply-To: <32188.1574336426@jrobl>
Message-ID: <alpine.LSU.2.11.1911211154090.1697@eggly.anvils>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com> <20191120154552.GS20752@bombadil.infradead.org> <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com> <alpine.LSU.2.11.1911202026040.1825@eggly.anvils> <32188.1574336426@jrobl>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, J. R. Okajima wrote:
> Hugh Dickins:
> > Internally (in Google) we do rely on good tmpfs inode numbers more
> > than on those of other get_next_ino() filesystems, and carry a patch
> > to mm/shmem.c for it to use 64-bit inode numbers (and separate inode
> > number space for each superblock) - essentially,
> >
> > =09ino =3D sbinfo->next_ino++;
> > =09/* Avoid 0 in the low 32 bits: might appear deleted */
> > =09if (unlikely((unsigned int)ino =3D=3D 0))
> > =09=09ino =3D sbinfo->next_ino++;
> 
> I agree with that "per superblock inum space", but I don't see your
> point.  How can you manage it fully?  I mean how can you decide whether
> the new inum is in use or not?
> For example,
> - you create a file which is assigned inum#10.
> - you or other people create and unlink over and over on the same tmpfs.
> - then sbinfo->next_ino will become zero, skipped, ok.
> - and then it will be 10.
> I don't think you want to share the same inum by two inodes.

64 bits. I haven't done the arithmetic to work out the amusing number,
but zhengbin mentioned the script taking 10 days to duplicate an inode
number in 32 bits, so: a larger number of years than I need to care about.

> 
> Moreover, SysV SHM uses tmpfs and shmget(2) overwrite inum internally.
> It will be another seed of a similar problem.

I was totally ignorant of that peculiarity in ipc/shm.c, thanks for
alerting me to it.  But it doesn't affect what we're doing in tmpfs,
and apparently suits the users of SysV SHM: I don't see any need to
worry about it.

Hugh
