Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA313C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868C4216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Yzt1J203"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfHALTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:19:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38684 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfHALTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:19:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so34013026edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qkKpSTDuuwbIMR/7MbiNrB08VgfKwqP+sli4OTfz1gY=;
        b=Yzt1J203i5UaLb2ByniXCHSrE3OhEgnQfeu54s8xJucGCdyxoKsLbHGRhZsFRJpNrV
         F7zCOoVhdnnd+cfX0k0Bi0XvxD+Et5ZfpdlHyX/egg+VJ7fC6/tbb2Ewry0WiYu9rQ3L
         wvgU+2TdbrfP3wwSbAVAtW0RUhVq4hOugmAZZrv8MT05kS4Eek87hzHHdcs8XxpBLYn0
         7615oJ4D9zlLCIcJPyWyfvwwGm9vtX1ys+2UvvDqJQHTIcqwtjRDolSm3K57UNVyW7OO
         BUDrc/ihfpfHmn05kCOru0irD6vVDgUhNNu3ncF+VJIGNavENV4OEmyrirRLZJuVEgf9
         uiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qkKpSTDuuwbIMR/7MbiNrB08VgfKwqP+sli4OTfz1gY=;
        b=K0min77fFsfcrqBKy9lEYM4Htar/H4RoS54F7pJtVJ22j87gcGYugYP3xM9qNwGOhJ
         +dyNuzVdXg2MkLEVxIeJgdY1Pi7Y+FqwSUI1FA+2LfmKMuFeFXxxIJPJyKC4/+LjTP3l
         382qDeTHpO6dDFCzg5OKObib6JXjEtVjXEOXhHBRG00VqvVfV6Mp/CPQRsd7Hfl2dE4q
         VQ4lZeL4+13Wot6/eLPs6brOIobCBsT7D+0x6u2ObJDO2dmg7wSMF7oqBLSpTok/VZHE
         T5nsr7x4ynLOeweylzI+VOxAxIYJvMDW2QEPKIj4wfaxe1BalxTOJrb415JEAJ232cSS
         fmmw==
X-Gm-Message-State: APjAAAVcZTd8TT9r/bJid+bxS6UXJnxcYv2Xrds481UKL8kfAQkDqXyd
        glYnt4lTaSwHxUbXgNsad+Y=
X-Google-Smtp-Source: APXvYqyF6SX0CWzPPaoMgH0374aYW1XGVWRamvSqB0icTKG4hTO5BH/o437WyHbZv3Vt63NUESQFzg==
X-Received: by 2002:a50:89a6:: with SMTP id g35mr116231607edg.145.1564658386729;
        Thu, 01 Aug 2019 04:19:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id fk15sm13004072ejb.42.2019.08.01.04.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 04:19:46 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AF846101E94; Thu,  1 Aug 2019 14:19:45 +0300 (+03)
Date:   Thu, 1 Aug 2019 14:19:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, oleg@redhat.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        srikar@linux.vnet.ibm.com
Subject: Re: [PATCH v2 0/2] khugepaged: collapse pmd for pte-mapped THP
Message-ID: <20190801111945.t5jw3vivvfun4n27@box>
References: <20190731183331.2565608-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731183331.2565608-1-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:33:29AM -0700, Song Liu wrote:
> Changes v1 => v2:
> 1. Call collapse_pte_mapped_thp() directly from uprobe_write_opcode();
> 2. Add VM_BUG_ON() for addr alignment in khugepaged_add_pte_mapped_thp()
>    and collapse_pte_mapped_thp().
> 
> This set is the newer version of 5/6 and 6/6 of [1]. Newer version of
> 1-4 of the work [2] was recently picked by Andrew.
> 
> Patch 1 enables khugepaged to handle pte-mapped THP. These THPs are left
> in such state when khugepaged failed to get exclusive lock of mmap_sem.
> 
> Patch 2 leverages work in 1 for uprobe on THP. After [2], uprobe only
> splits the PMD. When the uprobe is disabled, we get pte-mapped THP.
> After this set, these pte-mapped THP will be collapsed as pmd-mapped.
> 
> [1] https://lkml.org/lkml/2019/6/23/23
> [2] https://www.spinics.net/lists/linux-mm/msg185889.html
> 
> Song Liu (2):
>   khugepaged: enable collapse pmd for pte-mapped THP
>   uprobe: collapse THP pmd after removing all uprobes

Looks good for the start.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
