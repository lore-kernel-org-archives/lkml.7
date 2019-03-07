Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8EC20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDdhp1UJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCGWu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:50:29 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:37222 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGWu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:50:29 -0500
Received: by mail-it1-f182.google.com with SMTP id z124so18575578itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DW3OmDjGWwedSz9G2iefQb7Xjdr1IH5ANFqID9HoAao=;
        b=eDdhp1UJUjTSPr1TI5E/ORgd/pTC9FzmBTrOjMfYX9PgXUWp20iVfQgw/KNqyFBG4I
         qZXbwtk+Q/Fp13N9f8i+WRvSuF1ZfIWI2KSpysNNfGaj0cpAikT0xZRhd2wVynN/0mbp
         WufKxmEIFIT8jO5CXTWlTvKLpAhuHWgR0uIzHntJ3tpHqCJQYvO9F+E4F729Q0czKfOP
         YNfjCPD6E3QLQjsQMFCN6LHBg0FLLUNa2qVjNjpzD/9dOo3r5POEXCWSG81wBKB0Uqj9
         P3pEnzNZhu6ZUXY+9FHdtgRWBB6DZJSYx/wSOD9IBGugFvzpbH+zj4VsLGd/UxDdV/v9
         BQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DW3OmDjGWwedSz9G2iefQb7Xjdr1IH5ANFqID9HoAao=;
        b=Svw/rpT57wGQC/jd6BKt5T7hsu2sdKXnb2bC79CHXVHGp1A47udWrf2MfhbcwBgmUj
         28GHDAIbqUVawlQ3bWHWtCgbyrT6AtVYrdpBFnVxuyLTN0OmILxTR0BkCTgkE5JN/62W
         yrJmcz7eKo/TKXr1dOMbLHKFfunT1aNUWmygUW7gB8klX+hFFwH+GU1ELTuTgbtrDKpM
         f9z2weSAcxCVs+OLeUESxE2+1V1TIP0sD0NrwOLxqE5I/NqPJ7obMcjQpQUYY2RoO6+W
         g/yGqcaq4jx4MAwrvMO8NLXqX5pwrAWEnm0FHt2K88I0LYxLELsjeoyct+tbH7EbhqPH
         Vbag==
X-Gm-Message-State: APjAAAWkqLCx9whv65mkIJRlPbQlpIzt/npt9tUDogEYdXnPO+9qiExE
        MdCoH6sPSjUYNmH08IQh0L5dVYvVmrvJAkxBx7sy+4sbL7A=
X-Google-Smtp-Source: APXvYqzFQzTE4yUT7KqWllJPm4aUg5u22m+RpyD9hJJphaWk9de0BVCd9fgOqn9tm0qEJEqGzigbIVkXeQ7F/h79vAk=
X-Received: by 2002:a24:43d1:: with SMTP id s200mr6689500itb.118.1551999027976;
 Thu, 07 Mar 2019 14:50:27 -0800 (PST)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com> <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com> <1551998897.31706.461.camel@linux.ibm.com>
In-Reply-To: <1551998897.31706.461.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 7 Mar 2019 14:50:17 -0800
Message-ID: <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Justin Forbes <jforbes@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:48 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> I added this last attempt because I'm seeing this on my laptop, with
> some older, buggy firmware.

Is the issue that it gives incorrect results on the first read, or is
the issue that it gives incorrect results before ExitBootServices() is
called? If the former then we should read twice in the boot stub, if
the latter then we should figure out a way to do this immediately
after ExitBootServices() instead.
