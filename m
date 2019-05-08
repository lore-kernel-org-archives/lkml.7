Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D367C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52279204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557346896;
	bh=HM8Zexg5fyYXYYnftIe90ImQAhfUbTY7yCvkGYUdcv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LncXcubo2H/w4VeI9k9dnKgePoXI9TtXVMs+Xy6LtZRZgFlubpf5NknS3+yWjCsiu
	 Uoa5agKIBdFeIuKGLwf/ibBr3TmKEKAbHc3CT4/ZGPcc3S4dmvMWaYB57ArRuPFGtl
	 lZ07PKkfoWQTzAQlAEHaz48RPCKrusUN36rgw1OM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfEHUVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:21:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42975 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfEHUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:21:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id 188so28611ljf.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNifpvFw3YJp0jtYSAGlVH5MnjXwA/O9EoLNdihZ8Vk=;
        b=iGbILcjlPkScfe3+kL4rx1YCDG0rLGj0OCxrAUVBg3IlsAhRS9DY04SkRQIoFsxih3
         xRoNOXhZ1lu58a4WaA1997ouURMmXG/VMAMERNTrT4TJkEYC9+TcKMiCbpmJJW4U1Pp5
         G8lMUyOfOoY8+mEM0ARD57qYPiTTCm+xulpbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNifpvFw3YJp0jtYSAGlVH5MnjXwA/O9EoLNdihZ8Vk=;
        b=BC0v3yKXd0VdyyjLwcnAU/XhI8ozkOW10HyE7bL+dqrvCrgsRFFdXtBwBAADSAHq+N
         CHXs5MG/DnwjRvEuc6Sy7BqRqcCd5VFeXnqx4Ovhh04tlCpJG9aSMMbSijPllSRj1x0F
         GUIS+iExIwsfzG2ZHN7E3dZ3p3qJWoXTkdTHReYQAZ5pvHJJlHST8rtLHCrzS6IYUNhd
         lXY0YcQk3iP3o4iUevGbgeTScWs6VS4h/B4k4DOPocOXve7n89kDgO2GpxwzQPwaxGpH
         +o7sjlC2K9VTI4Cyscw6pR/ktskK9QsopjgrvGo1iF3GBGjCMXVkbVNQih23mOoWTM3y
         YGVQ==
X-Gm-Message-State: APjAAAVS5+yAuba3rOpEfwx2G/lDi4DQpcxL3IDtDfAZZXB5S1weDiJi
        wONRpXhbnlGCixaFnF2V8JhHlSB3Q0M=
X-Google-Smtp-Source: APXvYqyNlZOUIURzW8uhu3FOe3SFGac56kPhFfj8dLM4iu42oOCRLj26eLrS3loPJxbtTe6pVyXDng==
X-Received: by 2002:a2e:9993:: with SMTP id w19mr9066949lji.111.1557346892086;
        Wed, 08 May 2019 13:21:32 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y131sm2596983lfc.76.2019.05.08.13.21.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 13:21:31 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k8so32954lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:21:30 -0700 (PDT)
X-Received: by 2002:a2e:801a:: with SMTP id j26mr12914689ljg.2.1557346890466;
 Wed, 08 May 2019 13:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
 <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
 <CAHk-=whbrADQrEezs=-t0QsKw-qaVU_2s2DqxLAkcczxc62SLQ@mail.gmail.com> <CAHc6FU40HucCUzx5k2obs8m6dXS08NmXBM-tFOq7fSbLduHiGw@mail.gmail.com>
In-Reply-To: <CAHc6FU40HucCUzx5k2obs8m6dXS08NmXBM-tFOq7fSbLduHiGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 13:21:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqKCxGfh8RfR15Xz-pB1SuyX3cJRAo90=Bww4rNS6bqA@mail.gmail.com>
Message-ID: <CAHk-=whqKCxGfh8RfR15Xz-pB1SuyX3cJRAo90=Bww4rNS6bqA@mail.gmail.com>
Subject: Re: GFS2: Pull Request
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 1:17 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Would it make sense to describe how to deal with merge conflicts in
> Documentation/maintainer/pull-requests.rst to stop people from getting
> this wrong over and over again?

Probably. I do think it got written up at some point (lwn or something
like that), but it's possible it never got made into an actual
documentation file..

Anybody want to try to massage that email into the appropriate doc file?

              Linus
