Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9787C10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A3D2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfDQAda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:33:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:6785 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfDQAd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:33:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 17:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,359,1549958400"; 
   d="gz'50?scan'50,208,50";a="316585980"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2019 17:33:06 -0700
Date:   Wed, 17 Apr 2019 08:33:27 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Guoqing Jiang <gqjiang@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: e00164a0f0 [    7.566387] WARNING: CPU: 0 PID: 1 at
 kernel/locking/lockdep.c:1025 lockdep_register_key
Message-ID: <20190417003327.GI24200@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus

commit e00164a0f000de893944981f41a568c981aca658
Author:     Guoqing Jiang <gqjiang@suse.com>
AuthorDate: Tue Apr 9 16:16:38 2019 +0800
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Tue Apr 16 15:24:38 2019 +0200

    sc16is7xx: move label 'err_spi' to correct section
    
    err_spi is used when SERIAL_SC16IS7XX_SPI is enabled, so make
    the label only available under SERIAL_SC16IS7XX_SPI option.
    Otherwise, the below warning appears.
    
    drivers/tty/serial/sc16is7xx.c:1523:1: warning: label ‘err_spi’ defined but not used [-Wunused-label]
     err_spi:
      ^~~~~~~
    
    Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
    Fixes: ac0cdb3d9901 ("sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()")
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

6b87784b53  serial: sh-sci: Fix HSCIF RX sampling point adjustment
e00164a0f0  sc16is7xx: move label 'err_spi' to correct section
+-----------------------------------------------------------+------------+------------+
|                                                           | 6b87784b53 | e00164a0f0 |
+-----------------------------------------------------------+------------+------------+
| boot_successes                                            | 201        | 32         |
| boot_failures                                             | 1          | 3          |
| BUG:soft_lockup-CPU##stuck_for#s                          | 1          |            |
| EIP:event_create_dir                                      | 1          |            |
| Kernel_panic-not_syncing:softlockup:hung_tasks            | 1          |            |
| WARNING:at_kernel/locking/lockdep.c:#lockdep_register_key | 0          | 3          |
| EIP:lockdep_register_key                                  | 0          | 3          |
+-----------------------------------------------------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    7.510650] IPMI poweroff: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot
[    7.534084] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    7.545328] ACPI: Power Button [PWRF]
[    7.554398] Warning: Processor Platform Limit event detected, but not handled.
[    7.563385] Consider compiling CPUfreq support into your kernel.
[    7.566387] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:1025 lockdep_register_key+0x100/0x110
[    7.569720] CPU: 0 PID: 1 Comm: swapper Not tainted 5.1.0-rc3-00003-ge00164a #237
[    7.571684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    7.573298] EIP: lockdep_register_key+0x100/0x110
[    7.573298] Code: 0c 2c 6f 5c 85 c0 0f 85 52 ff ff ff 68 85 54 16 5c 68 84 1f 13 5c e8 2f a4 fc ff 0f 0b 59 5b e9 3a ff ff ff 8d b6 00 00 00 00 <0f> 0b 8d 65 f8 5b 5e 5d c3 8d b4 26 00 00 00 00 55 89 e5 57 56 53
[    7.573298] EAX: 00000001 EBX: 5d5406a4 ECX: 5c7ec208 EDX: 5d5406a4
[    7.573298] ESI: 00000018 EDI: 5d5406c4 EBP: 40255ef4 ESP: 40255eec
[    7.573298] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210202
[    7.573298] CR0: 80050033 CR2: 00000000 CR3: 1c7de000 CR4: 00000690
[    7.573298] Call Trace:
[    7.573298]  ? alloc_workqueue+0xeb/0x380
[    7.573298]  ? acpi_container_init+0x19/0x19
[    7.573298]  ? acpi_thermal_init+0x3d/0x74
[    7.573298]  ? do_one_initcall+0x6d/0x14b
[    7.573298]  ? kernel_init_freeable+0xda/0x176
[    7.573298]  ? kernel_init_freeable+0xfc/0x176
[    7.573298]  ? rest_init+0x100/0x100
[    7.573298]  ? kernel_init+0xd/0xf0
[    7.573298]  ? ret_from_fork+0x19/0x30
[    7.573298] random: get_random_bytes called from init_oops_id+0x3f/0x50 with crng_init=1
[    7.573298] ---[ end trace 545f90114983ba96 ]---
[    7.828642] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start e00164a0f000de893944981f41a568c981aca658 79a3aaa7b82e3106be97842dedfd8429248896e6 --
git bisect good ace965696da2611af759f0284e26342b7b6cec89  # 22:48  G     65     0    0   0  serial: sh-sci: Fix HSCIF RX sampling point calculation
git bisect good 6b87784b53592a90d21576be8eff688b56d93cce  # 23:03  G     66     0    0   0  serial: sh-sci: Fix HSCIF RX sampling point adjustment
# first bad commit: [e00164a0f000de893944981f41a568c981aca658] sc16is7xx: move label 'err_spi' to correct section
git bisect good 6b87784b53592a90d21576be8eff688b56d93cce  # 23:11  G    196     0    1   1  serial: sh-sci: Fix HSCIF RX sampling point adjustment
# extra tests on HEAD of tty/tty-linus
git bisect  bad e00164a0f000de893944981f41a568c981aca658  # 23:11  B     32     3    0   0  sc16is7xx: move label 'err_spi' to correct section
# extra tests on tree/branch tty/tty-linus
git bisect  bad e00164a0f000de893944981f41a568c981aca658  # 23:18  B     32     3    0   0  sc16is7xx: move label 'err_spi' to correct section
# extra tests with first bad commit reverted
git bisect good a3d4c63910ec84ad8387b4a83aa6e0901e2f3888  # 23:38  G     63     0    0   0  Revert "sc16is7xx: move label 'err_spi' to correct section"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--sT9gWZPUZYhvPS56
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-vm-openwrt-224:20190416221017:i386-randconfig-a1-201915:5.1.0-rc3-00003-ge00164a:237.gz"
Content-Transfer-Encoding: base64

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
fEaOrpoBO0abc8DhJ9//Lt8GIQEA

--sT9gWZPUZYhvPS56
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-vm-openwrt-315:20190416231120:i386-randconfig-a1-201915:5.1.0-rc3-00002-g6b87784:1.gz"
Content-Transfer-Encoding: base64

H4sICAv3tVwAA2RtZXNnLW9wZW53cnQtdm0tb3BlbndydC0zMTU6MjAxOTA0MTYyMzExMjA6
aTM4Ni1yYW5kY29uZmlnLWExLTIwMTkxNTo1LjEuMC1yYzMtMDAwMDItZzZiODc3ODQ6MQC0
Wmtz2ziy/Z5fgdn9EHuvJRN8U1u+dWVbiVW2Eq3lZLKbSqkoEpS5pkgOH7Y1v35PAyT1cjKZ
ZK8qsUSy+6ABNLpPAxR+kaxZkKVllggWp6wUVZ3jRiheif1n4rkq/KCaP4giFcmrOM3rah76
lT9g2rOmC9PRXK25nYhU3tVCb+H40ausrnBb3uKa/DS3OkkeBVwP3FcKfV5llZ/My/h3odAX
UUBK0/t1GQd+wq6Hs5tbVpdxumS3l7fDd5f4uptd9Pv9V68uRZCt8kKU8vFNnNbPuM+mfiFv
jG7eyEtRRFmxojuFSLLAr2J0lp6EWSr6r86zrKKH1b1gyqr+q88MH62vuvBFQbNHAdwsZVaf
97VeERg9eqr3lvbCdRzXZEcPizpOwv9LHvKe+qm5x+xoGQSdrtn3+hC8FIvYb656+vEx+ytn
d7Vgw7xg3Ga6PrD0gaGzi9kd0zXu7Rt0Pbp9N7phZZ3nWVGJkAV5XQ72pRgbTi7ZsEbP0ioO
cHEo8WFysf1/X+Bi+mEA49MwK+ZxyF6/FWkdp2KcViJ5zer0Ic2e0pNmgpYiFUUcwIni6mAM
JdI/s7pg5bqsxIqt/DVbCGCUlb9IxIHCs2ufRnk9YDPVS2rh02z4ccQi4Vd1IaTj8QF7/ew6
LEoyX4rkWZxWmOlljFaK8vWPweqAnc1GP41jAmf48dP34DxjHCoxz6IIq/Oz/mXAmOXYJ+19
WiOluq1b9ldRRikNZthotbaUMMY5oVVeYXkzwmJxyVy42GJdibKdwdfQSkO/CF8zWjP+4TSe
j9/PenmRPcYhWsnbdXo7nGBC8wMXlOLC1bUB+7zCpNOY7H56O7e8aBFFX2AN9eJPgXkUOfbB
IgJD90XxKMI/BRcd2hb9OBzf7yqPolDB/dmuQlMcgv2wbZGIZMjt7d76YTiFtgP3h9blBZbs
w4CFYlEvByxepllB3phky0Q8ioTSFa2vA2dsFRcI4W0G+ywTGhrCc6EWw77aOwT8AAnn3Sd2
NHoWQY2FchnLeTgGZlaJgHIEC/w0zSoKUg3QgKVZ2psOR02i+GUfeTahoWF632WUlxB2D2y+
nIwH7B+jyQc2a9Yam16wo9g0tTef2P+w6Xj86YRxz7OPT+RAM97nWl/vcaaZpxo/RT4w90Gv
1jlGNi6zAoNI5pOt1x8n+3IPj6tegByIMfsgF/yqLEpmLizbDDXOYE97oW2pGpaxo4pkw7QT
0mV8wQUmnJ/QXKz8Yi0fSrlvAKhgUwb3CCEq3uGLGZC0Pc3TNZ0F6yARZQdhurZjfVG4JXII
zd4W3sovH4g/RHsfPHieKyh6zIPQBH/BwlucyEdxmIh5imeuyy1PszxuugZLu3Z1zXUM8wur
ymDALpuBpbnx+p7nsMnV7+QuAQhIVnQ6tut6sFUtjzoPKQzvrZJ2dWwFAHZ29r8HC8SwTcPh
LVYhVtnjNpa/wYpeCiam7drc/sISv6zmeZSyMxoEih+y934R3G9uS4NaTctwNctUaWU6vBuw
iyyN4mVdSPLEPms9B4no13PGfr0Dh7jo4T87uG7RbN10qRvEC2IkC3Qgg6cgX+Tkp4eDwwND
dahFwCyYOuw5v71G4898EZouRE9Y81t2fvr2bnh+M2p1XM21bbSK1HQ5nl137fAoDLymnTYK
dzo2t2xM3vBiilU6ktRYshMGX4Xr1SticnEUKxbJQhU1ugnzLFvXvVb/dnY53c0qb2zX0ZiM
2WCBj5rGzt9fXM3YsQIAr+QOPGsL4G479L95M+LWhScBDI0AeAPAzj9NL5R4IyvvdFddA5zb
FjfbBt7ga78B07uUao550IAS/3YDhs0NW28buDzsAUgRDQE3rcuDBi6/owempZsUy7oezA4a
0NQYm1qn4zqWZ7Q6w+n44mBYOZc67uGwKvFvG4Vp507X66vp6HDePNWA4R40oMT/oAHP0S00
oE3O2dX47dVkNGH+ox8nW9yZ9x1kEQezi95A7ub9r18Rs12LrGXNGkSmfWKFv0KQZD3WMoxW
2rV1rkvpb4p5nBsc8xKsUCmGK39ObBMxI6vLeRPYjpJ4FVedZtc5D2HfdHaWt7e1vL3D5a33
NV23DCy1f6GIg1HpUrQFEJ6ZBjdcsvgdsdgEP15gn1x7mZK1KNxAzJEoV/HyfgJ9JlZ5te6e
Oy53MS6T7FGGiN/JEhDooiLyzIQf3IMvhKKV1zXTowFSYaUJgiTQmN/JGYZr2NSufIi48iJ5
3jMfH09sm697lqFZfwDzdWLawhiW5rmwZozgTdpq60BCaj8yqiZGVcdcv09bELkHkPs0gYwb
mmfqraxnYI71rXmkIYaQpptMKiDhwXtptGEIfFkpGuAcusmNA0Wt0drNsxA3aE/jsB1pjNI5
YTfjN+/Zwq+C+4HBW03LBmtw23U/nfTu4pUo2Pg9m6ImJNJha24rbHPdtsydIBGHJEOpygev
A3wpN0IiEWqbtQVNG/EYzg5K10yAX67TgE3fyM5LQtbJgkBZluJbKDn9pIJJu6TND10rcDsN
x7LAc760s6k3U9cjOyIqyLD6uiAiG5xejEE0H8GiyxYEDMokkHY7JfcL/zEuqtpPUG2GDWNm
SJodL4WSq1s0IjvErhBRnIqw9+84imJyin16t0fr2tt7nI4jIOm2Zpq27lgyJ6SdsZ5jGi7G
M8eo9PwErQ9YqbFCY6GhIzqyWn3JR2f8b/JKKZuUo23L3lX+DO/RWCeBJOhQnVTHCcKddKcE
9T+8aJUt4iSu1mxZZHVOA5WlfcbuaA2wdhHonsc3zbm2RQvmWg1gkMHRwdOTmFy0wGifnWIq
ThGXNXZfp8t5heGa534aw3JVUzE/x4X6Wa7L4re5nzz563Le1DWsCBRR7ePHHN2aI4wlyZw8
J6urM06DJ6p+HKX+SpRnWlN59dHww6pcnmFWVYOoUsosqmg667wzIl3F8ydaOWG2PJM3WZbl
ZfMzyfxwDvNBph7OdGLUiLLdDUxJsQj7qxhFIVJKnVZnbrOFFPZRIc5liXgmikIVjmLelY1N
SXhWVWuNybJQmU03ZtoJ5xZcfVtqc/Nx6Z+lKhYUTzTWD2engcjvo/JU7eydFnXa+60WtTjN
cpE+FVUP6635eRobrt1DVA8DyZt7Pu/RNh63TtHKAP97gKzLQbNzuLAMy9N9Twt1bjn2QrhY
d6gjUIqFnhFgUSziEsWH1HruGe5p/3FFv3/vfS+CbF8zua0bVI71HGdwaHfP4BZbwO7gnobj
tDMUbOX93Xw8Gb4dnZ3mD8tTacg3urkMgp7Z906/17zTtj9f3Vx9wQvIa0UR9cv7ugqzp/Ss
iWjAcA009EU5+0B9MeXzbS3fb2UNx5Wyl6jWqX5F2hbs3i/vG+ZPt2UYsi3LsNlRVoSiwNUJ
00GMTFPtoB23cJYDF/IoXyK79b6OpgJMi2ah5Ad7cvQ9NFtD9DJU9o0pklLEuJh++GvXVSqu
vH2JlrBQrG6y7FGbkQftj64RFGcwBkRGUpIBMx1Ecvv61NIN2Hi9FfuPUJ6YxnUbzOkA4YQZ
NoSxTOiM4IShcNRxlakrx8IjqvvQP64beLIoEQVB7+h3m4dB9K6JN/Z2btyjE8hInZmeo8rZ
Jqu0RjREKvHXCFWDfWH6RPEzuAFjTbKQqRUEtskcdMHYEeOuyx7OD1pjlDnnyjcUgNzgagEC
zW4BGFjJiwCM5Q/SgAbA3AZw1QUATM2zvwbwuJKJhilG4YgtAEOSaQLQLVRWk5cBQN0pu0sA
s3EACWA1ZFx2gaqgrwAw1qd5lADWguu8A1jwsLWA5vtrXQAA+YQC8C3XCrnfAGgRPFACcO5w
5xsIcvtaInhbo9jBscZDNwh2HyWRpfMv7IIqeFocccSq+7jcbN2w+ywF9yjlEdCvU7ZAN5FA
UnlSVnc7ayt4e7/ff//Qb6Etx7U85Pnu2jM9C0397Yc/LRIIn+0ahESk9P3d+GL0J74Y2yCB
q7i0uCXSD3w2SC4FcU8i0QmhmKtsenTMFoLGlbh4nw0TdcaGG/IksVmf/R0kDzWO99+wyfN0
7pkS6Y7mdCX8lObRr9Qc45/PLkfnH9624YK4E+YXD7aRnL7mIT+qcarT0o8U0YWPhLXaDUb3
+t9hk9PnOrLPf6F3QHIMz1G9G0cM8Q3kX6iOgYaVYIuyO/TALwSjzWpJ8pY0+jtIOjc8k6u5
6845TxCA6eiqGarVSoQxSCDteWUEWjQnf79sI1GWIm77870zDc2mqv9nfdzpW5qr2/bPrzsH
FaeNPPyFvbudj2//MQMXR55Pi3lc/Faqi7wQvnJx8Ob2dqfuwom4POxEyqWnlY/C5gQMoAjP
jvKqePSTY0mRuyul6/Y1hFTamWsPNboDDUlM9w4zII5V7fI/PgPZ3aJ04VMoiehMGxQd3gLi
F4o0WDOYEiM+ZwVt9ubrAsm3YkfBMQMdttktOnvlI4uP06BPf5cZm2RJ6hctrq7rLu0p0cH6
ZPhpfvP+4vpyNJ3PPpxf3AxnsxEGk7mdtK0ZrrMrPYf43dVg4yrmRtw1LToA2Ae/Hv1z1ilg
7HmrYIBK0TySgmz+aji7ms/G/xpt4yPhdgqGAX88bGH07u52PGoa2SoDoWGBJNmHGhdXw/G7
1irJGTsNB0Z5jVEk9ZJRu214jiW3ghqSI7c7FiA7e5MXp1FGlNLzkPlaZZB9T+7bIYMxKgp7
ZVUgmLVgETxGes+A6SBninl2yuDcXrdXcYG6CsECeZAioSwlwJlbWaRXnQpiJdsc1rHRzcUt
BRKN6qmjCFUd04KOdULL9gyaop3a/z4X1c8X/E5X6rt923A5MWhCVm1Rat+8IbBZGY6pmba2
Z1BVBj25mr77lMnwfNeyRejpzounTLDP1cwtC12QYXK9C6zARaFSZyjAZzHNWc6OyoeYNmmP
1ZFiRSu1BhFhhjqHYufZMpuMpzN2lOT/PqPTKc9zNuPscc22Ka7E4Rzm0DFr5NcJhlkSTpRU
8apewXu0bvV4loc6kXY2UWh9o4aRG3FtCaOdKMDtAgZQNvfsFkq+m/EzeF4fric3ZRGz2cfh
zfhyeDeSTI51URxCqP7cfaFA7rjwHTnMuMqvB3L6jpzFPdp+W5FHUGxvXrwpYTGbIBkt/PSh
7KQdzTWsRrp5RUZqVetcgK9SmpbBnCaatBu0Tt/VPNqcuvHLiqmdjPju5nwzTOb1OY2OPpFf
Jn11uliYmrmjG/6RLkqzt1sQIPY65SH5ws72+z5M/ZWxYNpx56Mrv3wSCbLaUeSvYlooKFFO
JFtO5HoIThgWWk6bXbL66OYSy1Uy81kuggqgH3VQ+/ZihXJ2KU/ZBi11o4GjN75i2rJ6iqt7
LGL4FO2E/R0Pt1Q2JesvW425tCVM+HUCqUfBZhX15Xyd+yWG5mOdpKLYHKBCx9B0OkK84Xdv
Bu0G3I4VcjN0OOqzdzvN021S6oBcXR5INO+i+Wkg2IjCUEmvFLDp5AMLC1hUnEhu8ERsToap
kmVpsu63OOiCTqHi3WTM2g21gUTduUURH41AH1xulwB4yHS2QaMeisdqlUewIG63DjZCtD3q
2Xux8P9tQxbtWQa3wQeiGhXey7Fhs/XSM042ry513mS6pqZj2T0ThfHrKlthLgJwtXXzvsFC
YE2057jyfcCoThW3Z3CY5yYBt3iWYzq0N/1udDcA/2mzhXxBJAuyhCl379ifh6LNRqD4QhsG
1On2PYdlholN5RlFWreyjq4bm7OARV2q6EAb6/uZCcKIxhTC8bR9cSPYOZCXuly6HR0hMD+g
1SnVuUZEQCPecVUvBQWDTQO0vYwIFp/LrWf5XphkuL0NxW3OTDosG+EJpCIo1nkVDtTM5/X8
t0TI10op4/P25ALyjmY4xGAKPw7tAQ2z/qzj0VKkKBzxcSw2OT/t8GVp+II8ZlXKm66+Jc8R
bDGQe/J8G9+wduR1G1WHcyjf4nPD2JE3kbLpkI92OTNkyYgCq9wIobdHOynTlJt+DWpZir1e
7lkBI+Sh2r58a4Xl7Mq7nJv0XsK2/E4vbXNH3vO4PPvbl2/x9Z1R1BGfuE7HWBt5vmu/ZezI
GzaY7J78jj1yH2lLHimNCEUjr9aFnyyzAlF81c6y0t7pOlQ9rlO92aj2iTyrbrSugDJ29bRT
HkHNpJN2vt+imu1CBLQk1xsLOi0bxW33/scwpHcc5+9n46NJFtaIRpfyzOu4E3e4ZWsviG/S
474GBuJFDaOvsfnsYspGz5VIiWaXGyVQONf9ZjPD5RKrmsq3/RYtFJW2/YKyfKm5d4nU3fsY
hyLbaFAd+pKNSuNGpNlj1nv3sXd1ORn3hnUYb+kaylG/ons1Hfeu1osiDntvCz+/j4NNL22Q
AbPrJZffbDi5UYmgBEuSQS2qKaL7wW91TAFMHoVlfriZeQejpXcdJs5SIKLh776LuAacpBM8
6jjdTGMzqzPLRcAzOrNU8KUXQijWxgRe1Dmqiawm3t4q0UkLd3YC9n2GwEE9R5x9ihFMnkom
iyIC/jttSqaC+ucXa3obV7C/5EF8lmZBUf5F9rLZq/GRLJp24DMItWb32kn77q/O3k5HJe1e
LmShqGmyDnvTaume0nrKigd5hEXniHUa9opsESuqWoqkeQkS/QxoQ148EzEjZtExmHiV+4Gi
rRyJxLNcfXMUjkR2iwKTnasuf8YN+NQRguh/2rnW57ZxI/5Z/CvQ631I4sgB+AKpOV/r2Erq
aZK60fWmMx4Phw8w0VivknZy15v737s/gC+JlB/qzfQ+NJOxSGr3R2ABLHaxu4rpHXr7v8K2
x/k4z6+f1yhCCA8meZxu5uzywyU/5c6E8wlm0dmE/W3W2t5XM/VpCRvpumEm00aIipmcJW23
VNJmz67qLDcT2xaySUw1gUPqJGw7dD/OMpQV6IzQBtz3fMwr9Kw7mCRa0w8dWmmoAy5hqdEg
Rp2vTcRWMzTtu5qvWZVEgcSJNJdVk9t+hQ434epHg2Umfg/jbAeMLFG9RB8DNpRqmAyCOo6H
JM/Hg25lGST5IKjn6OF8DGg7lRruwAthYRF3w8n5MbJgkG8xIUuaVqi2nBAFXpAPgL76Td4F
YXjS12ldWxiixZAcmWgDGKLFkLYr/d12iGPRYoghDFLCQYNBlrNfSWIHg7S+FuakHvmUnNqx
/mhFQRYMdwfZF7RppD+zi/Mpg0K9qQFFC8hFrkde5LIFJAWHnIQnALotoJP7FZKH7GDXDp+E
FHSaJk3TpGwBSXB8UNx7AdNO02SnaWRg+LyH5DQDJ+BP9gc/aCYQYfiujir0Maom1C/2zfLy
nRxOVzxfmoM+ZIO7WqU2iAF3RF9gfURpECUfQpy9f10DCu7ofMo9gNFmPv/JjaBSjwjuFcnL
xn6yvmEOdc3GXpWWDZjrhP7uxLD1gqH15k5IvYsBmTm8IzN4RuFuDzVGZ24aJWJiuUaJZJUv
Spt93oyh49leb/F1sYIWi7RQRyHxJmmNYDxSBDAC9sE4vAujWhjVb5IvaZR3u+d09BLnakBE
dldEstrB+xh9EakkbdvTycUjGLKAgt7s7MK4HbXCjVpxanb/GCvXvod9WypB24pkVyr+sbC9
wNmdhW4rFduLkwGpBO1iIwxpC88bwhiSSi7awabLtiku9cvxB7YdsoY+/OP9aZVRUZN7NOXb
029YBxeNWUhW7w27evfhr6dk+lx8/HvJPPZCcHKPntfsPpnMjv0A++v97KFRQ/eyn7XsxP2i
wy6RD/4Q+/l+dhK4eKjvs5r9RdgwhnJgAusF9eVTHBdJG0aISx3aYj++Pa1SDh+P0fLAokOt
QaaQs1KezNdHNBFerr+ummt90kUG96rzAlJZg6u+fkFlAiLTuVgv2GZdlvP6/BAAAbdhzNbk
XUdFHnMHqWbXbHY2uyCrNqnqIndP40BJhNCbi3mCDIq6mBR5rhXmcUPquw5GRMdyJ1Xlqr4x
3koe4yTvCye137BIk8OKkj4SzpeaS9+zNN7oasYuN8mg4cZ2iz5Oz0/P2Hsy0X/EER017bgl
Eb4OVWoSHYyfMJXFabRMI+p0Xkbo86QeqmXK0kLh8KkBcAKOSf7mkgaUfI/4E3lzeREvFVyY
hsqzbV15kH2Be5JV3ZjBtWGnRfp5jgIe9OVcn7W2KVMd+Qnf9Xiw5blpRxTuHk3ibUcPEXoa
m5ocCkMHNyIcSeuKzfpIzHc74TXwIWDttZU9Ou1JV1Emd3lObWtN705hY9jR3oQR0uwSD2N0
KgabSsEag+x2G7GKLM0SWmnmA7VOiwWb6flYsvda4PC02GscLlbSe9bWQ9NWMHaOnecNKrk+
fPf0ePZ1fqsrvkgcnS/aOq6GOzDr+mxq4oE09TAfEPpczldRpha3cYQsjzXzzCmySg/gxRn0
obyIXBzO7AfSO5SZfCJhH8rsyNAPDmX2/NA7+M2B59oHvxmRG/fgV4vQJpf3YHkHAZnbh3K7
Djl/B/fbR9mcPJQ7pEV4+DwTrhf6WzMNoXQpoXA+F0gMLyad86/KHyA7SraxbZfsb7J14Y21
wSqt/RHkYiZJnI1NPisrb+/SG61nbaf8A7sqv6I2qZiI6wZMkLkqqsgkJ0/mHOeEZ+vlkhAN
NWp72W2MhmX7f6jhj2IX8i9xkemoGxLcf6P63A789OJyYgJ6kdnaomxekDvleORPuZWf3+0h
7cMTlnMWJMyLGQ9wQUtAuCwIiZCpFBeZ1M8dECQxo1meeixxwULPSb2pgMmYpURAIIJWIUs5
4zkuVMx0mRz+E7EkmpTlPtCcAHbed9L7nslQN8HTbQnxlyD9nKmQlIlmpeZIkLfYLktDxgmv
163p6T8nzFOKJlbG2fQ17hKe2E5Md2d0Z7w5xyZTAd/FQYZASQ9mdqEZ01i5AZFeIJXB5p6r
QS/1nefl1J/prL5TqgdzPsMLZcKm9cWbmWkCe1tfzPQFKc3pm3en5qmN/3ZvxD7SHkzLizYV
x6E7u+4MgZx9JGcaldLVnTvR9Y8odu7BxLTx/oDsysnuV+xP1QwyyZcwmY5weJHSFCIFN0Be
x/kMB+abkO4r/XeA2hBpXMOQl+BIwCB6wiOGbB2RsawZEGYlYj8DsZsMEFe/96LR80IpHK0S
Rxbr9viP58jTvRxkAt02cuH6qKI/B7eR0QSiy4fICoUXr5cR6aQbQIav4NPuUlZpAaaWxWR3
oDZLZzu0tTATXZuj07DKp+izH4wum7C3rPvvnQ7K/W70233T9jsym78fmj53y02k8yMhWx+z
eGhQtVyJIsxBYQ8NVL256HqlIspXR6BUoO8PF9FHUVWfZH4rARUlCxWv7jZHyI2HRh7mqva9
qLhbRTpuoheIoxdgNsRSrrJIpZ/X0aZYJ5i8KpZ6VsrfrllPe0fdhWbnxorSkk3+e/A+tLAB
vUeaNPsWCpm1kdFrNN3TzR06i4UmBhu0n0lgGLzH8GDf5Q8Q362gAm9UBjZiiMEQ38Ogc60q
Yoleq/ubcoQSBiLzVX/BvNq3YtZISkbzA+IMh5Q4qgPXq60xUO4+BfcEg+T/m8/vZPOxpot4
A4PdVPWSSrDIgT55Zo3+pZZ3Y3OGNP4p8CPftUZjE/IeEwndoAS4ytZ7eVQu1QZ/4w19UyXY
fVv95ttojObRzvBqXc6X5PzXNY5NreNtAYqfx6gAPE4//ZtYlswTNn2Wyw3DZ3Wao3DM+nKl
bun+hD44fWXuEDkoXs6z+qk+5tMpXierFFTrcaHwkK6bzLY5+RNclUnn2Tg2kWpd+kDPi9tU
Z0GdIIVJVz+jVarAT4+Ut9l8jcbNyw0ybPVxH7V9Tb1BrdzdYmE9tyzsvasMUt0usLVGvQpb
a1S9t62xtUZDRbaE9WCVrTXaKrO1Rr06W3pUFdrSW3qVtsTfK7W1Rm2trTXaLrbFC7arbak7
vUJL3Z9+va012im4tUbdiltrtK/kdouu87QtuiVZfbVGQ5Wo1uh/Xoo6LKKBYlSaSN98+wut
vas/X//6DRubWcXombm6ekGPrf8Aaf9qlJ1RAAA=

--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-openwrt-vm-openwrt-224:20190416221017:i386-randconfig-a1-201915:5.1.0-rc3-00003-ge00164a:237"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/openwrt/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.1.0-rc3-00003-ge00164a"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.1.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40904
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_KVM_GUEST=y
CONFIG_PVH=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_F00F_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_ANCIENT_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=y
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOOLPC=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=y
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
# CONFIG_GOOGLE_VPD is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
# CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
CONFIG_BLK_DEV_UMEM=y
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SX8=y
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=y
CONFIG_PCH_PHUB=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
# CONFIG_HABANA_AI is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
# CONFIG_SCSI_3W_9XXX is not set
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=y
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_DPT_I2O=y
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=y
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=y
CONFIG_SCSI_UFSHCD_PCI=y
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=y
CONFIG_SCSI_UFS_CDNS_PLATFORM=y
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=y
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_HPTIOP=y
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=y
CONFIG_VMWARE_PVSCSI=y
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_GDTH=y
CONFIG_SCSI_ISCI=y
CONFIG_SCSI_IPS=y
# CONFIG_SCSI_INITIO is not set
CONFIG_SCSI_INIA100=y
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
# CONFIG_SCSI_IPR is not set
CONFIG_SCSI_QLOGIC_1280=y
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_DC395x=y
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_DH is not set
CONFIG_ATA=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_CEVA=y
CONFIG_AHCI_QORIQ=y
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=y
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
# CONFIG_MD_RAID456 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BCACHE=y
CONFIG_BCACHE_DEBUG=y
CONFIG_BCACHE_CLOSURES_DEBUG=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_UNSTRIPED=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_THIN_PROVISIONING=y
CONFIG_DM_CACHE=y
CONFIG_DM_CACHE_SMQ=y
CONFIG_DM_WRITECACHE=y
CONFIG_DM_ERA=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
CONFIG_DM_DELAY=y
# CONFIG_DM_INIT is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=y
CONFIG_DM_VERITY=y
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=y
CONFIG_DM_LOG_WRITES=y
CONFIG_DM_INTEGRITY=y
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5520=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_OMAP4=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CROS_EC=y
# CONFIG_KEYBOARD_CAP11XX is not set
CONFIG_KEYBOARD_BCM=y
CONFIG_KEYBOARD_MTK_PMIC=y
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_AD714X_SPI=y
# CONFIG_INPUT_ARIZONA_HAPTICS is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_MSM_VIBRATOR is not set
# CONFIG_INPUT_MAX77693_HAPTIC is not set
CONFIG_INPUT_MAX8925_ONKEY=y
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
# CONFIG_INPUT_GP2A is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=y
# CONFIG_INPUT_TWL6040_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_RK805_PWRKEY=y
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
CONFIG_INPUT_DA9055_ONKEY=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
# CONFIG_INPUT_ADXL34X_SPI is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_SOC_BUTTON_ARRAY=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_STPMIC1_ONKEY=y
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=y
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_MOXA=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_IFX6X60=y
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
CONFIG_SERIAL_MEN_Z135=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=y
CONFIG_MWAVE=y
# CONFIG_SCx200_GPIO is not set
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_CROS_EC_TUNNEL is not set
CONFIG_SCx200_ACB=y
CONFIG_I2C_FSI=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=y
CONFIG_SPI_DW_MID_DMA=y
CONFIG_SPI_DW_MMIO=y
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_TOPCLIFF_PCH=y
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EXAR=y
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_AMD_FCH=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_MAX8925_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
CONFIG_BATTERY_OLPC=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP20X_POWER=y
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_88PM860X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC_P9_SBE=y
CONFIG_SENSORS_OCC=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX31785 is not set
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_CHARDEV=y
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_STPMIC1=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LOCHNAGAR=y
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8925 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_STPMIC1 is not set
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=y
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
CONFIG_VIDEO_TW686X=y

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_IVTV is not set
CONFIG_VIDEO_HEXIUM_GEMINI=y
CONFIG_VIDEO_HEXIUM_ORION=y
# CONFIG_VIDEO_MXB is not set
CONFIG_VIDEO_DT3155=y

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=y
CONFIG_VIDEO_CX18_ALSA=y
CONFIG_VIDEO_CX23885=y
CONFIG_MEDIA_ALTERA_CI=y
CONFIG_VIDEO_CX25821=y
# CONFIG_VIDEO_CX25821_ALSA is not set
CONFIG_VIDEO_CX88=y
# CONFIG_VIDEO_CX88_ALSA is not set
CONFIG_VIDEO_CX88_BLACKBIRD=y
CONFIG_VIDEO_CX88_DVB=y
# CONFIG_VIDEO_CX88_ENABLE_VP3054 is not set
CONFIG_VIDEO_CX88_MPEG=y
CONFIG_VIDEO_SAA7134=y
# CONFIG_VIDEO_SAA7134_ALSA is not set
# CONFIG_VIDEO_SAA7134_RC is not set
# CONFIG_VIDEO_SAA7134_DVB is not set
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
CONFIG_DVB_BUDGET_CORE=y
# CONFIG_DVB_BUDGET is not set
# CONFIG_DVB_BUDGET_CI is not set
# CONFIG_DVB_BUDGET_AV is not set
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
CONFIG_DVB_PLUTO2=y
CONFIG_DVB_DM1105=y
# CONFIG_DVB_PT1 is not set
# CONFIG_DVB_PT3 is not set
# CONFIG_MANTIS_CORE is not set
CONFIG_DVB_NGENE=y
CONFIG_DVB_DDBRIDGE=y
CONFIG_DVB_SMIPCIE=y
# CONFIG_DVB_NETUP_UNIDVB is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=y
# CONFIG_VIDEO_CADENCE is not set
# CONFIG_VIDEO_ASPEED is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
CONFIG_VIDEO_SH_VEU=y
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIVID=y
# CONFIG_VIDEO_VIVID_CEC is not set
CONFIG_VIDEO_VIVID_MAX_DEVS=64
# CONFIG_VIDEO_VIM2M is not set
CONFIG_VIDEO_VICODEC=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CROS_EC_CEC=y
# CONFIG_VIDEO_SECO_CEC is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEOBUF2_DVB=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y
CONFIG_SMS_SIANO_MDTV=y
CONFIG_SMS_SIANO_RC=y
CONFIG_VIDEO_V4L2_TPG=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
# CONFIG_VIDEO_IR_I2C is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_TLV320AIC23B=y
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_SONY_BTF_MPX=y

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=y
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_AD5820=y
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7640=y
CONFIG_VIDEO_OV7670=y
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9T112=y
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_SR030PC30=y
CONFIG_VIDEO_RJ54N1=y

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
CONFIG_VIDEO_LM3560=y
CONFIG_VIDEO_LM3646=y

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_I2C=y

#
# SPI helper chips
#

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18250=y
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA827X=y
# CONFIG_MEDIA_TUNER_TDA18271 is not set
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
# CONFIG_MEDIA_TUNER_XC5000 is not set
# CONFIG_MEDIA_TUNER_XC4000 is not set
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=y
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y
CONFIG_MEDIA_TUNER_QM1D1B0004=y

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=y
CONFIG_DVB_STV6111=y
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
# CONFIG_DVB_CX24123 is not set
# CONFIG_DVB_MT312 is not set
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=y
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
# CONFIG_DVB_TDA10071 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=y
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=y
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_DIB3000MB=y
# CONFIG_DVB_DIB3000MC is not set
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_AF9013=y
# CONFIG_DVB_EC100 is not set
# CONFIG_DVB_STV0367 is not set
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_SI2168 is not set
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
# CONFIG_DVB_LG2160 is not set
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
# CONFIG_DVB_DIB8000 is not set
# CONFIG_DVB_MB86A20S is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y
CONFIG_DVB_MN88443X=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBH29=y
CONFIG_DVB_LNBP21=y
# CONFIG_DVB_LNBP22 is not set
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
CONFIG_DVB_A8293=y
# CONFIG_DVB_LGS8GL5 is not set
# CONFIG_DVB_LGS8GXX is not set
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_TDA665x is not set
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_M88RS2000=y
# CONFIG_DVB_AF9033 is not set
CONFIG_DVB_HORUS3A=y
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
CONFIG_DVB_SP2=y

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
CONFIG_AGP_SWORKS=y
CONFIG_AGP_VIA=y
CONFIG_AGP_EFFICEON=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=y
CONFIG_DRM_GMA600=y
# CONFIG_DRM_GMA3600 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
CONFIG_DRM_CIRRUS_QEMU=y
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_LVDS=y
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_ILITEK_IL9322=y
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_CDNS_DSI=y
# CONFIG_DRM_DUMB_VGA_DAC is not set
CONFIG_DRM_LVDS_ENCODER=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
# CONFIG_DRM_THINE_THC63LVD1024 is not set
CONFIG_DRM_TOSHIBA_TC358764=y
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_I2C_ADV7511=y
CONFIG_DRM_I2C_ADV7511_AUDIO=y
# CONFIG_DRM_I2C_ADV7533 is not set
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_HISI_HIBMC=y
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_TINYDRM=y
CONFIG_TINYDRM_MIPI_DBI=y
# CONFIG_TINYDRM_HX8357D is not set
CONFIG_TINYDRM_ILI9225=y
CONFIG_TINYDRM_ILI9341=y
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=y
CONFIG_TINYDRM_ST7586=y
# CONFIG_TINYDRM_ST7735R is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
CONFIG_DRM_SIS=y
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_PCM_OSS_PLUGINS is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_MIDI_EMUL=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL3_LIB_SEQ=y
CONFIG_SND_VX_LIB=y
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=y
CONFIG_SND_ALS4000=y
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=y
# CONFIG_SND_ATIIXP_MODEM is not set
CONFIG_SND_AU8810=y
CONFIG_SND_AU8820=y
# CONFIG_SND_AU8830 is not set
CONFIG_SND_AW2=y
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
CONFIG_SND_CMIPCI=y
CONFIG_SND_OXYGEN_LIB=y
CONFIG_SND_OXYGEN=y
CONFIG_SND_CS4281=y
# CONFIG_SND_CS46XX is not set
CONFIG_SND_CS5530=y
CONFIG_SND_CS5535AUDIO=y
CONFIG_SND_CTXFI=y
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=y
CONFIG_SND_LAYLA20=y
CONFIG_SND_DARLA24=y
CONFIG_SND_GINA24=y
CONFIG_SND_LAYLA24=y
CONFIG_SND_MONA=y
CONFIG_SND_MIA=y
CONFIG_SND_ECHO3G=y
CONFIG_SND_INDIGO=y
CONFIG_SND_INDIGOIO=y
CONFIG_SND_INDIGODJ=y
CONFIG_SND_INDIGOIOX=y
# CONFIG_SND_INDIGODJX is not set
CONFIG_SND_ENS1370=y
CONFIG_SND_ENS1371=y
CONFIG_SND_FM801=y
CONFIG_SND_HDSP=y

#
# Don't forget to add built-in firmwares for HDSP driver
#
CONFIG_SND_HDSPM=y
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
CONFIG_SND_LOLA=y
CONFIG_SND_LX6464ES=y
CONFIG_SND_MIXART=y
CONFIG_SND_NM256=y
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RIPTIDE=y
CONFIG_SND_RME32=y
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
CONFIG_SND_VIA82XX=y
CONFIG_SND_VIA82XX_MODEM=y
# CONFIG_SND_VIRTUOSO is not set
CONFIG_SND_VX222=y
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
# CONFIG_SND_HDA_CODEC_HDMI is not set
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_SPI is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=y
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=y
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_SOC_MIKROE_PROTO=y
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_SSI=y
# CONFIG_SND_SOC_FSL_SPDIF is not set
CONFIG_SND_SOC_FSL_ESAI=y
# CONFIG_SND_SOC_FSL_MICFIL is not set
CONFIG_SND_SOC_IMX_AUDMUX=y
# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XILINX_I2S=y
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_ZX_TDM=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU1761_SPI=y
CONFIG_SND_SOC_ADAU7002=y
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4458=y
# CONFIG_SND_SOC_AK4554 is not set
CONFIG_SND_SOC_AK4613=y
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CROS_EC_CODEC=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
# CONFIG_SND_SOC_CS35L35 is not set
CONFIG_SND_SOC_CS35L36=y
CONFIG_SND_SOC_CS42L42=y
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=y
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS4265=y
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS4271_SPI=y
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=y
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DA7219=y
# CONFIG_SND_SOC_DMIC is not set
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_ES8328_SPI=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98927=y
# CONFIG_SND_SOC_MAX98373 is not set
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM179X_SPI=y
CONFIG_SND_SOC_PCM186X=y
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM186X_SPI=y
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM3168A_SPI=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=y
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_SPI=y
CONFIG_SND_SOC_SSM2602_I2C=y
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=y
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS5086=y
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC23_SPI=y
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC32X4=y
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC32X4_SPI=y
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=y
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=y
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8770=y
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
# CONFIG_SND_SOC_WM8804_SPI is not set
CONFIG_SND_SOC_WM8903=y
# CONFIG_SND_SOC_WM8904 is not set
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_ZX_AUD96P22=y
CONFIG_SND_SOC_MAX9759=y
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD=y
# CONFIG_SND_X86 is not set
CONFIG_AC97_BUS=y

#
# HID support
#
# CONFIG_HID is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_WHCI=y
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=y
CONFIG_MMC_TIFM_SD=y
CONFIG_MMC_SPI=y
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_PCI=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_TOSHIBA_PCI=y
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77693=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_AMD76X=y
# CONFIG_EDAC_E7XXX is not set
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82875P=y
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
CONFIG_EDAC_I3200=y
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
CONFIG_EDAC_R82600=y
CONFIG_EDAC_I5000=y
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_PCH_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DCDBAS=y
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBU is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_PMC_CORE=y
CONFIG_IBM_RTL=y
# CONFIG_XO15_EBOOK is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=y
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PCENGINES_APU2=y
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_I2C=y
CONFIG_CROS_EC_SPI=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_LIGHTBAR=y
# CONFIG_CROS_EC_VBC is not set
CONFIG_CROS_EC_DEBUGFS=y
# CONFIG_CROS_EC_SYSFS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_CLK_TWL6040=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16209=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
CONFIG_BMA220=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_DA280=y
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=y
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7455_SPI=y
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7124=y
CONFIG_AD7266=y
# CONFIG_AD7291 is not set
CONFIG_AD7298=y
# CONFIG_AD7476 is not set
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
CONFIG_AD7768_1=y
CONFIG_AD7791=y
CONFIG_AD7793=y
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
CONFIG_AD799X=y
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
CONFIG_CC10001_ADC=y
# CONFIG_DA9150_GPADC is not set
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HI8435=y
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=y
CONFIG_MAX11100=y
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=y
CONFIG_MCP320X=y
CONFIG_MCP3422=y
CONFIG_MCP3911=y
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=y
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=y
CONFIG_QCOM_SPMI_ADC5=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC084S021=y
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS7950=y
CONFIG_TI_ADS8688=y
# CONFIG_TI_ADS124S08 is not set
CONFIG_TI_TLC4541=y
CONFIG_VF610_ADC=y

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y

#
# Amplifiers
#
CONFIG_AD8366=y

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_SPS30=y
CONFIG_VZ89X=y
# CONFIG_IIO_CROS_EC_SENSORS_CORE is not set

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORS_COMMONS is not set
CONFIG_IIO_SSP_SENSORHUB=y
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
# CONFIG_AD5593R is not set
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
CONFIG_LTC1660=y
CONFIG_LTC2632=y
CONFIG_AD5686=y
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=y
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
CONFIG_AD5764=y
CONFIG_AD5791=y
CONFIG_AD7303=y
# CONFIG_AD8801 is not set
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=y
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=y
CONFIG_TI_DAC7612=y
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
# CONFIG_HDC100X is not set
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_KMX61=y
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
CONFIG_CM36651=y
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_SENSORS_RM3100_SPI=y

#
# Multiplexers
#
CONFIG_IIO_MUX=y

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=y
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
CONFIG_TPL0102=y

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_HP03=y
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y

#
# Lightning sensors
#
CONFIG_AS3935=y

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
CONFIG_VL53L0X_I2C=y

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
# CONFIG_AD2S1200 is not set

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
CONFIG_NTB=y
CONFIG_NTB_IDT=y
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
CONFIG_VME_TSI148=y
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set

#
# VME Device Drivers
#
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=y
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
# CONFIG_FMC_TRIVIAL is not set
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_CADENCE_DP=y
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
CONFIG_DAX=y
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=y
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_XOR=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128L=y
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_MORUS640=y
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_GEODE=y
CONFIG_CRYPTO_DEV_HIFN_795X=y
# CONFIG_CRYPTO_DEV_HIFN_795X_RNG is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_PREEMPTIRQ_EVENTS=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_DYNAMIC_FTRACE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_TRACING_EVENTS_GPIO is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

--sT9gWZPUZYhvPS56--
