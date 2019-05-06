Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C87C004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 01:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F6A20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 01:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYCaSOsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfEFBmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 21:42:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42876 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfEFBmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 21:42:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so5530482pln.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 18:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCZjPT3fIdMuf6X+Drkyh0Pi0w8h/8ZrH8XOMoAj5DE=;
        b=RYCaSOsbopBQbwgRrKRBrT/SiZJ+RAnZuf2Q8InI2Lb+2dmqLTdMmm/EBdwnCLPUpQ
         RLX1nDGPaIo7GMVa+w6zXbsMEZ07VayM0a4No0QdmOAeDVATUldi8kfQGMvCG+yvGQ72
         1fdo+gWxjv8pR11crHUFjwv2ik7mTVgrujBLc7dDNdL3MXgfqo1XhX/a8DFr2yWE/aMf
         G/XD6a0JZuABirjzOjOj2lRiS6V+osf6pxuRoEML55TBkvjKfYXggmMPXZxyBtC8QBN/
         5LpnE7W+pl0AOTc1Eqp20I1kHJayKphmXwNlzvfxHDYLeL8rcCpo5tWYea3LBDY56hXa
         wpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCZjPT3fIdMuf6X+Drkyh0Pi0w8h/8ZrH8XOMoAj5DE=;
        b=W1Dle12IGiZ6QgMbadIaKiQONO+23Lrc+fwydSNgVvVaFTLTsMsdBJ5LeJnFF42sP1
         5K2W9bIgfwwtan0Qdr9Gj91Sa76zW3eTSqP/8ZO1yDnn5F1ybHm4d4daaoXSkuH2p6Cz
         9D8HFIz/enApvSGJZj5GA6sFlkAmyGpmN2JofIm/gLqb1ITHJzG1AZt/iMNmb2orT2bb
         mJkqrD2+Wezb67lppGQKGmhs8k3PpoJU37n6WeSPmCi/bcD2geDNCo6iFByu86Gx3zho
         9CuHL1ynfOhoh42LaFPB8Ghs2+F8pzORQ48uj2LRBaFxXlFFWA+WjOKcKqtQH0oJkpot
         fpMQ==
X-Gm-Message-State: APjAAAV1uXT3KrLyvvjy3k8r7ozN0cGjCnGcueYzUcHdpl0TSr90pjJR
        K9OXpot4qemPd0uPw8HwDCa1jE/qPcA=
X-Google-Smtp-Source: APXvYqzBLje126fMS36ME/t87Es+vQoutjPtf2V7OujwyML0dIS1nk/ze1sMBnPdqhgsXZ93pldidw==
X-Received: by 2002:a17:902:820c:: with SMTP id x12mr28063876pln.199.1557106973881;
        Sun, 05 May 2019 18:42:53 -0700 (PDT)
Received: from ArchLinux ([103.231.91.74])
        by smtp.gmail.com with ESMTPSA id m6sm10068159pgq.0.2019.05.05.18.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 18:42:52 -0700 (PDT)
Date:   Mon, 6 May 2019 07:12:41 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.1
Message-ID: <20190506014241.GA3022@ArchLinux>
References: <CAHk-=whsbDxdapMJGvy9OkVSrKMsKRJBTrH-Qj-qTbkMUGnWUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <CAHk-=whsbDxdapMJGvy9OkVSrKMsKRJBTrH-Qj-qTbkMUGnWUw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Thanks, a bunch Linus!

On 18:07 Sun 05 May , Linus Torvalds wrote:
>So it's a bit later in the day than I usually do this, just because I
>was waffling about the release. Partly because I got some small pull
>requests today, but mostly just because I wasn't looking forward to
>the timing of this upcoming 5.2 merge window.
>
>But the last-minute pull requests really weren't big enough to justify
>delaying things over, and hopefully the merge window timing won't be
>all that painful either. I just happen to have the college graduation
>of my oldest happen right smack dab in the middle of the upcoming
>merge window, so I might be effectively offline for a few days there.
>If worst comes to worst, I'll extend it to make it all work, but I
>don't think it will be needed.
>
>Anyway, on to 5.1 itself. The past week has been pretty calm, and the
>final patch from rc6 is not all that big. The shortlog is appended,
>but it's small changes all over. Networking, filesystem code, drivers,
>tooling, arch updates. Nothing particularly odd stands out.
>
>Of course, the shortlog below is just for that final calm week. On the
>whole, 5.1 looks very normal with just over 13k commits (plus another
>1k+ if you count merges). Which is pretty much our normal size these
>days. No way to boil that down to a sane shortlog, with work all over.
>
>Go out and test,
>
>                Linus
>
>---
>
>Al Viro (4):
>      securityfs: fix use-after-free on symlink traversal
>      apparmorfs: fix use-after-free on symlink traversal
>      [fix] get rid of checking for absent device name in vfs_get_tree()
>      ufs: fix braino in ufs_get_inode_gid() for solaris UFS flavour
>
>Alan Stern (5):
>      USB: core: Fix unterminated string returned by usb_string()
>      USB: dummy-hcd: Fix failure to give back unlinked URBs
>      USB: core: Fix bug caused by duplicate interface PM usage counter
>      USB: yurex: Fix protection fault after device removal
>      USB: w1 ds2490: Fix bug caused by improper use of altsetting array
>
>Alban Crequy (1):
>      tools: bpftool: fix infinite loop in map create
>
>Alex Williamson (1):
>      PCI/portdrv: Use shared MSI/MSI-X vector for Bandwidth Management
>
>Alexander Lochmann (1):
>      Abort file_remove_privs() for non-reg. files
>
>Alexander Shishkin (2):
>      perf/ring_buffer: Fix AUX software double buffering
>      perf/x86/intel/pt: Remove software double buffering PMU capability
>
>Alexey Kardashevskiy (1):
>      KVM: PPC: Book3S: Protect memslots while validating user address
>
>Andrew Jones (2):
>      KVM: arm/arm64: Ensure vcpu target is unset on reset failure
>      Documentation: kvm: fix dirty log ioctl arch lists
>
>Andrew Lunn (1):
>      net: phy: marvell: Fix buffer overrun with stats counters
>
>Andrey Smirnov (1):
>      power: supply: sysfs: prevent endless uevent loop with
>CONFIG_POWER_SUPPLY_DEBUG
>
>Anson Huang (1):
>      i2c: imx: correct the method of getting private data in notifier_call
>
>Ard Biesheuvel (1):
>      i2c: synquacer: fix enumeration of slave devices
>
>Arnaldo Carvalho de Melo (5):
>      tools uapi x86: Sync vmx.h with the kernel
>      perf bench numa: Add define for RUSAGE_THREAD if not present
>      tools build: Add -ldl to the disassembler-four-args feature test
>      tools arch uapi: Copy missing unistd.h headers for arc, hexagon and =
riscv
>      perf tools: Remove needless asm/unistd.h include fixing build in
>some places
>
>Bhagavathi Perumal S (1):
>      mac80211: Fix kernel panic due to use of txq after free
>
>Bj=F8rn Mork (1):
>      qmi_wwan: new Wistron, ZTE and D-Link devices
>
>Bo YU (1):
>      perf bpf: Return value with unlocking in perf_env__find_btf()
>
>Brian Norris (1):
>      ath10k: perform crash dump collection in workqueue
>
>Christoffer Dall (1):
>      KVM: arm/arm64: Don't emulate virtual timers on userspace ioctls
>
>Christophe Leroy (1):
>      powerpc/32s: Fix BATs setting with CONFIG_STRICT_KERNEL_RWX
>
>Cong Wang (1):
>      xfrm: clean up xfrm protocol checks
>
>Dan Carpenter (1):
>      net: dsa: bcm_sf2: fix buffer overflow doing set_rxnfc
>
>David Ahern (1):
>      selftests: fib_rule_tests: Fix icmp proto with ipv6
>
>David Howells (1):
>      rxrpc: Fix net namespace cleanup
>
>Dmitry Osipenko (1):
>      clk: Add missing stubs for a few functions
>
>Douglas Anderson (1):
>      mwifiex: Make resume actually do something useful again on SDIO cards
>
>Emmanuel Grumbach (1):
>      iwlwifi: fix driver operation for 5350
>
>Eric Dumazet (6):
>      l2tp: use rcu_dereference_sk_user_data() in l2tp_udp_encap_recv()
>      tcp: add sanity tests in tcp_add_backlog()
>      ipv6/flowlabel: wait rcu grace period before put_pid()
>      l2ip: fix possible use-after-free
>      ipv6: fix races in ip6_dst_destroy()
>      udp: fix GRO packet of death
>
>Eugeniy Paltsev (1):
>      ARC: memset: fix build with L1_CACHE_SHIFT !=3D 6
>
>Fabien Dessenne (1):
>      net: ethernet: stmmac: manage the get_irq probe defer case
>
>Gary Hook (1):
>      x86/mm/mem_encrypt: Disable all instrumentation for early SME setup
>
>Gerd Hoffmann (1):
>      Revert "drm/qxl: drop prime import/export callbacks"
>
>Greg Kroah-Hartman (2):
>      iwlwifi: mvm: properly check debugfs dentry before using it
>      ALSA: line6: use dynamic buffers
>
>Hangbin Liu (1):
>      selftests: fib_rule_tests: print the result and return 1 if any
>tests failed
>
>Jakub Kicinski (3):
>      net/tls: don't copy negative amounts of data in reencrypt
>      net/tls: fix copy to fragments in reencrypt
>      net/tls: avoid NULL pointer deref on nskb->sk in fallback
>
>Jan Kara (1):
>      fsnotify: Fix NULL ptr deref in fanotify_get_fsid()
>
>Jan Kiszka (1):
>      stmmac: pci: Fix typo in IOT2000 comment
>
>Jarkko Nikula (1):
>      i2c: Prevent runtime suspend of adapter when Host Notify is required
>
>Jens Axboe (2):
>      io_uring: have submission side sqe errors post a cqe
>      io_uring: drop req submit reference always in async punt
>
>Jeremy Sowden (2):
>      vti4: ipip tunnel deregistration fixes.
>      vti4: removed duplicate log message.
>
>Jernej Skrabec (2):
>      clk: sunxi-ng: nkmp: Avoid GENMASK(-1, 0)
>      clk: sunxi-ng: nkmp: Explain why zero width check is needed
>
>Jim Mattson (1):
>      KVM: nVMX: Fix size checks in vmx_set_nested_state
>
>Jiri Olsa (1):
>      perf/x86/intel: Fix race in intel_pmu_disable_event()
>
>Johannes Berg (3):
>      mac80211: fix RX STBC override byte order
>      iwlwifi: mvm: don't attempt debug collection in rfkill
>      mac80211: don't attempt to rename ERR_PTR() debugfs dirs
>
>Kailang Yang (2):
>      ALSA: hda/realtek - Add new Dell platform for headset mode
>      ALSA: hda/realtek - Fixed Dell AIO speaker noise
>
>Kangjie Lu (1):
>      net: ieee802154: fix missing checks for regmap_update_bits
>
>Kees Cook (1):
>      selftests/seccomp: Prepare for exclusive seccomp flags
>
>Keith Busch (1):
>      PCI/LINK: Add Kconfig option (default off)
>
>Kim Phillips (2):
>      perf/x86/amd: Update generic hardware cache events for Family 17h
>      MAINTAINERS: Include vendor specific files under arch/*/events/*
>
>Leo Yan (3):
>      tools lib traceevent: Change tag string for error
>      perf cs-etm: Don't check cs_etm_queue::prev_packet validity
>      perf cs-etm: Always allocate memory for cs_etm_queue::prev_packet
>
>Linus Torvalds (7):
>      rdma: fix build errors on s390 and MIPS due to bad ZERO_PAGE use
>      x86: make ZERO_PAGE() at least parse its argument
>      gcc-9: silence 'address-of-packed-member' warning
>      gcc-9: don't warn about uninitialized variable
>      gcc-9: properly declare the {pv,hv}clock_page storage
>      gcc-9: don't warn about uninitialized btrfs extent_type variable
>      Linux 5.1
>
>Liran Alon (1):
>      KVM: x86: Consider LAPIC TSC-Deadline timer expired if deadline too =
short
>
>Logan Gunthorpe (1):
>      PCI: Fix issue with "pci=3Ddisable_acs_redir" parameter being ignored
>
>Luca Coelho (2):
>      iwlwifi: mvm: check for length correctness in iwl_mvm_create_skb()
>      iwlwifi: mvm: fix merge damage in iwl_mvm_vif_dbgfs_register()
>
>Malte Leip (1):
>      usb: usbip: fix isoc packet num validation in get_pipe
>
>Marc Zyngier (1):
>      KVM: arm/arm64: vgic-v3: Retire pending interrupts on disabling LPIs
>
>Marcel Holtmann (1):
>      genetlink: use idr_alloc_cyclic for family->id assignment
>
>Mark Rutland (3):
>      io_uring: fix SQPOLL cpu validation
>      io_uring: free allocated io_memory once
>      io_uring: avoid page allocation warnings
>
>Martin KaFai Lau (1):
>      ipv6: A few fixes on dereferencing rt->from
>
>Martin Willi (1):
>      xfrm: Honor original L3 slave device in xfrmi policy lookup
>
>Matteo Croce (1):
>      libbpf: add binary to gitignore
>
>Michael Chan (5):
>      bnxt_en: Improve multicast address setup logic.
>      bnxt_en: Fix possible crash in bnxt_hwrm_ring_free() under error
>conditions.
>      bnxt_en: Pass correct extended TX port statistics size to firmware.
>      bnxt_en: Fix statistics context reservation logic.
>      bnxt_en: Fix uninitialized variable usage in bnxt_rx_pkt().
>
>Ming Lei (2):
>      block: fix handling for BIO_NO_PAGE_REF
>      iov_iter: fix iov_iter_type
>
>Miquel Raynal (1):
>      mtd: rawnand: marvell: Clean the controller state before each operat=
ion
>
>Myungho Jung (1):
>      xfrm: Reset secpath in xfrm failure
>
>Nicholas Mc Guire (1):
>      rds: ib: force endiannes annotation
>
>Nicolas Dichtel (1):
>      xfrm: update doc about xfrm[46]_gc_thresh
>
>Paolo Abeni (1):
>      udp: fix GRO reception in case of length mismatch
>
>Paolo Bonzini (1):
>      KVM: fix KVM_CLEAR_DIRTY_LOG for memory slots of unaligned size
>
>Paul Chaignon (2):
>      bpf: mark registers in all frames after pkt/null checks
>      selftests/bpf: test cases for pkt/null checks in subprogs
>
>Paulo Alcantara (1):
>      selinux: use kernel linux/socket.h for genheaders and mdp
>
>Peter Zijlstra (1):
>      bpf: Fix preempt_enable_no_resched() abuse
>
>Rafael J. Wysocki (2):
>      ath10k: Drop WARN_ON()s that always trigger during system resume
>      Revert "ACPICA: Clear status of GPEs before enabling them"
>
>Randy Dunlap (1):
>      Documentation: fix netdev-FAQ.rst markup warning
>
>Rick Edgecombe (1):
>      KVM: VMX: Move RSB stuffing to before the first RET after VM-Exit
>
>Sabrina Dubroca (1):
>      esp4: add length check for UDP encapsulation
>
>Sean Christopherson (6):
>      KVM: lapic: Disable timer advancement if adaptive tuning goes haywire
>      KVM: lapic: Track lapic timer advance per vCPU
>      KVM: lapic: Allow user to disable adaptive tuning of timer advanceme=
nt
>      KVM: lapic: Convert guest TSC to host time domain if necessary
>      KVM: x86: Whitelist port 0x7e for pre-incrementing %rip
>      KVM: lapic: Check for in-kernel LAPIC before deferencing apic pointer
>
>Shahar S Matityahu (2):
>      iwlwifi: don't panic in error path on non-msix systems
>      iwlwifi: dbg_ini: check debug TLV type explicitly
>
>Shaul Triebitz (1):
>      iwlwifi: cfg: use family 22560 based_params for AX210 family
>
>Shmulik Ladkani (1):
>      ipv4: ip_do_fragment: Preserve skb_iif during fragmentation
>
>Sriram R (1):
>      cfg80211: Notify previous user request during self managed wiphy
>registration
>
>Stefan B=FChler (8):
>      io_uring: fix handling SQEs requesting NOWAIT
>      io_uring: fix notes on barriers
>      io_uring: remove unnecessary barrier before wq_has_sleeper
>      io_uring: remove unnecessary barrier before reading cq head
>      io_uring: remove unnecessary barrier after updating SQ head
>      io_uring: remove unnecessary barrier before reading SQ tail
>      io_uring: remove unnecessary barrier after incrementing dropped coun=
ter
>      io_uring: remove unnecessary barrier after unsetting IORING_SQ_NEED_=
WAKEUP
>
>Steffen Klassert (2):
>      Revert "net: xfrm: Add '_rcu' tag for rcu protected pointer in netns=
_xfrm"
>      xfrm4: Fix uninitialized memory read in _decode_session4
>
>Stephen Boyd (1):
>      clkdev: Hold clocks_mutex while iterating clocks list
>
>Stephen Suryaputra (1):
>      vrf: Use orig netdev to count Ip6InNoRoutes and a fresh route
>lookup when sending dest unreach
>
>Su Yanjun (2):
>      net: xfrm: Add '_rcu' tag for rcu protected pointer in netns_xfrm
>      xfrm6_tunnel: Fix potential panic when unloading xfrm6_tunnel module
>
>Suraj Jitindar Singh (1):
>      KVM: PPC: Book3S HV: Perserve PSSCR FAKE_SUSPEND bit on guest exit
>
>Suzuki K Poulose (1):
>      kvm: arm: Skip stage2 huge mappings for unaligned ipa backed by THP
>
>Takashi Iwai (1):
>      ALSA: hda/realtek - Apply the fixup for ASUS Q325UAR
>
>Thadeu Lima de Souza Cascardo (1):
>      perf annotate: Fix build on 32 bit for BPF annotation
>
>Thomas Richter (1):
>      perf report: Report OOM in status line in the GTK UI
>
>Tobin C. Harding (1):
>      sched/cpufreq: Fix kobject memleak
>
>Tony Lindgren (1):
>      power: supply: cpcap-battery: Fix division by zero
>
>Tycho Andersen (1):
>      seccomp: Make NEW_LISTENER and TSYNC flags exclusive
>
>Vasundhara Volam (1):
>      bnxt_en: Free short FW command HWRM memory in error path in
>bnxt_init_one()
>
>Vineet Gupta (2):
>      ARC: PAE40: don't panic and instead turn off hw ioc
>      ARC: [hsdk] Make it easier to add PAE40 region to DTB
>
>Vitaly Kuznetsov (3):
>      x86: kvm: hyper-v: deal with buggy TLB flush requests from WS2012
>      x86/kvm/mmu: reset MMU context when 32-bit guest switches PAE
>      KVM: selftests: make hyperv_cpuid test pass on AMD
>
>Wei Huang (1):
>      KVM: arm/arm64: arch_timer: Fix CNTP_TVAL calculation
>
>Willem de Bruijn (3):
>      ipv6: invert flowlabel sharing check in process and user mode
>      packet: in recvmsg msg_name return at least sizeof sockaddr_ll
>      packet: validate msg_namelen in send directly
>
>Wolfram Sang (2):
>      i2c: designware: ratelimit 'transfer when suspended' errors
>      MAINTAINERS: friendly takeover of i2c-gpio driver
>
>Xin Long (1):
>      sctp: avoid running the sctp state machine recursively
>
>YueHaibing (3):
>      xfrm: policy: Fix out-of-bound array accesses in __xfrm_policy_unlink
>      MIPS: eBPF: Make ebpf_to_mips_reg() static
>      appletalk: Set error code if register_snap_client failed

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAlzPkQsACgkQsjqdtxFL
KRUIkAf/fooCbRg5+dhG5PgD35HJOoS1ZHgBo3DFEPBQ/C3D8DPib05uzVPVqI1O
EQ6OdjTW1H9fFGSu7Vm5VYuaNlItV2SwWdRrwHFqcYq61s2YgYSDYT5sSfcp5rCn
A+SR/k4dXuJ7TPV1Q0+C/rHuZS5EsJZBfN9ceHVsoW6iy732aGSTLUS8U3XXG98E
NBoIVC0dyM01ng9QIW8fRYq/c6BhCt0kSv5NsjbSfrx7088sqkpIofaANptNAUdS
iW53sQxFvsbpSRYcUE+DgXIhPgovBtrhEn/6ZpwfWzDXzJ1SdFzLVfreBe00MHTR
kE8agoBQJpmVcnjDTA+pb/eKQ7WHVQ==
=GNH/
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
