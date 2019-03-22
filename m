Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927A520830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCVPIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:08:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34434 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:08:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so2893532qtm.1;
        Fri, 22 Mar 2019 08:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ray6a3oBz8Eivrw+X+ERFR/qqf3R27iqqoHid6iCv2g=;
        b=cb18/CkB9NaNUi5d0Nkp/re/8u0i/exNkDmTi0bdpsGj6oT9dQ8UzjgDLX+jfTn+kl
         2IacXJxOg5pxMoITGFmSS8yBRMtWEU49UiWR/WR0O94W+zq7S+mmO0v24BKLaVZ6UK03
         4gx5e6f/zYU4v+8ITGywxX7etthAwf/mSTR2t4P8hNBMy3ao255wEPD2G5DGNT8NxsAz
         nG3aDXFn1XOAMNt+/ltfUQ8jsPtI83RqSerE2wvmTI0THf9hPvqXDbHs+inxcVScMVA4
         +76OYivXano9OEzHuDFpa84pyGwGQIp5WpTPUKmJ6nyIPrs2KfByAPXi67j+bUV0p1ly
         c7dg==
X-Gm-Message-State: APjAAAVAlDtvKAqQsbLcxy/d1YEGZPfqDLzxXWuNYBCya/d0JLcAUW/s
        a4XZmHch3JpgKwKf707PZ1/l6tF+tngTqoKmVKs=
X-Google-Smtp-Source: APXvYqxf6n981aQvzEvr8ry83eBeRQzo+exZOntT5pOCmGmMNw4vj7nENFSSJ0GahSsVmdFqLzzLDhwvXzX8216RSWg=
X-Received: by 2002:aed:3b09:: with SMTP id p9mr8562803qte.152.1553267287421;
 Fri, 22 Mar 2019 08:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190322140819.300740-1-arnd@arndb.de> <CAOi1vP_=5gBUFLCofhaCNbMkfdwYNSkJ06Rmw-bJkLXNC4v8fA@mail.gmail.com>
In-Reply-To: <CAOi1vP_=5gBUFLCofhaCNbMkfdwYNSkJ06Rmw-bJkLXNC4v8fA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 16:07:50 +0100
Message-ID: <CAK8P3a0NXVt3znez-BtVpCX61sNWoJ6Q9XmJw6mJVzQkG6VCdQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:40 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Fri, Mar 22, 2019 at 3:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Arnd,
>
> I don't like this because the initialization is no longer contained to
> ceph_oid_init().  Now there are two things to patch instead of one.
>
> How is this going to be fixed in other places?

The only other warning like this that I encountered was in
DECLARE_WAIT_QUEUE_HEAD_ONSTACK().

So far, I have no idea for how to solve it, other than disabling
CONFIG_LOCKDEP when clang is used.

Would you prefer this version?

#define CEPH_OID_INITIALIZER(oid) { .name = (oid).inline_name }
#define CEPH_DEFINE_OID_ONSTACK(oid)                            \
        struct ceph_object_id oid = CEPH_OID_INITIALIZER(oid)

static inline void ceph_oid_init(struct ceph_object_id *oid)
{
        *oid = (struct ceph_object_id)CEPH_OID_INITIALIZER(*oid);
}




       Arnd
