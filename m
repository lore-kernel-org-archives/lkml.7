Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ED0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5A22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfCRLTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:19:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40065 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCRLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:19:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id u68so11387885lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 04:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuMUJQAaY87/HXNfGHrFFRQkIhHekKIC4vvffzsFHoY=;
        b=d/fLHmoxVIYWTpmbK26DRsIJXcOGEDGccBsxlV/b7+OKCcsGyWIwPPw3Dh89Mw7cjn
         wXCqfeIUb94LXskDkJU1v2Wzqk/+d1ImMwlvowvcMyE/pJVqplwD2ePB0zwFYabvt9q/
         iHOGhN+n+t95Rd/r8bIFZ5kitrDmM3MkMstdXA+JD7d0m4HJDl0Vkeq00fUKQs0r1XUN
         KHj+fM0hXvwOg8ffqy9fbQNRW7pVZ3CVH+NYem4JjGnpWlqC/isT9yzbfnoMLQu8ZWB+
         7SFQKVF4+vx5eMxlXCPRGHszI9vOupAlRmYse5FwcfA/sx3L3PupihNAH3yaOU76Yquz
         abSw==
X-Gm-Message-State: APjAAAUUS2ryWORMMeU/giILSeKS8YMWqKRq8RX6q6v7ADr+29+LwVyP
        1RciJT0hhqaecSBPT8n/GCyzCF7nrmGrNLU6GO3ZZw==
X-Google-Smtp-Source: APXvYqyVV69EICDvFFZGDq/TgY1CBOnnvXcH9LajNkLhpS75hJYSXsz+HZ7nr5A22VTuO10+nxDuNEyXb7szCAX0OW4=
X-Received: by 2002:a19:6a0b:: with SMTP id u11mr9931675lfu.13.1552907991300;
 Mon, 18 Mar 2019 04:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190312142019.30936-1-lhenriques@suse.com> <20190312142019.30936-3-lhenriques@suse.com>
 <CAAM7YAmMBv1Z4Etp5yf9K=RqpTNF0kJ3tsiAysfs_wv9mdNG8w@mail.gmail.com>
 <CAJ4mKGZ3a9xq4HkR3JQ0yRyBCh1acm0YEz14OBUK+bQFzbVEDg@mail.gmail.com>
 <CAAM7YAmt+OS8=ycPrtLLe_FqeD2F_szdkShNAPA49FOPoJd+Gg@mail.gmail.com> <87lg1czc26.fsf@suse.com>
In-Reply-To: <87lg1czc26.fsf@suse.com>
From:   Gregory Farnum <gfarnum@redhat.com>
Date:   Mon, 18 Mar 2019 16:49:40 +0530
Message-ID: <CAJ4mKGZKUO5DYrn7-PaD=rqERx1rywGmiTyyAaSd=f9dBumzBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "Yan, Zheng" <ukernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 4:25 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> "Yan, Zheng" <ukernel@gmail.com> writes:
>
> > On Mon, Mar 18, 2019 at 5:06 PM Gregory Farnum <gfarnum@redhat.com> wrote:
> >>
> >> On Mon, Mar 18, 2019 at 2:32 PM Yan, Zheng <ukernel@gmail.com> wrote:
> >> > After reading the code carefully. I feel a little uncomfortable with
> >> > the "lookup_ino" in get_quota_realm.  how about populating directories
> >> > above the 'mount subdir' during mounting (similar to cifs_get_root ).
>
> Wouldn't it be a problem if the directory layout (or, in this case, the
> snaprealm layout) change during the mount lifetime?  In that case we
> would need to do this lookup anyway.
>
> >>
> >> Isn't that going to be a problem for any clients which have
> >>restricted filesystem access permissions? They may not be able to see
> >>all the directories above their mount point.  -Greg
> >
> > using lookup_ino to get inode above the "mount subdir" has the same problem
> >
>
> In this case I believe we get an -EPERM from the MDS.  And then the
> client simply falls back to the 'default' behaviour, which is to allow
> the user to create/write to files as if there were no quotas set.

Right, but a client is a lot more likely to have access to
/home/<username>/ than they are to also be able to look at /, and
/home.

So if they can do a lookup on /home/<username>/ they get their quota,
but if they have to look it up from the root it's lost even though the
client has permission to see all the things that contain their quota
state... :/

>
> Cheers,
> --
> Luis
