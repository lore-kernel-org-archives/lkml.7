Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1145C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A452D20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MRarh6C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393635AbfIWI2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:28:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41134 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404845AbfIWI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:28:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id f20so12006116edv.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PlnBoWmdR1wZQMraBmo6UgPzJr5syvfhEvHIy2QrtUI=;
        b=MRarh6C+fRkbT4z71nShZ5RGSLrhCQuv4OxuhLwgBY7hB93FNgsWEjVMJQCZuuZnJb
         ZelgdeAdc8ux6Wr5QUoCRBpK54PWXEMcHyOfBqvphLEqxjATNZ/hl/jiXP1cJSqafbah
         pR5BwnE4qsBhkeBWrH5F3js8hfxLP8KmkWqgz8iEYMzjws+DK1dpV/gF5TYAe3u+srTB
         BmDQf2All+JfFBFPaFheCx6ymlYs7iSaC26BaCqk2w6vnif4cImxCv977Yfn/Ax3PsRL
         Stccz4j52X0tOsjoC/zjjznjFZZSsw4RNY/prA9YXi9Y3xuiHV+VclcUhRXWsHUOYDFa
         MsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PlnBoWmdR1wZQMraBmo6UgPzJr5syvfhEvHIy2QrtUI=;
        b=WWUEJ34vJKkGE6ub+BzTfDaYW4LSjUvYh+j1KrM9KMhhUuPH1pLlSdRAcdQ9d6Tg3y
         1HIYATr6lFo4ynEu0grq/AnLk6U/KdOgDxIUZAqM9azwu8dn6DvENb/6AhCE851r4IvT
         onu886AaERfGVjkhB73Am1JidqHHXPMq6JLzg1hymrk6x1iFur+LwMtlHa9SK9ronZSj
         4pjKGuPCD2N61me6Eql2e+YG9yu1gqdcbHUBNm8Y8xE9FOCNkpAmvbN4xOmy49h6NiaS
         frBazyMJ0RMDZ/qWbcplSJWbYoKQvLrYOC2Rcs67pGzEH/AsHBCO1/8STSvfPSHItH8e
         0hfw==
X-Gm-Message-State: APjAAAVBHspm5j7bOglUJY8WncMIjEe4zq0mh2OMMEWP1/RLqjtoTiTC
        5wtksIofPk8Ih/weUR0oK5VBtw==
X-Google-Smtp-Source: APXvYqwfyMaWGIIWiECsmd3xkv/IOhdkWbJ1QV+G2FTfarkpzctYceNAbojdiMfoTKCmghIr0fi8Bw==
X-Received: by 2002:aa7:df16:: with SMTP id c22mr26499511edy.22.1569227300141;
        Mon, 23 Sep 2019 01:28:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v8sm2229345edi.49.2019.09.23.01.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:28:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F11101012F5; Mon, 23 Sep 2019 11:28:19 +0300 (+03)
Date:   Mon, 23 Sep 2019 11:28:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v8 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190923082819.k62npejhjudemsxv@box.shutemov.name>
References: <20190921135054.142360-1-justin.he@arm.com>
 <20190921135054.142360-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921135054.142360-4-justin.he@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 09:50:54PM +0800, Jia He wrote:
> When we tested pmdk unit test [1] vmmalloc_fork TEST1 in arm64 guest, there
> will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> 
> Below call trace is from arm64 do_page_fault for debugging purpose
> [  110.016195] Call trace:
> [  110.016826]  do_page_fault+0x5a4/0x690
> [  110.017812]  do_mem_abort+0x50/0xb0
> [  110.018726]  el1_da+0x20/0xc4
> [  110.019492]  __arch_copy_from_user+0x180/0x280
> [  110.020646]  do_wp_page+0xb0/0x860
> [  110.021517]  __handle_mm_fault+0x994/0x1338
> [  110.022606]  handle_mm_fault+0xe8/0x180
> [  110.023584]  do_page_fault+0x240/0x690
> [  110.024535]  do_mem_abort+0x50/0xb0
> [  110.025423]  el0_da+0x20/0x24
> 
> The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
> [ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003, pmd=000000023d4b3003, pte=360000298607bd3
> 
> As told by Catalin: "On arm64 without hardware Access Flag, copying from
> user will fail because the pte is old and cannot be marked young. So we
> always end up with zeroed page after fork() + CoW for pfn mappings. we
> don't always have a hardware-managed access flag on arm64."
> 
> This patch fix it by calling pte_mkyoung. Also, the parameter is
> changed because vmf should be passed to cow_user_page()
> 
> Add a WARN_ON_ONCE when __copy_from_user_inatomic() returns error
> in case there can be some obscure use-case.(by Kirill)
> 
> [1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> 
> Reported-by: Yibo Cai <Yibo.Cai@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
