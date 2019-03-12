Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F865C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD22E214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="EMZ2k1vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfCLHiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:38:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41727 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfCLHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:38:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so1161073pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vG7/p2YG5fIAtcp+Y5RzQtOa+meXAQOB2qrOCBt5U0A=;
        b=EMZ2k1vUUizGYd2dk7OOl1aCZdkfnqDzF81ycYcthVaxw6W4VJdLbBT0Ltxj0dE/Bd
         OSVLsh9+VFPYvdlEd7CqElc3k6heHayOqjyKfpj2g3+opgJM56g99VNeJxAhpSKbA4h9
         JZlfyFdjy+DIdswUfge8SQc2kN/1gQLokmqibgACrIZRTGZgSgy3O68b4lCxP3I9cO/m
         dIaBn2AWOv1+5/jQZe7K4CsFXHqYri6HEDq1JQJqlk8Q2JJmT5Ltm/qD83xCaE9ihf2V
         Eo+4TYEVE37KL2c1aOBTjMz3Uvk6JUO3yXu3/AILwngvHPc1bFTKEuYWgf1Wem2TqFVk
         AFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vG7/p2YG5fIAtcp+Y5RzQtOa+meXAQOB2qrOCBt5U0A=;
        b=aCuffItTddapFdyfkzCLAg2OCz1ghjho5zMzplBdoEsLLltgEZTI2gSaBopio05H33
         Smv2fGJLYO+IlY0DesAeTbY6RH5+3ubqQIrZoOMfcuDlYJqFrDZXRaYYwOcTfsOHddFI
         Uwa0xO4FR4prva1GuUpGueAnmbbswvkUk9Rwsz4+avvmkCsteN9XjNW3YuxMI5GFEw7z
         iSKEBDvAwQOFQpRNhJQhUArMkDyrnCXTuUWtZy6E/EnE6P5CiNEVUtY8+DmugxQ9OZfo
         olyNz+Qu6g1AIdZz3gKMZZq58TvjNHJ/U0JLg3088pAkMxIC9l3YMNw/lAR3e5ud1SsM
         l+PA==
X-Gm-Message-State: APjAAAXnxUdXV3pqtVMWihyRoA19Lh498zdl3CE/vaFz+1vE78asErlh
        JKz8Va2nTu7nYQYpr4ZyZeBaz2tHtPlMyg==
X-Google-Smtp-Source: APXvYqy4G6h0qSEMQCdQBiEN8JNg++JhJiqz+gPNhgkqj4Xho+QD6osrAa6tnGXbk02sp7urw8lncg==
X-Received: by 2002:a65:5cc4:: with SMTP id b4mr21541969pgt.334.1552376332844;
        Tue, 12 Mar 2019 00:38:52 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id f192sm19687127pfc.180.2019.03.12.00.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:38:51 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 771FE3011CA; Tue, 12 Mar 2019 10:38:49 +0300 (+03)
Date:   Tue, 12 Mar 2019 10:38:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v3 1/2] x86/mm/KASLR: Only build one PUD entry of area
 for real mode trampoline
Message-ID: <20190312073849.d6xezoaaffmbeyx5@kshutemo-mobl1>
References: <20190308025616.21440-1-bhe@redhat.com>
 <20190308025616.21440-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308025616.21440-2-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:56:15AM +0800, Baoquan He wrote:
> The current code builds identity mapping for real mode treampoline by
> borrowing page tables from the direct mapping section if KASLR is
> enabled. It will copy present entries of the first PUD table in 4-level
> paging mode, or the first P4D table in 5-level paging mode.
> 
> However, there's only a very small area under low 1 MB reserved
> for real mode trampoline in reserve_real_mode(). Makes no sense
> to build up so large area of mapping for it. Since the randomization
> granularity in 4-level is 1 GB, and 512 GB in 5-level, only copying
> one PUD entry is enough.
> 
> Hence, only copy one PUD entry of area where physical address 0
> resides. And this is preparation for later changing the randomization
> granularity of 5-level paging mode from 512 GB to 1 GB.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
