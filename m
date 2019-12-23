Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDBC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4521206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdhTbqUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfLWU17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 15:27:59 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54079 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfLWU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 15:27:58 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so233732pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0CpDSOHl4OB3Bl/8MPwGobF9HXf9d9LqUIFLz9HC5Pg=;
        b=WdhTbqUDds7nyFaC9p71RME7G0VwPZ9ZDH6V0nR6o0rqKzuerooiAls4fT/9Ui5t4x
         wqS8AZCEr60/tsFY+EP6KnlDlbpM7Ye/QWsI9YZ2CDiGa/AhTR2lk6KjF0FkwJu6EiA8
         tn7W8fxAFagZMlpEKbUVSCsIJdos/MnZvsA78QX1wer/aITw7vIE6qxGUvq9gJpG8zk3
         OYykfoWDypbvlEn6Uq6U9DLEGtUwaWcwEHgFXUeNq9klbkCGfpHGfazk+qeJESdOTu3A
         RilDvmQCO+nmvJ0BDvSyQvvqP7kPvmF3uKs8It21GkuvazsDqx+h6uHJoESP1noQXx8d
         3bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0CpDSOHl4OB3Bl/8MPwGobF9HXf9d9LqUIFLz9HC5Pg=;
        b=DCjXiUfRjP75ufd1U5+0WuYsUqSFYPH6/jJQbrk6nQRJDj1+LtIqqWe/PL+uw+o5+z
         tdbm/v3mYTHG1/VH5Q6xnK73RT7LhiB2G0edoYu0xuIiode1TYst/3JF36Wr9xYYCYbb
         w474jJueoW3rM+3GYY0rZq5qzCJ0d0geMOik4d+Vc+oQvMILkUEO0OQ1p/UFCcUVG34x
         naiHBp68hGjHh6GcgH+HjeCYHow9CcFmref9AjQ117KvMHPgp4xMPVX74/W3YTb4omdb
         o0JXPQAcxN8Zug2t2p9mF7L/3d1ELz130ZaPx2X54Tsc9izWwXgtGVyRSGQe5cCsg+yM
         Bb+Q==
X-Gm-Message-State: APjAAAWh2kXrBHb27B4G8U0OjbZXdZYF6Us4wFfQYF7J0cU3ZNRSaQfD
        pGuKorhxaIeW/ag/j3v/quYj+Q==
X-Google-Smtp-Source: APXvYqxbImqtxcivG20ioyyeelsS5eDCA5kPWmfhNdOu+pRVWG/5srb/+ywEPdeZXOlh7WPZS+T52Q==
X-Received: by 2002:a17:90b:3115:: with SMTP id gc21mr1095410pjb.54.1577132877922;
        Mon, 23 Dec 2019 12:27:57 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id m6sm328478pjv.23.2019.12.23.12.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 12:27:57 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity
 check
To:     "Chen, Yian" <yian.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org
References: <20191211194606.87940-1-brho@google.com>
 <20191211194606.87940-2-brho@google.com>
 <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
 <93820c21-8a37-d8f0-dacb-29cee694a91d@google.com>
 <4c24f2d2-03fd-a6cb-f950-391f3f7837cb@intel.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <14ccbc00-7451-bd2e-d861-01c422cad53a@google.com>
Date:   Mon, 23 Dec 2019 15:27:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4c24f2d2-03fd-a6cb-f950-391f3f7837cb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 2:19 PM, Chen, Yian wrote:
>> Regardless, I have two other patches in this series that could resolve 
>> the problem for me and probably other people.  I'd just like at least 
>> one of the three patches to get merged so that my machine boots when 
>> the original commit f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region 
>> in BIOS is reported as reserved") gets released.
>>
> when a firmware bug appears, the potential problem may beyond the scope 
> of its visible impacts so that introducing a workaround in official 
> implementation should be considered very carefully.

Agreed.  I think that in the RMRR case, it wouldn't surprise me if these 
problems are already occurring, and we just didn't know about it, so I'd 
like to think about sane workarounds.  I only noticed it on a kexec. 
Not sure how many people with similarly-broken firmware are kexecing 
kernels on linus/master kernels yet.

Specifically, my firmware reports an RMRR with start == 0 and end == 0 
(end should be page-aligned-minus-one).  The only reason commit 
f036c7fa0ab6 didn't catch it on a full reboot is that trim_bios_range() 
reserved the first page, assuming that the BIOS meant to reserve it but 
just didn't tell us in the e820 map.  My firmware didn't mark that first 
page E820_RESERVED.  On a kexec, the range that got trimmed was 
0x100-0xfff instead of 0x000-0xfff.  In both cases, the kernel won't use 
the region the broken RMRR points to, but in the kexec case, it wasn't 
E820_RESERVED, so the new commit aborted the DMAR setup.

> If the workaround is really needed at this point, I would recommend 
> adding a WARN_TAINT with TAINT_FIRMWARE_WORKAROUND, to tell the 
> workaround is in the place.

Sounds good.  I can rework the patchset so that whenever I skip an RMRR 
entry or whatnot, I'll put in a WARN_TAINT.  I see a few other examples 
in dmar.c to work from.

If any of the three changes are too aggressive, I'm OK with you all 
taking just one of them.  I'd like to be able to kexec with the new 
kernel.  I'm likely not the only one with bad firmware, and any bug that 
only shows up on a kexec often a pain to detect.

Thanks,

Barret

