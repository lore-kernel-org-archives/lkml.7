Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D6EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDEC259B8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfEaXgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:36:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43227 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfEaXgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:36:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so4849373pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 16:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ETJ6ykBl1LYGxegwTN6YGSCsMcqD6BFzZek270Zuebk=;
        b=IgmLv/Xs176W/ck+Ol/au9faCGFs0O+oyMm8rtkZifVmVhiECGa40A0IJIehQKXM5G
         kAxZCqVTvwzjJOGRg93FzjNN+JHLnNEPDldPdrv5FoW04RAPwD5Tw+bljOL7e3dDXe56
         tiTpfIGL6tY9GTs+7Wq++1vsYBfcFZXywnCMhWxv7iZ9wZJsAThPmhWwc2/8OYPmY394
         sd8vEIyqt9MbO35cxHpIdhKnwfC/zBT/F32jeQUHSi7axGAWuQrGVu0O6s4Xy3tpLX0o
         R40H6BTbppvstsx+QDZnFsMZKvJ+8w+qM5ETSc4/McFUh/tElMunTSKjP1WWmnPJkYDQ
         cSWQ==
X-Gm-Message-State: APjAAAW+m6I57JKLlP3JLIcEsz2/NTyJmNUIH3FFTJzalnHJuz1P19jV
        z5Y8ZbLnhGs4wEC7unjmPekvMA==
X-Google-Smtp-Source: APXvYqwoLUrSF2L9O78QIaOKl9xWjaJYrvRMSYuFqnbqJmbAXL60kkJQDOuqKH/g+FbeaN2B66BGeQ==
X-Received: by 2002:a17:90a:207:: with SMTP id c7mr12479237pjc.94.1559345802001;
        Fri, 31 May 2019 16:36:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t187sm7656787pfb.64.2019.05.31.16.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 16:36:41 -0700 (PDT)
Date:   Fri, 31 May 2019 16:36:41 -0700 (PDT)
X-Google-Original-Date: Fri, 31 May 2019 16:23:50 PDT (-0700)
Subject:     Re: [PATCH 2/5] Add fchmodat4(), a new syscall
In-Reply-To: <CAK8P3a3HPeVq29k3Zk5rSk4bddiUQFrdEgDZUgdNnYZK+8QpGw@mail.gmail.com>
CC:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-234d2802-9483-43be-af69-5bd04721b932@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019 12:51:00 PDT (-0700), Arnd Bergmann wrote:
> On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> man 3p says that fchmodat() takes a flags argument, but the Linux
>> syscall does not.  There doesn't appear to be a good userspace
>> workaround for this issue but the implementation in the kernel is pretty
>> straight-forward.  The specific use case where the missing flags came up
>> was WRT a fuse filesystem implemenation, but the functionality is pretty
>> generic so I'm assuming there would be other use cases.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>  fs/open.c                | 21 +++++++++++++++++++--
>>  include/linux/syscalls.h |  5 +++++
>>  2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/open.c b/fs/open.c
>> index a00350018a47..cfad7684e8d3 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -568,11 +568,17 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
>>         return ksys_fchmod(fd, mode);
>>  }
>>
>> -int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
>> +int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int flags)
> ...
>> +
>> +int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
>> +{
>> +       return do_fchmodat4(dfd, filename, mode, 0);
>> +}
>> +
>
> There is only one external caller of do_fchmodat(), so just change that
> to pass the extra argument here, and keep a single do_fchmodat()
> function used by the sys_fchmod(), sys_fchmod4(), sys_chmod()
> and ksys_chmod().

OK, I'll roll that up into a v2.
