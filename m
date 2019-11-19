Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B49C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E94222DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pMNRPe/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfKSKrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:47:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38663 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSKrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:47:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id v8so22773905ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZeUoRBlonDBywzKfeqqP13/zDfclITwdseqORXN8Cf8=;
        b=pMNRPe/vbBEEGmwaWUdl00xTZ6wQoousS+UdFgtJC/pWhowy4zMVZjnDPZzrqVJYEt
         2r7GEZ5b7/mdzlTO/V40zTu6h8qStWZhGLBixdIGD6kwhWmF9jDvcZLLYDp8MqlAUHdT
         SjoXj+PFJjsZ78X9Q0cgmJnvpJ5hozipVsRpquAxLPa4riHqYPI/CMOpe69EKjcnvRwH
         52O/pK47K2Soaj9dAvkuJUQvDPJvczfcEHjQQFqyMoZ7b2ZFRHWU5/tmmapT3h+HOsrk
         g/F+vEIOLx3FuFst6FtA/lsnuYlfuj8if3dqxvP19cFFSrcWXtgYHR+GEOsQCvXau6QR
         S5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZeUoRBlonDBywzKfeqqP13/zDfclITwdseqORXN8Cf8=;
        b=B2JnC+bkKj91w928o3tkwTzmOODtVi7dcna5NHbTqwBEPGsH3o18sbW+Co4SHiIOrw
         8BFAPuE7Og99czmdX8S8T/vDSJKutMHOtKN3WSPTDmqZK+OxEG+3L6W4XgK60hOlMnwe
         rK9R3xxz9vDW8VmW3X055ICUe29c3JOxpYPcELMeMKjvc6rS9n30/bJaltmvpoea2Gqy
         IkPNznfxwa2LvN13mc4D6PWKFcjJU9xbwIIlyra4EPORIO2G0DbiGw4HsxjTajwWsgqY
         AtTmBkuTaVuMQg0K4U0L6+/71c7sx7AzW6ho0BQoMdmNYoERGdcHBh1qfVIyUaj1DldS
         M9Kw==
X-Gm-Message-State: APjAAAVFH6ptHewx8uSWz49FvoZsTn/L0YpdnGUOIr5SmSQfah6yWzp0
        GMz6j39k1B9UIkkPOAdKlFXfWN9pGBM=
X-Google-Smtp-Source: APXvYqwjTgl8vU2jVXehL8zImk0x1eHm3t2yMg3AUBp9OVxqwasqP3PbsJyzfhvWoMG3Zt2ugIMwpw==
X-Received: by 2002:a2e:970a:: with SMTP id r10mr3366384lji.142.1574160459559;
        Tue, 19 Nov 2019 02:47:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c80sm786601lfg.81.2019.11.19.02.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 02:47:38 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id F354C100F52; Tue, 19 Nov 2019 13:47:41 +0300 (+03)
Date:   Tue, 19 Nov 2019 13:47:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kconfig: make Transparent Hugepage Support sysfs
 defaults to match the documentation
Message-ID: <20191119104741.rtjc7awl4k57boyu@box>
References: <20191119030102.27559-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119030102.27559-1-aquini@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:01:02PM -0500, Rafael Aquini wrote:
> Documentation/admin-guide/mm/transhuge.rst (originally in Documentation/vm/transhuge.txt)
> states that TRANSPARENT_HUGEPAGE_MADVISE is the default option for THP config:
> 
> "
> madvise
>         will enter direct reclaim like ``always`` but only for regions
>         that are have used madvise(MADV_HUGEPAGE). This is the default
>         behaviour.
> "
> 
> This patch changes mm/Kconfig to reflect that fact, accordingly.

No. You've read it incorrectly.

The documentation describes default behaviour wrt defragmentaton ("defrag"
file), not page fault ("enabled" file). We don't have any Kconfig option
to set default behaviour for "defrag".

> Besides keeping consistency between documentation and the code behavior,
> other reasons to perform this minor adjustment are noted at:
> https://bugzilla.redhat.com/show_bug.cgi?id=1772133
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5dae9a7eb51..c12a559aa1e5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -385,7 +385,7 @@ config TRANSPARENT_HUGEPAGE
>  choice
>  	prompt "Transparent Hugepage Support sysfs defaults"
>  	depends on TRANSPARENT_HUGEPAGE
> -	default TRANSPARENT_HUGEPAGE_ALWAYS
> +	default TRANSPARENT_HUGEPAGE_MADVISE
>  	help
>  	  Selects the sysfs defaults for Transparent Hugepage Support.
>  
> -- 
> 2.17.2
> 
> 

-- 
 Kirill A. Shutemov
