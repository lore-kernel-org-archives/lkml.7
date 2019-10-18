Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA4FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D4A20854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ped4rrJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634342AbfJRQtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:49:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41651 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437269AbfJRQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:49:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so4229257pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fk5TkOpRTpvTPvIhw+jhlH/EWYQ8SCFWPxmF3GrKXeU=;
        b=ped4rrJomSO8Qcd+AsAMZA070NAYHWro7VtIKJuL9kgSqKl/bjXvFmpIJGE+GbioWu
         KuDeNNAkDwi9w5N50nVaR08kMiP11Nu+jKWWqtcTHKKo1X03N3iP7L9NNy9p1j6ori5Y
         8E3a+TgNF4HIaBlwLWgOl+mZg4mzfvuJq+BDzUDc+XTK9DIBnXv+o7lvmPoQIBkvW5pk
         UFnYHPWDqeoXf1abjMPdqglUBJeL7VPQXxex0TGM4sgbIgatSyUjEdhuemM7bTsGDqWR
         TxXCq0/BvwqWM1HmnVe4wz9K2N29lO7r1wVVC07/hc9cIil6wLqiZuQhcLhbLKff7nig
         GI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fk5TkOpRTpvTPvIhw+jhlH/EWYQ8SCFWPxmF3GrKXeU=;
        b=lAqG9O7YJnz5kapaoKK4WmuY+9UDC7DXXaV1/dIE7FUgQ3TmLdwvIWwtTZwFHPjFjM
         Bkxi0k+pcwyVH6Q2GdQPAdU3vCDGyChwUo3Tn5CMoAw1GZBC030bKmpzKN8R0x7nUdeb
         1zORFSZOFV5p0t0Vxjfc/dSXVNAoo7eSA2BKPfJh9wined9CK9zURxcW7/igzAPJJZ1R
         0D3iNe3KIsbnrrnyuMV66Dx8YYf1MqJDrI0ZJjY9FG3zgmiOMXnCrOk6PtOGai4lIvt1
         hjav871lM68HUFOySi14PpENzWSseLQ4u26uI7O8eir1epJj0nZj6E0VfkSvBtPQQkfQ
         xDyw==
X-Gm-Message-State: APjAAAW6xeCJZdP8mT4aJp/gCdMg8q0FgL1HirtN/E+6NRMMjxtpWcRT
        7ayFa64xd9ZAx6IGyAAyrty/IQ==
X-Google-Smtp-Source: APXvYqzNkyEbDBFSb68fMtMY4IH1lrlqz0jazTRwI0mKFFgI83JhTG+uTnC9dghY0c7f09Cj90/1hQ==
X-Received: by 2002:a63:394:: with SMTP id 142mr11150477pgd.375.1571417385868;
        Fri, 18 Oct 2019 09:49:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::ac1a])
        by smtp.gmail.com with ESMTPSA id v9sm6691727pfe.109.2019.10.18.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:49:45 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:49:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm,thp: recheck each page before collapsing file THP
Message-ID: <20191018164943.GA179426@cmpxchg.org>
References: <20191018163754.3736610-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018163754.3736610-1-songliubraving@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 09:37:54AM -0700, Song Liu wrote:
> In collapse_file(), after locking the page, it is necessary to recheck
> that the page is up-to-date. Add PageUptodate() check for both shmem THP
> and file THP.
> 
> Current khugepaged should not try to collapse dirty file THP, because it
> is limited to read only text. Add a PageDirty check and warning for file
> THP. This is added after page_mapping() check, because if the page is
> truncated, it might be dirty.
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
