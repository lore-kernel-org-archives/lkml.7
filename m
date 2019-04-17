Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816FAC10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACF721773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="o7ahXSz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfDQAie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:38:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41695 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDQAid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:38:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so25505504qta.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GSQ8TirPqwJAsSiNJnnBOgDcOzugydgBi2qhD2NrVxg=;
        b=o7ahXSz2i/MCNdJcDLIUjeRUnQrOMUjVO0O2rOd7/anrC6edj6S3XN+JD0ReWO+jW7
         L1J1dp/54x6tgI2PWhIaf3nsH44QWq+Vgcz8Sxe7JkdwoNrgs7HPnYrScLszhtZG+ECU
         qia8U8bP6On7i8fc97IYGGjpLwVUomgvKv1qQWw7rLDwPcwTUjxe0oOwbfQul/7lzM1s
         7MIcHgizsBH9k4qortLCalsLS/jwO2OdOopCUeC9GXrc8hdMQnTkNLCV4xxbVqzxNngu
         hVE9C/Mmb1wqVtMFv5/ehGdvonJvpcOHY9YuzQevp6mG04bb/2nroKnFlTQV4M0IccHe
         vs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GSQ8TirPqwJAsSiNJnnBOgDcOzugydgBi2qhD2NrVxg=;
        b=OOOaDZuv47oEqbiSD7zLDTCSmckDnteZRr8Cf5bEW9SpUa3fqzDyj4BiUER0U7U6Bo
         K9gIfOfzp3z3mpdpJfS3OwvXK2xegu3dJcxTImpp9rDYuiIZWn+HacNXLRIPxIBRCRaN
         fJfldTi5exY6dd4ZedMAOuz4KAg08MxbTWP8oZwV2loL0hpsER7Jkrc2sy4xRSHCgcJK
         AnfbpiUG/LaxgM5rpXrf8Y3/yXBkgTKz3SAbkHjKU9YDmKC67wjI7uVXaEHPoZEvHglK
         a/69yc6W28ZH1IJxvx1efejrRRd0+B2OB1YCU2jK3rbcRm6fJQQ5k3nDU16xqZeY+Ens
         7t9A==
X-Gm-Message-State: APjAAAW3WpBq/ZKP0wsL9QYptrs436WQkM0k7U2ACU4sOLOthwlKHKJW
        GZar3aj3fzrTsVkjOQMeWXLLIg==
X-Google-Smtp-Source: APXvYqxyj3c5SaB53jTF9KCSjeE4w29w3+bQn3OvwYk+jXeVoUrXvwm3Tabis7WSb+eX+V/vUrMeiQ==
X-Received: by 2002:ac8:3554:: with SMTP id z20mr71050811qtb.150.1555461512878;
        Tue, 16 Apr 2019 17:38:32 -0700 (PDT)
Received: from ovpn-120-81.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z16sm22698153qti.53.2019.04.16.17.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 17:38:32 -0700 (PDT)
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
To:     Borislav Petkov <bp@alien8.de>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20190409040502.55361-1-cai@lca.pw>
 <20190416171104.GI31772@zn.tnic>
From:   Qian Cai <cai@lca.pw>
Message-ID: <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
Date:   Tue, 16 Apr 2019 20:38:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416171104.GI31772@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 1:11 PM, Borislav Petkov wrote:
>> +	/*
>> +	 * Inform kmemleak about the hole in the .bss section since the
>> +	 * corresponding pages will be unmapped with DEBUG_PAGEALLOC=y.
>> +	 */
>> +	kmemleak_free_part((void *)vaddr, vaddr_end - vaddr);
>>  	free_init_pages("unused decrypted", vaddr, vaddr_end);
> 
> I don't understand what the logic here is: we have a couple of other
> free_init_pages() calls but they don't have kmemleak_free_part() in
> front.
> 
> Now, if kmemleak needs to be told that memory is getting freed, why
> isn't kmemleak_free_part() called in free_init_pages() ?
> 
> This needs more explanation.

kmemleak_init() will register the data/bss sections (only register
.data..ro_after_init if not within .data) and then kmemleak_scan() will scan
those address and dereference them looking for pointer referencing. If
free_init_pages() free and unmap pages in those sections, kmemleak_scan() will
trigger a crash if referencing one of those addresses.

I checked other x86 free_init_pages() call sites and don't see anything obvious
where another place to free an address in those sections.

__smp_locks[]: .smp_locks
__initramfs_start[]: .init
__init_begin: .init
from text_end to rodata_start: contains .notes, __ex_table
from rodata_end to _sdata: .pci_fixup, __ksymtab, __ksymtab_gpl etc

So, I don't think it need to add kmemleak_free_part() in every free_init_pages()
calls.
