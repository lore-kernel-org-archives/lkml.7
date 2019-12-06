Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC25C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A3E2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575628260;
	bh=BFDhcVs07XxhlAcLug0w64ImfeksNTAlzdAXJjqPOt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bAbPeeTOwWfmOnHl68T60ZQN45Fh3WJrPikYorQwHDUIVFVHqR09Wjh2fwlKwQ4OB
	 X/O6y9R3Ir15xsoObDmDUh9TjRd2Z43xSZPnCmy2h6g5fTIzxQ1dBIeZl05qDUTUOF
	 NNgka3NR5v5UPfmQ2HHwRERMFbIvPSQ+j5HCmz0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLFKa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:30:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFKa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:30:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so7209354wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mhXoMaU1UVBlyQ18j97xc9RF9JW9UYyQB2n+rphqqfo=;
        b=DN4U2kaQtORqL/JKeZy32W0nRZv7+u8FG41CfyvVT4u4uRHJ67Ccbd6P7HnUmmVVst
         lcrzh5jOMLx2aeJeMeaYqmzDlaiOzHTAYMnMrhu4TYZOLtn0ccv8vg0/9k8xDiwolTrZ
         5eOqy66nLA7071p+882v9RIgwAJq5e7r5ew2/IS3EeXbYGGLygXsEMGXfPgc4Q/E072o
         nTaqjhdGC/rxIJjOB1sPskXcKZs5DdfnJuKByfpJlN/dvl5tyn9UoVzv1UPG5uElVlCy
         vod7N9AUwnK/lzSsWrXXZnVRUwryiVVpNG4k7lUnnA1rcUc9CloyMnOPWY73VIqzb89z
         0+pA==
X-Gm-Message-State: APjAAAUtX1NqKsrL450T93Fcjde7K6RGCYn1323ffmVGD0cjqTW6avYN
        NW/ZdVskVV2OP9IjnkvP2us=
X-Google-Smtp-Source: APXvYqzrDFccK7X9H1o6iY59fBFIiglCFoyDGEbEf2g1TDhd0HxoZ/ezkIG+sW98yOq/zRmldKE/BA==
X-Received: by 2002:adf:83c7:: with SMTP id 65mr14202364wre.368.1575628256938;
        Fri, 06 Dec 2019 02:30:56 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z13sm2983280wmi.18.2019.12.06.02.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:30:56 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:30:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 2/2] mm, drm/ttm: Fix vm page protection handling
Message-ID: <20191206103055.GO28317@dhcp22.suse.cz>
References: <20191206082426.2958-1-thomas_os@shipmail.org>
 <20191206082426.2958-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191206082426.2958-3-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-12-19 09:24:26, Thomas Hellström (VMware) wrote:
[...]
> @@ -283,11 +282,26 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  			pfn = page_to_pfn(page);
>  		}
>  
> +		/*
> +		 * Note that the value of @prot at this point may differ from
> +		 * the value of @vma->vm_page_prot in the caching- and
> +		 * encryption bits. This is because the exact location of the
> +		 * data may not be known at mmap() time and may also change
> +		 * at arbitrary times while the data is mmap'ed.
> +		 * This is ok as long as @vma->vm_page_prot is not used by
> +		 * the core vm to set caching- and encryption bits.
> +		 * This is ensured by core vm using pte_modify() to modify
> +		 * page table entry protection bits (that function preserves
> +		 * old caching- and encryption bits), and the @fault
> +		 * callback being the only function that creates new
> +		 * page table entries.
> +		 */

While this is a very valuable piece of information I believe we need to
document this in the generic code where everybody will find it.
vmf_insert_mixed_prot sounds like a good place to me. So being explicit
about VM_MIXEDMAP. Also a reference from vm_page_prot to this function
would be really helpeful.

Thanks!

-- 
Michal Hocko
SUSE Labs
