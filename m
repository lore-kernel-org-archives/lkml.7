Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592B4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3447E2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="excfJ/xP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfJKAkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:40:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39805 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfJKAkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:40:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so8048862ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2FS1xOZd/52wDxpWUrAmpLbVkhqrk6X7y4KWQdphOQ=;
        b=excfJ/xPWZ2+jilbteJY4Vi+c9HHFbmh8FkB0VkVQqsRNzfaN29He3nWLonU+RXfhK
         3pXMA0TLVwHppNQr0AUdUG53U42HF+9GxxpGlj/4kcIRtN2pAGAhjypJkZNwf6iE4U2K
         QnDU6KwbkTBSAhWjCsQuxo6Yvo3mAnUXyeDgSEkA6Cy+jFD7qJ0JXa3ufc+Z8Ubil/UN
         0Cdjgen9Fv8pItZNyHwfvmTyOXAjZeb7m1pS8EB6mZ+mIjfO5jq4nE77VYMmJNXOtxB7
         kvPLp8grvYwauQ5k1eqQDdg2eooaCdMYqVLWUpqPOHk/o0cD7moYJjQphs+tsLLeny72
         W+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2FS1xOZd/52wDxpWUrAmpLbVkhqrk6X7y4KWQdphOQ=;
        b=tzHDKrU8MibXWvNI7/LdNXvqBnE/HFnU2B39uf+plH8sdxX4oUTKT/tSXWRtszukUU
         5CqMG5upg1BoM+ejDEygEpL7lOD+44tn6f2eFrBB9lO0dR3IWYhpUrwUlqyi4hbSj9+L
         XWJP0elgckc5iwubU3n7hgXz3YJKexCB03BFGc1wL+ND4jis5YXCFS6yCsHpVNeUbTZu
         7RxaZM1GfrqhkDZXogZlu5oe9I+K0Atyjp1Uq6SEjdVtqATWPeJauZ6kTlGFjHA6IIBQ
         Tujs6ZdeKz2PEAd3ut9yU0nwwyuzGFzYeESSeN50eMk8CUIvLEctfa6UbMAfoCmyN0Ih
         A8Sg==
X-Gm-Message-State: APjAAAWCEqhJz+jPutZH42s6qngZos4/tkqrQON6df2OUZn+lGRZLq72
        cIpTAnLFjysGFmBzt1oud0uUpN1Iazgrp7ADiTAF
X-Google-Smtp-Source: APXvYqxJgQInWarY5/M7kUO7HpwvMg1Nlpj/lgKKRdJtv+USUKJpyXPsrOQoku+hafT+CZ2zq5wB40bIA3VRiBrUbu8=
X-Received: by 2002:a2e:8ec2:: with SMTP id e2mr7129095ljl.126.1570754447449;
 Thu, 10 Oct 2019 17:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <ea4e8352fd1671f91d1b015a15abee785ea17136.1568834525.git.rgb@redhat.com>
In-Reply-To: <ea4e8352fd1671f91d1b015a15abee785ea17136.1568834525.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Oct 2019 20:40:36 -0400
Message-ID: <CAHC9VhRUmHiuRH6xYZo36hoV34ouNv4Ny0sWZYcz2dnEhx9nsA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 16/21] audit: add support for contid set/get by netlink
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 9:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add the ability to get and set the audit container identifier using an
> audit netlink message using message types AUDIT_SET_CONTID 1023 and
> AUDIT_GET_CONTID 1022 in addition to using the proc filesystem.  The
> message format includes the data structure:
>
> struct audit_contid_status {
>        pid_t   pid;
>        u64     id;
> };
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/uapi/linux/audit.h |  2 ++
>  kernel/audit.c             | 40 ++++++++++++++++++++++++++++++++++++++++
>  kernel/audit.h             |  5 +++++
>  3 files changed, 47 insertions(+)

I'm not a fan of having multiple interfaces to do one thing if it can
be avoided.  Presumably the argument for the netlink API is the
container folks don't want to have to mount /proc inside containers
which are going to host nested orchestrators?  Can you reasonably run
a fully fledged orchestrator without a valid /proc?

--
paul moore
www.paul-moore.com
