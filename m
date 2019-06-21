Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7B9C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E2821530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ZlBt1ZI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFUMsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:48:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45183 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFUMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:48:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so9889472edv.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4adQYbcIqRIUCBEdkxswp1975OueOQrS15/MY1hDOBk=;
        b=ZlBt1ZI3O0VPVoumZdjZDlOVbahkwHP0Gd/+Uf04iRyZBVzhCcdM1UWqVkdNgGSC7Q
         W47OGL+joFZokL2MgAo+Lxue5OKzFPJFpiTtEaxHsFRYXdkKMRPASxSDA3p/7+VJffIY
         RlKGQZrzIjbvABcchC03LHxG/puhUJX22aWzunxAgqOmlI2HyazUe2ttZrKUhzdxFZlH
         TpDrEw/NPuHN8GaqgvbLUX5rtASqhoRIzQbIwRoau4hhDtIh1N899gWgGjiZZAGQwWXW
         8ZgyVt0/oKwyAID4t7fEPrDGzq6BchbGJuLgpQufAy7H9bzUPPvmKPtumb/uuwHNo5hj
         akrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4adQYbcIqRIUCBEdkxswp1975OueOQrS15/MY1hDOBk=;
        b=V9559FOE6vhTyAqlhCMdYaYwP7XsiFo3Y+cudMxO2qGaXgTU7Nqlvu2JGYuZElejs2
         lYM6AgdHEOxBUAW0t791OTqsLz8YMo4Bw+/72o7l8AnH7HjI3s1xBnpUzHYvBC0CUiNc
         S6O+QpnYMWrJJ9sIETwb+fscsZlaca/usfQEH+XLhX6zxzPYO/rlJRD6kXLYL1kksFvF
         Y3OprCYcC6gik670GB8Jlnim2iI8w6qKi3pmz0Jx9IA4yGgYNN54X/NpUfRXdKI8GpCO
         7jzZKhu53YSRh9nWNToCFiFB8AMSMGTisOnICBtvMOipJb8LA++4nR31OX3XF8rHTILK
         JW8A==
X-Gm-Message-State: APjAAAXq1fQF6LxMHz7Il3hSO6bUJ5H4viSF4mfylU00gsDvI8rSyfjA
        IsvEFfwJrM2mtBuyJCL2BhMedQ==
X-Google-Smtp-Source: APXvYqx/TwHAJD6kk+b8dyJleYW2CHXvFxSsfvy2LLGu8vJEZP6ld5sJ0RhKrIWoNBlPsRROYLAv+Q==
X-Received: by 2002:a17:906:32d2:: with SMTP id k18mr23391835ejk.232.1561121302258;
        Fri, 21 Jun 2019 05:48:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j17sm849175ede.60.2019.06.21.05.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:48:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7170C10289C; Fri, 21 Jun 2019 15:48:23 +0300 (+03)
Date:   Fri, 21 Jun 2019 15:48:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, oleg@redhat.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        matthew.wilcox@oracle.com, kirill.shutemov@linux.intel.com,
        kernel-team@fb.com
Subject: Re: [PATCH v4 5/5] uprobe: collapse THP pmd after removing all
 uprobes
Message-ID: <20190621124823.ziyyx3aagnkobs2n@box>
References: <20190613175747.1964753-1-songliubraving@fb.com>
 <20190613175747.1964753-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613175747.1964753-6-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:57:47AM -0700, Song Liu wrote:
> After all uprobes are removed from the huge page (with PTE pgtable), it
> is possible to collapse the pmd and benefit from THP again. This patch
> does the collapse.
> 
> An issue on earlier version was discovered by kbuild test robot.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  include/linux/huge_mm.h |  7 +++++
>  kernel/events/uprobes.c |  5 ++-
>  mm/huge_memory.c        | 69 +++++++++++++++++++++++++++++++++++++++++

I still sync it's duplication of khugepaged functinallity. We need to fix
khugepaged to handle SCAN_PAGE_COMPOUND and probably refactor the code to
be able to call for collapse of particular range if we have all locks
taken (as we do in uprobe case).

-- 
 Kirill A. Shutemov
