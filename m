Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C025D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfCZMeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:34:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33082 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfCZMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:34:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id j10so4788666otq.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zo2kZaFXun4ur6wY2xnBnTG4h6yFnWUo8V5pDttjlIw=;
        b=IHYF9hq5PesHkBFM392tTz4+cEHh1lLW0K3l6OtJ8r53JzB3NPKZ4btvk4kHA/OMB7
         OM/ESiAvrItcoBVxiuPLmVAWUqDrFwO0pcgmAFEO30JVIX7lNMisEAlXeuggI4+LKWML
         FFj1nU4PhhAXoYdFamF+xrlxHsGIYYB95jatVYRrt816QMRbsE/uIlgk4iCc1SO9JblB
         SynkyE5deGmHQdW8iaHf+Bh4bCx4VLWRebl6A+qVbeS2P5MI7Lgt1crkbi118mvQmdoj
         oXOkp6RUNIZH2qkz8xgMbpY4HGCyEMexzklxxOMdFJ1EJjEcdowuLoqxgCGhiWyOZRtu
         yEQQ==
X-Gm-Message-State: APjAAAU/TU0/DeN7p7XtXmG9eMZ0ZFcuV4fr/MK/DykDEHXsOrX+YPcx
        daO7/T8Iy/GjH6pjmBD7fP6625xRcL2N5HF3tv+c5A==
X-Google-Smtp-Source: APXvYqytfmlPhKCfMz5dYKWqmfUc1uqr2mjGXWqJapB4AVtVXi26qRHFf/1V9w6QwMWNG2nNvLlJ2DqtXJHRC4y4Bh4=
X-Received: by 2002:a9d:3289:: with SMTP id u9mr11992007otb.52.1553603645845;
 Tue, 26 Mar 2019 05:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <CAHC9VhQt6RMdOsVNAXHnPzTrVRpnfaq4PULzBCmMPg7SgdTpfw@mail.gmail.com>
 <CAFqZXNuJMJTjGL5qGoemy4O--Y3kGGwGb2TfwJ5xxFAz03uPqg@mail.gmail.com>
In-Reply-To: <CAFqZXNuJMJTjGL5qGoemy4O--Y3kGGwGb2TfwJ5xxFAz03uPqg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 Mar 2019 13:33:54 +0100
Message-ID: <CAFqZXNtazgAzoFDMiQWOdaVNcpAH3PEEXwwJ8D+njGoEX4+DvA@mail.gmail.com>
Subject: Re: [kernfs] e19dfdc83b: BUG:KASAN:global-out-of-bounds_in_s
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>, selinux@vger.kernel.org,
        lkp@01.org, kernel test robot <rong.a.chen@intel.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 6:06 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Mar 25, 2019 at 4:17 PM Paul Moore <paul@paul-moore.com> wrote:
> > Ondrej, please look into this.
> >
> > You've looked at this code more recently than I have, but it looks
> > like there might be an issue with __kernfs_iattrs() returning a
> > pointer to a kernfs_iattrs object without taking a kernfs reference
> > (kernfs_get(kn)).  Although I would be a little surprised if this was
> > the problem as I think it would cause a number of issues beyond just
> > this one ... ?
>
> I think this is actually because of how xattr_full_name() reconstructs
> the full name from the xattr suffix. It assumes that the suffix was
> obtained from the full name by just taking a pointer inside it, but in
> kernfs_security_xattr_get/set() I pass the suffix directly... I'm
> surprised that this didn't fail spectacularly earlier during testing.
> Maybe the newer GCC does some clever merging of the string constants,
> so that XATTR_SELINUX_SUFFIX actually ends up as a substring of
> XATTR_NAME_SELINUX? (That would be one hell of a "lucky" coincidence
> :)
>
> I'll post a patch that converts kernfs_security_xattr_get/set() to
> take the full name and hopefully that will fix the problem. I'll see
> if I can run the reproducer locally tomorrow...

I managed to reproduce the KASAN warning in my kernel testing
environment by simply enabling CONFIG_KASAN and running the cgroupfs
issue reproducer from the original patchset. With the patch I posted I
no longer get the warning, so I believe it really fixes the problem.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
