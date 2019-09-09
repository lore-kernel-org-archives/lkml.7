Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349D6C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC2321D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bC1iKUUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391334AbfIIRAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:00:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42107 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfIIRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:00:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id y91so13603267ede.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndNymM6S7tmHE+n2EfAPZaAIl9m2k/Hd15vX5tVSFn0=;
        b=bC1iKUUAEbStsWoLLyFmH5e3Rn8L60J3eOAqn15+XFheVcXT1DobBZSZOvDsKrkPto
         BZiYeUcnpJuBt0piDhdzCsqC3hIod7bQagzUG9EjXBu0ESLXWCVV2X7T0c81KPLM1Uf5
         0f7ixvlLeBdwKRO29lKj8JclH/y5G451SsJIj+y1zKjGQqQ4t1XF2xWUTa0iI02AECtm
         UGFfXMsdzSC33aaEpg621gISPu5F5vPOIUSC4aFqzcjw2P7AvkYRRZ7AgQ3ewr5RQp3C
         b5f90jb1+egIK7q+SbO3Y6RqrcCAr280k27p746RhVM2R7SGmgTERnkk1Axx5L/3rZx+
         Tu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndNymM6S7tmHE+n2EfAPZaAIl9m2k/Hd15vX5tVSFn0=;
        b=mmuEkfWeYBKb2bi1WbPbasryfXxgEPRl9CqeVMWi8dGG9yrVLAg38ZEMwr7eEYudk7
         qvwyEOCH13QDqFrmZFHh86uxM4uiKxbPqYJfWI0HL7I8eFn5uktTeFV8ivJCV/DoOqTT
         Jv6WmZUjvnp8n6Pj911xnHXsBFTwkBrw6zEDUJQ6oIJc2Ogpbw44MiKJZsZ5kXGTe+if
         rZK6KSf50KKmFqL9et8bFkRCipmjK/hLG7e0otHfdpawpw2vHIzkBbTckZJUR0nfhLT6
         WVTQQZrKuBfsyh0XcWPL3lDuImJPW+Hv8Zj3D+80I/Vq3wqVFKbukiahVQalsz8NKhRv
         N8ig==
X-Gm-Message-State: APjAAAWBKpHs1p+c20yCeRpdaH0CRNKKMwI+H+DB7AZJThHLtxxa07aq
        WUryV1hY2WeGyAovjjOjf0F4xg==
X-Google-Smtp-Source: APXvYqwrMgzfqO4cc8VaH4OYBbPyjLCLYVUXkYW0y564TeNoEu15jhrHaKYbf96/6CjMmoqhLR3q1Q==
X-Received: by 2002:a17:906:35c2:: with SMTP id p2mr10087253ejb.241.1568048438153;
        Mon, 09 Sep 2019 10:00:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id ot4sm1832093ejb.43.2019.09.09.10.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 10:00:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4F3861029C4; Mon,  9 Sep 2019 20:00:36 +0300 (+03)
Date:   Mon, 9 Sep 2019 20:00:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        mst@redhat.com, catalin.marinas@arm.com, david@redhat.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, osalvador@suse.de,
        yang.zhang.wz@gmail.com, pagupta@redhat.com,
        konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com,
        lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com,
        ying.huang@intel.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v9 2/8] mm: Adjust shuffle code to allow for future
 coalescing
Message-ID: <20190909170036.t3gvjar3qjywjquc@box>
References: <20190907172225.10910.34302.stgit@localhost.localdomain>
 <20190907172520.10910.83100.stgit@localhost.localdomain>
 <20190909094700.bbslsxpuwvxmodal@box>
 <171e0e86cde2012e8bda647c0370e902768ba0b5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171e0e86cde2012e8bda647c0370e902768ba0b5.camel@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 09:43:00AM -0700, Alexander Duyck wrote:
> I'm not sure I follow what you are saying about the free_area definition.
> It looks like it is a part of the zone structure so I would think it still
> needs to be defined in the header.

Yeah, you are right. I didn't noticed this.

-- 
 Kirill A. Shutemov
