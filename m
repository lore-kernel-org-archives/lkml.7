Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714F4C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3320721738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/cna8pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfDWWFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:05:40 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42199 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDWWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:05:39 -0400
Received: by mail-vs1-f68.google.com with SMTP id f15so9210653vsk.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Elez7iCG1GYh8Uw47EOEivzLdi0hlZmyMv1EE1RvfA=;
        b=G/cna8pakquU+rziPipI1afH+o7ef1kqk/0WiSmr8IwaciwTA8hCKiE/dNM0LSPiWP
         CasdiVciJz9ais7EHjy8h+fGsMFKpAeqH98t436ZHSf0jteX0xQecLlgkRAQudve10Jv
         ikRNmUG931DxwSwEWzqJRKfZ0tnAaDTXXMrtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Elez7iCG1GYh8Uw47EOEivzLdi0hlZmyMv1EE1RvfA=;
        b=N7mCEqGnvXByFEXgZXQHXOBUgmqNcSXRvOAv3qRd/7uqHFV/xf9B/VuFg+mJ1eNWt7
         Wk/L67wAYHZU7ZXUvKyGBoI/tcTojWp/f2dFuj5SUYzQ5B16BHIr5RANRoiSHg8b/3cM
         +mIQWE+zmRRc6wbzqRBxXZh/LmQDLuRxxIrYnb1vsSpNaCXKX41bAE0agzBYHQprETtT
         vbiMclnVrRxDaBAI4Gz111zylPpfbztZUId32v0s+NU0j/NcxmTqLblfe2tO2QwzaSBQ
         jPRlZSvawJ9uniUqxK0JOjEq15B87ElxS3pncJTuFx6alAsbQzR2ow7rBomK9/S1aZoy
         xkcg==
X-Gm-Message-State: APjAAAX8xcZ946P248j+9+JSAbqyL3kChFtX4jSUxroVPU/CRSbFs8R4
        9vTTf8gKQJhUyGX1uM0XWiFHyR5Gyc4=
X-Google-Smtp-Source: APXvYqxMH1Zqc/aT9gacqynpJBOQRhlNr8f2nqM/4oaS2vAjUbW//zpykXicb94Wuh4IgSqXYjot+w==
X-Received: by 2002:a05:6102:25a:: with SMTP id a26mr15033472vsq.187.1556057138544;
        Tue, 23 Apr 2019 15:05:38 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id j8sm5020189vke.1.2019.04.23.15.05.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:05:37 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id x194so3582770vke.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:05:37 -0700 (PDT)
X-Received: by 2002:a1f:3c83:: with SMTP id j125mr14762825vka.92.1556057137033;
 Tue, 23 Apr 2019 15:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190413224438.10802-1-okaya@kernel.org> <CAGXu5jLRnq1WeDtMSwE_qnve_O9+GiZd4m=N=_1rBidwRwmeJg@mail.gmail.com>
 <ff84544e-33f8-e6aa-48b3-2f786ff15dfc@kernel.org>
In-Reply-To: <ff84544e-33f8-e6aa-48b3-2f786ff15dfc@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:05:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+EqMOJKO-u9jiDuk3+FfukCzUz9BX+WyLW5x70ZKU=rw@mail.gmail.com>
Message-ID: <CAGXu5j+EqMOJKO-u9jiDuk3+FfukCzUz9BX+WyLW5x70ZKU=rw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <Okaya@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 3:02 PM Sinan Kaya <Okaya@kernel.org> wrote:
>
> On 4/14/2019 11:55 PM, Kees Cook wrote:
> > Thanks! This looks good to me. For the series:
> >
> > Reviewed-by: Kees Cook<keescook@chromium.org>
> >
> > Andrew, can you take these from lkml, or should the series get resent
> > directly to you? I think you might be the best to carry this?
>
> Where do we stand on this?
>
> Anything for me to do, here?

I think we're done. I'm just waiting to hear back from Andrew.

Andrew, do you want me to resend this directly to you, or can you
fetch them from lkml?

Thanks!

-- 
Kees Cook
