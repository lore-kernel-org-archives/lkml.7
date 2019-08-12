Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0DC41514
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33432206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Ns5tnFaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfHLUdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:33:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36440 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:33:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so50057719pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=opuTeOP019YiHjS7zgVGx1N/ZtI2m573pQ8Fm6DPedA=;
        b=Ns5tnFaXWDviA+GNTixFkO7AFl1W+l/Ald/kQO5BWa44a6ukvr1eWIfWjaWVDYUYDj
         hiAQT2HpufQzPthDGeB765CF3V6cCc9ECB9Nb9FumVOdvKyCv603isBx/5MPS6iHlrNj
         YgxsfNStteKFyfoyRgVQ7FztMMbz+A+7H9xCy4FP4N6hIP3FexB/hSxdWfnYZ5e8qxoO
         n8ijIrIRl4bVRGBQMRhePCuyMmbw7FhP1X3hyIp9VFPC+iRXtGEIKjnn3rnFwdAycubP
         1wpdkQhN3+kVMZT8ywoPlKyHLiAEMXVoKcD7/Lr1NHmQ8oLt8qXpYTHauzLeviIHKc2M
         tWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=opuTeOP019YiHjS7zgVGx1N/ZtI2m573pQ8Fm6DPedA=;
        b=ojsyqzKzlAHRzJ6uIBrtzUBvoymi/pFYYpLMlfkNIz2u961Ce4Ve5L/d3u45NvoXe4
         ZbxCfvOX3gBVgEmfTGwcmwItUaPCA8YVTg7jnzerv4K1hp+HqLtXtGm+UXKWsg8sR5jb
         hxje6e+4766VoFSQpT0gZ5+0L3sdqao2sy8M88H2qj/V/sb1U+8jlUk12gWU29/DCTRN
         en4MxAI48rQdDIFQO3DktX4wjToTz6gPaj43x4m0Y3tANKNa08+ne5pSTgiyjkRMsBdZ
         VThqRj9onyYvVvMI8U9Uar6YgYj/bpo0FoRNtHbyoHR5NjjhUVYjzulUm/5iQqFUe+8u
         joWg==
X-Gm-Message-State: APjAAAXvhad9Ljo24LBQ2HbgZhOgsBOKlCazaLHSA5+mWp8GvDwtLklX
        lMUGhdqeGGF1k/vinLjbsAIzqw==
X-Google-Smtp-Source: APXvYqzLso2VXLAcxk2gXZWzzA185FIPfyG4h7hY0rd/zhvtbW+18JphumXy+BZjj65b5PHnBueorA==
X-Received: by 2002:a17:90a:d793:: with SMTP id z19mr1014808pju.36.1565641986978;
        Mon, 12 Aug 2019 13:33:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f08])
        by smtp.gmail.com with ESMTPSA id b6sm93774090pgq.26.2019.08.12.13.33.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:33:06 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:33:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v10 2/7] filemap: check compound_head(page)->mapping in
 pagecache_get_page()
Message-ID: <20190812203304.GA15498@cmpxchg.org>
References: <20190801184244.3169074-1-songliubraving@fb.com>
 <20190801184244.3169074-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801184244.3169074-3-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:42:39AM -0700, Song Liu wrote:
> Similar to previous patch, pagecache_get_page() avoids race condition
> with truncate by checking page->mapping == mapping. This does not work
> for compound pages. This patch let it check compound_head(page)->mapping
> instead.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
