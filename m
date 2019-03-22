Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53F621874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jH9uz9xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCVUCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:02:42 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44462 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:02:42 -0400
Received: by mail-lj1-f181.google.com with SMTP id n18so3028445ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVhcFvBSU0ilIWQ6zraITGsbJeqbqMeecPM//6iFgS0=;
        b=jH9uz9xZZX2F8LWYXB1jJVPYDGKpnIcwAFsdxCmgl1V2qAjGcgryI9I8IM0mljKQD4
         cZ4mFjNX3Dx2Z5aI24LwSRw9IppAC1Hu1OtSSpRYSWb0zJth/V0rJKI1aGHIekcng5Zf
         LHBqAKbpCB1B5Iy2WmoQ+s9QdwzgT3Qqv1SB+nRwcWGFaiv6fMTNrzcUW/ukYtCeRlQ8
         kGgXsITY6gZnnGZpaAEh1wjrYsDPcbJFqWDc4uqg+/Fy8I+pXfQecwAi2LQMs+WQHaOM
         ON3SD6nvib27G15Z6OCem40jwr29WbT1A2tJv7fKX9DCd8fJGbtCatPD7SRmcGLZK8NP
         Ccng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVhcFvBSU0ilIWQ6zraITGsbJeqbqMeecPM//6iFgS0=;
        b=ft8mP0Hoc4sEPwIjwgo8L7gbFSyXip2QER67XtLKp9KgzggAdMaeTSNDa/T2J/GHkX
         dwSu7Q1Qozl+VbXhKMg675lcHE0GKFXAGGRqkpOTQjD12pgsB/NkgpfyNikD2bdYeH9z
         4FXCKugo1b0WMHFiSYlXkxbSter784HQS3Q2HrQnJ9ev3banx5svSVyGJ0NePH+O+y8G
         lo95a3RLC8DGXkf37qLUl3ITQovcfKOlU33iw6eSQl9YeGCjkt52HPXYsUzhBASihvhI
         z4CtKVKjYGsUllaHAohkYKFnk36ArO8TH78YG6ObWQXagRmUBd9P5wz/pHH4ZCaoVYrK
         5ieA==
X-Gm-Message-State: APjAAAXe+/f/xrOsJtf4kEXBqvpp/AybfIh5Hzcf1ythLIDCDYcGPvZz
        lYF2iZUIKW/98Oz75zagwJJzs17uY+5B4mFexSXm
X-Google-Smtp-Source: APXvYqx1sPszIyYrTFmMNiYbIBu5EMB5UYqK1dgtaba+v7+UHYP8hAvhq6PSz4sDL9jUH2b01NQunZsR3JZjZ2T6knk=
X-Received: by 2002:a2e:904b:: with SMTP id n11mr6274461ljg.57.1553284959714;
 Fri, 22 Mar 2019 13:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190322140400.18892-1-yuehaibing@huawei.com> <CAFqZXNv-u+nAr2F+bYuovqMgvVJaS1LK9kCWXCZCtWGBYGj_cQ@mail.gmail.com>
In-Reply-To: <CAFqZXNv-u+nAr2F+bYuovqMgvVJaS1LK9kCWXCZCtWGBYGj_cQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Mar 2019 16:02:27 -0400
Message-ID: <CAHC9VhR7eUWxB3Fviqtp5ZUtdjJVasVOdF2MbKTgqufa2vXLdg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Make selinux_kernfs_init_security static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 1:46 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Mar 22, 2019 at 3:04 PM Yue Haibing <yuehaibing@huawei.com> wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > Fix sparse warning:
> >
> > security/selinux/hooks.c:3389:5: warning:
> >  symbol 'selinux_kernfs_init_security' was not declared. Should it be static?
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Yup, another trivial mistake on my part...
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Thanks for catching that!

Yes, thanks for the patch; I don't always check for static (or
const'ified args) as much as I should when reviewing code.  Merged
into selinux/next.

-- 
paul moore
www.paul-moore.com
