Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E831C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350392084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnB8/Pcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfIKQxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:53:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41724 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfIKQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:53:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so24375420wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTW2NGhchHctlDfByjQ3iFEDbmI3VdsCUaLfFyoMAJ8=;
        b=hnB8/Pcy7pVNims5ONvJOOiLXQquQNUiLlnpuExQysfOSHUYBCHDjSaewyv3gh9S3L
         rjbI2zg3KwrS6Td16efQHiypKuIAigmR0XqaI0aO7iELofYqsoOOy/kTWx2aVVoZ8OpS
         L0FPqF95b7ksipCMWGqHwXj5oC6S+IU4adGodm5uCbHfrK09wyRO61F0HCQI0xzDEpBB
         5haI+KEXQcefks+1f2d4xCf+radDZ9SQd9DdWWnKf/1lwaZMo2c1J2MvzWBxg3Ant+Ec
         5KZZIqRp2cBbjGrvSfgxAlTjIsCzBVe/ZQYE9V8Mw+n3LUM7g2/478Ec8V6Y5U4pqmy3
         iAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTW2NGhchHctlDfByjQ3iFEDbmI3VdsCUaLfFyoMAJ8=;
        b=HMvfx2n9NdDFcry0AtJVhJ+ZeZrhhdV1uneAOY+f0UZMCp3dDf8CHNDRwAfRuhGcaY
         +P4hx3gJUQESvz2D9vNtwv5Bn2cpt2WbacTX1STRdQdq2FD3yTj0UeBJ0i9IK54fRMz6
         46p+xKH+HtmbQHntaJb8RpKtWDFmd99HzyN+ALSBXmrdk6MKcsosr2i31FVq2iFG95fB
         kfZTgOp3845muMDL6Nc++MGY7iVj1l1Cy89NPWxkIpO6f3HuVVnyb698VuuK1LsSKfn1
         kqIdbCMAxPO1peaHvH+p+y9zkzZ4LYBsZk/He1V7H5DCeVt+4WoI+t/ySyRwmVHaqG3i
         0Bgw==
X-Gm-Message-State: APjAAAUo1k+7Z+WdipcgyYtfbSabTw36QLXNeqaO75Y4Mesotr9UfeMR
        qdGWo2UOXxi9jkf0ua/rtDMpwQ==
X-Google-Smtp-Source: APXvYqzrQLLJCrnyf7C59El44czLd6dbLQsyczqdPGvatxMhN+DToH5Fg6V5WD/fQBv+dh3aJDCSvQ==
X-Received: by 2002:adf:a357:: with SMTP id d23mr3448326wrb.18.1568220825432;
        Wed, 11 Sep 2019 09:53:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id y6sm2420326wmi.14.2019.09.11.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 09:53:44 -0700 (PDT)
Date:   Wed, 11 Sep 2019 17:53:41 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        maco@android.com, gregkh@linuxfoundation.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH] module: Fix link failure due to invalid relocation on
 namespace offset
Message-ID: <20190911165341.GA40932@google.com>
References: <20190911122646.13838-1-will@kernel.org>
 <20190911133506.GB7837@linux-8ccs>
 <20190911164012.nalsccw6jku7gbpw@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190911164012.nalsccw6jku7gbpw@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 05:40:13PM +0100, Will Deacon wrote:
>On Wed, Sep 11, 2019 at 03:35:06PM +0200, Jessica Yu wrote:
>> +++ Will Deacon [11/09/19 13:26 +0100]:
>> > Commit 8651ec01daed ("module: add support for symbol namespaces.")
>> > broke linking for arm64 defconfig:
>> >
>> >  | lib/crypto/arc4.o: In function `__ksymtab_arc4_setkey':
>> >  | arc4.c:(___ksymtab+arc4_setkey+0x8): undefined reference to `no symbol'
>> >  | lib/crypto/arc4.o: In function `__ksymtab_arc4_crypt':
>> >  | arc4.c:(___ksymtab+arc4_crypt+0x8): undefined reference to `no symbol'
>> >
>> > This is because the dummy initialisation of the 'namespace_offset' field
>> > in 'struct kernel_symbol' when using EXPORT_SYMBOL on architectures with
>> > support for PREL32 locations uses an offset from an absolute address (0)
>> > in an effort to trick 'offset_to_pointer' into behaving as a NOP,
>> > allowing non-namespaced symbols to be treated in the same way as those
>> > belonging to a namespace.
>> >
>> > Unfortunately, place-relative relocations require a symbol reference
>> > rather than an absolute value and, although x86 appears to get away with
>> > this due to placing the kernel text at the top of the address space, it
>> > almost certainly results in a runtime failure if the kernel is relocated
>> > dynamically as a result of KASLR.
>> >
>> > Rework 'namespace_offset' so that a value of 0, which cannot occur for a
>> > valid namespaced symbol, indicates that the corresponding symbol does
>> > not belong to a namespace.
>> >
>> > Cc: Matthias Maennich <maennich@google.com>
>> > Cc: Jessica Yu <jeyu@kernel.org>
>> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
>> > Reported-by: kbuild test robot <lkp@intel.com>
>> > Signed-off-by: Will Deacon <will@kernel.org>
>> > ---
>> >
>> > Please note that I've not been able to test this at LPC, but it's been
>> > submitted to kernelci.
>>
>> Thanks for fixing this so quickly. I can confirm that this fixes the
>> build for arm64 defconfig and x86 built fine for me as well. I'll wait
>> a bit and apply this at the end of the day in case Matthias or anybody
>> else would like to confirm/test.
>
>FWIW, I've managed to boot arm64 Debian under QEMU and load/unload
>modules successfully with this patch applied on top of modules-next.

Thanks Will for fixing this so quickly! The patch looks good to me.

Feel free to add
Reviewed-by: Matthias Maennich <maennich@google.com>
Tested-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias
