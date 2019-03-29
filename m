Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A808C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07095218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHXxaJID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfC2SJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:09:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33041 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2SJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:09:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so1428164pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4ZCUKfRLPJnIxAUuStXAE+wg+9f7Meg4+UY3x4a0tc=;
        b=iHXxaJID1cfcFFuS4BGDnRyg9Mxplx4UhQoViLW3/gt5s5HuCZPp0EWOtuBz1X7fKt
         WAuEATJBmWOLWZxbPAQSevDxuA3jUitzRs+m1m/Hr2gELSKiEmq7P+I1SbTROFV40kDM
         P28z3Q6P+VRj7IiWG1u1n7IxIXi9y63/9R8wqZNUOcoNQv3EYcDm00vASADxRdLOwR6p
         D5Xi/zzjhTfjkUmnVjEuExzjV6MyNdw7NlyqZqivoz8kRQ9mUbtuqFDHK8F+UtUTGqeM
         j16u9bxOtDrqjxnrxrPWdup2xEJqZfP4PHseCUHfolSHGPreR+NMcnuyZPVyEB5OitUQ
         U83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4ZCUKfRLPJnIxAUuStXAE+wg+9f7Meg4+UY3x4a0tc=;
        b=FHYdOrlogtnlMUuKGm/Ey4i9e8wqn92yLnkIFLXrImzOgGYZptV6/2n88ffFg5Kod3
         S4tiTvIrB3ocGEUgOmkQsLcuJAVq3wR/I3hda2KOTGTd0D0iAU1MQCKb3wyalU9/TjN5
         Yknlc67hLEE07LoDGi18zX43EALgwEmqqhHVhVXwU5Nga1aooDmbQsm+fyOmIbrui+HW
         mX2FM8eV5Cz3sOxt7/+myDjEwL3V3eMDGM1VS+DlxrWrgvLI4ZeqtKa/4slBkNMvSXBZ
         7wiqbapDhVWfzaWIwLXtnL3qkFbbTRj0gDAUDFPyDlCuNZAUTUjGYb7kvqfpgcRktLGM
         n0Qg==
X-Gm-Message-State: APjAAAU9JzozjpchZgdcnqNTbBByckNmsxe7VzN82JyNYQKrWun5a8/b
        41lbKoinc6cSakb5o8HfVwB8O8eTZJvI3BEAEg+6Iw==
X-Google-Smtp-Source: APXvYqyAiLFvFmAzP17NJ+HtjCZy23KROjG8Dcmjfu2QSFVMdm7SITNkMr0Jg5U4JI3OnJm1c4zZxj/jiGjXg1dLHR8=
X-Received: by 2002:a62:7603:: with SMTP id r3mr48744017pfc.32.1553882979336;
 Fri, 29 Mar 2019 11:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <201903291603.7podsjD7%lkp@intel.com> <20190329174541.79972-1-ndesaulniers@google.com>
 <9f1ad3e1-fad7-2fb4-31c0-d31832468143@infradead.org>
In-Reply-To: <9f1ad3e1-fad7-2fb4-31c0-d31832468143@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Mar 2019 11:09:28 -0700
Message-ID: <CAKwvOdmv4_8pN5r8EO8c59WN+EE7ZPST8qHKMg7SzPH1rzaqag@mail.gmail.com>
Subject: Re: [PATCH] gcov: include linux/module.h for within_module
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>,
        Tri Vo <trong@android.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:01 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/29/19 10:45 AM, Nick Desaulniers wrote:
> > Fixes commit 8c3d220cb6b5 ("gcov: clang support")
> >
> > Cc: Greg Hackmann <ghackmann@android.com>
> > Cc: Tri Vo <trong@android.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-mm@kvack.org
> > Cc: kbuild-all@01.org
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> see https://lore.kernel.org/linux-mm/20190328225107.ULwYw%25akpm@linux-foundation.org/T/#mee26c00158574326e807480fc39dfcbd7bebd5fd
>
> Did you test this?

Yes, built with gcc 7.3 and
defconfig
+
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y

> kernel/gcov/gcc_4_7.c includes local "gcov.h",
> which includes <linux/module.h>, so why didn't that work or why
> does this patch work?

Good point. May be something in the configs from 0-day bot.  Boarding
a plane for Bangkok, but can dig further once landed.

Maybe module support was disabled?

--
Thanks,
~Nick Desaulniers
