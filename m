Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D57FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A68B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556556521;
	bh=G62UUeDTnAjbpDIAkXXjWZ1MD7yMfvPO9bm8UWwg+c0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o968yklHSBFN8SCePdlusjEzVxIEypBaj8MF8kPiVKNl1n8xNHjI+FSSI2nBY3oVg
	 u6cUJm7TzFvjmUR6FWcKzqHwuEnu42eGQrN0Wr+VrAGMl77Jdt/1aznRtyYs1LZtRn
	 L90KTwadvWw/lLZeXXQTtsOavOTaYFowbQfl5P9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfD2Qsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:48:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35767 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfD2Qsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:48:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so10041424ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYehPJ6wJvH/t0sND63lM9JFmbpN65exB3Q2CmnY7pQ=;
        b=boxZnEB7KXPFCHisvjFAhGhtDzlLRSPvSiTJOtc3E2UiH96le78g5Eu6tEp8R4Osak
         n/blcnqZgtrT+GiEjey4L/qDFcJ8IB9NiYzOJeU9JfWishn6yS+CkMjZ5pQsM1el58FG
         FVj/h+G4gJ2fDEqwqpUf1xoYFHH0+VbQCiodA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYehPJ6wJvH/t0sND63lM9JFmbpN65exB3Q2CmnY7pQ=;
        b=W6M3Ry4dAki15FE+k2uMkfVW3sAUXRmTlfqN+CfeBZ3ixDPxwvhmst7wHOT50owlJJ
         0AfLpQl7uJJnbU95LC/ejOT2xiIq6+47IhI1EylkZ9WtZu5vXXYbcj0zYFvIWSPYbmeC
         uKKG+bTUIhyePZo/aiHMbArsliGcgPFboA8Vyn+gNU3LsL70XiT+TvOX5wfFOCIMFNBi
         Rvm0DvO2c2wbAlRYza0QKeDOB5Zm6sS5OSADioOU2Agc+E3STVWQ4ER3IJrTVCpMcVbL
         P8cAbuEdvyilqFUEV0IcgGZUb5CwXBb1ylLwhuBkgCIQyZdNOcMw4PCNi1vNpeYxCZCz
         hAGg==
X-Gm-Message-State: APjAAAVP8quJNpaK8qx2L1ujjmK8EKYuWK4rvWDv94/gVjLmSdHUeN1x
        jVwCfxdBB4hKpKUnCaY3r5VwgbYvwy4=
X-Google-Smtp-Source: APXvYqyk/4DD4QjBS5cOOxbi4JamP4KIFDDgw0GxSRy0sCggF6twXOCRpwlg/v58oVYsXnvEsMQ3PQ==
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr32547701lja.68.1556556516811;
        Mon, 29 Apr 2019 09:48:36 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s3sm7439724lfc.25.2019.04.29.09.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:48:35 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k8so10000892lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:48:35 -0700 (PDT)
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr34012924lje.22.1556556515412;
 Mon, 29 Apr 2019 09:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <48cbd548d153d1d2a1cf6c4f2127a6cef5d55deb.camel@redhat.com>
In-Reply-To: <48cbd548d153d1d2a1cf6c4f2127a6cef5d55deb.camel@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 09:48:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYHXxkHrbDACc1-5bqJPuiMnmwbStSYBYo82zsO=gstQ@mail.gmail.com>
Message-ID: <CAHk-=wiYHXxkHrbDACc1-5bqJPuiMnmwbStSYBYo82zsO=gstQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull rdma.git
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 9:29 AM Doug Ledford <dledford@redhat.com> wrote:
>
>
>  drivers/infiniband/core/uverbs_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This trivial one-liner is actually incorrect.

It should use 'vmf->address', because the point of the ZERO_PAGE
argument is to pick the page with the right virtual address alias for
broken architectures that need those kinds.

I'm actually surprised s390 wants it, usually it's just MIPS that has
the horribly broken virtual address translation stuff. But it looks
like for s390 it's at least only a performance issue (ie it causes
some aliases in L1 that cause cacheline ping-pong rather than anything
else).

                 Linus
