Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3464CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 23:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E977B2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 23:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ozHEe23W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfC3X5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 19:57:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39227 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3X5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 19:57:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so5350071otb.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mTXQwEHp25jsXXs0xOppcW45YpPe1sGxWOzazKsAao=;
        b=ozHEe23WHi2UdztToyVId1Kmaiop+mLWTewhTDgRtxN41uC3SZ+Jbdhy7Cp+IWvbQR
         zFzOQex+qr+RrVTlm1knBbHOjWMcA1YsbxtMW1VuqFurEgBnOCmy10L9vPNaHP3VRML8
         kUsXQIQHEPgmDaxjgax3Cn+vjBGL2oAoSg6qnZCpsIMVXxVVXHeoKUIAxmUf+reY9ggj
         XfucD1OxCplzwT/Z4+VEndIs7+cGtpLxSI1f+G0TwuBZ6H03v/C5zUHlNgnOas4iWMfl
         +J5W/v0JS1VRmMtu89cD2R8Jngi+gyjyElfBo4GSqfYu4/c4S8sjVF95aclfsOKQvnnz
         MDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mTXQwEHp25jsXXs0xOppcW45YpPe1sGxWOzazKsAao=;
        b=sX0yT2AbJXDz4GiQssxUGFNyxg2nYp2u3VYvsI3aybU7bnhvK1ap0eDIpS5nySTaaH
         AhYrEh6enpQG3ocKvjvlHdJGHnL+PhAKY900dYPIWI3NcYa2/uoxsx84LdCzr6NpNMLx
         qYWdp+LTyPDpoxemal1pFtCi1+q65N4AxoNUDgNaimQYFxEMK1sFX+W64oc4lSlduew7
         pV/owCgx0SBERPlxhRkkeyRx3ziqzB2wN/OZkMrV7SM1MePCcKdwAVadfmeAoPbxMmMB
         kTBiOv2eHQknCjuOXJOVN8rU4cDpKfNGSsfUUFNuPI0PQS/AyEk4JPW0xSJZ13YggEkQ
         ZDXQ==
X-Gm-Message-State: APjAAAUM6O5AQv7uPIsDogIgGlvgpliX+HvVxM2/6HixCdFRD+zXiGtw
        fs7tqCLYt/+vMwz0yCZkoAiicjN3JTFQC7hsykZePA==
X-Google-Smtp-Source: APXvYqxHD39w1ZNGQhKRDXhJxSes4mrfXcPcv4gwie55Uu1wRRS/LRNC7hDRdRwMbzqNi05PsdH8148aAAI3q6j3C9Y=
X-Received: by 2002:a9d:3e11:: with SMTP id a17mr38746422otd.185.1553990261575;
 Sat, 30 Mar 2019 16:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <eea3ce6a-732b-5c1d-9975-eddaeee21cf5@infradead.org>
 <20190329181839.139301-1-ndesaulniers@google.com> <83226cfb-afa7-0174-896c-d9f7a6193cf4@infradead.org>
In-Reply-To: <83226cfb-afa7-0174-896c-d9f7a6193cf4@infradead.org>
From:   Tri Vo <trong@android.com>
Date:   Sat, 30 Mar 2019 16:57:30 -0700
Message-ID: <CANA+-vAcW0VfAZmZWi84s1pQQ+tFx8VyzYsWi5_gj7vHT3Ao6Q@mail.gmail.com>
Subject: Re: [PATCH v2] gcov: fix when CONFIG_MODULES is not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>, linux-mm@kvack.org,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 1:53 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/29/19 11:18 AM, Nick Desaulniers wrote:
> > Fixes commit 8c3d220cb6b5 ("gcov: clang support")
>
> There is a certain format for Fixes: and that's not quite it. :(
>
> > Cc: Greg Hackmann <ghackmann@android.com>
> > Cc: Tri Vo <trong@android.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-mm@kvack.org
> > Cc: kbuild-all@01.org
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>
> Thanks.
>
> > ---
> >  kernel/gcov/gcc_3_4.c | 4 ++++
> >  kernel/gcov/gcc_4_7.c | 4 ++++
> >  2 files changed, 8 insertions(+)

Thanks for taking a look at this Nick! I believe same fix should be
applied to kernel/gcov/clang.c. I'll send out an updated version later
today.
