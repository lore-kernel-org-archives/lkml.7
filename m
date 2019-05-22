Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE777C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE4A217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEVEg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 00:36:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:54017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfEVEg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 00:36:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 21:36:52 -0700
X-ExtLoop1: 1
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2019 21:36:47 -0700
Date:   Wed, 22 May 2019 12:37:07 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: [locking/rwsem] a8654596f0:
 BUG:using__this_cpu_add()in_preemptible[#]code:cryptomgr_probe
Message-ID: <20190522043707.GH19312@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: a8654596f0371c2604c4d475422c48f4fc6a56c9 ("locking/rwsem: Enable lock event counting")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: trinity
with following parameters:

	runtime: 300s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+----------------------------------------------------------------+------------+------------+
|                                                                | bf20616f46 | a8654596f0 |
+----------------------------------------------------------------+------------+------------+
| boot_successes                                                 | 161        | 0          |
| boot_failures                                                  | 3          | 126        |
| BUG:kernel_reboot-without-warning_in_test_stage                | 3          |            |
| BUG:using__this_cpu_add()in_preemptible[#]code:swapper         | 0          | 118        |
| BUG:using__this_cpu_add()in_preemptible[#]code:cryptomgr_probe | 0          | 18         |
| BUG:using__this_cpu_add()in_preemptible[#]code:init            | 0          | 19         |
| RIP:__clear_user                                               | 0          | 19         |
| RIP:copy_user_generic_string                                   | 0          | 12         |
| RIP:create_elf_tables                                          | 0          | 2          |
| BUG:using__this_cpu_add()in_preemptible                        | 0          | 1          |
| BUG:using__this_cpu_add()in_preemptible[#]code:udevadm         | 0          | 1          |
| BUG:using__this_cpu_add()in_preemptible[#]code:systemd-journal | 0          | 2          |
| BUG:using__this_cpu_add()in_preemptible[#]code:systemd-udevd   | 0          | 1          |
| BUG:using__this_cpu_add()in_preemptible[#]code:sed             | 0          | 2          |
| BUG:using__this_cpu_add()in_preemptible[#]code:systemd         | 0          | 1          |
| BUG:using__this_cpu_add()in_preemptible[#]code:rs:main_Q:Reg   | 0          | 1          |
| BUG:using__this_cpu_add()in_preemptible[#]code:in:imklog       | 0          | 1          |
| BUG:using__this_cpu_add()in_preemptible[#]code:trinity-main    | 0          | 4          |
| BUG:using__this_cpu_add()in_preemptible[#]code:meminfo         | 0          | 3          |
| RIP:filldir                                                    | 0          | 1          |
| RIP:__put_user_4                                               | 0          | 2          |
+----------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


[   23.899712] BUG: using __this_cpu_add() in preemptible [00000000] code: cryptomgr_probe/248
[   23.901529] caller is rwsem_optimistic_spin+0xf0/0x280
[   23.902657] CPU: 0 PID: 248 Comm: cryptomgr_probe Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   23.904690] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   23.906477] Call Trace:
[   23.907125]  dump_stack+0x71/0xa3
[   23.907931]  __this_cpu_preempt_check+0x110/0x120
[   23.908984]  rwsem_optimistic_spin+0xf0/0x280
[   23.909981]  ? rwsem_spin_on_owner+0x100/0x100
[   23.910986]  ? preempt_count_sub+0x13/0xc0
[   23.911929]  ? schedule+0x64/0xc0
[   23.912726]  rwsem_down_write_failed+0xfd/0x4b0
[   23.913747]  ? rwsem_down_read_failed_killable+0x450/0x450
[   23.914941]  ? _raw_spin_lock_irq+0x80/0xd0
[   23.915896]  ? _raw_spin_lock_bh+0xc0/0xc0
[   23.916834]  ? __might_sleep+0x2f/0xd0
[   23.917712]  ? ___might_sleep+0x81/0x200
[   23.918621]  ? preempt_count_sub+0x13/0xc0
[   23.919561]  ? strncmp+0x65/0xa0
[   23.920343]  ? strncmp+0x65/0xa0
[   23.921130]  ? crc_t10dif_rehash+0x43/0xc0
[   23.922067]  ? __might_sleep+0x2f/0xd0
[   23.922942]  ? down_write+0x5a/0x60
[   23.923775]  down_write+0x5a/0x60
[   23.924577]  crypto_larval_kill+0x13/0xb0
[   23.925502]  crypto_register_instance+0x108/0x130
[   23.926547]  ? crypto_ctr_create+0x140/0x140
[   23.927526]  ? cryptomgr_notify+0x5c0/0x5c0
[   23.928476]  crypto_ctr_create+0x125/0x140
[   23.929412]  ? crypto_rfc3686_free+0x20/0x20
[   23.930392]  cryptomgr_probe+0x38/0x120
[   23.931287]  ? cryptomgr_notify+0x5c0/0x5c0
[   23.932245]  kthread+0x1d6/0x200
[   23.933033]  ? __kthread_create_on_node+0x260/0x260
[   23.934127]  ret_from_fork+0x1f/0x30
[   23.935086] BUG: using __this_cpu_add() in preemptible [00000000] code: cryptomgr_probe/248
[   23.936922] caller is rwsem_down_write_failed+0x2fc/0x4b0
[   23.938109] CPU: 0 PID: 248 Comm: cryptomgr_probe Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   23.940134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   23.941917] Call Trace:
[   23.942559]  dump_stack+0x71/0xa3
[   23.943359]  __this_cpu_preempt_check+0x110/0x120
[   23.944413]  ? rwsem_down_write_failed+0x2ef/0x4b0
[   23.945479]  rwsem_down_write_failed+0x2fc/0x4b0
[   23.946520]  ? rwsem_down_read_failed_killable+0x450/0x450
[   23.947714]  ? _raw_spin_lock_irq+0x80/0xd0
[   23.948661]  ? _raw_spin_lock_bh+0xc0/0xc0
[   23.949604]  ? __might_sleep+0x2f/0xd0
[   23.950483]  ? ___might_sleep+0x81/0x200
[   23.951385]  ? preempt_count_sub+0x13/0xc0
[   23.952321]  ? strncmp+0x65/0xa0
[   23.953106]  ? strncmp+0x65/0xa0
[   23.953890]  ? crc_t10dif_rehash+0x43/0xc0
[   23.954821]  ? __might_sleep+0x2f/0xd0
[   23.955708]  ? down_write+0x5a/0x60
[   23.956537]  down_write+0x5a/0x60
[   23.957335]  crypto_larval_kill+0x13/0xb0
[   23.958266]  crypto_register_instance+0x108/0x130
[   23.959316]  ? crypto_ctr_create+0x140/0x140
[   23.960283]  ? cryptomgr_notify+0x5c0/0x5c0
[   23.961236]  crypto_ctr_create+0x125/0x140
[   23.962180]  ? crypto_rfc3686_free+0x20/0x20
[   23.963156]  cryptomgr_probe+0x38/0x120
[   23.964046]  ? cryptomgr_notify+0x5c0/0x5c0
[   23.964997]  kthread+0x1d6/0x200
[   23.965785]  ? __kthread_create_on_node+0x260/0x260
[   23.966876]  ret_from_fork+0x1f/0x30
[   23.971678] BUG: using __this_cpu_add() in preemptible [00000000] code: cryptomgr_probe/248
[   23.973517] caller is rwsem_down_write_failed+0x415/0x4b0
[   23.974703] CPU: 0 PID: 248 Comm: cryptomgr_probe Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   23.976712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   23.978503] Call Trace:
[   23.979146]  dump_stack+0x71/0xa3
[   23.979953]  __this_cpu_preempt_check+0x110/0x120
[   23.981003]  rwsem_down_write_failed+0x415/0x4b0
[   23.982034]  ? rwsem_down_read_failed_killable+0x450/0x450
[   23.983225]  ? _raw_spin_lock_irq+0x80/0xd0
[   23.984177]  ? _raw_spin_lock_bh+0xc0/0xc0
[   23.985127]  ? __might_sleep+0x2f/0xd0
[   23.986001]  ? ___might_sleep+0x81/0x200
[   23.986905]  ? preempt_count_sub+0x13/0xc0
[   23.987854]  ? strncmp+0x65/0xa0
[   23.988638]  ? strncmp+0x65/0xa0
[   23.989418]  ? crc_t10dif_rehash+0x43/0xc0
[   23.990357]  ? __might_sleep+0x2f/0xd0
[   23.991237]  ? down_write+0x5a/0x60
[   23.992061]  down_write+0x5a/0x60
[   23.992856]  crypto_larval_kill+0x13/0xb0
[   23.993781]  crypto_register_instance+0x108/0x130
[   23.994838]  ? crypto_ctr_create+0x140/0x140
[   23.995807]  ? cryptomgr_notify+0x5c0/0x5c0
[   23.996754]  crypto_ctr_create+0x125/0x140
[   23.997696]  ? crypto_rfc3686_free+0x20/0x20
[   23.998664]  cryptomgr_probe+0x38/0x120
[   23.999555]  ? cryptomgr_notify+0x5c0/0x5c0
[   24.000516]  kthread+0x1d6/0x200
[   24.001301]  ? __kthread_create_on_node+0x260/0x260
[   24.002380]  ret_from_fork+0x1f/0x30
[   24.003675] Key type big_key registered
[   24.007311] PM:   Magic number: 3:423:374
[   24.015767] DHCP/BOOTP: Ignoring device wpan0, MTU 123 too small
[   24.017096] DHCP/BOOTP: Ignoring device wpan1, MTU 123 too small
[   24.020223] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   24.022414] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   24.039706] Sending DHCP requests ., OK
[   24.056671] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
[   24.058194] IP-Config: Complete:
[   24.058986]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
[   24.061044]      host=vm-snb-2G-903, domain=, nis-domain=(none)
[   24.062335]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
[   24.062337]      nameserver0=10.0.2.3
[   24.067529] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   24.070534] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   24.072158] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   24.074058] platform regulatory.0: Falling back to syfs fallback for: regulatory.db
[   24.075816] ALSA device list:
[   24.076581]   #0: Loopback 1
[   24.077304]   #1: MTPAV on parallel port at 0x378
[   24.080586] Freeing unused kernel image memory: 2484K
[   24.095750] Write protecting the kernel read-only data: 59392k
[   24.098779] Freeing unused kernel image memory: 2040K
[   24.100318] Freeing unused kernel image memory: 652K
[   24.206562] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   24.208053] rodata_test: all tests were successful
[   24.209315] Run /init as init process
[   24.210864] BUG: using __this_cpu_add() in preemptible [00000000] code: init/1
[   24.212520] caller is down_read_trylock+0x62/0xf0
[   24.213614] CPU: 1 PID: 1 Comm: init Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   24.215484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   24.217309] Call Trace:
[   24.217968]  dump_stack+0x71/0xa3
[   24.218780]  __this_cpu_preempt_check+0x110/0x120
[   24.219852]  down_read_trylock+0x62/0xf0
[   24.220775]  ? up+0x70/0x70
[   24.221483]  ? up_write+0x22/0x40
[   24.222293]  __do_page_fault+0x182/0x630
[   24.223217]  async_page_fault+0x1e/0x30
[   24.224127] RIP: 0010:__clear_user+0x31/0x60
[   24.225110] Code: f3 be 13 00 00 00 48 c7 c7 00 06 ee a1 e8 a7 2e 03 fe 66 66 90 48 89 d8 48 c1 eb 03 48 89 ef 83 e0 07 48 89 d9 48 85 c9 74 0f <48> c7 07 00 00 00 00 48 83 c7 08 ff c9 75 f1 48 89 c1 85 c9 74 0a
[   24.228928] RSP: 0000:ffff888067c17c98 EFLAGS: 00010202
[   24.230090] RAX: 0000000000000004 RBX: 00000000000001da RCX: 00000000000001da
[   24.231603] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: 000055b9fa2bd12c
[   24.233113] RBP: 000055b9fa2bd12c R08: 000055b9fa293000 R09: ffffed100b684239
[   24.234618] R10: ffff88805b4211c7 R11: ffffed100b684239 R12: ffff88804f35f918
[   24.236140] R13: ffff88804f35f900 R14: ffff888052901a00 R15: ffff888067c10000
[   24.237652]  ? __clear_user+0x19/0x60
[   24.238524]  load_elf_binary+0x1157/0x1a80
[   24.239482]  ? elf_core_dump+0xe60/0xe60
[   24.240406]  search_binary_handler+0x76/0x140
[   24.241406]  __do_execve_file+0xc13/0xe30
[   24.242340]  ? search_binary_handler+0x140/0x140
[   24.243390]  ? memcpy+0x34/0x50
[   24.244171]  ? getname_kernel+0x105/0x1a0
[   24.245103]  ? rest_init+0xd0/0xd0
[   24.245934]  kernel_init+0x55/0x120
[   24.246778]  ? _raw_spin_unlock_irq+0x20/0x40
[   24.247778]  ? rest_init+0xd0/0xd0
[   24.248597]  ret_from_fork+0x1f/0x30
[   24.252055] BUG: using __this_cpu_add() in preemptible [00000000] code: init/1
[   24.253670] caller is down_read_trylock+0x62/0xf0
[   24.254736] CPU: 0 PID: 1 Comm: init Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   24.256541] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   24.258303] Call Trace:
[   24.258946]  dump_stack+0x71/0xa3
[   24.259746]  __this_cpu_preempt_check+0x110/0x120
[   24.260792]  down_read_trylock+0x62/0xf0
[   24.261698]  ? up+0x70/0x70
[   24.262393]  ? up_write+0x22/0x40
[   24.263191]  __do_page_fault+0x182/0x630
[   24.264097]  async_page_fault+0x1e/0x30
[   24.264994] RIP: 0010:__clear_user+0x31/0x60
[   24.265962] Code: f3 be 13 00 00 00 48 c7 c7 00 06 ee a1 e8 a7 2e 03 fe 66 66 90 48 89 d8 48 c1 eb 03 48 89 ef 83 e0 07 48 89 d9 48 85 c9 74 0f <48> c7 07 00 00 00 00 48 83 c7 08 ff c9 75 f1 48 89 c1 85 c9 74 0a
[   24.269714] RSP: 0000:ffff888067c17c98 EFLAGS: 00010202
[   24.270852] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
[   24.272326] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: 00007f3d7c08ffc0
[   24.273806] RBP: 00007f3d7c08ffc0 R08: 00007f3d7c08e000 R09: ffffed100b684239
[   24.275284] R10: ffff88805b4211c7 R11: ffffed100b684239 R12: 0000000000000000
[   24.276776] R13: ffff88804f35f900 R14: ffff888052901a00 R15: ffff888067c10000
[   24.278259]  ? __clear_user+0x19/0x60
[   24.279116]  load_elf_binary+0x112b/0x1a80
[   24.280060]  ? elf_core_dump+0xe60/0xe60
[   24.280966]  search_binary_handler+0x76/0x140
[   24.281943]  __do_execve_file+0xc13/0xe30
[   24.282867]  ? search_binary_handler+0x140/0x140
[   24.283896]  ? memcpy+0x34/0x50
[   24.284656]  ? getname_kernel+0x105/0x1a0
[   24.285570]  ? rest_init+0xd0/0xd0
[   24.286384]  kernel_init+0x55/0x120
[   24.287214]  ? _raw_spin_unlock_irq+0x20/0x40
[   24.288198]  ? rest_init+0xd0/0xd0
[   24.289013]  ret_from_fork+0x1f/0x30
[   24.289999] BUG: using __this_cpu_add() in preemptible [00000000] code: init/1
[   24.291591] caller is down_read_trylock+0x62/0xf0
[   24.292667] CPU: 0 PID: 1 Comm: init Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   24.294477] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   24.296267] Call Trace:
[   24.296914]  dump_stack+0x71/0xa3
[   24.297714]  __this_cpu_preempt_check+0x110/0x120
[   24.298764]  down_read_trylock+0x62/0xf0
[   24.299673]  ? up+0x70/0x70
[   24.300371]  ? kfree+0x7b/0xb0
[   24.301126]  ? load_elf_binary+0x156e/0x1a80
[   24.302096]  ? search_binary_handler+0x76/0x140
[   24.303115]  __do_page_fault+0x182/0x630
[   24.304021]  async_page_fault+0x1e/0x30
[   24.304922] RIP: 0010:copy_user_generic_string+0x31/0x40
[   24.306086] Code: 27 89 f9 83 e1 07 74 15 83 e9 08 f7 d9 29 ca 8a 06 88 07 48 ff c6 48 ff c7 ff c9 75 f2 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 <f3> a4 31 c0 66 66 90 c3 0f 1f 80 00 00 00 00 66 66 90 83 fa 40 0f
[   24.309824] RSP: 0000:ffff888067c17bc8 EFLAGS: 00010297
[   24.310962] RAX: 0000000000000007 RBX: 00007ffeebd505a0 RCX: 0000000000000007
[   24.312446] RDX: 0000000000000007 RSI: ffffffffa10b27a0 RDI: 00007ffeebd50599
[   24.313932] RBP: ffff888052901a00 R08: 1ffffffff42164f4 R09: fffffbfff42164f4
[   24.315417] R10: 0000000000000006 R11: fffffbfff42164f5 R12: ffff88804e4df100
[   24.316906] R13: ffff88804f35f900 R14: ffff888052901a00 R15: ffff888067c10000
[   24.318398]  create_elf_tables+0x123/0x9bb
[   24.319340]  ? insert_vm_struct+0xd6/0x160
[   24.320278]  ? set_brk+0xa5/0xa5
[   24.321056]  ? up_write+0x22/0x40
[   24.321857]  ? map_vdso+0xe0/0x120
[   24.322666]  load_elf_binary+0x15ae/0x1a80
[   24.323605]  ? elf_core_dump+0xe60/0xe60
[   24.324516]  search_binary_handler+0x76/0x140
[   24.325496]  __do_execve_file+0xc13/0xe30
[   24.326419]  ? search_binary_handler+0x140/0x140
[   24.327457]  ? memcpy+0x34/0x50
[   24.328225]  ? getname_kernel+0x105/0x1a0
[   24.329150]  ? rest_init+0xd0/0xd0
[   24.329962]  kernel_init+0x55/0x120
[   24.330798]  ? _raw_spin_unlock_irq+0x20/0x40
[   24.331789]  ? rest_init+0xd0/0xd0
[   24.332597]  ret_from_fork+0x1f/0x30
[   24.335722] BUG: using __this_cpu_add() in preemptible [00000000] code: init/1
[   24.337322] caller is down_read_trylock+0x62/0xf0
[   24.338374] CPU: 0 PID: 1 Comm: init Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   24.340187] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   24.341963] Call Trace:
[   24.342602]  dump_stack+0x71/0xa3
[   24.343396]  __this_cpu_preempt_check+0x110/0x120
[   24.344440]  down_read_trylock+0x62/0xf0
[   24.345350]  ? up+0x70/0x70
[   24.346060]  __do_page_fault+0x182/0x630
[   24.346967]  ? async_page_fault+0x8/0x30
[   24.347877]  ? async_page_fault+0x8/0x30
[   24.348786]  async_page_fault+0x1e/0x30
[   24.349671] RIP: 0033:0x7f3d7be6bc20
[   24.350518] Code: Bad RIP value.
[   24.351307] RSP: 002b:00007ffeebd503b0 EFLAGS: 00010202
[   24.352449] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   24.353943] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   24.355419] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   24.356897] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   24.358385] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   24.359942] BUG: using __this_cpu_add() in preemptible [00000000] code: init/1
[   24.361543] caller is down_read_trylock+0x62/0xf0
[   24.362590] CPU: 0 PID: 1 Comm: init Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   24.364397] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   24.366180] Call Trace:
[   24.366823]  dump_stack+0x71/0xa3
[   24.367618]  __this_cpu_preempt_check+0x110/0x120
[   24.368662]  down_read_trylock+0x62/0xf0
[   24.369555]  ? up+0x70/0x70
[   24.370261]  __do_page_fault+0x182/0x630
[   24.371173]  ? async_page_fault+0x8/0x30
[   24.372078]  ? async_page_fault+0x8/0x30
[   24.372982]  async_page_fault+0x1e/0x30
[   24.373873] RIP: 0033:0x7f3d7be6c87f
[   24.374718] Code: 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 48 83 ec 48 0f 31 48 c1 e2 20 89 c0 48 09 c2 <48> 8b 05 fa 25 22 00 48 89 15 d3 23 22 00 48 8d 15 ec 25 22 00 49
[   24.380083] RSP: 002b:00007ffeebd50330 EFLAGS: 00010202
[   24.381227] RAX: 00000000dec2e854 RBX: 0000000000000000 RCX: 0000000000000000
[   24.382709] RDX: 00000012dec2e854 RSI: 0000000000000000 RDI: 00007ffeebd503b0
[   24.384186] RBP: 00007ffeebd503a0 R08: 0000000000000000 R09: 0000000000000000
[   24.385666] R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffeebd503b0
[   24.387143] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   24.388711] BUG: using __this_cpu_add() in preemptible [00000000] code: init/1
[   24.390305] caller is down_read_trylock+0x62/0xf0
[   24.391366] CPU: 0 PID: 1 Comm: init Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   24.393163] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   24.394952] Call Trace:
[   24.395589]  dump_stack+0x71/0xa3
[   24.396394]  __this_cpu_preempt_check+0x110/0x120
[   24.397449]  down_read_trylock+0x62/0xf0
[   24.398355]  ? up+0x70/0x70
[   24.399059]  __do_page_fault+0x182/0x630
[   24.399975]  ? async_page_fault+0x8/0x30
[   24.400888]  ? async_page_fault+0x8/0x30
[   24.401794]  async_page_fault+0x1e/0x30
[   24.402690] RIP: 0033:0x7f3d7be6c886
[   24.403530] Code: 00 00 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 48 83 ec 48 0f 31 48 c1 e2 20 89 c0 48 09 c2 48 8b 05 fa 25 22 00 <48> 89 15 d3 23 22 00 48 8d 15 ec 25 22 00 49 89 d6 4c 2b 35 62 27
[   24.407262] RSP: 002b:00007ffeebd50330 EFLAGS: 00010202
[   24.408400] RAX: 000000000000000e RBX: 0000000000000000 RCX: 0000000000000000
[   24.409887] RDX: 00000012dec2e854 RSI: 0000000000000000 RDI: 00007ffeebd503b0
[   24.411367] RBP: 00007ffeebd503a0 R08: 0000000000000000 R09: 0000000000000000
[   24.412856] R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffeebd503b0
[   24.414344] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   24.415877] BUG: using __this_cpu_add() in preemptible [00000000] code: init/1
[   24.417465] caller is down_read_trylock+0x62/0xf0
[   24.418531] CPU: 0 PID: 1 Comm: init Tainted: G                T 5.1.0-rc4-00069-ga865459 #1
[   24.420354] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   24.422129] Call Trace:
[   24.422776]  dump_stack+0x71/0xa3
[   24.423569]  __this_cpu_preempt_check+0x110/0x120
[   24.424616]  down_read_trylock+0x62/0xf0
[   24.425524]  ? up+0x70/0x70
[   24.426229]  __do_page_fault+0x182/0x630
[   24.427136]  ? async_page_fault+0x8/0x30
[   24.428051]  ? async_page_fault+0x8/0x30
[   24.428960]  async_page_fault+0x1e/0x30
[   24.429850] RIP: 0033:0x7f3d7be6cc60
[   24.430693] Code: c6 00 00 00 41 0f b6 57 04 49 8b 47 08 48 03 05 8e 2d 22 00 83 e2 0f 80 fa 0a 0f 84 ba 00 00 00 48 83 eb 06 48 83 fb 1e 77 48 <49> 63 14 98 4c 01 c2 ff e2 0f 1f 80 00 00 00 00 48 89 d9 48 29 c1
[   24.434439] RSP: 002b:00007ffeebd50330 EFLAGS: 00010297
[   24.435573] RAX: 00007f3d7c090140 RBX: 0000000000000000 RCX: 00007f3d7c08eff0
[   24.437060] RDX: 0000000000000001 RSI: 00007f3d7be6ba38 RDI: 00007f3d7be6b390
[   24.438540] RBP: 00007ffeebd503a0 R08: 00007f3d7be87080 R09: 00007f3d7be82010
[   24.440022] R10: 0000000000000031 R11: 000000006ffffdff R12: 00007ffeebd503b0
[   24.441502] R13: 00007f3d7be6b9a8 R14: 00007f3d7be6b000 R15: 00007f3d7be6b468
[   24.455099] systemd[1]: RTC configured in localtime, applying delta of 480 minutes to system time.
[   24.462673] random: systemd: uninitialized urandom read (16 bytes read)
[   24.465906] random: systemd: uninitialized urandom read (16 bytes read)


[   24.493245] random: systemd-cryptse: uninitialized urandom read (16 bytes read)
         Mounting Debug File System...
         Starting Load Kernel Modules...
         Mounting RPC Pipe File System...
         Starting Create Static Device Nodes in /dev...
         Starting Remount Root and Kernel File Systems...
         Starting Journal Service...
         Mounting Configuration File System...
         Starting Apply Kernel Variables...
         Mounting FUSE Control File System...
[   24.638397] random: fast init done
See 'systemctl status run-rpc_pipefs.mount' for details.
         Starting udev Coldplug all Devices...
         Starting Load/Save Random Seed...
         Starting udev Kernel Device Manager...
         Starting Raise network interfaces...
         Starting Preprocess NFS configuration...
         Starting Flush Journal to Persistent Storage...
         Starting Create Volatile Files and Directories...
         Starting RPC bind portmap service...
         Starting Network Time Synchronization...
         Starting Update UTMP about System Boot/Shutdown...
         Starting LSB: Execute the kexec -e command to reboot system...
         Starting OpenBSD Secure Shell server...
         Starting /etc/rc.local Compatibility...
         Starting System Logging Service...
         Starting Login Service...
[   25.879824] rc.local[348]: PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/lkp/lkp/src/bin
         Starting LSB: Start and stop bmc-watchdog...
         Starting LKP bootstrap...
         Starting Permit User Sessions...
         Starting LSB: Load kernel image with kexec...
LKP: HOSTNAME vm-snb-2G-903, MAC 52:54:00:12:34:56, kernel 5.1.0-rc4-00069-ga865459 1, serial console /dev/ttyS0
[   26.475825] cfg80211: failed to load regulatory.db

Elapsed time: 30

qemu-img create -f qcow2 disk-vm-snb-2G-903-0 256G
qemu-img create -f qcow2 disk-vm-snb-2G-903-1 256G
qemu-img create -f qcow2 disk-vm-snb-2G-903-2 256G
qemu-img create -f qcow2 disk-vm-snb-2G-903-3 256G
qemu-img create -f qcow2 disk-vm-snb-2G-903-4 256G
qemu-img create -f qcow2 disk-vm-snb-2G-903-5 256G
qemu-img create -f qcow2 disk-vm-snb-2G-903-6 256G

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu SandyBridge
	-kernel $kernel
	-initrd initrd-vm-snb-2G-903
	-m 2048
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::24010-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-drive file=disk-vm-snb-2G-903-0,media=disk,if=virtio
	-drive file=disk-vm-snb-2G-903-1,media=disk,if=virtio
	-drive file=disk-vm-snb-2G-903-2,media=disk,if=virtio
	-drive file=disk-vm-snb-2G-903-3,media=disk,if=virtio
	-drive file=disk-vm-snb-2G-903-4,media=disk,if=virtio
	-drive file=disk-vm-snb-2G-903-5,media=disk,if=virtio
	-drive file=disk-vm-snb-2G-903-6,media=disk,if=virtio
	-serial stdio
	-display none
	-monitor null
)

append=(
	ip=::::vm-snb-2G-903::dhcp
	root=/dev/ram0


To reproduce:

        # build kernel
	cd linux
	cp config-5.1.0-rc4-00069-ga865459 .config
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
lkp


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.1.0-rc4-00069-ga865459"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.1.0-rc4 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
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
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

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
CONFIG_GENERIC_IRQ_DEBUGFS=y
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
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
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
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_UV is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
# CONFIG_XEN_PVHVM is not set
# CONFIG_XEN_512GB is not set
CONFIG_XEN_SAVE_RESTORE=y
CONFIG_XEN_DEBUG_FS=y
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_CALGARY_IOMMU=y
CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
# CONFIG_X86_64_ACPI_NUMA is not set
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_VERIFY_SIG is not set
# CONFIG_CRASH_DUMP is not set
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
# CONFIG_RANDOMIZE_MEMORY is not set
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=y
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_PMIC_OPREGION=y
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_CHT_WC_PMIC_OPREGION=y
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
# CONFIG_CPU_FREQ_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_XEN=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_SMI=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
CONFIG_GOOGLE_VPD=y

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
CONFIG_EFI_TEST=y
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=y
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
CONFIG_STACKLEAK_RUNTIME_DISABLE=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
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
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZSWAP is not set
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
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
# CONFIG_IPV6_ILA is not set
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
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_COMMON=y
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_LABELS is not set
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_IRC=y
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CT_NETLINK=y
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=y
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_IRC=y
CONFIG_NF_NAT_SIP=y
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_LOG=y
CONFIG_NETFILTER_XT_NAT=y
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_RAW is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_REJECT=y
CONFIG_IP6_NF_MANGLE=y
# CONFIG_IP6_NF_RAW is not set
CONFIG_NF_DEFRAG_IPV6=y
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
# CONFIG_IPDDP is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
# CONFIG_VMWARE_VMCI_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_HYPERV_VSOCKETS=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=y
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
CONFIG_6PACK=y
# CONFIG_BPQETHER is not set
# CONFIG_BAYCOM_SER_FDX is not set
# CONFIG_BAYCOM_SER_HDX is not set
CONFIG_YAM=y
CONFIG_CAN=y
CONFIG_CAN_RAW=y
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
CONFIG_CAN_SLCAN=y
CONFIG_CAN_DEV=y
# CONFIG_CAN_CALC_BITTIMING is not set
# CONFIG_CAN_FLEXCAN is not set
CONFIG_CAN_GRCAN=y
CONFIG_CAN_C_CAN=y
# CONFIG_CAN_C_CAN_PLATFORM is not set
CONFIG_CAN_C_CAN_PCI=y
CONFIG_CAN_CC770=y
# CONFIG_CAN_CC770_ISA is not set
# CONFIG_CAN_CC770_PLATFORM is not set
CONFIG_CAN_IFI_CANFD=y
# CONFIG_CAN_M_CAN is not set
CONFIG_CAN_PEAK_PCIEFD=y
CONFIG_CAN_SJA1000=y
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=y
# CONFIG_CAN_EMS_PCI is not set
CONFIG_CAN_PEAK_PCI=y
CONFIG_CAN_PEAK_PCIEC=y
# CONFIG_CAN_KVASER_PCI is not set
CONFIG_CAN_PLX_PCI=y
CONFIG_CAN_SOFTING=y

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
CONFIG_CAN_EMS_USB=y
CONFIG_CAN_ESD_USB2=y
CONFIG_CAN_GS_USB=y
CONFIG_CAN_KVASER_USB=y
CONFIG_CAN_MCBA_USB=y
CONFIG_CAN_PEAK_USB=y
CONFIG_CAN_UCAN=y
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_BCM=y
CONFIG_BT_RTL=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_RTL=y
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
CONFIG_BT_HCIBPA10X=y
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=y
# CONFIG_BT_MRVL is not set
CONFIG_BT_ATH3K=y
# CONFIG_BT_WILINK is not set
CONFIG_BT_HCIRSI=y
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=y
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
CONFIG_MAC80211_DEBUG_MENU=y
CONFIG_MAC80211_NOINLINE=y
# CONFIG_MAC80211_VERBOSE_DEBUG is not set
# CONFIG_MAC80211_MLME_DEBUG is not set
# CONFIG_MAC80211_STA_DEBUG is not set
CONFIG_MAC80211_HT_DEBUG=y
CONFIG_MAC80211_OCB_DEBUG=y
# CONFIG_MAC80211_IBSS_DEBUG is not set
# CONFIG_MAC80211_PS_DEBUG is not set
# CONFIG_MAC80211_TDLS_DEBUG is not set
CONFIG_MAC80211_DEBUG_COUNTERS=y
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_XEN=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
# CONFIG_NFC_NCI is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_SIM is not set
CONFIG_NFC_PORT100=y
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_USB=y
CONFIG_NFC_PN533_I2C=y
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=y
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
CONFIG_PCI_STUB=y
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
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
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
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
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
# CONFIG_RAPIDIO_CPS_XX is not set
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
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_FD=y
CONFIG_CDROM=y
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_UMEM=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_SKD=y
CONFIG_BLK_DEV_SX8=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=y
CONFIG_XEN_BLKDEV_FRONTEND=y
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_VMWARE_BALLOON is not set
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# CONFIG_SENSORS_LIS3_I2C is not set
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
CONFIG_INTEL_MIC_BUS=y

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=y

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
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
CONFIG_MISC_ALCOR_PCI=y
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HABANA_AI=y
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_DELKIN=y
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
CONFIG_BLK_DEV_IT8172=y
CONFIG_BLK_DEV_IT8213=y
CONFIG_BLK_DEV_IT821X=y
CONFIG_BLK_DEV_NS87415=y
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_TC86C001=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
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
CONFIG_SCSI_BNX2_ISCSI=y
CONFIG_SCSI_BNX2X_FCOE=y
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=y
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC94XX=y
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=y
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=y
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_XEN_SCSI_FRONTEND=y
# CONFIG_HYPERV_STORAGE is not set
CONFIG_LIBFC=y
CONFIG_LIBFCOE=y
# CONFIG_FCOE is not set
CONFIG_FCOE_FNIC=y
CONFIG_SCSI_SNIC=y
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_GDTH=y
# CONFIG_SCSI_ISCI is not set
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=y
CONFIG_SCSI_IPR_TRACE=y
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_1280=y
CONFIG_SCSI_QLA_FC=y
CONFIG_TCM_QLA2XXX=y
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=y
# CONFIG_SCSI_LPFC is not set
CONFIG_SCSI_DC395x=y
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
CONFIG_SCSI_PMCRAID=y
CONFIG_SCSI_PM8001=y
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_ATA=y
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_ATA_ACPI is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=y
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
CONFIG_TCM_USER2=y
CONFIG_LOOPBACK_TARGET=y
CONFIG_TCM_FC=y
CONFIG_ISCSI_TARGET=y
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=y
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
CONFIG_SUNGEM_PHY=y
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
# CONFIG_ARCNET_1051 is not set
CONFIG_ARCNET_RAW=y
CONFIG_ARCNET_CAP=y
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=y
# CONFIG_ARCNET_RIM_I is not set
CONFIG_ARCNET_COM20020=y
# CONFIG_ARCNET_COM20020_PCI is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=y
CONFIG_CAIF_SPI_SLAVE=y
CONFIG_CAIF_SPI_SYNC=y
CONFIG_CAIF_HSI=y
CONFIG_CAIF_VIRTIO=y

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_TYPHOON=y
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=y
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=y
# CONFIG_NET_VENDOR_ALTEON is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
CONFIG_BCMGENET=y
CONFIG_BNX2=y
CONFIG_CNIC=y
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=y
CONFIG_SYSTEMPORT=y
CONFIG_BNXT=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
# CONFIG_BNXT_DCB is not set
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=y
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_GEMINI_ETHERNET=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
# CONFIG_NET_VENDOR_DEC is not set
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=y
CONFIG_SUNDANCE=y
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_HP=y
CONFIG_HP100=y
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
CONFIG_MVMDIO=y
CONFIG_SKGE=y
CONFIG_SKGE_DEBUG=y
# CONFIG_SKGE_GENESIS is not set
CONFIG_SKY2=y
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
CONFIG_VXGE=y
CONFIG_VXGE_DEBUG_TRACE_ALL=y
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_8390=y
CONFIG_NE2K_PCI=y
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=y
# CONFIG_NET_VENDOR_QLOGIC is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
CONFIG_RMNET=y
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=y
CONFIG_SUNGEM=y
# CONFIG_CASSINI is not set
CONFIG_NIU=y
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
CONFIG_DWC_XLGMAC_PCI=y
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
CONFIG_VIA_VELOCITY=y
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_GPIO=y
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_MSCC_MIIM=y
CONFIG_MDIO_OCTEON=y
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_AQUANTIA_PHY is not set
CONFIG_ASIX_PHY=y
# CONFIG_AT803X_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
# CONFIG_DAVICOM_PHY is not set
CONFIG_DP83822_PHY=y
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
CONFIG_DP83867_PHY=y
CONFIG_FIXED_PHY=y
# CONFIG_ICPLUS_PHY is not set
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=y
CONFIG_NATIONAL_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PPP is not set
CONFIG_SLIP=y
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
# CONFIG_USB_PEGASUS is not set
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=y
CONFIG_USB_LAN78XX=y
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
CONFIG_USB_NET_SR9700=y
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
# CONFIG_USB_NET_GL620A is not set
CONFIG_USB_NET_NET1080=y
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=y
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
CONFIG_USB_NET_CX82310_ETH=y
# CONFIG_USB_NET_KALMIA is not set
CONFIG_USB_NET_QMI_WWAN=y
CONFIG_USB_HSO=y
# CONFIG_USB_NET_INT51X1 is not set
CONFIG_USB_IPHETH=y
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_VL600 is not set
CONFIG_USB_NET_CH9200=y
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_ADM8211=y
# CONFIG_WLAN_VENDOR_ATH is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_ATMEL=y
# CONFIG_PCI_ATMEL is not set
CONFIG_AT76C50X_USB=y
# CONFIG_WLAN_VENDOR_BROADCOM is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
CONFIG_LIBERTAS_THINFIRM=y
CONFIG_LIBERTAS_THINFIRM_DEBUG=y
# CONFIG_LIBERTAS_THINFIRM_USB is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=y
CONFIG_MT76_CORE=y
CONFIG_MT76_LEDS=y
CONFIG_MT76_USB=y
CONFIG_MT76x02_LIB=y
CONFIG_MT76x02_USB=y
CONFIG_MT76x0_COMMON=y
CONFIG_MT76x0U=y
CONFIG_MT76x0E=y
CONFIG_MT76x2_COMMON=y
CONFIG_MT76x2E=y
# CONFIG_MT76x2U is not set
CONFIG_MT7603E=y
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_RTL8180=y
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
CONFIG_RTL8XXXU=y
# CONFIG_RTL8XXXU_UNTESTED is not set
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_RSI_91X=y
# CONFIG_RSI_DEBUGFS is not set
CONFIG_RSI_USB=y
CONFIG_RSI_COEX=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_CW1200=y
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
CONFIG_WL12XX=y
CONFIG_WL18XX=y
CONFIG_WLCORE=y
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
CONFIG_QTNFMAC=y
CONFIG_QTNFMAC_PCIE=y
# CONFIG_MAC80211_HWSIM is not set
CONFIG_USB_NET_RNDIS_WLAN=y
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
# CONFIG_IEEE802154_FAKELB is not set
CONFIG_IEEE802154_ATUSB=y
CONFIG_IEEE802154_HWSIM=y
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_THUNDERBOLT_NET is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=y
# CONFIG_ISDN_PPP is not set
# CONFIG_ISDN_AUDIO is not set
# CONFIG_ISDN_X25 is not set

#
# ISDN feature submodules
#
# CONFIG_ISDN_DIVERSION is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=y

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_NO_SENDCOMPLETE=y
CONFIG_HISAX_NO_LLC=y
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
# CONFIG_HISAX_16_3 is not set
# CONFIG_HISAX_TELESPCI is not set
CONFIG_HISAX_S0BOX=y
# CONFIG_HISAX_FRITZPCI is not set
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
# CONFIG_HISAX_GAZEL is not set
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=y
# CONFIG_HISAX_HFCUSB is not set
CONFIG_HISAX_HFC4S8S=y
# CONFIG_HISAX_FRITZ_PCIPNP is not set
CONFIG_ISDN_CAPI=y
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=y
CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE=y

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
# CONFIG_ISDN_DRV_AVMB1_B1PCI is not set
CONFIG_ISDN_DRV_AVMB1_T1PCI=y
CONFIG_ISDN_DRV_AVMB1_C4=y
CONFIG_ISDN_DRV_GIGASET=y
CONFIG_GIGASET_CAPI=y
# CONFIG_GIGASET_BASE is not set
CONFIG_GIGASET_M105=y
# CONFIG_GIGASET_M101 is not set
# CONFIG_GIGASET_DEBUG is not set
# CONFIG_MISDN is not set
CONFIG_ISDN_HDLC=y
CONFIG_NVM=y
CONFIG_NVM_PBLK=y
# CONFIG_NVM_PBLK_DEBUG is not set

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
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=y
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_SAMSUNG=y
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CROS_EC=y
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
CONFIG_KEYBOARD_MTK_PMIC=y
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_88PM860X=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_UCB1400=y
CONFIG_TOUCHSCREEN_PIXCIR=y
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=y
# CONFIG_TOUCHSCREEN_WM97XX is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=y
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_HYPERV_KEYBOARD is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=y
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_LDISC_AUTOLOAD=y
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_MOXA=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_HVC_XEN is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_APPLICOM=y
CONFIG_MWAVE=y
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
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
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_CHT_WC=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=y
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
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
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=y
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=y
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_RK805=y
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
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
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_ICH=y
CONFIG_GPIO_LYNXPOINT=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_AMD_FCH=y

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=y
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TPS68470=y
CONFIG_GPIO_TQMX86=y
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_UCB1400=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP288_CHARGER=y
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CPU_THERMAL=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_MAX77620_THERMAL is not set
CONFIG_QORIQ_THERMAL=y
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
# CONFIG_INT3406_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_WDAT_WDT=y
CONFIG_WM831X_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_MLX_WDT=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_STPMIC1_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=y
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=y
CONFIG_NI903X_WDT=y
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set
# CONFIG_XEN_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_CHARDEV=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_BXTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
CONFIG_UCB1400_CORE=y
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TPS68470=y
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_STPMIC1=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD718XX is not set
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_RK808=y
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_SKY81452 is not set
# CONFIG_REGULATOR_STPMIC1 is not set
# CONFIG_REGULATOR_SY8106A is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
CONFIG_IR_XMP_DECODER=y
CONFIG_IR_IMON_DECODER=y
CONFIG_IR_RCMM_DECODER=y
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=y
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=y
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
CONFIG_IR_MCEUSB=y
# CONFIG_IR_ITE_CIR is not set
CONFIG_IR_FINTEK=y
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_REDRAT3=y
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=y
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=y
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=y
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=y
CONFIG_RC_XBOX_DVD=y
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
# CONFIG_DRM is not set
CONFIG_DRM_DP_CEC=y

#
# ARM devices
#

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
CONFIG_DRM_XEN=y

#
# Frame buffer Devices
#
# CONFIG_FB is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_PCM_XRUN_DEBUG=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=y
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=y
CONFIG_SND_USB_UA101=y
CONFIG_SND_USB_USX2Y=y
CONFIG_SND_USB_CAIAQ=y
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=y
CONFIG_SND_USB_6FIRE=y
CONFIG_SND_USB_HIFACE=y
CONFIG_SND_BCD2000=y
CONFIG_SND_USB_LINE6=y
CONFIG_SND_USB_POD=y
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
CONFIG_SND_USB_VARIAX=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=y
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=y
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
CONFIG_SND_SOC_FSL_SSI=y
# CONFIG_SND_SOC_FSL_SPDIF is not set
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_I2S_HI6210_I2S=y
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_PCI=y
CONFIG_SND_SST_IPC_ACPI=y
CONFIG_SND_SOC_INTEL_SST=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
CONFIG_SND_SOC_INTEL_SKYLAKE=y
CONFIG_SND_SOC_INTEL_SKL=y
CONFIG_SND_SOC_INTEL_APL=y
CONFIG_SND_SOC_INTEL_KBL=y
CONFIG_SND_SOC_INTEL_GLK=y
CONFIG_SND_SOC_INTEL_CNL=y
CONFIG_SND_SOC_INTEL_CFL=y
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=y
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=y
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_SKL_RT286_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=y
# CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH is not set
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=y
# CONFIG_SND_SOC_INTEL_BXT_RT298_MACH is not set
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=y
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=y
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=y
# CONFIG_SND_SOC_MTK_BTCVSD is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XILINX_I2S=y
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_AK4118=y
CONFIG_SND_SOC_AK4458=y
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CROS_EC_CODEC=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS35L36=y
CONFIG_SND_SOC_CS42L42=y
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_HDAC_HDMI=y
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
CONFIG_SND_SOC_RK3328=y
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_RT5663=y
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS5086=y
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_TSCS42XX=y
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
CONFIG_SND_SOC_WM8753=y
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_ZX_AUD96P22=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_NAU8825=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_X86 is not set
CONFIG_SND_XEN_FRONTEND=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACCUTOUCH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_HYPERV_MOUSE=y
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WACOM=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
CONFIG_USB_OTG_WHITELIST=y
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_OTG_FSM=y
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=y
# CONFIG_REALTEK_AUTOPM is not set
CONFIG_USB_STORAGE_DATAFAB=y
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
# CONFIG_USB_STORAGE_SDDR09 is not set
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=y
CONFIG_USB_SERIAL_EDGEPORT=y
CONFIG_USB_SERIAL_EDGEPORT_TI=y
CONFIG_USB_SERIAL_F81232=y
CONFIG_USB_SERIAL_F8153X=y
# CONFIG_USB_SERIAL_GARMIN is not set
CONFIG_USB_SERIAL_IPW=y
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
# CONFIG_USB_SERIAL_KEYSPAN is not set
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=y
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=y
# CONFIG_USB_SERIAL_SPCP8X5 is not set
CONFIG_USB_SERIAL_SAFE=y
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
CONFIG_USB_SERIAL_OMNINET=y
CONFIG_USB_SERIAL_OPTICON=y
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=y
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=y
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_RIO500=y
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_ATM=y
# CONFIG_USB_SPEEDTOUCH is not set
CONFIG_USB_CXACRU=y
CONFIG_USB_UEAGLEATM=y
CONFIG_USB_XUSBATM=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_USB_ISP1301=y
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=y
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=y
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y

#
# Platform Support
#
# CONFIG_USB_NET2272 is not set
CONFIG_USB_GADGET_XILINX=y
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_NCM=y
CONFIG_USB_F_RNDIS=y
CONFIG_USB_F_UAC1=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_SERIAL=y
# CONFIG_USB_CONFIGFS_ACM is not set
CONFIG_USB_CONFIGFS_OBEX=y
CONFIG_USB_CONFIGFS_NCM=y
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
CONFIG_USB_CONFIGFS_RNDIS=y
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_UAC1=y
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
# CONFIG_USB_CONFIGFS_F_UAC2 is not set
# CONFIG_USB_CONFIGFS_F_MIDI is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
# CONFIG_USB_CONFIGFS_F_TCM is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_CCG=y
CONFIG_UCSI_ACPI=y
CONFIG_TYPEC_TPS6598X=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
CONFIG_USB_LED_TRIG=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_DA903X=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_UDMABUF=y
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TSCPAGE=y
# CONFIG_HYPERV_UTILS is not set
CONFIG_HYPERV_BALLOON=y

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
# CONFIG_XEN_DEV_EVTCHN is not set
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=y
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=y
# CONFIG_XEN_GNTDEV_DMABUF is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
CONFIG_XEN_GRANT_DMA_ALLOC=y
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_ACPI_PROCESSOR=y
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_SYMS is not set
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=y
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
# CONFIG_COMEDI_USB_DRIVERS is not set
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
# CONFIG_R8712U is not set
# CONFIG_RTS5208 is not set

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SYNTH_ACNTSA=y
CONFIG_SPEAKUP_SYNTH_APOLLO=y
# CONFIG_SPEAKUP_SYNTH_AUDPTR is not set
CONFIG_SPEAKUP_SYNTH_BNS=y
# CONFIG_SPEAKUP_SYNTH_DECTLK is not set
# CONFIG_SPEAKUP_SYNTH_DECEXT is not set
# CONFIG_SPEAKUP_SYNTH_LTLK is not set
CONFIG_SPEAKUP_SYNTH_SOFT=y
CONFIG_SPEAKUP_SYNTH_SPKOUT=y
CONFIG_SPEAKUP_SYNTH_TXPRT=y
CONFIG_SPEAKUP_SYNTH_DUMMY=y
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ION is not set
CONFIG_STAGING_BOARD=y
CONFIG_GS_FPGABOOT=y
CONFIG_UNISYSSPAR=y
CONFIG_UNISYS_VISORNIC=y
CONFIG_UNISYS_VISORINPUT=y
CONFIG_UNISYS_VISORHBA=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
CONFIG_MOST_NET=y
CONFIG_MOST_SOUND=y
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=y
CONFIG_MOST_USB=y
# CONFIG_GREYBUS is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
CONFIG_XIL_AXIS_FIFO=y
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
# CONFIG_EROFS_FS_XATTR is not set
# CONFIG_EROFS_FS_USE_VM_MAP_RAM is not set
CONFIG_EROFS_FAULT_INJECTION=y
CONFIG_EROFS_FS_IO_MAX_RETRIES=5
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
# CONFIG_EROFS_FS_ZIP_NO_CACHE is not set
# CONFIG_EROFS_FS_ZIP_CACHE_UNIPOLAR is not set
CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR=y
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=y
CONFIG_ALIENWARE_WMI=y
CONFIG_ASUS_LAPTOP=y
# CONFIG_DCDBAS is not set
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_WMI is not set
CONFIG_DELL_LAPTOP=y
# CONFIG_DELL_WMI is not set
CONFIG_DELL_WMI_AIO=y
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=y
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=y
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=y
# CONFIG_AMILO_RFKILL is not set
CONFIG_GPD_POCKET_FAN=y
CONFIG_HP_ACCEL=y
CONFIG_HP_WIRELESS=y
CONFIG_HP_WMI=y
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=y
# CONFIG_PANASONIC_LAPTOP is not set
CONFIG_COMPAL_LAPTOP=y
# CONFIG_SONY_LAPTOP is not set
CONFIG_IDEAPAD_LAPTOP=y
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_ASUS_WIRELESS=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_INTEL_WMI_THUNDERBOLT=y
CONFIG_MSI_WMI=y
CONFIG_PEAQ_WMI=y
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_IPS=y
CONFIG_INTEL_PMC_CORE=y
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_MXM_WMI=y
CONFIG_INTEL_OAKTRAIL=y
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_APPLE_GMUX=y
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_PMC_IPC=y
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_SURFACE_3_BUTTON=y
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_TELEMETRY=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_CHTDC_TI_PWRBTN=y
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_HUAWEI_WMI=y
CONFIG_PCENGINES_APU2=y
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CHROMEOS_TBMC=y
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
# CONFIG_CROS_EC_DEBUGFS is not set
# CONFIG_CROS_EC_SYSFS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_CLK_TWL6040 is not set
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

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
CONFIG_SOUNDWIRE_BUS=y
CONFIG_SOUNDWIRE_CADENCE=y
CONFIG_SOUNDWIRE_INTEL=y

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
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_AXP288=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_INTEL_CHT_WC=y
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=y
CONFIG_NTB_INTEL=y
# CONFIG_NTB_SWITCHTEC is not set
CONFIG_NTB_PINGPONG=y
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
# CONFIG_VME_USER is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_MADERA_IRQ=y
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_CADENCE_DP=y
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_MAPPHONE_MDM6600=y
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
CONFIG_ND_BLK=y
# CONFIG_BTT is not set
CONFIG_OF_PMEM=y
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_INTEL_TH is not set
# CONFIG_FPGA is not set
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
CONFIG_PM_OPP=y
CONFIG_UNISYS_VISORBUS=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=y
CONFIG_OCFS2_FS=y
CONFIG_OCFS2_FS_O2CB=y
# CONFIG_OCFS2_FS_STATS is not set
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=y
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"
CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_PCRYPT=y
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
# CONFIG_CRYPTO_AEGIS256 is not set
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=y
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_MORUS1280_GLUE=y
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
CONFIG_CRYPTO_MORUS1280_AVX2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=y

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
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BTREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y

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
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=1
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_EFI_PGT_DUMP=y
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='vm-snb-2G-903'
	export tbox_group='vm-snb-2G'
	export branch='linux-devel/devel-hourly-2019052104'
	export commit='a8654596f0371c2604c4d475422c48f4fc6a56c9'
	export kconfig='x86_64-randconfig-s3-05210623'
	export repeat_to=84
	export submit_id='5ce4a3b4ad698516b0b2c6d7'
	export job_file='/lkp/jobs/scheduled/vm-snb-2G-903/trinity-300s-debian-x86_64-2018-04-03.cgz-a8654596f0371c2604c4d47542-20190522-5808-kzhoce-49.yaml'
	export id='1e04e000760c37ef8a444e83ca02d6f7a4bc6566'
	export queuer_version='/lkp/lkp/src'
	export arch='x86_64'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export ssh_base_port=23108
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-05-22 09:19:54 +0800'
	export _id='5ce4a3bcad698516b0b2c708'
	export _rt='/result/trinity/300s/vm-snb-2G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-s3-05210623/gcc-7/a8654596f0371c2604c4d475422c48f4fc6a56c9'
	export user='lkp'
	export result_root='/result/trinity/300s/vm-snb-2G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-s3-05210623/gcc-7/a8654596f0371c2604c4d475422c48f4fc6a56c9/77'
	export scheduler_version='/lkp/lkp/.src-20190522-085324'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-2G-903/trinity-300s-debian-x86_64-2018-04-03.cgz-a8654596f0371c2604c4d47542-20190522-5808-kzhoce-49.yaml
ARCH=x86_64
kconfig=x86_64-randconfig-s3-05210623
branch=linux-devel/devel-hourly-2019052104
commit=a8654596f0371c2604c4d475422c48f4fc6a56c9
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s3-05210623/gcc-7/a8654596f0371c2604c4d475422c48f4fc6a56c9/vmlinuz-5.1.0-rc4-00069-ga865459
max_uptime=1500
RESULT_ROOT=/result/trinity/300s/vm-snb-2G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-s3-05210623/gcc-7/a8654596f0371c2604c4d475422c48f4fc6a56c9/77
LKP_SERVER=inn
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
rw'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-04-24.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/trinity-x86_64-865d3fc2_2019-05-14.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='2G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export job_origin='/lkp/jobs/scheduled/vm-snb-2G-903/trinity-300s-debian-x86_64-2018-04-03.cgz-a8654596f0371c2604c4d47542-20190522-5808-kzhoce-49.yaml'
	export vm_tbox_group='vm-snb-2G'
	export nr_vm=220
	export vm_base_id=1201
	export kernel='/pkg/linux/x86_64-randconfig-s3-05210623/gcc-7/a8654596f0371c2604c4d475422c48f4fc6a56c9/vmlinuz-5.1.0-rc4-00069-ga865459'
	export dequeue_time='2019-05-22 09:21:17 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-2G-903/trinity-300s-debian-x86_64-2018-04-03.cgz-a8654596f0371c2604c4d47542-20190522-5808-kzhoce-49.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--GLp9dJVi+aaipsRk
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--GLp9dJVi+aaipsRk--
