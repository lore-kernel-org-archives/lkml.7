Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3F821D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZgWMP+5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393621AbfJYNLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:11:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:33971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbfJYNLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572009041;
        bh=BoPFv1n1GeGtr39TG5vhVjMFSfhdHAlVzUt3V8lzM8U=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=ZgWMP+5l21mPV2wbqXCVC23tC2gJ8/YimpxuUagutV1gbXpVrszB1s8f0uv0+sEFx
         KkGs3uqeWkEku1GAT+TwbzF6X7i1FhtogWQSB14gmccuhxMUg0YXfDkSu7lQXG5HGc
         5mHiJBl5UwWkhO/4lFajHX/g/NXm74LmYJREMPEY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1iLVaU17Ot-007TkU; Fri, 25
 Oct 2019 15:10:41 +0200
Message-ID: <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Michal Hocko <mhocko@kernel.org>, snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Fri, 25 Oct 2019 15:10:39 +0200
In-Reply-To: <20191025121104.GH17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
         <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
         <20191025092143.GE658@dhcp22.suse.cz>
         <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
         <20191025114633.GE17610@dhcp22.suse.cz>
         <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
         <20191025120505.GG17610@dhcp22.suse.cz>
         <20191025121104.GH17610@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wQXLSULoKLs2PrgCMu7pprfq3s7ZjhIOPwa98NMJl1/Svbn2ouU
 zhliSXAbrJX9pEZnkkmx/hUv7/l69KUzLZbDgzCAh1ckNY/5hzn4ggNFGldJOc28DLiYKAn
 V7aRbqPSBCJIh0z3+F6OxGbaYahEVJXB3W4a+jJdX5GHYvpZjS2fjnNxT9i9gDw0mOTaBjF
 Ru802iqplep7LZiCRNfug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RPG2XjiKy54=:2d5S81T6W4s7Xp64WuFXzR
 m1vx7iD6xAdbDesYvGNwrbq8E8Fa9KdtUcQ49CxKNmvh5e5D7JOt+DZbUxDdKLylfZzY9ypX0
 c6XbAU+GFUAH9SzQeUNRQ83BQ89aZ74U/XJE/tQegAUJ4gZ4NCuJIBpBa9GtxIPTtMagiOEsc
 quBPvFquu/yQm0IBIz3cpOYd1P+m4E+W7GcaFxSAjEAUCaREyn7p+oh7sT3S8Ujcs/NOXJ0Ij
 pxXyeQjFbPhdMmng32LgHLuQFpT8AnVX3gN38e+muB5FKP/p5e7g+9dbWQH4PMJvxs09/L8cb
 3hfhbIDVdW4C1pF/vGg4v/nwETw1iF9U5PGNybvAyYtcWurUt70s4ZxUTP+ohbdVdmFy5Wp17
 5j323tOrW4nySfmxXLgb1zXvaYQRKVgBZUqRvdeqM6DVEjkDkp+VYP12SQyq6JYRh3RhrOc6V
 wiZrk/irBuvDCTLYAK7Glc9SunmtV+oDYFivP9VNkK4numKmgSo39M8IxJzLoEOrnxZfQwNlu
 KxV+pmLjfbc5U6PxWCMV2MUlXJpTV142J14VOt6oIjqEawkx+l9M1SPeIy+Tse/vcMcrixnXS
 +5D6yg7w1ZsBnU07R689RRgGwfBeApaZazOxcXrWQlaZPpg0/awyaB3cvxkSOWZYsgWayYAJj
 LD3J2OOgGc+ldIpPGA8rfvwRKpY0cy1G65df/EG0CZ3mjcIWlGuNd1wZo35TVVEx7w7MwuqR1
 2Cgsf04kO/psfW4fnH+vigB0u5Z+Jd5PRv7+ypv5IaEXPfOLDWRW7TPuKu3zrPj7O2ubn6By0
 KbN1tWH4VNFfwq8nxmF6f1ppyfJOKZ37yddMlALWV5mM/RfSUz83h0yjNPcKJb+DUJHP2Ossn
 /jRGNiUj1fo3FirbFKnZdlh3UWkNzCyIvsK9/11GNIRXyBx6R2K0ftR7szYOzDUc1z77GHezS
 KZHCKNSk9E0ROYnc2AmMUvm8So73HJV1v6V/oCZMt5iwAgY6rsfrBvjHi8DFmXPpEhe+ww3mI
 n3WdvwzsHFPbNTkBTi3m3nwvzKyARSWPoJsO+HtfFVklj+UZ9d3xm/pFcBpJoiP9fnQkxNWoy
 hPmEdEgz6oq5McxxdUycnRcZ4V5ew1Im7yhA8lRmmwyh2MWoMFe5BYsjbTd2wL00ZBmFJVc0o
 DsQ75kUtSWWAQFUhY6ygJ0vo22/WBcxc4QM57LMEbzhzKlKVIZjKYH6hpGS1lH9GBl6kZv9Bp
 1hT2CFG6k94t0UdoSB9InLVtWNnRT+v9RDoVC6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 14:11 +0200, Michal Hocko wrote:
> On Fri 25-10-19 14:05:05, Michal Hocko wrote:
> [...]
> > This smells like something that could be runtime specific. Could
> > you
> > post strace output of your testcase?
>
> Ohh and /proc/<pid>/smaps while the strace is hung on mlockall
> please.

Sure, see below.


strace ./test
execve("./test", ["./test"], 0x7ffd6ba0f970 /* 89 vars */) =3D 0
brk(NULL)                               =3D 0x564ee2c79000
arch_prctl(0x3001 /* ARCH_??? */, 0x7ffd58f1d460) =3D -1 EINVAL (Invalid
argument)
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or
directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D176037, ...}) =3D 0
mmap(NULL, 176037, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f8be92bb000
close(3)                                =3D 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC)
=3D 3
read(3,
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360r\2\0\0\0\0\0"...,
832) =3D 832
lseek(3, 64, SEEK_SET)                  =3D 64
read(3,
"\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"...,
784) =3D 784
lseek(3, 848, SEEK_SET)                 =3D 848
read(3,
"\4\0\0\0\20\0\0\0\5\0\0\0GNU\0\2\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0", 32)
=3D 32
lseek(3, 880, SEEK_SET)                 =3D 880
read(3,
"\4\0\0\0\24\0\0\0\3\0\0\0GNU\0!U\364U\255V\275\207\34\202%\274\312\205
\356%"..., 68) =3D 68
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2025032, ...}) =3D 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x7f8be92b9000
lseek(3, 64, SEEK_SET)                  =3D 64
read(3,
"\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"...,
784) =3D 784
lseek(3, 848, SEEK_SET)                 =3D 848
read(3,
"\4\0\0\0\20\0\0\0\5\0\0\0GNU\0\2\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0", 32)
=3D 32
lseek(3, 880, SEEK_SET)                 =3D 880
read(3,
"\4\0\0\0\24\0\0\0\3\0\0\0GNU\0!U\364U\255V\275\207\34\202%\274\312\205
\356%"..., 68) =3D 68
mmap(NULL, 2032984, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D
0x7f8be90c8000
mmap(0x7f8be90ed000, 1540096, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x25000) =3D 0x7f8be90ed000
mmap(0x7f8be9265000, 303104, PROT_READ,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19d000) =3D 0x7f8be9265000
mmap(0x7f8be92af000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e6000) =3D 0x7f8be92af000
mmap(0x7f8be92b5000, 13656, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f8be92b5000
close(3)                                =3D 0
arch_prctl(ARCH_SET_FS, 0x7f8be92ba540) =3D 0
mprotect(0x7f8be92af000, 12288, PROT_READ) =3D 0
mprotect(0x564ee18c8000, 4096, PROT_READ) =3D 0
mprotect(0x7f8be9312000, 4096, PROT_READ) =3D 0
munmap(0x7f8be92bb000, 176037)          =3D 0
fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(0x88, 0xa), ...}) =3D =
0
brk(NULL)                               =3D 0x564ee2c79000
brk(0x564ee2c9a000)                     =3D 0x564ee2c9a000
write(1, "Before mlockall(MCL_CURRENT)\n", 29Before
mlockall(MCL_CURRENT)
) =3D 29
mlockall(MCL_CURRENT

^ the strace stops there (no closing bracket)

Unlike non-strace runs, I've got to do a `kill -9 $(pidof test)`



cat /proc/$(pidof test)/smaps
564ee18c5000-564ee18c6000 r--p 00000000 103:02
49174659                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         4 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo sd
564ee18c6000-564ee18c7000 r-xp 00001000 103:02
49174659                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         4 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd ex mr mw me dw lo sd
564ee18c7000-564ee18c8000 r--p 00002000 103:02
49174659                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         4 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo sd
564ee18c8000-564ee18c9000 r--p 00002000 103:02
49174659                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo ac sd
564ee18c9000-564ee18ca000 rw-p 00003000 103:02
49174659                  /home/snazy/devel/misc/zzz/test
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd wr mr mw me dw lo ac sd
564ee2c79000-564ee2c9a000 rw-p 00000000 00:00
0                          [heap]
Size:                132 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 132 kB
Pss:                 132 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:       132 kB
Referenced:          132 kB
Anonymous:           132 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:              132 kB
THPeligible:		0
VmFlags: rd wr mr mw me lo ac sd
7f8be90c8000-7f8be90ed000 r--p 00000000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:                148 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 144 kB
Pss:                   0 kB
Shared_Clean:        144 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:          144 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr mw me lo sd
7f8be90ed000-7f8be9265000 r-xp 00025000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:               1504 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 832 kB
Pss:                   5 kB
Shared_Clean:        832 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:          832 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                5 kB
THPeligible:		0
VmFlags: rd ex mr mw me lo sd
7f8be9265000-7f8be92af000 r--p 0019d000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:                296 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  64 kB
Pss:                   0 kB
Shared_Clean:         64 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:           64 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr mw me lo sd
7f8be92af000-7f8be92b2000 r--p 001e6000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:                 12 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  12 kB
Pss:                  12 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        12 kB
Referenced:           12 kB
Anonymous:            12 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               12 kB
THPeligible:		0
VmFlags: rd mr mw me lo ac sd
7f8be92b2000-7f8be92b5000 rw-p 001e9000 103:02
44307431                  /lib/x86_64-linux-gnu/libc-2.30.so
Size:                 12 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  12 kB
Pss:                  12 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        12 kB
Referenced:           12 kB
Anonymous:            12 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               12 kB
THPeligible:		0
VmFlags: rd wr mr mw me lo ac sd
7f8be92b5000-7f8be92bb000 rw-p 00000000 00:00 0
Size:                 24 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  24 kB
Pss:                  24 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        24 kB
Referenced:           24 kB
Anonymous:            24 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               24 kB
THPeligible:		0
VmFlags: rd wr mr mw me lo ac sd
7f8be92e6000-7f8be92e7000 r--p 00000000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   0 kB
Shared_Clean:          4 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo sd
7f8be92e7000-7f8be9309000 r-xp 00001000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                136 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 136 kB
Pss:                   0 kB
Shared_Clean:        136 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:          136 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd ex mr mw me dw lo sd
7f8be9309000-7f8be9311000 r--p 00023000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                 32 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  32 kB
Pss:                   0 kB
Shared_Clean:         32 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:           32 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo sd
7f8be9312000-7f8be9313000 r--p 0002b000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd mr mw me dw lo ac sd
7f8be9313000-7f8be9314000 rw-p 0002c000 103:02
44302414                  /lib/x86_64-linux-gnu/ld-2.30.so
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd wr mr mw me dw lo ac sd
7f8be9314000-7f8be9315000 rw-p 00000000 00:00 0
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                4 kB
THPeligible:		0
VmFlags: rd wr mr mw me lo ac sd
7ffd58efe000-7ffd58f20000 rw-p 00000000 00:00
0                          [stack]
Size:                136 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  20 kB
Pss:                  20 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        20 kB
Referenced:           20 kB
Anonymous:            20 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               20 kB
THPeligible:		0
VmFlags: rd wr mr mw me gd lo ac
7ffd58f74000-7ffd58f77000 r--p 00000000 00:00
0                          [vvar]
Size:                 12 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   0 kB
Pss:                   0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd mr pf io de dd sd
7ffd58f77000-7ffd58f78000 r-xp 00000000 00:00
0                          [vdso]
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   0 kB
Shared_Clean:          4 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            4 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: rd ex mr mw me de sd
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00
0                  [vsyscall]
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   0 kB
Pss:                   0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         0 kB
Referenced:            0 kB
Anonymous:             0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		0
VmFlags: ex


