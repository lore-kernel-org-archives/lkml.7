Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF7ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2893D21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568181560;
	bh=3ypS9+H2EwN0SpLc6Y2kISgYfwEUW1gRWh6xPU0C5BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uM/zCADMdEWR7WX9YypvQEG461PYzVAiyOuak4vRCPm6aw/Od5uxeC0TyJDoE+xxO
	 eBHiEBiLl+ZBf78srq1dzrMmdW3Lg87HPcMFGC9WT5FkDGfLlhLej2DQJ6mka/9zxw
	 x6vv5PbBsIRlVXZjRxtBNQWMZ1M9dWTJCU7V8vBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfIKF7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:59:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39684 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKF7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:59:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id q12so1926206wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L+VskumO8DZY0fNQAHQAEHwj13ZWS0q3JEkxtqeOHLU=;
        b=dF7u80VkNW9G8z99FnhuunK2Ag9xEHuQemKMEAG/npZhR/qTKHU8i/U+32jCYphKL+
         TxbYEq3vKLSA/WdVcDs/rDoU5txX7prHcEX0S7aXJ7z8B1J/747DDqotyZUNIzr8Ur88
         mhb+sgNxKhfYtBR2QO3N73kKi5r9YMxGxAk+DfpmcuiJfVmfZ4Z7fcuUfNEdH8i3VhaJ
         ouEb3EbxH/kY2Js+THlhr0ynwMb9lUujH6C5lEjPOfl6Wa2IBSRriNx1Bya8cvTQ73Wa
         Cj6333PNnTcaip5FoeO1YNsnWNJHfMD7LAIhH95g3blfg30lnzLPJUeC+9blAFOnFzYA
         V5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L+VskumO8DZY0fNQAHQAEHwj13ZWS0q3JEkxtqeOHLU=;
        b=Nygz6DVr6TrfmSqFvBrWyc+8k+Wrvj3Swf3kSu65hwGSfqVd6LGeUO4dS/RZJDDnBZ
         wbNs1ZHKmF3wG2zGpXxRQV8XKVYA5s0PR7eLIk4hcjhZDMXD90phjjP8HqN9I4Xdu1YN
         dyaV+q1jOb+P0prilIG/TQ8QFI9BSxfrBIkNKeIrYPjeaSfcofyGCN3mzv8IkUtCs2AH
         fRDY+mVV0cMqoFZQ7vYxhuI0BGdNDFxxhZD9T5MegM5hEfaummf6sxFTmmD11pj5o+Ac
         VY41ih12FGXSeFDMZHgOlNikkR17wACVbxK0W4B7syPfSOaxll6Io0jwVuzL1YdElX0t
         Hxrg==
X-Gm-Message-State: APjAAAXzzKPppDWu19Wbjad5jECO4RltdwPnEOVDQBiUCgtaaCvtrSLz
        iCAhaf0YlGkkP6iZ3/WIRVw=
X-Google-Smtp-Source: APXvYqxUjCgvWp2pqomx5+bl7HzZBn2ZOB3oncrk3JlryEbTlKwp7t7r5MmS9Mhk3gqM7VQLLWMFNQ==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr2308170wma.124.1568181556667;
        Tue, 10 Sep 2019 22:59:16 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y6sm1508390wmi.14.2019.09.10.22.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:59:16 -0700 (PDT)
Date:   Wed, 11 Sep 2019 07:59:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 0/2] Fix SEV user-space mapping of unencrypted coherent
 memory
Message-ID: <20190911055913.GB104115@gmail.com>
References: <20190910133542.64523-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190910133542.64523-1-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Hellström (VMware) <thomas_os@shipmail.org> wrote:

> With SEV and sometimes with SME encryption, The dma api coherent memory is
> typically unencrypted, meaning the linear kernel map has the encryption
> bit cleared. However, default page protection returned from vm_get_page_prot()
> has the encryption bit set. So to compute the correct page protection we need
> to clear the encryption bit.
> 
> Also, in order for the encryption bit setting to survive across do_mmap() and
> mprotect_fixup(), We need to make pgprot_modify() aware of it and not touch it.
> Therefore make sme_me_mask part of _PAGE_CHG_MASK and make sure
> pgprot_modify() preserves also cleared bits that are part of _PAGE_CHG_MASK,
> not just set bits. The use of pgprot_modify() is currently quite limited and
> easy to audit.
> 
> (Note that the encryption status is not logically encoded in the pfn but in
> the page protection even if an address line in the physical address is used).
> 
> The patchset has seen some sanity testing by exporting dma_pgprot() and
> using it in the vmwgfx mmap handler with SEV enabled.
> 
> Changes since:
> RFC:
> - Make sme_me_mask port of _PAGE_CHG_MASK rather than using it by its own in
>   pgprot_modify().

Could you please add a "why is this patch-set needed", not just describe 
the "what does this patch set do"? I've seen zero discussion in the three 
changelogs of exactly why we'd want this, which drivers and features are 
affected and in what way, etc.

It's called a "fix" but doesn't explain what bad behavior it fixes.

Thanks,

	Ingo
