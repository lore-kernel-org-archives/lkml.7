Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C407C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC64820651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfGQCMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:12:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38085 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfGQCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:12:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so11084205plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 19:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XJLjYj+DtIYQb0AMLYtaQvMihTCm0rsvCGKlwMRh3LE=;
        b=hv8vbqzRWVJ3EBmCUy5G+I4xQ/4tBJqDWYFz62cpZzrm3kKWWOncfmrc82MKp2RI07
         vUv2RhCiUoK7Y46FKLxVcZLxAcDGbRAk075sSbSDP4aPIbIE3zEISy34SJ4IBqgfRphv
         QrWJeeC+sVlxBPJGNcsMqCfbAT7X+9Q3K5gNhgrgYHhIwsFh9SS+1OWmsw4PD9JY0KV6
         L31dHhnz9f2SHCPpeJgni0r/JrnQISEe6vE+dcK8fIX2v1KQUCH0v752BHSJWuBfKVMr
         b6eCmXq435eIMW8PvtpqCGhIQejg5BIyXgBFS+r5quncENfXyl6C16SU6/RcjELxDOtH
         gq4w==
X-Gm-Message-State: APjAAAVO/SgBzQMdkOlyARgRo3TZW1bmajSxAE04KtZKtwFasHeVsfJ2
        6aHuHqB0k/KBdTwTzNq7Y6FUOZJr6ec=
X-Google-Smtp-Source: APXvYqw1pQN2mCJqE4LloipsyU+ky9ZyfrHyYjD9dGtOKrfKeU8jFTsCJcFJac6EgQIwz1mt6T4pwQ==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr38738719plo.207.1563329552353;
        Tue, 16 Jul 2019 19:12:32 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 196sm24393369pfy.167.2019.07.16.19.12.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 19:12:31 -0700 (PDT)
Date:   Tue, 16 Jul 2019 19:12:31 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 19:12:29 PDT (-0700)
Subject:     Re: [PATCH v2 2/4] Add fchmodat4(), a new syscall
In-Reply-To: <20190717014802.GS17978@ZenIV.linux.org.uk>
CC:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, dhowells@redhat.com, firoz.khan@linaro.org,
        stefan@agner.ch, schwidefsky@de.ibm.com, axboe@kernel.dk,
        christian@brauner.io, hare@suse.com, deepa.kernel@gmail.com,
        tycho@tycho.ws, kim.phillips@arm.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk
Message-ID: <mhng-07134298-232b-4472-ac6f-cf33862883c5@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 18:48:02 PDT (-0700), viro@zeniv.linux.org.uk wrote:
> On Tue, Jul 16, 2019 at 06:27:17PM -0700, Palmer Dabbelt wrote:
>
>> -int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
>> +int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int flags)
>>  {
>>  	struct path path;
>>  	int error;
>> -	unsigned int lookup_flags = LOOKUP_FOLLOW;
>> +	unsigned int lookup_flags;
>> +
>> +	if (unlikely(flags & ~AT_SYMLINK_NOFOLLOW))
>> +		return -EINVAL;
>> +
>> +	lookup_flags = flags & AT_SYMLINK_NOFOLLOW ? 0 : LOOKUP_FOLLOW;
>> +
>
> 	Why not do that in sys_fchmodat4() itself, passing lookup_flags to
> do_fchmodat() and updating old callers to pass it 0 as extra argument?

Ya, that seems better -- passing LOOKUP_FOLLOW instead of 0, to keep the
behavior the same.  That way I could avoid the overhead of these checks for the
old syscalls, as we know they're not necessary.

I'll replace this patch with the following for a v3

    diff --git a/fs/open.c b/fs/open.c
    index b5b80469b93d..a5f99408af11 100644
    --- a/fs/open.c
    +++ b/fs/open.c
    @@ -569,11 +569,12 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
            return ksys_fchmod(fd, mode);
     }
    
    -int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
    +int do_fchmodat4(int dfd, const char __user *filename, umode_t mode,
    +                int lookup_flags)
     {
            struct path path;
            int error;
    -       unsigned int lookup_flags = LOOKUP_FOLLOW;
    +
     retry:
            error = user_path_at(dfd, filename, lookup_flags, &path);
            if (!error) {
    @@ -587,15 +588,28 @@ int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
            return error;
     }
    
    +SYSCALL_DEFINE4(fchmodat4, int, dfd, const char __user *, filename,
    +               umode_t, mode, int, flags)
    +{
    +       unsigned int lookup_flags;
    +
    +       if (unlikely(flags & ~AT_SYMLINK_NOFOLLOW))
    +               return -EINVAL;
    +
    +       lookup_flags = flags & AT_SYMLINK_NOFOLLOW ? 0 : LOOKUP_FOLLOW;
    +
    +       return do_fchmodat4(dfd, filename, mode, lookup_flags);
    +}
    +
     SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
                    umode_t, mode)
     {
    -       return do_fchmodat(dfd, filename, mode);
    +       return do_fchmodat4(dfd, filename, mode, LOOKUP_FOLLOW);
     }
    
     SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
     {
    -       return do_fchmodat(AT_FDCWD, filename, mode);
    +       return do_fchmodat4(AT_FDCWD, filename, mode, LOOKUP_FOLLOW);
     }
    
     static int chown_common(const struct path *path, uid_t user, gid_t group)
    diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
    index e1c20f1d0525..6676b1cc5485 100644
    --- a/include/linux/syscalls.h
    +++ b/include/linux/syscalls.h
    @@ -81,6 +81,7 @@ struct io_uring_params;
     #include <linux/quota.h>
     #include <linux/key.h>
     #include <linux/personality.h>
    +#include <linux/namei.h>
     #include <trace/syscall.h>
    
     #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
    @@ -433,6 +434,8 @@ asmlinkage long sys_chroot(const char __user *filename);
     asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
     asmlinkage long sys_fchmodat(int dfd, const char __user *filename,
                                 umode_t mode);
    +asmlinkage long sys_fchmodat4(int dfd, const char __user *filename,
    +                            umode_t mode, int flags);
     asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
                                 gid_t group, int flag);
     asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
    @@ -1320,11 +1323,12 @@ static inline long ksys_link(const char __user *oldname,
            return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
     }
    
    -extern int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
    +extern int do_fchmodat4(int dfd, const char __user *filename, umode_t mode,
    +                       int flags);
    
     static inline int ksys_chmod(const char __user *filename, umode_t mode)
     {
    -       return do_fchmodat(AT_FDCWD, filename, mode);
    +       return do_fchmodat4(AT_FDCWD, filename, mode, LOOKUP_FOLLOW);
     }
    
     extern long do_faccessat(int dfd, const char __user *filename, int mode);
