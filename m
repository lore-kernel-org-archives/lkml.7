Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1EDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 04:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CF9206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 04:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568347867;
	bh=3ez4L9vo2QvVV4HRgGQ9xolQfSEDtLPplmLm1EC3s8o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1ZgSkS7UozlkuB/Ywg9tY1zt0fLJ8buAdXJz1i22mlMCVm7wH2gi0H44C97O5GzXK
	 VsAIKme5Ulkm128kFxPsVuAeWEMVERljDsTg+bJb5ODvOjox6W/k5WqsI2oI7usDCJ
	 ucoeIpztzyhh0afa3AV5YddmPdVyaFKdVIqNz0u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfIMEKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 00:10:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIMEKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 00:10:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so17264111pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 21:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GO2No0HIdUGvuyNINzggSwNk3CJtj+AbrCdCV94Fi6E=;
        b=SSmbRrBjsEEamOBcE0nmg+Q713xgceFcoZI/Ez7P/C/fTVxlM6zhagrKkn/4MHc0PO
         ebUurxkkHNE9JDIzn7jM166v6CsAnXvz9SSejOHLeuRxlCey/ASC47TJnEHEYyqdlxvY
         0SZwnoHFma/LUGL876AP6C90fd41Ja4XKoBp0wu46dRjVElSmm2oTCkJj459G9wQxuTc
         JbZOCu4ac5hWySuEyXQczDUKSc50UzrzxBtx3Xuw7uD+QaHCM0QMCOELwBgUzu4mrRey
         c9jg/7e+758Zh2eLSp2UPOvMn2fiD8Is3HJFxL0QGwY0DQPA6F6dcyrmk7oIwRdmrk2l
         PlfQ==
X-Gm-Message-State: APjAAAUijnwRmTKPkURHJTK1yLXXykI5DQrWy1NauHoEWkBxgAPBAxS7
        Wl9GNZ32hdaBU7z6xsWtO9BHlw==
X-Google-Smtp-Source: APXvYqw7rcmyyNzCGwbrGFsuY3tsDnKQ/wviG2+t3QxQQe/YAJuLjhD6Dagb6sOM8g5eHvA1ctUYfg==
X-Received: by 2002:a63:83c3:: with SMTP id h186mr15740057pge.317.1568347847094;
        Thu, 12 Sep 2019 21:10:47 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id t6sm23135332pgu.23.2019.09.12.21.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 21:10:46 -0700 (PDT)
Subject: Re: [PATCH v8 00/17] Enable FSGSBASE instructions
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dave.hansen@intel.com,
        tony.luck@intel.com, ak@linux.intel.com
Cc:     ravi.v.shankar@intel.com
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <034aaf3a-a93d-ec03-0bbd-068e1905b774@kernel.org>
Date:   Thu, 12 Sep 2019 21:10:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/19 1:06 PM, Chang S. Bae wrote:

> Updates from v7 [7]:
> (1) Consider FSGSBASE when determining which Spectre SWAPGS mitigations are
>      required.
> (2) Fixed save_fsgs() to be aware of interrupt conditions
> (3) Made selftest changes based on Andy's previous fixes and cleanups
> (4) Included Andy's paranoid exit cleanup
> (5) Included documentation rewritten by Thomas
> (6) Carried on Thomas' edits on multiple changelogs and comments
> (7) Used '[FS|GS] base' consistently, except for selftest where GSBASE has
>      been already used in its test messages
> (8) Dropped the READ_MSR_GSBASE macro
> 

This looks unpleasant to review.  I wonder if it would be better to 
unrevert the reversion, merge up to Linus' tree or -tip, and then base 
the changes on top of that.

I also think that, before this series can have my ack, it needs an 
actual gdb maintainer to chime in, publicly, and state that they have 
thought about and tested the ABI changes and that gdb still works on 
patched kernels with and without FSGSBASE enabled.  I realize that there 
were all kinds of discussions, but they were all quite theoretical, and 
I think that the actual patches need to be considered by people who 
understand the concerns.  Specific test cases would be nice, too.

Finally, I wrote up some notes here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=70a7d284989e3539ee84f9d709d6450099f773fb

I want to make sure that they're accounted for, and that patch should 
possibly be applied.  The parent (broken link, but should fix itself soon):

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=166324e907f8a71c823b41bbc2e1b5bc711532d8

may also help understand the relevant code.

--Andy
