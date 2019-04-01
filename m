Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5503BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1337020651
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554154478;
	bh=qsbu7naBGDe2NrYrYfbqTs5V7BLtCbSYdbFodHB7c5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wBrIIZCVgU3IqujeQHm2tE4OzX368AsPe9wpUblMGQaIp+rCQ/6HaTekUK2tqxV1M
	 p7OfyKyBkBtjBSHSHldcRZDITF/xXbydcDpqzQ7O/yG92PRZ8u0AM9cw7cr5Hr20dX
	 dAE136DHhRYfIVEgDlo/cmfCL9RW6u63QGnVRl/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfDAVeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:34:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36868 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDAVeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:34:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so10146788otn.4;
        Mon, 01 Apr 2019 14:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsbu7naBGDe2NrYrYfbqTs5V7BLtCbSYdbFodHB7c5o=;
        b=lfgkG6+VKrkcf/AHpsE8ayZoNGAdxItjUCwDtfz68LoD9xZmBkQ5RFl1jVB+VvxatY
         3yEGP+w2nXVV19dVaMvrl3DRwcvBam4jXd5OERTdiCDmMW+5xa+eY2+RWfSh+sRjSOYu
         4fNJAtTlYtWisrKKtjqQGn7lHcb8b29XqFGcNmVuk0uOlkfGvd7pNgSTcIiXaI4gnskP
         GmhLT/JwECUjuZKJXkabdr27hMjNoFPdg8+XvA+JYKlOS0OuXtvNF0zOqrBHjqJ1K5nz
         iTShkSlKPXjg4Rr6+jeRMRfLml7W4F4HetxmPxpr2JfIlGIGEyWG+KIEtPMy9nKQutp2
         RXbg==
X-Gm-Message-State: APjAAAVXdWwbMjGUVjPwX1FiW9HvAX0pNUVKBthCZ6RTdBygPKBilrU5
        6qcQuocMy5sLrz3z5oQeNLUIGfdwPfPwWfQ6DFE=
X-Google-Smtp-Source: APXvYqyhJ5uuE8f/9gjCUA8a6mvKNjVrcrSvyHJ4UezoMNnEK2cKIZXc0iNoHb73M3y6t9OiVLKYUgnhVBk9ZVvKeR4=
X-Received: by 2002:a9d:5c09:: with SMTP id o9mr2627778otk.311.1554154475712;
 Mon, 01 Apr 2019 14:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190330112022.28888-1-bp@alien8.de> <20190330112022.28888-6-bp@alien8.de>
 <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
 <CAJZ5v0gfqOB8r0dvTf3uRSkJCNOLYPe9qLaUV1BLGjTanmMbvg@mail.gmail.com> <20190401124814.GD28264@zn.tnic>
In-Reply-To: <20190401124814.GD28264@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Apr 2019 23:34:24 +0200
Message-ID: <CAJZ5v0gCJSDFkmdf-Pi5fiZXTe2T5PK5iM3UxQeX_uk5yMPYyg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drivers/cpufreq: Convert some slow-path
 static_cpu_has() callers to boot_cpu_has()
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 2:48 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 01, 2019 at 11:32:59AM +0200, Rafael J. Wysocki wrote:
> > Or I can queue it up if you prefer.
>
> Doesn't matter to me - it doesn't have any dependencies to previous
> patches so however you like.

OK, I'll take it.
