Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B466C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45A72082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jYF2DJel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFNGGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:06:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40964 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNGGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:06:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id 107so1560714otj.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 23:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFqoZrLn4XJruK+9pn7RAj8QC3xVsIBz0Ldc8KI1RK4=;
        b=jYF2DJelMMrI8nnlZYsIYlnmUV+N30iTkEsMcMyr3v70I6bMnL2jhLm84BQPGlUu7C
         IEj3zolvKRIWNvp2+qJ81sOfAsIZPdiuIjo3RX3HPF0WQfMepylltFEkfnr7J0orOj2H
         ZEjpZfdUD+sOVeygs/KETF5r8o9PEw4lLkGZrv0ycL7J0S86+fWyok/T+lLeY+db8FbX
         DdzoNMvJgRIYgmuLu+EgEPXmtonsNifm8/O5IyxWPCo+Ju2HxUEVC0vlLiDskCzJlKTq
         hVGYveUBp/H4sOoj6DLcivr880qKBE8yqn3sfiwDStAlf257cT+FK3s37Neer/T3IjEc
         uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFqoZrLn4XJruK+9pn7RAj8QC3xVsIBz0Ldc8KI1RK4=;
        b=bydxTKfiwoQHY7dCzcMHtywvH75eRGiwqN7Uq3UFeb9/fZFuBRUyVF/1LuD1ZKLR3M
         07PbPi614Tqhl9aHv3j2AWNcOOZ0OThFGWnpIr+ydfiaYSON4Gtek4adG6MP3kF0N1U6
         YZFh3jkLVYulbnob/9gixw8kbxJ7imjEeKTvUVsWD7oNRZapppp3l2LeWgpujSCtB2Z5
         +EXpV2576UVB/AOdvBA5936INbg72LqlGtMFg8QHE7H+y43R+DKFGUyNPHCodCQvlnMH
         mK2EVhhd8kODlmf5XbCeO+9r1RTSsSyqE0GQxrEXmEMIw9XiCrY0GOburQ/iQRd3AxRj
         gusQ==
X-Gm-Message-State: APjAAAWnQRdT8wq2WyhCAT0BMEFgz9jQY2AerAGi+hXBlnhtzXX71/NV
        FzJ8lxB4GcEhq7AtcndmWBsrVaOz6a+IHg7db45ooA==
X-Google-Smtp-Source: APXvYqwFKuK4B/rDJ24rW4G6xtxeywNz7GPMreIg2SyEv7ohj4cJwQTihFlChg+pviZMbAiazF4q5lqMsbh4hztlGhk=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr3089404otk.363.1560492384101;
 Thu, 13 Jun 2019 23:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190614060143.17867-1-richardw.yang@linux.intel.com>
In-Reply-To: <20190614060143.17867-1-richardw.yang@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 23:06:13 -0700
Message-ID: <CAPcyv4hohqZ0DVriW=cdgH+9jrxWoWq4FFk-KGqvtqJHOTt7eg@mail.gmail.com>
Subject: Re: [PATCH] kernel/memremap.c: use ALIGN/ALIGN_DOWN to calculate align_start/end
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:02 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> The purpose of align_start/end is to expand to SECTION boundary. Use
> ALIGN/ALIGN_DOWN directly is more self-explain and clean.

I'm actively trying to kill this code [1] so I don't see the need for
this patch.

[1]: https://lore.kernel.org/lkml/155977193326.2443951.14201009973429527491.stgit@dwillia2-desk3.amr.corp.intel.com/
