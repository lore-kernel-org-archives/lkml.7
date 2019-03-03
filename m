Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3030C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC13C20818
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNhW5r4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfCCRG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:06:59 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38493 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfCCRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:06:58 -0500
Received: by mail-io1-f65.google.com with SMTP id p18so2173504ioh.5;
        Sun, 03 Mar 2019 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PQdwPgrYQIaK+JSzk6KwOnnr9WbfAiUl8ZSpdunwhC4=;
        b=fNhW5r4KfDovU2iF1KNuaOxj3t4W2LJSemv+HUxeLmbKOXgbAofwlepdoTjXoW9I8+
         IeCmKi9cV6DK8n4rd8bQjC8ANzFlfZRaN8+jFeQ8bEGgeK84wYSFJXyqmXFSa9uBXUfu
         bh0rXPUW1a7MsXaNPk6/Rm4opeZZGkZ2lWBPMdoQRNBm1GHmElCCC0ZHhONTnG7roW9Q
         FGZQm94iolQ3jtBo0pS+9HelO1m9iInUHQVlmFQKhwPj6llQHDtcgP+S8udzTwkwRlES
         K9fvm+2xTo/Qg+UzS/rEIXIcG1sPEZjSNMCSgvoqkzCaC/4OL+cmiTbXepdN+mAWU4nk
         d+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PQdwPgrYQIaK+JSzk6KwOnnr9WbfAiUl8ZSpdunwhC4=;
        b=YoajDpQWrWUk15BsxDe9Ox1VA2g44v9cSyqETK62hPx1j7fQU/2c6WV/qkWnaSM7Hu
         u6Ccvsf+dbxIswgBS5MXcWiM0HcLfXyD/Nfnrayjp6KKVp1JWsMiWIdKL9m1RYlXSe4O
         qmTmtY3OryY43hWYzgGptLZKsIb683rpTDtUZVImStaAT68+LTn787eSJZQSDcoVOezN
         n1rvWCsEAOph9RJF6uIwZ6KL2/O4quBDsPVAGcMaiEhT/APyZoYZh4MvM0SFNadpdDyv
         Yb+AJ09eZ7dJIaHSRTULAxJIw7vvsS6KeEs/oIgjcAdBO1js2fBRS7zWbENOU2CJZZFO
         eiOw==
X-Gm-Message-State: APjAAAXgBPxO6ALN06ulHGBvQlPjYMfa0JI8Z85FbUdpCF6xZWM5Jk39
        +FZ9CBuEcX6P7O/83DCh3Yhyub8TxOgRtpoMMk8=
X-Google-Smtp-Source: APXvYqzO7vUUltjcoAcnkc8d8oAbSRT4Zuzk1u+NDe7Rxrjgb3BmfwYlwBprkLiQfIU66CQTgum+5h2tMDMvOwSMcX4=
X-Received: by 2002:a5e:8c14:: with SMTP id n20mr7441262ioj.200.1551632817394;
 Sun, 03 Mar 2019 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <CAKgT0UeMqmojVrNV1i-DdY18EBwbJ_4zVTUggAWas5D5yeU1PQ@mail.gmail.com>
 <20190303034847.GA8699@redhat.com>
In-Reply-To: <20190303034847.GA8699@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sun, 3 Mar 2019 09:06:46 -0800
Message-ID: <CAKgT0Ue9+wSL60Bj0drkgVQwem=mh_eTrFMda+inX4=qBgi3dA@mail.gmail.com>
Subject: Re: x86 VM Boot hang with latest linux-next
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 7:48 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Sat, Mar 02 2019 at  6:34pm -0500,
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> > So I have been seeing an issue with an intermittent boot hang on my
> > x86 KVM VM with the latest linux-next and have bisected it down to the
> > following commit:
> > 1efa3bb79d3de8ca1b7f6770313a1fc0bebe25c7 is the first bad commit
> > commit 1efa3bb79d3de8ca1b7f6770313a1fc0bebe25c7
> > Author: Mike Snitzer <snitzer@redhat.com>
> > Date:   Fri Feb 22 11:23:01 2019 -0500
> >
> >     dm: must allocate dm_noclone for stacked noclone devices
> >
> >     Otherwise various lvm2 testsuite tests fail because the lower layer=
s of
> >     the stacked noclone device aren't updated to allocate a new 'struct
> >     dm_clone' that reflects the upper layer bio that was issued to it.
> >
> >     Fixes: 97a89458020b38 ("dm: improve noclone bio support")
> >     Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> >     Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> >
> > What I am seeing is in about 3 out of 4 boots the startup just hangs
> > at the filesystem check stage with the following message:
> > [  OK  ] Reached target Local File Systems (Pre).
> >          Starting File System Check on /dev/=E2=80=A6127-ad57-426f-bb45=
-363950544c0c...
> > [    **] (1 of 2) A start job is running for=E2=80=A6n on device 252:2 =
(19s / no limit)
> >
> > I did some googling and it looks like a similar issue has been
> > reported for s390. Based on the request for data there I have the
> > following info:
> > [root@localhost ~]# dmsetup ls --tree
> > fedora-swap (253:1)
> >  =E2=94=94=E2=94=80 (252:2)
> > fedora-root (253:0)
> >  =E2=94=94=E2=94=80 (252:2)
> >
> > [root@localhost ~]# dmsetup table
> > fedora-swap: 0 4194304 linear 252:2 2048
> > fedora-root: 0 31457280 linear 252:2 4196352
>
> Thanks, which version of Fedora are you running?

The VM is running Fedora 27 with a kernel built off of latest
linux-next as of March 1st.

> Your case is more straightforward in that you're clearly using bio-based
> DM linear (which was updated to leverage "noclone" support); whereas the
> s390 case is using request-based DM which isn't impacted by the commit
> in question at all.
>
> I'll attempt to reproduce first thing Monday.
>
> Mike

Thanks. The behavior of it has me wondering if we are looking at
something like an uninitialized data issue or something like that
since as I mentioned I don't see this occur on every boot, just on
most of them. So every now and then I can boot up the VM without any
issues, but most of the time it will boot and then get stuck waiting
on jobs that take forever.

- Alex
