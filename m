Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846D7C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 01:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D0620881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 01:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfLBB1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 20:27:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:26181 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfLBB1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 20:27:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 17:26:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,267,1571727600"; 
   d="xz'?gz'50?scan'50,208,50";a="411591934"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2019 17:26:55 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ibaUI-000Gop-8F; Mon, 02 Dec 2019 09:26:54 +0800
Date:   Mon, 02 Dec 2019 09:26:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        philip.li@intel.com
Subject: 5e6669387e ("of/platform: Pause/resume sync state during init
 .."):  WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688
 device_links_supplier_sync_state_resume
Message-ID: <5de4684e.IaCwhRvrFq8+6GM8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5de4684e.5JkgR+lPG87Klc+8H4eHXbIq3kSBnlRrHwK1l11jdj4W3TIN"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5de4684e.5JkgR+lPG87Klc+8H4eHXbIq3kSBnlRrHwK1l11jdj4W3TIN
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 5e6669387e2287f25f09fd0abd279dae104cfa7e
Author:     Saravana Kannan <saravanak@google.com>
AuthorDate: Wed Sep 4 14:11:24 2019 -0700
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Fri Oct 4 17:30:19 2019 +0200

    of/platform: Pause/resume sync state during init and of_platform_populate()
    
    When all the top level devices are populated from DT during kernel
    init, the supplier devices could be added and probed before the
    consumer devices are added and linked to the suppliers. To avoid the
    sync_state() callback from being called prematurely, pause the
    sync_state() callbacks before populating the devices and resume them
    at late_initcall_sync().
    
    Similarly, when children devices are populated from a module using
    of_platform_populate(), there could be supplier-consumer dependencies
    between the children devices that are populated. To avoid the same
    problem with sync_state() being called prematurely, pause and resume
    sync_state() callbacks across of_platform_populate().
    
    Signed-off-by: Saravana Kannan <saravanak@google.com>
    Link: https://lore.kernel.org/r/20190904211126.47518-6-saravanak@google.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

fc5a251d0f  driver core: Add sync_state driver/bus callback
5e6669387e  of/platform: Pause/resume sync state during init and of_platform_populate()
b94ae8ad9f  Merge tag 'seccomp-v5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
+-------------------------------------------------------------------------+------------+------------+------------+
|                                                                         | fc5a251d0f | 5e6669387e | b94ae8ad9f |
+-------------------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                          | 35         | 0          | 0          |
| boot_failures                                                           | 0          | 11         | 11         |
| WARNING:at_drivers/base/core.c:#device_links_supplier_sync_state_resume | 0          | 11         | 11         |
| EIP:device_links_supplier_sync_state_resume                             | 0          | 11         | 11         |
+-------------------------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    5.695288] ### dt-test ### end of unittest - 219 passed, 1 failed
[    5.698253] Unregister pv shared memory for cpu 0
[    5.702549] DEBUG_HOTPLUG_CPU0: CPU 0 is now offline
[    5.703456] ------------[ cut here ]------------
[    5.704233] Unmatched sync_state pause/resume!
[    5.704260] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:688 device_links_supplier_sync_state_resume+0x4f/0x180
[    5.706900] Modules linked in:
[    5.707376] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.4.0-rc1-00005-g5e6669387e228 #1
[    5.708730] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    5.710111] EIP: device_links_supplier_sync_state_resume+0x4f/0x180
[    5.711174] Code: 85 c0 75 47 83 05 c8 ec f8 42 01 83 15 cc ec f8 42 00 68 78 cf 40 42 e8 df 75 8e ff 83 05 d0 ec f8 42 01 83 15 d4 ec f8 42 00 <0f> 0b 83 05 d8 ec f8 42 01 83 15 dc ec f8 42 00 58 e9 fb 00 00 00
[    5.714313] EAX: 00000022 EBX: 2e3be8ad ECX: 91fc3059 EDX: 00000001
[    5.715302] ESI: 42769f73 EDI: 000016f8 EBP: 40115f24 ESP: 40115f14
[    5.716316] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[    5.717378] CR0: 80050033 CR2: ffffffff CR3: 0296c000 CR4: 001406d0
[    5.718332] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    5.719325] DR6: fffe0ff0 DR7: 00000400
[    5.719943] Call Trace:
[    5.720376]  ? of_core_init+0x1f2/0x1f2
[    5.720976]  ? of_platform_sync_state_init+0x47/0x6d
[    5.721694]  ? do_one_initcall+0x210/0x5ab
[    5.722338]  ? parse_args+0x380/0x760
[    5.722927]  ? kernel_init_freeable+0x2a1/0x484
[    5.723663]  ? kernel_init_freeable+0x2cd/0x484
[    5.724407]  ? rest_init+0x220/0x220
[    5.725001]  ? kernel_init+0x16/0x270
[    5.725608]  ? ret_from_fork+0x2e/0x40
[    5.726342] ---[ end trace e07e47ab6a227b84 ]---
[    5.746163] Freeing unused kernel image memory: 2620K

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 32ef9553635ab1236c33951a8bd9b5af1c3b1646 v5.4 --
git bisect good 1c134b198daa81cb689f881dcf2900061914085a  # 02:59  G     10     0    0   0  Merge branch 'x86-mm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good d76886972823ce456c0c61cd2284e85668e2131e  # 03:20  G     10     0    0   0  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect  bad a308a7102215a582fc474375648965bc5692894b  # 04:24  B      0    11   27   0  Merge tag 'ioremap-5.5' of git://git.infradead.org/users/hch/ioremap
git bisect  bad 6a0e20cd8cddd70ae5c1211ebe102d738ff2069b  # 04:41  B      0     1   17   0  Merge tag 'riscv/for-v5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect good 0dd09bc02c1bad55e92306ca83b38b3cf48b9f40  # 05:04  G     10     0    0   0  Merge tag 'staging-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect  bad 9a3d7fd275be4559277667228902824165153c80  # 05:47  B      0     3   19   0  Merge tag 'driver-core-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect  bad f1dfe70b7ff73e1469fd6ea25e89d8a4d2dd1c39  # 07:31  B      0    11   27   0  mmc: atmel-mci: Remove superfluous cast in debugfs_create_u32() call
git bisect  bad e40d38f28c10e3010b2828f2c737b50fb81bda8f  # 07:31  B      0    11   27   0  debugfs: remove return value of debugfs_create_x16()
git bisect  bad 201e91091b1d47047f55580b5474e1239f4d17aa  # 07:31  B      0    11   27   0  sh: add the sh_ prefix to early platform symbols
git bisect good fc5a251d0fd7ca9038bab78a8c97932c8c6ca23b  # 07:31  G     11     0    0   0  driver core: Add sync_state driver/bus callback
git bisect  bad d4387cd117414ba80230f27a514be5ca4a09cfcc  # 07:32  B      0    22   61   0  of: property: Create device links for all child-supplier depencencies
git bisect  bad 5e6669387e2287f25f09fd0abd279dae104cfa7e  # 07:32  B      0    10   26   0  of/platform: Pause/resume sync state during init and of_platform_populate()
# first bad commit: [5e6669387e2287f25f09fd0abd279dae104cfa7e] of/platform: Pause/resume sync state during init and of_platform_populate()
git bisect good fc5a251d0fd7ca9038bab78a8c97932c8c6ca23b  # 07:43  G     31     0    0   0  driver core: Add sync_state driver/bus callback
# extra tests with debug options
# extra tests on head commit of linus/master
git bisect  bad b94ae8ad9fe79da61231999f347f79645b909bda  # 08:53  B      0     1   17   0  Merge tag 'seccomp-v5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
# bad: [b94ae8ad9fe79da61231999f347f79645b909bda] Merge tag 'seccomp-v5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
# extra tests on revert first bad commit
git bisect good fd231e31e9be1a388ad6c2ce5f601aae8d859510  # 09:25  G     11     0    0   0  Revert "of/platform: Pause/resume sync state during init and of_platform_populate()"
# good: [fd231e31e9be1a388ad6c2ce5f601aae8d859510] Revert "of/platform: Pause/resume sync state during init and of_platform_populate()"
# extra tests on linus/master
# duplicated: [b94ae8ad9fe79da61231999f347f79645b909bda] Merge tag 'seccomp-v5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
# extra tests on linux-next/master
# 119: [419593dad8439007452bb6f267861863b572c520] Add linux-next specific files for 20191129

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

--=_5de4684e.5JkgR+lPG87Klc+8H4eHXbIq3kSBnlRrHwK1l11jdj4W3TIN
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vm-yocto-3bfeebd98b7a:20191202072328:i386-randconfig-e002-20191201:5.4.0-rc1-00005-g5e6669387e228:1.gz"

H4sICCZo5F0AA2RtZXNnLXlvY3RvLXZtLXlvY3RvLTNiZmVlYmQ5OGI3YToyMDE5MTIwMjA3
MjMyODppMzg2LXJhbmRjb25maWctZTAwMi0yMDE5MTIwMTo1LjQuMC1yYzEtMDAwMDUtZzVl
NjY2OTM4N2UyMjg6MQCsW2tzo8iS/Xz3V+TG/TD2XCNRvCFCN9aW5bbClq2x3D290+FQIChk
xgg0PPzoX7+ZBUigh2XPXUV0S0DWqaysyqyTWZi7afQGXhJnScQhjCHjebHEGz7/rx+AH7kj
i88DXIdx8QrPPM3CJAa9o3VkKfWYRE91aa5zwzBs1TK5olhw9DQrwsj/H81SDDMI2Mw1+TEc
zT1vhWB29I4MR+d8FrrVlcSOj+GfDCajMYxQ5Jx7oIBsOsxwdB36k3tQZGZvavZqGd1gWTgw
KZbLJM3DeA7fJ6ffBhBwNy9SDvKrLDMHfnm1TAiixBUiyySMc0j5PMxy1OmXvwerIOxkMviP
cTTEOf32/SM4r1nu5nyaBAHO1g/lwQHQTeOkvp+FP3lW3lZ0Yy/KIHZnEferVrUuGSpjntCK
yPlrDoQFYQaWqsDsLefZCRQZDeAXbBX7bur/AkGSLty8s9nR2fB2Ii3T5Dn0sZfl41sWem4E
d6cjWLhLZ6c4txTZgR8LvhA2aX+k1i07mAXBA2pDo/gUmB1422ABgeHwefrM/U/BBdu6BX8f
jm0OFUfpl3CfHSq25Ntgf1u3gAdkuCYc3frbcCVaC+7va8dqjDWcoq7gdltumaL/Pzng81kx
dyCcx0lKSztK5hF/5hHFQnLWrZV9k+Shxx24+Q5Hg1fuFeg+56Ho4xhRk5x7OUU4z43jJIcZ
B176mgNxEkvj0wE88TTm0X9vIk9GNEJQOhbioA3ibbc6Hw0d+G0w+gqTygNh3IejUNPki+/w
LxgPh99PgNm2cXwi7AWsw+SOIjGQta7MuhhBtU3Qy7cl2jvMkhStQeqTrlffRptyT88LyYsS
D632VYSBRZZmoM10Q/NlBqhPfSG/09RbFiCfUFtQ7JmLs3dCk7Fw0zfxTIi9076MQJn3iHGl
DIL4BUxRbZMZhqWD9+ZFPGshmA8lbJYUKc1dA27hZvi//BpsfPDB67SEosfM8zWFa+iMsxPx
KPQjPo3xmWUx3ZZ1m2mWCnGrX2Y8QJ55Dm5lpVlBYbbWsZkBo8uftFg8nqHZ120UXUVdyzVe
LH0KzRueUy/xxtKGXu/fO5xG0TW1xkr5InluYrlrrD1uoug6e4DIzfLpMoihh+1ETBGjd1Pv
cXW7dL9mS9N+gNH93R2up8AtohxyXGIOvKRhzqWZ25xfRbfUSjgIX9FEqRvPcSOqnaYlifbE
30J1+wI/exBtmeROhdyZkCtiz/UeNwdoayTXF3IXDbzKi1uiZqXks5uGwuj79TRkRegJMzfD
7V3uV1Mn1hpcXKyud2plyDq1ZuCXQcVvPbPombLzGWP0TN39TGBqu58JTH3nM0VgGrufCeuZ
O58ZrOQa49N7B/pJHITzInVFXPwhSyayk9/PAH6/B/jal/AfbF230FD73900JsdPYqSsiq2Y
ozN4CaOIAmyRcb/TaoBD+oq2d+Fy+OVyNBjV01SF3pYwLdYwDvMQ+Qn6R4JxCCnKkoLgDt9T
zdJfGgiWiqM9u7vCoeFzJqsoegLVb+Fb4y/3p2fXg2YbA1c9sqHz4eRq1Y8ZuLZZ9mPW21ez
jYl2OO2PcQsYCOaei4WIkRAjW7Egbh0GSLOEmXfMCkaquv3d5HzcJjIXGDpl4VtMg6NnXJ1n
t/3LCRw3AewmwH0DAL1swGzVEACqTACsAoCz7+N+KV7t1uLO6qrZgU2xvuzgAr82O7DkU9HM
1LY6KMU/0IFVd3C+PQLk4WQCZvZPtzo4/+AImN4YwWSrA7m0sdYMl7ayGvXpeNjfGrU5EG2s
bbOW4oeVUsy6g8vxYGverIuyA9Xa6qAUP9yBujLrdUI8Xyjm+j7uSpRTBFxw0dagaXMq/ayU
zhOoP0FFD+FodacCaHVq4mqsIsH17e/k5e6zG0a07DstObFtVH1FyQuG7gXu6SDBzChZclPa
EiHvgJgqxP5I4nofcFrPRLS9ocwowh87MhraMpvM3Ch5/kMLhTbR5Fn4+E/qCZOuNKeECzhu
G8gmm2m6atu465RxoYpiJFCp15IT2omHeGtnwrWhHn5svqmebR+A2Z/MrGE0mXa7P3ia4NRk
eVp4OSzduShGFPFqOmsjg22Jx1kLAad3iPGb+i8LGEIp+SN236URQzvexjVInuRuJPp0wNRs
zbBass2ZpklywNCtSkmxL4n5QkVw+bUa2lsN5arVNpPTZEXZEi+VKducwPXw4hb5Ru49Ooa6
aqkYlqE9VGxdeJmfhrhN1LxsLWjiwq9deDyS7sMFSg1vYZykOfFfZB4NYVVWP+fv2ISt9o5r
kp7ejIZw5HrLEKn0D+LfD+AHkfgXYWqGt9jDcRPAxD6Ht9T2h4wEwl2GHjalXKIuKjHzpKWE
SDHx+ZfJEGRJUZtoxP1KdYY399PJXX96++0OjmZFRsStyKZh+hf+mkfJzI3EhVLr19KK3GAY
o42I4pIyyySirzwN5/QtAPF7ePeb+BaWGp7D6ucNBlilgaitbfuOZnpTMx0ew/kjiLz1uAVl
7FCOVcqpG8rpe5TTm4hM/oBydlM5e59yTPuEcvYe5ewWovkB5VhrUvFqj3pEfT+snrtHPbeF
+JElx1hLPbZXPesT6s32qDdrIqrKSr273+QyeM3eAPPGNA39xpZKsvonVj3b0ztrIX7Gj9Q9
iE0P14hgfBhR24OotRCNhoX09y2kfWY8xp7ejSai/pnxmHsQzRbirvCwD9Hag9jcFzRDbljI
ft9ChtqQZQcWnNE0PXrF+8Kfsb23Z1xeE9H8jO39PYh+C9H8BCLfg8ibiJb8CcRgD2LQQlxz
BzQ9HI1Oz++PBaGhMxqvldaHcXkSgL+bELbeyjxCn8iEJVuGq2BCQQUSUXzj/iZf0KmIki2W
syTBIZ1GSMhJEQX646/IdzBsJ/kyKubiutXOWuUVJVugzIJI3kxkFDUraAZTXcc2FVv0Kmoo
kVYBHTMgMVkTURr8uD9EAvUcerzVMa3nM9RWnC65qfscpnnhRuHPVdkB0E7Nuio2ohymVZpM
eRDG3Jf+DIMgJNK5WaDcKEzWtzeqksxmTDFkDFlkEhp53FKWUhRBlqdLnnp0InRzN0VTThxV
gTid4i3qeDoL82x9C/EzR1wQOxZXjSBu2SYumBpvsJhxnw5/VF0pWWqXyrsZQw6hKjKkMvgq
00wFCqbh1m0rTSQLZ3+J8pKLM+857zUDIdLDbn7VZNtooRhtFCSOlBfg/2xdYKKqAzojTkyV
PrjZW+zB+EJMtihXN2WJtlD9OMu5G+XIk1sl7ZnO/JlttVpQen9WhFGOvRJ3j8IsxyW8SGZh
FOZvME+TYlnWtjoA95RwwCrjUKwNMIxtV+Vq8hLMKmKf6DItHFx6vS6uyy7mregeRTyf5jSF
SzcOvR4rTzoEbe6VP7O3LP1r6kYv7ls2rQtkqVfWnTv4Q0w5Zp1RNKWBJkXeY7SSeN4Jg9hd
8KwnVwcpHez4aZHNe7jEyw4lBlkS5LS2aZVVSsSLcPpCaYqfzHviJiTJMqt+RonrT1F9P8ye
egoVyBfLfHUDZz6d+Z1FGCe4GpMiznsWDSLnC78TJfOpYEk93BDK4xw+XR3mVGfcvTx/kzF7
xiS5VJtuTOQTxnQFB9aQWt98nru9uEy80hey9VOv6/HlY5B1y2PublrE0l8FL3j3LfHyRMLF
IX50Q9UyJExd/TJUSpgUKRKdYTP8rxvRkbqUYiDhL87IpaNh6SwqFjzOKIZEjp8uJLRxEkvP
PPYk73mWSUH4KvW/nU2kBTqgtCBLoqxTg0qyoTLddFrn8Wag6IFsB77sznzFtH2XM1nzAtfk
zizMuJdLg+HYmZYxbUpDzKZZsVxGIU+n5AzT8mwZEytU71/ya7fzvCD1f0of7agetiKbiqwy
yXLatpLUGSaNM9+2ZqYLMzSa99hrWqi7w0Ldj1uou2EhOLu9vZ8OR6dfBr3u8mlezsaBGZt7
nmR2Pzrk7spG778tQR7H06CTPRa5n7w0nJ0RyRde6pRfUDprXc1ekx5VZgbGsHMe53SM5nqP
HB7d7LEqEdNtsZnoCgUUOEpSn6cOYFalyLaJC70+36dY4qbHDWDFFHkaGXM/Lp0UaNoKF7ki
WsHSTeM9XKtVNdfkddVc21k1V6lqWNZ6QtpXKWTilvVPuSGhUtpGO7lb4KKisr5DdTPvyZlO
kTOmJ/DI3WW5ZThJXF0GKedOg7gQjraFg1uuK86Iy5izPiygSvwTx3C34ECBstOpZoZ1FE2V
aa8dCVmH6pWaZWlXXcW2TctUrhrc4ojhypSvarJAr+Hg/DBFvcLIgzEZk0wLdzW8SsortDqK
k3InYJr0e5ahramWQ1JVHQmNegXewpXqG8dN5ajsUzGVuuNqXJH7hhHf2RSmD/oYUiyAkoD4
qk0EQ6rZCF0AHCmWJsPT2VZvQPvltFypJYAmGFcFYHmsAtAsw9oNAPC8EFNYApimKM+WALys
1RIAoNfCaDcA8kmaXgGgVZyvBDDWAFRd3gcA0CHLlwCK4Zs1gKbYhlED4AztGwIC0DSWAMzz
TdutAQxP8ywBwNCxtXcQxHs6JUJjDCs4qBbVBgKjGlOfzo1oOYcB5I9htj6PRm4dIx3N8DaH
38eAJBBwG43FK2LF6mUBCrC41G+fmqvdpBTw9nxw9vULeh6PAnR/qulmWV3RJDFNpiMJjHyY
F+AmQ8fJ5ftB/a8QLpYRxxifi2Si02xEB22i0T9IkFTKMb1xPTGKzbBYNdGaTfy3OA+9J4l4
MvIu1+MSDidMfHA9j0e8TmZ2Y+l6EwvdCaOfl1dhKMMokixqGt1Dzox5x5o295Q2lN1SS/Ax
nEoeE2P+bSIi61uXv4Z5qxnlGKIF9gGCmcFLeTCaQUXRiMRS18TUjnaSuOM2JE7EP+6RKGbC
+rvGbdZmJwGcJq+IXHqb4dmNCk5vX4i3MQo0n8RjYrc0ezgojCBkSsztq2ymjVpb89T/sxAb
Osw5hlCKC8S8SffAxYWYI7Fzgx4zTlr2bGCJA1+0PKa2E4yxKpVzUDRM/6I9z6AXTLiIF0Lt
8jYzGgCWWS/Hf9wG9I6gX481opcLqrmlWXbgKEYOv7ahajOZstz6haL6dcofgkU+1AZtiJt0
IHWNvBhNtKQZj703smWI4SBJ6bx8+YY5+2MOR94xbtCyAXeo9qWLYX4Yex36f57AKIliN13j
qrKJ3aFDwuj0+/T6tn91PhhPJ1/P+tenk8kADQNWQ9qkGNCUnqL4/aUDq4/WENdUTd0Gvxr8
72TVwGK20mhgW2bZQHR/eTq5nE6Gfwya+KtsjRroyIi2exjc3N8NB1UnqmIaDZ0MVde2W/Qv
T4c3tVaGrquNPnDMdqUUSe1SaqMP06SXeOotsa46RRuTR8UPXHeyrmKgXTe2dFKQMmKgTEyq
DrgqsAATNrFosCUm6yVTWjdGfrg6keljMgPEg8UxB/FR2VqvX9y+FE3fqCM8Lnn+nxcPzFXZ
gLphljibGA/7DkxeQmTWFGiytwU5LaZvw+6t2BTKPHrdTtFpKOKV09VBFMmh2S8wkmDSW1aZ
mECgx41OVZUCBQ0EbT94zalMhUZoED+S0pEBYxc3SBiHN19geCuVNa273xpQunjrQuzaw9vp
DgFDHEqIHJmO43C7w2w3ycmnY/EC11rUFDtY4zxqgmEXE3kRx0pycyRjDiz9G+3MA/qmwhtD
t8WBy3CKG8cz/TjHbcRhx2tkS9k46dqJrJTIqlwjy4eR0Sm1w8jqps7qQWSGu4hyGFnbRNYO
IzOb3s85hKxvIuslMnsHWWXWB2bQ2EQ2DuusqcQUDiGbm8jmYWQMZx9AtjaRrcPIhvmRVWdv
ItuH7Wzaygd0ZvKWq8iHsW1mGx/A3nZDdhBbkcsa/SFsZQtbOWhthRn2B/yFbbkiO+yLCmZ/
H/BytuWM7LA3KtqHYhPbckemH8bWdSr6NoMvM/ZEXyo3GBuy5l5ZiwqwLVlrn6ypqRsbALP3
yWIurrZllX27Bb3ut6GDwvbJ2grVeFuyyl5Zk17Ja8mqe2RV2aDXATqd++FocOfAMz5O0p7Y
Qqg96wkA1lPEpUIFXLym7zUG00m3FtHIM08SFdWPv0sduMg+NY+59gbxoKzA1il/tpUm81BV
RcNx9pEjz9Ly73fK7CJKkiUcZU8hnfccl6/N52VegiRPUy27Y6lwlsyT0XA8gaNo+WeP3sG2
mSGvl55KCQAy+NCfojpO/XaMU5JBWCBjWBQLvJQbptAVqs6NqAz9TmGMSPGqLKaeVIi7imKE
aeBqrTDF3yf9vwGbBqXlv/76K3w7vR6en94PIF8sg4xuraUsnRLslhTVBNpCtkLLqCXkiRMM
tiFnGrvllJacJmtEkq/dLC/fcoDw/vpsPU7t6ozOVpSR+NLoa92WiReRGm39Q21PgH1pQeDK
whU9WaI3IMf+xsCBUZiHc1EIoL824KmH+Vg3e3GXmGTP3BSx00z8tUNZUiz/lAy/M5cqkz8b
Z6DUgabT9rfqQNno4KLAHH7OY04EOuU47zR56+a6atkbzeuLZwW69cXd5AzXaQM2jATXpvv0
xyj1X3QJ1r5GNwzK7QmDUnoMzDDJKdc4e6OKjQPfigg1W7+hTm1MjZKNa3Z/4dQnUWXEWSzD
qHrhbXw66MBN0lBJ3KZGayBLo7R9dD5p9oPJDpVZRYFjVgSBsHWe88Uyp1JmTJgeLsrVy4+E
ZBtUT7lIOacx0+G0G+GMxGJIWZVwUcp/tWqjy4aB2839pI/u7vpkdFFBSTcTdk1nCr16sTqL
Rs1kh07aceAiMRuv6mZHl272wqPoGI4CdxFSTJT/j7lr72obWfJfpXfyR8gMhu7Wq6Xd3F0C
JOEMEC+QudmTk+Mj2zLxDdheCyfhfvqtX7WkbluCkAyzuZwzGduqqn5X11tf421Wdq7wORht
i/KmWMDdx6zQndEo0Lh7+sWSHemzUSEOYeCiVVjNSps8iFS6mKeGKYoYF47on7yt4vq22eX2
JadOsXGs5HD5nc022na383sMbzUWTUAmXsAAjkleLUjLo201Rt4Om788q3eN8tXEWeMTb8UM
ZJvgO9DMbUTpEzqp1tzCf08aN7OKTRDGHV4AB5FYiI2cI+XlHGn64nrfyjqqKXQqna12/I1B
+t3+fEYrYaMA6rRHhJEis4y/jKeFcPdIrDiw5x7vcwu2w/usau9zEDjvMzBgR2iWbr6CUYna
UDzL21U0hYMm1cV4AzrJvza9XuSjT9YnrT14k/hRGtZ1PZ8I7WzJdHoh8bHhbcskSboTx82F
7HZ/TLSIE42Lz3wvZXVGBqInNoHqcM/rnLpmbd9BQvdxvgkIR96c7u3LAk5kfB7wBcl2PXAq
GPVm9HBWDtDeb/LrMN0leqNIEKP8KEbL2SU/ee5NaWLizXyyvyxYg9pLAo2xTFbEwLt9eurh
ggCi4thWWc1MWcCgRfIGHwSY60WHvT5MohR+tQYNtuUGuGxBxxHuVOJxdDPBj7Us1tazeVKu
htaV5lBJC4UltrjEfTRf9sar6+tbZE5ySM11gdxoB20MksdODy8ycVZlToP8cn5DF8SVsDzY
s/SGRsZQMr7Ml5/YY4+wCRp8bzkfTmfWqF5cVQmcdP5GuHKKr7hiYcVrGDNxyrzODwNV0hXp
3NBBxJLWKYqXiE2bcfT3bOVgg9DZ9RCSxdFaCClaNiNwwHTecSfsIyqbQDij09kBd0hFtkpX
foPdNY4Qa4mUPVD29iwJdnFNx5ra1oO3uA+KOQ7nrMEZUrp5Tul4YXzL28XN/PpyOeA9sqXD
Z9Yierkscv6JPa0wjN58ROxKbdQk4WziZiuNDFy/n7AIxXJ3FZIyuKXje2nFaSg7aEV08GUT
GbjH4UaDN+dHW6RsruiMHHBEwzMHTqK+6gB3N3gbI01lB0awI8XgfL+Py6GYYTlKDylih8Q9
zexd0jgvscPbLcZhZ4tcgaF3QNJF74/puJh7GIlKuibBYhwXs/nnee/0j97rg5Oj3t5qPPVw
daAjfSfu6/5R7/XtcDkd914t8wXJCt4ooQw2zSobIrh3cmzZU0mHmzfRhORb2p+j/11NcTY5
Xmmej90mj0ijSFzoMSRpUuNu2oLYOuBWJRKV4lyK8+hZN5Td7FUcILY3S+rL1aKxWmzieWfk
4xwHiQZ/WdB1QJzvS+UHAu1/h9uUVGwaIrFOFEYoxC+L0fT5bD5alr/wQJcFeihyOo2unVBF
qtkcdRmGQLzqH5bwrw7ZtyBZYpCNsBzFWrosMbCCM7pxIY2hc+/pB3q4Rbw5h80aN8h7G+7Z
m0w+uLmJA42wSmRdiP5pX+7JIJMkzNKS72eCeEszqe/Pi8trliBf99/1Log/BB98MvB4tchM
8ukV+p2Px+LkZP/N6cujV35g6DaS4p/eVOzF+TsxnnWGVBJ/LUjuHcN1At+0XYYd14WI80+B
6S8TNW7HTd2R0kGTYg0FfzQdeI9tzBwjLAt7lYv307mocoaQJzSaJNXSe6NP2Hj3HcTGNpwU
8kCLWCpl+jBiXbnbw06iiQyRmPRwomtBr7ZMRJuoMg8dttt6DjuQkcVuMKXcQdoYgoEzpXHt
28BlSbJVzhk8MnZBwaBBt2G6QUM5GgjA6KShfBokTsUtGsrRUF00FFxfDQ1DPLOTBrF0gub6
FHblRzLEnNL/vKkwMWeCtNGv6EYY3Yqjg0MBbvmpJqgcQakmvPJqkngESSLt7M+dBENHMJjE
HqXUVBvnoZSM17XEdi3xupaiLsN3ERx5XUu8rqVBELQHGTQLp1TQtfjG30ApiUFJF42qC3XD
sT1ecTCBnJ+TlsVeXxTXCJkFO4rEDNpr2aaYWIqJ7KJ4fvLCEUwlHO1rBDXvcZrJMFMKaXSt
YQb+OYnhDVZdNLztZM/9ZOzO/bjSWOjydZs1lqSSbE67T8s4WsQ4PB4iJ97xj1XEhuO7yATS
J1M4MkVHlxA/sblJA4+VSFl0TJFemyJNB3pzioLuKSqGI9cfP1sUZHQYb3I1n0zocQJpOUHg
o5tQbU5ucNesGNeLYcesEH8NNkcUulnRUT7smBXjn48YfG3zfIR3zcpEucWmj15XSC8Lu25b
utdP357sVZm1DXikZGR80eaokdFICv0k3h+f/r5H0g1c9SISv5LSo5zdLI58FeAO9Bf3oEec
enYv+r5DJ+xf19ATJdU30A/uQTectnMv+nmN/mvqEGPFIlj7QH2+zPPlMKvLF4mcZCfc0H+8
2quSVhwNzXlNd9NwOBDpUBBjXMDwWj6fzn+jjbA9/zJrPrM95Dlio1wDgTadzKNuoJLaYJ1e
kr6+mJfl1LM1k9jGGWU1+LriQDqWBq/0JHbWQSDmw+e4IeCvgWNvsm8F0e62aFodNxeH65E4
NV5dSIdjaLmQmTVPe4KZV1ssXWcUD6ThFe1qinU1NJIgDIINw5ONwqHLhDruPXC2zxo7iZMU
Rpk1f8xwMfF9MUls0pabaJlfr7uJSPpNoCgtZgvasrO+nXSYdxqIBDH2DCGqo99HphZUoj68
doxhN9Y2iQAlKxFDxCuyrdApwwhq5m1eUVIPohTIoINSkPANVFHSD6I0UV2UIgkLTk0JIsj4
Ohf6gwdhjF6DeEBbSef4bZp0TSl8EKWwk5JJA28mowdRiqRqUzIyCj1K8Z+gFCgEZK3tJNIi
YZFDXSE/xQ7QkYS5/eZjgWScQXlbrln9qt+d2e0pHC2DL9OyeLpGI/0eGov5l2I5qGJH58uG
ktFKJpunkasZLK43zcCdRuANE7CWJoLyoUPP9mt0EEEfaetctaoVPkBhJdYTVfLgHVSiB2iq
Rkf1bXEHlfg7VFSj4wju87upJd+hmxptFOqIfMsQrB1CGsMgcDNaDBCvXMwGMHugdsSATeyd
OS4ydJkz4bZITSDDOwzttLMVLOYX+31RlCA0LcGmu+hag31NONoWKqC91Z2RA8qadoqlPKRp
eABJZONUqZJ30YwMrBBEMxOvG3plY5SB78YfRuVjQPP80aNEvB9Zwwf9b88hhopUibu8FSYw
nPdNxHrH05s7Mo++i2IoOX/zmx4Dh6BSXGVn/f01BCQ/jsXb06N3oiQGUHAawqxkc9812553
HAltkg4Sq/HiPqQg7mqXNux9SCGXNelCOn15/jncQcb16NPoYz6D1/4eQjbqoG1pgcIaZC6U
t096BKIGzoqrIi8LRyAOWnoxm3uOpwgJQPzOdAmvCklju5B7uS8Tz7lDKkSgNqVT7sOe9Sey
Yfd8TxyQRkEDumSnTs7uHI+I4SjqtgTKJvRauGVfX/kxJ55C03X25gT+FMfMvEql6/qfCdMk
lJVIuX98LmS97+q6h3HYwEakSmMzz+BJ5YQVEplYumoc59SzmC4B40IZGGbcBDCQsiJ/d7CG
83g2o7H+qjgstJgarMk1WjrJkVhZlZ+jjv6D48nafltCSzQ1w2EHyLaZZL1eD/VLl1y5E86e
TMyWBcn2y/I5tcdFGPkj3cLDeVk8V6JKjpzVTi1QtekwoEoNo3wxLQK8R5g4JI+grYGly/H3
DjNSUfKjmEi+akbSCW0LdXnjB3/V34tFa8uOoG/00k7WWi8VvGI/jKlkZ0896FZPSUwx4fdi
kWgvIy+dsyzqvMqb5aq84aIJt4g2KR1GGElOf7+1lozhFR0l3N8t3ykBBzQUY129IIJsCMRL
UC+uF1zW4LkKedfz3fFcowQPOHn1PXaEIgl/5T+Hq/G6CkrP4oCN4k2PcpcM0dGlOGSnxZ4D
oiHCsY0osqdfaXBPO9GiEPU070BbfBqVphvPJJjgy8V0PpjemITd6L4NgGBgN40/sFvsamC9
131m5ZX3TZz8fe/oAo4p9j2fH1687TtkLbkMUf/kiFhUWaJwG7FiorLMmiiNIN3RHoaB/D1d
XE9J6c4s6rlddjZ9TOD3scFMDomEF+MhvbU9Q1kPSCD57LZFYqv2UwKdmKasesni/HwyWUuy
2uckK0Q/z27yP2gWc3Feh1H1LF4feOA/4vM0xz6lkwuzimuExASex8WKNhqDixermxuagLwU
u5Uus3t8+u78f84vTugiwuf+389enOIz49l/GwYHRStpauSskXxPiC+rayjYkTKOOUiwWNJB
InlPR3JXxVEkm7CwULBbzxZ/oZtuaa9gv0Qo0QmCEJa4Sj/k/DXchEjKkV+DCclZqEn1HMIv
wgQGw3w1pq+2UMIzpPrlgtvda0jGKkLXKkURJJUjqR3J4DtIxpwSMitHA2xtd+M0xh4AJREC
n16TYMAXVGbZD7t169+qeD+5k5JgtIW8UM5WNLKKDUONjnx5OeV80Lj5tU79C3CxaQR3cpBK
b4o0fTphmOJLmvYZ5zUVSDd8fupQYgWufrK3T+TE0eHhIZK6d9TeoQeSQkgtYGCtAg23zp6J
/tmbXU6NPi1uwNXEga3l1/NeqhDsaNX7ZHqne7WTAvSMgpRS0VvPLlRpmvY4xbAJaKSd4gcA
hjtpGHI9lruto3XxEKwsZ1dY1Ag5YxF8Zdz2mpFbFDcfqTdbkJ2C4OT1P7NA94gtPxORzqIQ
YEpnQZjVLzEAMeIe4T3E7p6qfRsO3wTmRsjSSWC5nRoZwhh0SqpP/3xXAxTGyCtY5SprUvb7
i4Ptyh6Unbx5+8HG28Rym/4JBRdq21bakYaxBfV1ltN5ZlsQRELYaIAWqsMzSRpt4O29fXcX
nmtQK42yR9WGgAFU9b6QgC0O8qsr4j+zahpqPWfHYUYRBJqKb+1diAsI4ja9F7kdGnfNcI5C
8z4fWxAE3Pq73Mld7vEaF3ODohsSi2ZvmAUXEsm8EFaEDjfRrQ0SrQ4ktGpAT0n+rdJqn4ov
1I9VcwPU156V4VFEj+/hpwg6A4N+KobFKEdwBnLZYWoAPhr1BFU3HWGgEGZRt/t5Mf6LG0QY
Q/oAhVQ2GHHIdpgqPkOcVck33J2j/md3WmBhoQ1eonQFHmzj35DtdCd9UlZg47I/3aygD/KV
4N28EWIPWYJIFzOIT0czTiMHXNqHP61eOAdPggpNny1Uu2DJDOK9e45IObCLcddTI429qI/o
iiKyECXEcEkS1yiHjrAWDwR4FWLvImi4qmVWRQtXFiMptuokD0BrDQNoA/3H4dn50ZvTDNCR
bF6LwJAc8yX/5J+jF0Q4Af9K9NQavThA+OJsdT2kHUEq2UnfygmsUyI+NdrxgLkwsQOuU22f
SPf2mkzo0ENJeBdhrbF3cC6ObJrvTvefwzQcSVpBUxObz1NauipuvDmYT3DLtSctjdMqxBzQ
ApU/mvhsps616RxCKkNpNhAO6JTQ+bgVF/w+Aw9YqTDeAD6+OBfN3zowx2ts9lplXHuc/nPM
M9VsJvXoCqj3XwnPGlBw7Te2MJU4RFrSaBOxT4vaBPnDnef1KdSx3ISv572SLzL/Yk/DNA7b
g9AdU5/SHaM2aefLIcwfNlvFB461qUZsvXjeQNn0l3mg7K6qovuk94A0BqQSLqYz1BSq5dxt
UcDbuM0lVbfFH1skYUIiPtvC/8/533pLbIsD+/jE5yGpSRA/yoTVdiP2tAhr3SJcx9EzYb1B
GEHfTY/1PYSDdo/XCKsWYaVNWBEOHnEqovqlEiAcPiphW4GbCUePSjjibDEmHD8q4ThSNeHk
UQknXE2HCZtHJZwqSOVMOPW3G2fReftYfec+VjTJNeH8MXusSC2rCQ8flbBOg3q7je470t+Y
itbJU6EK6gMyftQeRyxEMeHiUQnHAdJgmfDkUQkncb146jH5caSMCauTp9RjEibpNqkYvdKP
Spj4cbXd1KPyY016RLV46lH5sQ7ZF8SEH5Uf6zhoFu9R+bFOTH3nqUflx9oa+SCWkCaIbHsU
GoZ1OfNg0sjC2IIWWaOl0/UTIk0VBaztI+U94reZ0CNb8iEL3CM675of2YoNWegeoeLQB1uM
nB9F3iMu8UuPbAGTLHaPAgV7Nj2yFUiyxHvEr4qhR7aESGbcozCKLEFbAyRL3aOIg29tFW87
MOk9TKruq3rU3rDjILLDrspoZMqbrthwuRp6WE2K8mYl4bRxPKymRXnzYqSuyFYTo7yZMbF0
isC9f2I8nxWNthFVBei42Nmgyiw9ydm9IErrlt5Cx1JN9yudQZuqSpv8We9vWzR78I2TRrMt
ekqGAQRdt7XChC2Jx6Ts2vQsm0zdoz32Dve1GCGnlN/uVIfEAMvEsOw17oedwaTkLK2WOwDA
aYwsLgd8DyyJHtBnJmUPL5W6uc1cvi3yJuufG3iaUjCJgxWp9egiO8jhNYDSR9p70bMVK5eF
9ZzT8fllXAP38NsT9UtDzaQpSq88efJEjG96nA2Gz2XtMlxRX/jXnridr+xrwMqiEMVyyel2
7Ilws5QGXMTrzctM7K71Z3dhvRXcRLkLE9Pqulj2clRxW12N2WxzWVDrNeCouLoqe9fTksMN
YWi7l2L1AtSl2/GkmkAX+lfoS0zKZvjjfWHfSwXoSCKV+5FJRnxev4vk+hzBvVBFlfW80ceJ
/kvoGvY8PJzu8M4Vrta2au0HVljJGO9E+cG+dC4HCeLh95JsTZtuTxsxSw73qAzL64wjc9/Y
AK35NRDEX8bF16pEGxNsqKGYULW4MHNe5cTB/r53dnp0+ipr6tsW+SfLO+aj0WqJfL4Ktnpd
5hh1I+cLYry3rcFWkD3EsvOj3nBV2g81d5K7MHavStcpk8qf3Sm12SkSL0L9kzulW52KuEDq
T+1U0OpUym+S+6mdijY7FQZscf+pnYpbnUpk+rP3VLLZqUjxm+J+aqdMq1NJaIKf3qkauzeZ
z13X0hhqwlrX+K0f9tuiHMBLuByMSmLwsah/tY6oJ4n4rx/oSdN4rEK9uYPqQVNjU+tRu5kv
rufOgRQnKDX6QUz1CP/1ZJ3Rfr26upkurgq8XhgP4ZVzN09CO2NzoP8Pa4Ae3sGjW/wwMVr9
hL17Txdb3NFECqrcg+a+0fFiEs3h39iU9F/uHR2ToD+om6v23O0Aqrt9zcfWs0wHRtdjHHD0
COcib/haXVsRexY224Izcl2n0CqtSppsoyhGPr3yqRiuBvV21jg9Fp85oqYYu8K+a6+NiXYS
vIsb6hGqog9ev7noH9P/bR0peMKl3dBf8D5zV/0LeAG/o6vn/b0Xo9WN+Ejamvjg/+5wQh1w
B/nVF3itZvMCDxrVqix27Ws8/s3HgJm52VDUJRR06MOfytE61itc7mKOd+Ho3hllpMmKh78w
JJzsIlnUm5GY3/Vr63SU/FoVbJBZ5iAS5P9udGZ/fo2qNV/wfqflrhQX+dR6sl6Jjb8L8Y3X
bjxRrimToDzj63w55qAv6KOZ+O/Dk7cIU0VtHNQoEFvTMJQv34nfOAwaoeZp/GzbBsapHSV3
dE8JGe5KhbeNNOYIZAgiaxfvWPkzU0ZE8CqOfS6cjPfcS5FEIkyECYSkr0YUIzExItRCKvyo
6MeR96MUsRGJEaOJCCV+KWgJJyBiCjGZVHTGsoPOOFyj8x9y8jchhzVGV8vj9ZYjgknFZCg4
csdz+CUq5Djvw713tetQa3H4gr7pIhgWJh+Lw336lqrJKCCxUBweNJDSraGKApS2ODw/yqjJ
JE4nSUCgRxZUxdSTwxe0ACEtRjTRIUE23/y1itnEh5p0UiZDcVh/eMkfaKivzi1Jcc4faEoP
Xx7vVb8igSd2xGgLE8fZP6NzbjjKIAjoG2kvTUT2/llAiDqN+X3H+2chO4FDGY+9GTIBlOqD
M8+vTd/U2je99i1ou2ETlQa4HQ/OYm6/kJMJQJMKNFwD5dcz7+P9Ahd4S4I7lprT8oX4T/Bn
8IK6cpaa6F3+1wNNHWit2Pl7vcIME0KMxw5Psaue8MbzwXxm4VCyi2C1kgQc5UMHTezOMDRH
xA7y5WVJgIEBYBJLD5CNmwT4f+1de2/bOBL/2/oUvMUCSe5CWe9HcD5smqRFL22zcNJdHIrC
kCXZ0dl6rGTHmz3cd7+ZoSTLTmQnqdMN2gMIW6b5GA7JISnO/Eb4OaFiB+j6BV/dYdmeiuBf
znI0aLqFKuYbsvjBehbUnacs6B+iaqKmITXwuUyHOifrRSMbLUxoNxNailMWiHWn8QD4OMFC
Q6y7kdLS8ShHiwSuaugZI2ShYoeG7Q0tT9PsoWPQslHnMSwywavsDeYJgTCVjmCiGDV6K+MD
8jZTZzTFy9BfUcGb1JVC4QmjzEpokwIDxws4ohAyOsgj1L2rTRrFkJO2/jxhXQJm9woB0F4C
yNUJbafU9mf7qqZuBotyNKMJFnVZaX7OQfpWBTqG6eALbYwLPoEQ+txQEa11l2VNtpc5bPKw
UIGgUU4EZ2xCm83Fv9RsoLT0f0Q/D5YFObTg7qAglyTDlxdkaqRKtcKMLPSjUURcTucZ25vc
xHtQ9gQ2KrUWpWOZjlJlhNINfXPPwHHnDowXlmKbSqMvjGZfhBjLV3rCNR0LlU9W0m8n15IV
x6SbAczoBTESvAV3DPZfdwi2CGQbAWuW5Zj2lnK0lYZDdJxCV531+xf95js32J8npW0UbiW7
02jYFdZZRXfzhuYI8VaLuX/NRrBhZbAHrYupq6u3eBw2OWEYFIyfYUr++s+i6PXx1fG7ZnVF
iKCkpUVasamIk9I4EQdJpeAaVQYAaFTFqu5ydcXCrRPqZ07TMQ5UR9ncXzBBm/11Xkm1AvFY
EdGUXZz/RRI3EugFcIY3NbMcJ96tAFwg1Ub/OidkTIF7hYZ3IFDplLLk6Cxle5wjkjCO4b1N
Tb4qK7hRZZerfAzTL9BHvsbYqXcTsn/CYlmwvwfw/O+fEKghTmFbfSun+VieT/4hFdfxEayM
tknuVjksHnrguqFqsH1DeJwEiYAQYp+X91q3Ba68AkIzhcPbjAxm2b6uagcorBFxK6zvWOUq
/ymQQgsyYVDk4zmBiZV3abYMGzK6MyyFE9lBwW6s4XAH98boyL06epV5rKW0K7m9Wd4Zq+JO
EFfeZZUlEQgmeg0yTRs3aUaVrOx01N+diXMGQphQn88zmf2KZ23haJKNph56YLqGwxIeILwp
1oeAmjNZqliJbCzZWSDnlp6WSpYRDxtML9D8AI9FkLhiMKIGNf1+wvRE1bii2W905tvSbUFY
w7LWBNRgdLCDr0iQS7IgWl1G1iMJ5GM9kkbqvSNp20jQDLqFeq5eVSzYTdu6Y/5JvbpkqnEf
U5UGU0+PP7xBZP7+xw8opdnxJetfXFzJ0sdkinh5eNeJdOTzJBHGocyrfffFwhzzUMDlCXkq
9NBJOX9O7t2gyrgQwgVIxVcnaKBHCMrvLy4lkDVFFEdTL2eL6wgSiWIy2NwlyNopOjuchKKK
skLoJxR3dPuNr/7QA5kHoiuP6ShNgPyy9C8gPSajk4WXEMyKsMDB1FVz6MUh50GewsyPbgq2
78/zHGqGahGDNY8Im3p6IEsSwsdyn96ZzJfMISdftwyXfGgA9FrFsSCFCv7Px13xsRzaBEkM
p0cGO6wwP1Kq+H7pZ7LbnMCmSE4+4ESyNwh6L2xSaaULwsLPowwWulqaiVeImm1SCvI4LBA4
u7STF4kE9E/pvAHvZIUHrxdF4yX6tbum3kGjjUWeorFFuXcZzRb7+A7eP5DZPlePfiG3erM0
ZTCCxsLneCDcgtMhitQ3DlbrN0xDv0MAiBZJMetXLsxUls+6s3zeEtTls9XM5T64hM1heH+8
BpQHbGQzxfqy8lvo9B0GMnkIzxtYYTyg/Iek+c6C1Bw0dvM//UsKfVpO7/54XcMh4MKztqN2
N9rcnGo7myjh/fFwtHQ0ZnwHw1BqdlVzWKlbu/Dh4u5Z6G6bDuoTSzTa5lELI1yXOUOUpw8s
X3/8mHU2/HuHKttahk3FtpGhowMtvFrY1dx6ScFvNGpl6FjNdPaO6vO/UqueZU1YCS0c0S3m
wkJv7k7Qv4zQztDdCru2KfZU2fXCQ+sio7dsJB4d2sb7d7CCv8Agte7bWvp71BJv+8wz7svV
ImEDF4WSdif98JHnHZ0u1s0h01sG1trKDIlHozKspNyRHH7+JauNQd/oBFphqNEU7s8sgodD
1CAZ+V98BH9hoX3Kb1w5R/C5OmWgM7x7NxVhS2UrL1B2tUyb98dbBnNV1MJZI/qBwQrwWGnZ
66PMe+yWu6WZ69LnbtAeVM5jQ7t4euZB7nnovzkMW994vfDwxFnziNC2wdrVAeGFhd2/FlgP
35bY/ios+7ZDy0x1XOYFLBi2riVfLbQLmV296fkW3xhtYmh5T3SCd5CohUJmfSVqNfnAwGsj
GdHH6ssu+amv2jeRwRjTbYS1tQjGX9zzc/JYNy/CgqVDBHibhWz/59eDtx/Org4vL07OBz8f
n5yfXR1I14vKmS/p0pBa0h7esXXjqPC7+Wyz6szlLCVTfbxvRx2g7gQ/Uc8sRd/xVTTbz6KA
6ap+IFX/TJrx1oGERuHSaehvVT8S1uOXYRJUigKlUmNYEAjW1Vn/PSuiceJNEdSqPeH523fv
Ggk/JjF6iCcw3zBOgWPYXAGeW4NJ26asaormNlQrgi26gWbtr1PoVZxWOiLEtoWXrVWOPhGm
63X3CQUPx1ClgGW7QImhos+mFUTiukfW0IIbmVw0AiozACeIzHVs4axUxAjozrTCEK7wopeF
mY6+jha9nQLLREDUnVBgqKqOGrNbKBCI0MtM0IcbeFDiRz+UAs0x1nGht1OgG/ruKDBN10X/
vsJhdD+s1TwbjoApoUWeKquElZJELjJI0hnamiGQALnABi5J0uQm7u1Lnd/CeM5Fafx3xxpY
htThQiuHQxL4gbY5paP2w78VcZjhp5fBP6Xy8o/iGyJK/PVuWpAudPc2BWkiPnklwSLdsWR/
/Ackj5mjuho8FHHG8LsEmCfE0kOQEvC7B18K/CV+oejLD6OAYg/RleVoEfRmfnZ0pGuKrvEj
DcshjUIBTJ34mDnlJQBxhy/QzidIxyyydEUJi2EjjnsCOS0I0QVph4OUJJzdHs1dZB4SS7jB
IAmDKEWaoyJDqzFy5QRtSqGVIEqT+XQqHUgSmt4kAXIa9Rh7JIFzL4YmXc+T8QChvgeZl0R+
T5U6Zb1eBj/LZ+ia/LeBN114t8WggnTswHjKAm8WyjiwoIMGBDU5QArT+ayHLhw7wCI5GpGC
Qw9+ZsD/2USG+idxMe6lCURRvRwqLtLRDJeLebYkJomjQcWYHsVKnTTNiuoZsb0H0BRgwKSn
YQVpnM3qGKgyyIeBHEdJmg98lII9h9oDQy2QYZUQlmm9MM+ljlAhG0AsRUqdEsC0N5vdQkmh
l09vRQt6BLR8KCCPV9I1Ym/GXi9BP6pQUr6QOkOQ3P51b0puetEjdLjovqepxF9NUcWOsBan
3SCPOfArTfhNmPjcvxkWfBT9zk9+eXXJEYGVk5kYpEWbJRcmksrRe5NpS51XFxdXg7fvj9+c
9brZZNylyro43DmuG2IB5KGiaLzK2x37Pre7K2rA9kgzR4o7ChRvGGi2G3gwHQx/5Nlh9ybG
Qv/gmxWJxfAAaSM33AB0qq4coEgqrnuWgsPzhx//A7P800+f//sD42KsMogTT5/+CtHS/wAU
bCQn97oAAA==

--=_5de4684e.5JkgR+lPG87Klc+8H4eHXbIq3kSBnlRrHwK1l11jdj4W3TIN
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-yocto-vm-yocto-3bfeebd98b7a:20191202072328:i386-randconfig-e002-20191201:5.4.0-rc1-00005-g5e6669387e228:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 8192
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
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
	rcuperf.shutdown=0
	watchdog_thresh=60
)

"${kvm[@]}" -append "${append[*]}"

--=_5de4684e.5JkgR+lPG87Klc+8H4eHXbIq3kSBnlRrHwK1l11jdj4W3TIN
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="2e57c5fca382a4b94347224fb585b0dfd4e892d1:gcc-7:i386-randconfig-e002-20191201:EIP:device_links_supplier_sync_state_resume.xz"

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

--=_5de4684e.5JkgR+lPG87Klc+8H4eHXbIq3kSBnlRrHwK1l11jdj4W3TIN
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.4.0-rc1-00005-g5e6669387e228"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.4.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_UCLAMP_TASK_GROUP is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

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
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_BIGSMP=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
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
CONFIG_MWINCHIPC6=y
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
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_TOSHIBA=m
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
# CONFIG_X86_PAE is not set
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_INTEL_UMIP is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
# CONFIG_ENERGY_MODEL is not set
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
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
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
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=m
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
CONFIG_GOOGLE_VPD=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
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
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
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
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
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
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

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
# CONFIG_XDP_SOCKETS is not set
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
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
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
CONFIG_INET6_TUNNEL=y
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
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
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
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
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
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
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# end of Cadence PCIe controllers support

# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=m
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=m
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_OF=y
CONFIG_MTD_AMD76XROM=m
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_SPI_MTK_QUADSPI=m
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_HYPERBUS is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=m
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

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
CONFIG_VOP_BUS=y

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
CONFIG_VOP=y
CONFIG_VHOST_RING=y
# end of Intel MIC & related support

CONFIG_ECHO=m
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=m
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
# end of Distributed Switch Architecture drivers

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
CONFIG_NET_VENDOR_GOOGLE=y
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
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
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
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
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
CONFIG_USB_NET_DRIVERS=m
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
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

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
# CONFIG_MOUSE_PS2_CYPRESS is not set
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
# CONFIG_MOUSE_PS2_ELANTECH is not set
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_OLPC=y
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
CONFIG_TOUCHSCREEN_ADC=m
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_SPI is not set
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_MSM_VIBRATOR=m
# CONFIG_INPUT_MAX77693_HAPTIC is not set
CONFIG_INPUT_MAX8925_ONKEY=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=m
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_CPCAP_PWRBUTTON=m
CONFIG_INPUT_WISTRON_BTNS=m
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_TPS65218_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=m
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9052_ONKEY=m
# CONFIG_INPUT_DA9055_ONKEY is not set
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_WM831X_ON=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=m
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=m
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

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
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=y
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_NVRAM is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=m
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=m
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=m
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=m
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_OC_TINY=m
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SINGLE=m
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD70528=m
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=m
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_TC3589X is not set
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TQMX86=y
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
CONFIG_GPIO_XRA1403=m
CONFIG_GPIO_MOXTET=m
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_MAX8925_POWER=m
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=m
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_CPCAP=m
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_OLPC=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=m
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_CHARGER_UCS1002=m
CONFIG_CHARGER_BD70528=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=m
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=y
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=m
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_PXE1610=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=m
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=m
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_MADERA_SPI=m
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=m
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SYSCON is not set
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD70528=m
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
CONFIG_RAVE_SP_CORE=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=m
# CONFIG_REGULATOR_AB3100 is not set
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AS3722=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD70528=m
CONFIG_REGULATOR_BD718XX=m
CONFIG_REGULATOR_CPCAP=m
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9063=y
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=m
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8925 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_S2MPA01=m
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_REDRAT3=m
CONFIG_IR_SPI=m
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
CONFIG_IR_GPIO_CIR=m
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_PWM_TX is not set
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=m
CONFIG_RC_XBOX_DVD=m
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=m
CONFIG_DRM_RCAR_LVDS=m
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
CONFIG_DRM_PANEL_LG_LB035Q02=m
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
CONFIG_DRM_PANEL_NOVATEK_NT39016=m
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=m
CONFIG_DRM_PANEL_RONBO_RB070D30=m
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
CONFIG_DRM_PANEL_SONY_ACX565AKM=m
CONFIG_DRM_PANEL_TPO_TD028TTEC1=m
CONFIG_DRM_PANEL_TPO_TD043MTEA1=m
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_DUMB_VGA_DAC=m
CONFIG_DRM_LVDS_ENCODER=m
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NXP_PTN3460=m
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_SIL_SII8620=m
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_THINE_THC63LVD1024=m
CONFIG_DRM_TOSHIBA_TC358764=m
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TI_TFP410=m
CONFIG_DRM_TI_SN65DSI86=m
CONFIG_DRM_I2C_ADV7511=m
CONFIG_DRM_I2C_ADV7533=y
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_DW_HDMI=m
CONFIG_DRM_DW_HDMI_CEC=m
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=m
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_GM12U320=m
CONFIG_TINYDRM_HX8357D=m
CONFIG_TINYDRM_ILI9225=m
CONFIG_TINYDRM_ILI9341=m
# CONFIG_TINYDRM_MI0283QT is not set
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=m
CONFIG_TINYDRM_ST7735R=m
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=m
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=m
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=m
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_TPS65217 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_RAVE_SP is not set
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_BIGBEN_FF=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=m
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_GOOGLE_HAMMER=m
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_GYRATION=m
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=m
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=m
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=m
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_U2FZERO=m
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=m
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
CONFIG_USB_XHCI_PLATFORM=m
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_MAX3421_HCD=m
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_BCMA=m
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS3=m
CONFIG_USB_CDNS3_GADGET=y
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_PCI_WRAP=m
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_HAPS=m
CONFIG_USB_DWC3_OF_SIMPLE=m
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_OF=m
CONFIG_USB_CHIPIDEA_UDC=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=m
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=m
CONFIG_USB_FOTG210_UDC=m
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=m
CONFIG_USB_SNP_UDC_PLAT=m
CONFIG_USB_M66592=m
CONFIG_USB_BDC_UDC=m

#
# Platform Support
#
CONFIG_USB_BDC_PCI=m
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=m
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y
CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=m
CONFIG_UCSI_CCG=m
# CONFIG_UCSI_ACPI is not set
CONFIG_TYPEC_TPS6598X=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
CONFIG_TYPEC_NVIDIA_ALTMODE=m
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=m
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
# CONFIG_MMC_REALTEK_USB is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=m
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_CPCAP=m
CONFIG_LEDS_CR0014114=m
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_CLEVO_MAIL=y
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_SPI_BYTE is not set
CONFIG_LEDS_TI_LMU_COMMON=m
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_LM36274=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_DW_AXI_DMAC is not set
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_FB_OLPC_DCON is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_GOLDFISH_AUDIO is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_FB_TFT is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# end of Gasket devices

# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_USB_WUSB_CBAF is not set
# CONFIG_UWB is not set
# CONFIG_QLGE is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBU is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
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
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_XO15_EBOOK is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_MLX_PLATFORM=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_SPI=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_VBC=y
# CONFIG_CROS_EC_DEBUGFS is not set
CONFIG_CROS_EC_SYSFS=y
# CONFIG_CROS_USBPD_LOGGER is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_MLXREG_IO=m
CONFIG_OLPC_EC=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
CONFIG_ADIS16209=m
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
CONFIG_BMA220=m
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD06=m
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MXC4005=m
CONFIG_MXC6255=m
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
CONFIG_AD7476=m
CONFIG_AD7606=m
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=m
# CONFIG_AD7766 is not set
CONFIG_AD7768_1=m
CONFIG_AD7780=m
CONFIG_AD7791=m
CONFIG_AD7793=m
CONFIG_AD7887=m
CONFIG_AD7923=m
CONFIG_AD7949=m
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
CONFIG_CPCAP_ADC=m
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=m
# CONFIG_HI8435 is not set
CONFIG_HX711=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
# CONFIG_MAX1027 is not set
CONFIG_MAX11100=m
# CONFIG_MAX1118 is not set
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP320X=m
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=m
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_NAU7802 is not set
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_STX104 is not set
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=m
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
# CONFIG_VF610_ADC is not set
# CONFIG_VIPERBOARD_ADC is not set
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
CONFIG_PMS7003=m
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SPS30=m
# CONFIG_VZ89X is not set
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORS_COMMONS is not set
CONFIG_IIO_SSP_SENSORHUB=m
# end of SSP Sensor Common

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
CONFIG_AD5421=m
# CONFIG_AD5446 is not set
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
# CONFIG_AD5592R is not set
CONFIG_AD5593R=m
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
CONFIG_LTC1660=m
CONFIG_LTC2632=m
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
CONFIG_AD5696_I2C=m
CONFIG_AD5755=m
CONFIG_AD5758=m
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
CONFIG_AD7303=m
CONFIG_CIO_DAC=m
# CONFIG_AD8801 is not set
CONFIG_DPOT_DAC=m
CONFIG_DS4424=m
CONFIG_M62332=m
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
CONFIG_MCP4922=m
CONFIG_TI_DAC082S085=m
CONFIG_TI_DAC5571=m
CONFIG_TI_DAC7311=m
CONFIG_TI_DAC7612=m
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
# CONFIG_ADIS16260 is not set
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_FXAS21002C_SPI=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
# CONFIG_HTU21 is not set
CONFIG_SI7005=m
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
# CONFIG_ADIS16460 is not set
CONFIG_ADIS16480=m
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM3605=m
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP020A00F=m
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=m
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1133=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=m
CONFIG_TSL2772=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
CONFIG_VEML6070=m
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
CONFIG_SENSORS_RM3100_SPI=m
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
CONFIG_MAX5432=m
CONFIG_MAX5481=m
CONFIG_MAX5487=m
CONFIG_MCP4018=m
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=m
# CONFIG_MCP41010 is not set
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_DPS310 is not set
CONFIG_HP03=m
CONFIG_MPL115=m
# CONFIG_MPL115_I2C is not set
CONFIG_MPL115_SPI=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=m
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_MB1232=m
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9500=m
# CONFIG_SRF08 is not set
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=m
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_MLX90614=m
CONFIG_MLX90632=m
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
CONFIG_MAX31856=m
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=m
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_CADENCE_DP=m
CONFIG_PHY_CADENCE_DPHY=m
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_FSL_IMX8MQ_USB=m
CONFIG_PHY_MIXEL_MIPI_DPHY=m
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=m
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_TUSB1210=m
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_RAVE_SP_EEPROM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=m
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=m
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=m
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_ADGS1408=m
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=m
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=m
CONFIG_FTM_QUADDEC=m
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
# CONFIG_JFFS2_FS_SECURITY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=m
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
# CONFIG_UBIFS_FS_SECURITY is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
# CONFIG_CRAMFS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
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
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_USER=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

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
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=m
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_ECRDSA=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_TGR192=m
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
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
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STRING_SELFTEST=m
# end of Library routines

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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_INSTALL=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Lockups and Hangs

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
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOTIFIER_ERROR_INJECTION=m
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
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
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_STACKINIT=m
CONFIG_TEST_MEMINIT=m
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_NO_ALIGNMENT is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_TEST_UBSAN=m
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--=_5de4684e.5JkgR+lPG87Klc+8H4eHXbIq3kSBnlRrHwK1l11jdj4W3TIN--
