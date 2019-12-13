Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246ECC34352
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B39224741
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9Z6gPhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLMM5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:57:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37643 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbfLMM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576241851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9VSUdKWho0AsMY5EAuNCRxldiXE6vz+eRj4A1RpznE=;
        b=M9Z6gPhSmBz+RLo3zCnmIJRZtu09ZDR9fSv0okoqmWJvfNmePGzF7jAqH2Kj6H2JJkFUjb
        odvpvGJaocHWpPkIVAEQbfsT26+KV+CjvAsoxrqA8mpfFqHlzMpqbLdQnNeSF9wUMt3LpG
        LxBLldJa/I8wfCmFadiTOgNRsu91t7c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-nlLw_sDSP-2FEA_EHgK9qQ-1; Fri, 13 Dec 2019 07:57:30 -0500
X-MC-Unique: nlLw_sDSP-2FEA_EHgK9qQ-1
Received: by mail-wm1-f72.google.com with SMTP id z2so1776038wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 04:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b9VSUdKWho0AsMY5EAuNCRxldiXE6vz+eRj4A1RpznE=;
        b=Su83KEqFm5fO2I3PMaWUxSC6y4dl4XSskxWoNBvlCkNgcGWQmrQq6umHUF3V83Xlju
         KPLq1R4JjP+qJtWWsyLXxk5Fb4pR+swBQIwTXYbAlNPtR+IgsE0yZ5Fo6txPC46IG3v3
         44EBUZuhEKKO0vmAiz8Uk8zwNn5MjTQycB1iopG3XtxWaTXNaIIyr3GoEFqhMKQdZyj1
         PTahakWPGIDyjZ1oh01nyxlF8e87TLD9jrnxYqBw3mhJXz8C+mFJiCeTzD7vy7d2L1qY
         4Ydv1NzrhKh4hUo6VYvMsis8gNaEEEq38aDUBEhF3Ql5hiROdRwXeGs/5O2A5dkr9Gxs
         w5wg==
X-Gm-Message-State: APjAAAXvrAovcSNHQPPhlVsUwFDohbACK2T4bJ70KfSXII7BnmYK2pFb
        FMreufbivDGa7IepxX9V90t3Ybfh/ojcBDaQrPKIO4vlhsGCU/qX1NOBFpuG9YPHf1Wf9M/7Mo1
        WEFnRVd1uBEdDbxg9oK2UZP4e
X-Received: by 2002:a5d:4847:: with SMTP id n7mr12782919wrs.30.1576241849424;
        Fri, 13 Dec 2019 04:57:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyooJsG59h/SK6I3qzEzqYCu18nX3AX3vzKAV9jTMjSRqTrZNGY7kFwDuyC2i72yIcBNrfkKg==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr12782893wrs.30.1576241849183;
        Fri, 13 Dec 2019 04:57:29 -0800 (PST)
Received: from [192.168.1.14] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id q15sm9897425wrr.11.2019.12.13.04.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 04:57:28 -0800 (PST)
Subject: Re: [GRUB PATCH 1/1] loader/i386/linux: Fix an underflow in the
 setup_header length calculation
To:     The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, eric.snowberg@oracle.com, hpa@zytor.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, phcoder@gmail.com, rdunlap@infradead.org,
        ross.philipson@oracle.com
References: <20191202172939.29271-1-daniel.kiper@oracle.com>
From:   Javier Martinez Canillas <fmartine@redhat.com>
Message-ID: <74fdf9ed-814b-0fc8-d405-79eb1011b9ee@redhat.com>
Date:   Fri, 13 Dec 2019 13:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202172939.29271-1-daniel.kiper@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 12/2/19 6:29 PM, Daniel Kiper wrote:
> Recent work around x86 Linux kernel loader revealed an underflow in the
> setup_header length calculation and another related issue. Both lead to
> the memory overwrite and later machine crash.
> 
> Currently when the GRUB copies the setup_header into the linux_params
> (struct boot_params, traditionally known as "zero page") it assumes the
> setup_header size as sizeof(linux_i386_kernel_header/lh). This is
> incorrect. It should use the value calculated accordingly to the Linux
> kernel boot protocol. Otherwise in case of pretty old kernel, to be
> exact Linux kernel boot protocol, the GRUB may write more into
> linux_params than it was expected to. Fortunately this is not very big
> issue. Though it has to be fixed. However, there is also an underflow
> which is grave. It happens when
> 
>   sizeof(linux_i386_kernel_header/lh) > "real size of the setup_header".
> 
> Then len value wraps around and grub_file_read() reads whole kernel into
> the linux_params overwriting memory past it. This leads to the GRUB
> memory allocator breakage and finally to its crash during boot.
> 
> The patch fixes both issues. Additionally, it moves the code not related to
> grub_memset(linux_params)/grub_memcpy(linux_params)/grub_file_read(linux_params)
> section outside of it to not confuse the reader.
>

Maybe you should add the following tag?

Fixes: e683cfb0cf5 ("loader/i386/linux: Calculate the setup_header length")

> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

