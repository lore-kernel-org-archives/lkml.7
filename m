Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D3DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5991A2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uPGBabdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfK1Ibs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:31:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44727 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfK1Ibr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:31:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so494188lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ngIzBSaZTBdMqXGWOPe9GclRnKYINQpAHzSYxgt3Z4Y=;
        b=uPGBabdrg40M2eyaJnEIdzAkPAWAh66yboW71srLcihQEm3evrrLv74wXfV/y0V4vy
         zE/5pxbcMDSb1+4rtp1KpfxSCBM5IxnfAXZUnmZpBcXTFpLEv+9cXKxZbN0hqsTIuchd
         stcvU4DC7L3G2Y+HUlF8Qa7lC5LTD5RcGAB5Yxgk7W2ZzsLazJrIy7DArw/KamasuYuc
         ZP6uN9UEfkQfaHhAi1s7cd6epkq/kl6vd/sfaiYoNWbucL/y0c9caw50APZ8YKXkcb9p
         E1r9Ij0lC0+jumkCzaG1osQeFg7kxsC2RkGlhkx51mfDWXOyoqq5hd2zal85x52Zmz9P
         5/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ngIzBSaZTBdMqXGWOPe9GclRnKYINQpAHzSYxgt3Z4Y=;
        b=Ho+5NKNKvlcQl0N03HSULKr5yhNnOv2MyCl7FCAIr3Q31IgmRBQCPzOrZ1W1TF4seu
         FJN8D3H+B6OjRbzuUPseozJ22SDBj7DwCyycJBhKEKpzEd1Wx8vJfdwyIkwyCtU0VU29
         G4sV9tgsm3w1bgVR9REqhlJv6WwDrV+PSbFntZCEL/3Zt+ZhYA3ZMu++MzrHecx7FVFa
         tLL++sq1SuvoYvl8pTh3UMAyq/hO9jrCd5mAggj0qE+V7QlSG8Fr4v+ieJv87KGJNtoN
         oKBSrCy15d55pICl2dBXit2493IOhPDvwraJgx4iKvJHjK++Bz0Of9OQ67bD5+3xKyUJ
         PINA==
X-Gm-Message-State: APjAAAWfz8AT8aWrVkinKEJdIZ7AjHh78HlAzHsQbOkH80FAsGC+pcJg
        3DNMTmswCikvg6qxE9keNzymnw==
X-Google-Smtp-Source: APXvYqyjhpd1fwjyFGGobQaLrboEaWvt16SUkegSBCmGAMmjCSEb7g/vVLKhFYp3N5W/45siUXkQfg==
X-Received: by 2002:a2e:888b:: with SMTP id k11mr9117296lji.87.1574929905389;
        Thu, 28 Nov 2019 00:31:45 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s11sm8207800ljo.42.2019.11.28.00.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 00:31:44 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C25C6101715; Thu, 28 Nov 2019 11:31:43 +0300 (+03)
Date:   Thu, 28 Nov 2019 11:31:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_vma_mapped: page table boundary is already
 guaranteed
Message-ID: <20191128083143.kwih655snxqa2qnm@box.shutemov.name>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128010321.21730-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128010321.21730-2-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 09:03:21AM +0800, Wei Yang wrote:
> The check here is to guarantee pvmw->address iteration is limited in one
> page table boundary. To be specific, here the address range should be in
> one PMD_SIZE.
> 
> If my understanding is correct, this check is already done in the above
> check:
> 
>     address >= __vma_address(page, vma) + PMD_SIZE
> 
> The boundary check here seems not necessary.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

NAK.

THP can be mapped with PTE not aligned to PMD_SIZE. Consider mremap().

> Test:
>    more than 48 hours kernel build test shows this code is not touched.

Not an argument. I doubt mremap(2) is ever called in kernel build
workload.

-- 
 Kirill A. Shutemov
