Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BADEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACF62146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="k0e84dPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfLSFTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:19:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47020 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfLSFTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:19:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id c22so5560824otj.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 21:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebFIMmIFcRXMNWKUGHUPVzk5pgnyLGBQyisFaU/FwbA=;
        b=k0e84dPH4htoykVcj9saaY4VEZM4fFiDoj23iKL7NDpna4Dyr28UklvE4Qm1hEnppc
         4EbUbfCTOn/b8lUfCNu2jNxUj1froCEK5Z8ZrX+n4cNMtHyy3HHVdQ4F0Dnz6W644vIS
         CoypM4ri8MnlsjoxJl6sNO2YIoAd65qi9vuKkshigdqdkOxib4j6DAXomkzWIUoKIo8T
         SMzh8t1qvWHtMDnhP1avLg6zE5zGJQFkYt3QsG1u0q3paSZqxZo4s2JqOmXvs03sYzR8
         qqPl9RGItEiN72UPcuWzspy7AXHNrvdYBRk7bebD4oCBZa+e0MhCf52+QgTmd1tU/laL
         8nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebFIMmIFcRXMNWKUGHUPVzk5pgnyLGBQyisFaU/FwbA=;
        b=k+j2kAdNGWtAQ96JxasSHfEk6Ad9vfCeBzBnOqCScKXyeb5peinVwkDv6W7Bo2iXeM
         akYcgfTdnE8yzmOF/0BAcEOuQu1pmgWRIiAC57Jta0UxMevkfWkAHms2zKPzFHNOgCvy
         RzEYgVJ7OyZ0WHCQUeP5i+VFTxV/P8/d/wVgijecL1ypczFrPFS9YwUVyuMweRzX0YJT
         CxY2ivftieXg99HEXjIUg/jX3xr5Ah7MZWaXqmxkx+hH1oSln8qkLObDKgMp7zIVtdRY
         sY15P59Hcri+PoCSwnIUyytE1B5QwkqUekNjJRbdfLkjwxV9mXrcKdS5697nmfQE0gjr
         DvHg==
X-Gm-Message-State: APjAAAXAZzLx62z8HMWE7Yq0cFX1zy5R2oCvWpbxz8HsqknfjMHbAfn3
        TdjfJEtpmwqP+k/V4wg1ELOwKGypt4x6VUkPyGvmWHEC
X-Google-Smtp-Source: APXvYqxhpUIvpLGge5tDFBoL23b9F+f851RUtQ3m9EXuu4PlCjXNQWpf9BjSiCVPHeeUOCcme8JMICpJQ2zNNvAoUtY=
X-Received: by 2002:a05:6830:1744:: with SMTP id 4mr6553170otz.71.1576732776609;
 Wed, 18 Dec 2019 21:19:36 -0800 (PST)
MIME-Version: 1.0
References: <1576728650-13867-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1576728650-13867-1-git-send-email-anshuman.khandual@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Dec 2019 21:19:25 -0800
Message-ID: <CAPcyv4gCqt1cfEb4KFWW+J+FcQj8ZnYEFz-ggLzgR2Zs+Wg13w@mail.gmail.com>
Subject: Re: [PATCH] mm: Drop elements 'hw' and 'phys_callback' from struct memory_block
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 8:10 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> memory_block structure elements 'hw' and 'phys_callback' are not getting
> used. This was originally added with commit 3947be1969a9 ("[PATCH] memory
> hotplug: sysfs and add/remove functions") but never seem to have been used.
> Just drop them now.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/memory.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 0ebb105eb261..4e95a9eb8061 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -29,8 +29,6 @@ struct memory_block {
>         int section_count;              /* serialized by mem_sysfs_mutex */
>         int online_type;                /* for passing data to online routine */
>         int phys_device;                /* to which fru does this belong? */
> -       void *hw;                       /* optional pointer to fw/hw data */
> -       int (*phys_callback)(struct memory_block *);
>         struct device dev;
>         int nid;                        /* NID for this memory block */
>  };
> --
> 2.20.1

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
