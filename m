Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9CC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9B624717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmvuOLY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfLMObk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:31:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35670 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:31:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so2197182qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ykZo3kG5ISYmLvjiMpJlkxot5ywM3Vp6sip1X77Jcyw=;
        b=ZmvuOLY2OLj5gJEZSCS9MLSflO3nur5U4G0jfmS3Vi4JUEXPLq1mO1hniQJWD3i1MM
         UsEfpzKFKlfr1t2rfpsf0EOIEqQZWQji91CsYnjndbmkIkUNaXYbHcJrwVh/8jk+y+UK
         dESEyoWyxC3OKowZygAEzHIlHH8uj5ScAqkS3I40xzMZRW7d1mU2UtGI20G+752MgVEn
         +WWDbc2kP7cAmnZkD11zQ9oLwOfPQcm9cLTY2GMJMisxkvc0AfUzzDcMmraRIP4ZAzdU
         mBcf4MKtRdpyhmhUfgBuAcz1TbrshSGS63P+qTy3xlYE9Yp8qgcUqe9Nsai26KGMpJyL
         Iaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ykZo3kG5ISYmLvjiMpJlkxot5ywM3Vp6sip1X77Jcyw=;
        b=mxAx3g8NMupZtb84ejFIUZSS/2OHhpj+XYEBwpsw+1Uwgz4G6N54+ffg3QK1HMk+sx
         3N5+eSd5waGEavhy3i9T5sOOQj7r8QTLqg39iQCDKGBMYsdZW4UYl1SuoBqyCT+Cwohb
         /ULtq4aiT+cEwfWnFoROj6gyXPaQU2UAYKeprMz2eUHr7kP1FPaveXQOku/R++vEoyqj
         oaicPcii0begcwyP+TV0aArSZF2xFDaN0GyJkKHokT58Mtko06cN5smvft9IM9mcOEuV
         Rh1V+LxB5olJ9++jggNQGTW532lOWxouidApqJ5ySrzyD+2NooioUosFxOYqMH5VlR0h
         z6fw==
X-Gm-Message-State: APjAAAXTqgy4lIAY4M0NO0zEDseAHIyeSEdjnz4NCH2v65Dj+ZO0L2xq
        HDt8ahhSEIXcLDwakxA3T/6EJOj8JUa4IQ==
X-Google-Smtp-Source: APXvYqwZoU/9A01lyXQsE83D/uJ3Rhf4+zPgybuF9pUjpWSaeFFDYMW6+CIC83P4hM0EufocBt2YlQ==
X-Received: by 2002:a37:274a:: with SMTP id n71mr11692954qkn.302.1576247498387;
        Fri, 13 Dec 2019 06:31:38 -0800 (PST)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id v7sm3467318qtk.89.2019.12.13.06.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 06:31:37 -0800 (PST)
Subject: Re: [PATCH 0/3] iommu/vt-d bad RMRR workarounds
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20191211194606.87940-1-brho@google.com>
 <35f49464-0ce5-9998-12a0-624d9683ea18@linux.intel.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <8a530d5c-22e1-3c2f-98df-45028cc6c771@google.com>
Date:   Fri, 13 Dec 2019 09:31:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <35f49464-0ce5-9998-12a0-624d9683ea18@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 9:43 PM, Lu Baolu wrote:
> The VT-d spec defines the BIOS considerations about RMRR in section 8.4:
> 
> "
> BIOS must report the RMRR reported memory addresses as reserved (or as
> EFI runtime) in the system memory map returned through methods such as
> INT15, EFI GetMemoryMap etc.
> "
> 
> So we should treat it as firmware bug if the RMRR range is not mapped as
> RESERVED in the system memory map table.
> 
> As for how should the driver handle this case, ignoring buggy RMRR with
> a warning message might be a possible choice.

Agreed, firmware should not be doing this.  My first patch just skips 
those entries, instead of aborting DMAR processing, and keeps the warning.

So long as the machine still boots in a safe manner, I'm reasonably happy.

Thanks,

Barret


