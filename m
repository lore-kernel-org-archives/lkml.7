Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A5520857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHfAOHQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfCRMzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:55:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38047 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCRMzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:55:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id s1so17687257qte.5;
        Mon, 18 Mar 2019 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xg5AUW1Nh0Hmdv13GnjTN+6HcMcVP42BGyxv1p0ng1k=;
        b=RHfAOHQPQYMBmHnMZjFG40r5An6NrbBpcJRpyxooQzJxePJ6auwt0F9QB1QNcDflhy
         kNnA2wrhzB1jf/mqNr56OnZDmHADk4U9SCFZ3HE9NsjNuG6uc9pgCuYCfgG+ExMqOY/D
         FD/8+oxhOi0XNs6JIY0X2yTtKt/1uHIdIKtvv+xp6uASVs2o3KS6SQBe6XmIgmE9qOKQ
         THIBMhb8Pfk1icPopnW7b5LWZkVE/5ZivKojmoEEk+1A7LhckVujZ7zjzC7PA/0dcwuB
         N13hrSwvu/dco5yjFvMkaCTqom/i6ZClXbOf6eF+wWkPQZxbs21flGOg5y1Na2ErSd2f
         17lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xg5AUW1Nh0Hmdv13GnjTN+6HcMcVP42BGyxv1p0ng1k=;
        b=Qc0NV3RSLbUpWKqudYXpkoP1OBd9k3HzNUZDKcpClG7//tUL+dKEu+s5BUmNlTk5r/
         PKm2rrlfkPiq+ydWH5lNKbczt+uyNGQnhOplwX2i+Cwv/S5vNnCpkf/RmaU8ak3xqjLu
         dBUiP9MDtarglg6oRPfItRjPIzX4rGZjTG8UctWEEKpOmmnwL2PuLcZuLSdQ9wEPVmee
         97Asz1Sm/A0QpW8qAUcCzfpqwyYQZqQpQsEad0RXKtGbqvbKvSWQl6NMKVGp8hu7NdWL
         his5F17WnLn0drDWRP1fcKAADxvXZJblKRgFUzjmAkRhffEwK7qqAOlwZsRsTcec8ABR
         81mQ==
X-Gm-Message-State: APjAAAVa11K/DVKqVhZztiUc6fnt0hGDMJNYw5p1EXZmWEhwGZBOz41m
        OIMKoQEmOpuBYyBboa4p71K3rN0b1Es0TtKr42U=
X-Google-Smtp-Source: APXvYqxkTun46TLSUlrbKjsnuq32l78oooOQIkiqcMtrSLRC0Ski8OyAIQx0wDvza/jKZw5ZlVQtwOpvx0MHIDFkrFg=
X-Received: by 2002:a0c:ac98:: with SMTP id m24mr12529207qvc.3.1552913734521;
 Mon, 18 Mar 2019 05:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190312142019.30936-1-lhenriques@suse.com> <20190312142019.30936-3-lhenriques@suse.com>
 <CAAM7YAmMBv1Z4Etp5yf9K=RqpTNF0kJ3tsiAysfs_wv9mdNG8w@mail.gmail.com>
 <CAJ4mKGZ3a9xq4HkR3JQ0yRyBCh1acm0YEz14OBUK+bQFzbVEDg@mail.gmail.com>
 <CAAM7YAmt+OS8=ycPrtLLe_FqeD2F_szdkShNAPA49FOPoJd+Gg@mail.gmail.com> <87lg1czc26.fsf@suse.com>
In-Reply-To: <87lg1czc26.fsf@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Mon, 18 Mar 2019 20:55:23 +0800
Message-ID: <CAAM7YAk5s8OkamynT2y474fbCZqWRWyMZZ20=6h=chMr7HpCiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 6:55 PM Luis Henriques <lhenriques@suse.com> wrote:
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

right

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
>

fair enough

> Cheers,
> --
> Luis
