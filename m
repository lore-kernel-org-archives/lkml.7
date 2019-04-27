Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C346B2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwNZZqsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfD0W0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 18:26:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44079 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfD0W0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 18:26:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id l2so457918plt.11;
        Sat, 27 Apr 2019 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/4JN+t+xk+xY07xuluWr6A/tSKelPUKjwAcsihY5Xpk=;
        b=DwNZZqsb3HG7/AsSb5fnPyxCEz150lr9egoi/aJGf7i88yhYZN7HhrCMmiVQh41/Qe
         QhMy2ug3Hk8ant9a3y7Bz+vwxNuPFEnQYIQ/ZqpUbzbIro95r7oaJbjPbCO1S0SMiu4P
         XNctR8YiR+gqvz5P78rBq+ql3c0PUIGvLako0umN+lA4xxoNSIrp3L33dwNyeVx1gcev
         6HSAcAzfb1m7kyuMLM9mJmqBJyZD/fkWoF154gck7XY5a61BHZXnRcuV0Rtl4lReHwce
         6VeCKlP72QZxWGh1ArDn50aWQ9dU7tBKBfVZ1p/lDI0zmIzUohRutmvSYYEvYyd829UB
         vfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/4JN+t+xk+xY07xuluWr6A/tSKelPUKjwAcsihY5Xpk=;
        b=mKFGRkt9j/r7cqQn7PikC681dI17SJHU+YYT3bPl3+skjLDPj3gvbqEHB/RjBv/ciW
         fL7eTPiWphaiAzmIf1HG3S+YLVYmERxUOEYpkSmbwcZsWbZImFpHBePF95V41NsDZQbI
         M4hGbDxA78Yl0+HD24XrFNuzKTlujpjLX86rzLYsP5Vatzp1RtGDTkgDiMUKsPCImfj0
         DDqxsKxYW0O+uOM/z4r+CEtkQDLBCcGvXBlibRhsqh/376Gz9aurbXyLBpllyZCZaERU
         DppRghCqQMt6f2rdG2HuoVTLAr6k1Bk0bIB+W6UP3U3N0QaavNKmCZFsetwokhYOTW8z
         Wvvw==
X-Gm-Message-State: APjAAAUeAz45mCTSWISgVeUQdUZRK3wTjwoJy+8/pveSS+t8hUgK9t36
        VhZzqu6uHgIm/gfCRPxH9m8=
X-Google-Smtp-Source: APXvYqyxE6Cy+2XUBbJLPChE4CXhph0gGzROgk5aXbKqmhR15CrDHSwQQhYwujgj20Dx1YrUBagtzQ==
X-Received: by 2002:a17:902:29a7:: with SMTP id h36mr54239879plb.319.1556403990224;
        Sat, 27 Apr 2019 15:26:30 -0700 (PDT)
Received: from debian ([103.231.91.67])
        by smtp.gmail.com with ESMTPSA id t21sm37526270pfe.22.2019.04.27.15.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 15:26:28 -0700 (PDT)
Date:   Sun, 28 Apr 2019 03:56:17 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.0.10
Message-ID: <20190427222617.GA20071@debian>
References: <20190427124441.GA14400@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20190427124441.GA14400@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, man!
On 14:44 Sat 27 Apr , Greg KH wrote:
>I'm announcing the release of the 5.0.10 kernel.
>
>All users of the 5.0 kernel series must upgrade.
>
>The updated 5.0.y git tree can be found at:
>	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git lin=
ux-5.0.y
>and can be browsed at the normal kernel.org git web browser:
>	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Ds=
ummary
>
>thanks,
>
>greg k-h
>
>------------
>
> Makefile                                                 |    5
> arch/arm64/include/asm/futex.h                           |    2
> arch/s390/boot/mem_detect.c                              |    2
> arch/x86/crypto/poly1305-avx2-x86_64.S                   |   14 +
> arch/x86/crypto/poly1305-sse2-x86_64.S                   |   22 +-
> arch/x86/events/amd/core.c                               |   35 +++-
> arch/x86/events/intel/core.c                             |    2
> arch/x86/events/perf_event.h                             |   38 ++--
> arch/x86/kernel/cpu/bugs.c                               |    6
> arch/x86/kernel/kprobes/core.c                           |   48 ++++++
> arch/x86/kernel/process.c                                |    8 -
> arch/x86/kvm/emulate.c                                   |   21 +-
> arch/x86/kvm/svm.c                                       |   24 ++-
> arch/x86/kvm/vmx/vmx.c                                   |    4
> arch/x86/kvm/x86.c                                       |   10 -
> arch/x86/kvm/x86.h                                       |    2
> crypto/testmgr.h                                         |   44 +++++
> drivers/acpi/nfit/core.c                                 |   63 +++++---
> drivers/acpi/nfit/nfit.h                                 |   11 +
> drivers/base/memory.c                                    |    2
> drivers/char/ipmi/ipmi_msghandler.c                      |   19 ++
> drivers/char/tpm/eventlog/tpm2.c                         |    4
> drivers/char/tpm/tpm-dev-common.c                        |    9 +
> drivers/char/tpm/tpm_i2c_atmel.c                         |    4
> drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c                  |    1
> drivers/gpu/drm/ttm/ttm_page_alloc.c                     |    5
> drivers/i3c/master.c                                     |    5
> drivers/i3c/master/dw-i3c-master.c                       |    2
> drivers/iio/accel/kxcjk-1013.c                           |    2
> drivers/iio/adc/ad_sigma_delta.c                         |    1
> drivers/iio/adc/at91_adc.c                               |   28 ++-
> drivers/iio/chemical/bme680.h                            |    6
> drivers/iio/chemical/bme680_core.c                       |   54 +++++--
> drivers/iio/chemical/bme680_i2c.c                        |   21 --
> drivers/iio/chemical/bme680_spi.c                        |  115 +++++++++=
+-----
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c     |    7
> drivers/iio/dac/mcp4725.c                                |    1
> drivers/iio/gyro/bmg160_core.c                           |    6
> drivers/iio/gyro/mpu3050-core.c                          |    8 -
> drivers/iio/industrialio-buffer.c                        |    5
> drivers/iio/industrialio-core.c                          |    4
> drivers/infiniband/core/uverbs_main.c                    |    3
> drivers/input/mouse/elan_i2c_core.c                      |   25 +++
> drivers/net/bonding/bond_main.c                          |    6
> drivers/net/ethernet/cavium/thunder/nicvf_main.c         |   22 ++
> drivers/net/ethernet/freescale/fec_main.c                |   30 ++-
> drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c      |    4
> drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c     |    3
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |    8 -
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          |   94 +++++++++=
---
> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c       |    6
> drivers/net/ethernet/mellanox/mlx5/core/en_stats.h       |    4
> drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c       |   61 +++----
> drivers/net/ethernet/mellanox/mlxsw/core.c               |    6
> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c    |    2
> drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |    2
> drivers/net/ethernet/netronome/nfp/flower/action.c       |    3
> drivers/net/ethernet/netronome/nfp/flower/cmsg.h         |    3
> drivers/net/ethernet/netronome/nfp/flower/match.c        |   14 -
> drivers/net/team/team.c                                  |   26 +++
> drivers/net/wireless/mediatek/mt76/mt76x02_mac.c         |   14 +
> drivers/net/wireless/ralink/rt2x00/rt2x00.h              |    1
> drivers/net/wireless/ralink/rt2x00/rt2x00mac.c           |   10 -
> drivers/net/wireless/ralink/rt2x00/rt2x00queue.c         |   15 +
> drivers/scsi/libfc/fc_rport.c                            |    1
> drivers/scsi/scsi_lib.c                                  |    6
> drivers/staging/comedi/drivers/ni_usb6501.c              |   10 -
> drivers/staging/comedi/drivers/vmk80xx.c                 |    8 -
> drivers/staging/iio/adc/ad7192.c                         |    8 -
> drivers/staging/iio/meter/ade7854.c                      |    2
> drivers/staging/most/core.c                              |    2
> drivers/tty/serial/sh-sci.c                              |    6
> drivers/tty/vt/vt.c                                      |    3
> drivers/vhost/vhost.c                                    |    6
> fs/cifs/cifsglob.h                                       |    2
> fs/cifs/file.c                                           |   30 +++
> fs/cifs/misc.c                                           |   25 +++
> fs/cifs/smb2misc.c                                       |    6
> fs/cifs/smb2ops.c                                        |    2
> fs/cifs/smb2pdu.c                                        |   11 -
> fs/dax.c                                                 |   15 +
> fs/proc/task_mmu.c                                       |   18 ++
> fs/userfaultfd.c                                         |    9 +
> include/linux/kprobes.h                                  |    1
> include/linux/netdevice.h                                |    3
> include/linux/sched/mm.h                                 |   21 ++
> include/net/nfc/nci_core.h                               |    2
> include/net/tls.h                                        |    4
> kernel/events/ring_buffer.c                              |   33 +---
> kernel/kprobes.c                                         |    6
> kernel/sched/fair.c                                      |   25 +++
> kernel/sysctl.c                                          |    3
> kernel/time/sched_clock.c                                |    4
> kernel/time/tick-common.c                                |    2
> kernel/time/timekeeping.h                                |    7
> kernel/trace/ftrace.c                                    |    6
> mm/mmap.c                                                |    7
> mm/percpu.c                                              |    8 -
> mm/vmstat.c                                              |    5
> net/atm/lec.c                                            |    6
> net/bridge/br_input.c                                    |   23 +--
> net/bridge/br_multicast.c                                |    4
> net/bridge/br_netlink.c                                  |    2
> net/core/dev.c                                           |   16 +-
> net/core/failover.c                                      |    6
> net/core/skbuff.c                                        |   10 +
> net/ipv4/fou.c                                           |    4
> net/ipv4/route.c                                         |   16 +-
> net/ipv4/tcp_input.c                                     |   10 -
> net/ipv6/route.c                                         |    4
> net/mac80211/driver-ops.h                                |    3
> net/nfc/nci/hci.c                                        |    8 +
> net/sched/sch_cake.c                                     |   57 +++----
> net/strparser/strparser.c                                |   12 -
> net/tipc/name_table.c                                    |    3
> net/tls/tls_device.c                                     |   12 +
> net/tls/tls_main.c                                       |   24 +++
> net/tls/tls_sw.c                                         |   15 -
> security/device_cgroup.c                                 |    2
> sound/core/info.c                                        |   12 +
> sound/core/init.c                                        |   18 +-
> sound/pci/hda/patch_realtek.c                            |    6
> 122 files changed, 1135 insertions(+), 477 deletions(-)
>
>Alex Deucher (1):
>      drm/amdgpu/gmc9: fix VM_L2_CNTL3 programming
>
>Alexander Shishkin (1):
>      perf/ring_buffer: Fix AUX record suppression
>
>Andi Kleen (1):
>      x86/cpu/bugs: Use __initconst for 'const' init data
>
>Andrea Arcangeli (1):
>      coredump: fix race condition between mmget_not_zero()/get_task_mm() =
and core dumping
>
>Andy Duan (1):
>      net: fec: manage ahb clock in runtime pm
>
>Aneesh Kumar K.V (1):
>      fs/dax: Deposit pagetable even when installing zero page
>
>Aurelien Aptel (1):
>      CIFS: keep FileInfo handle live during oplock break
>
>Chang-An Chen (1):
>      timers/sched_clock: Prevent generic sched_clock wrap caused by tick_=
freeze()
>
>Christian Gromm (1):
>      staging: most: core: use device description as name
>
>Christian K=F6nig (1):
>      drm/ttm: fix out-of-bounds read in ttm_put_pages() v2
>
>Corey Minyard (1):
>      ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release=
_barrier
>
>Dan Carpenter (2):
>      NFC: nci: Add some bounds checking in nci_hci_cmd_received()
>      nfc: nci: Potential off by one in ->pipes[] array
>
>Dan Williams (4):
>      nfit/ars: Remove ars_start_flags
>      nfit/ars: Introduce scrub_flags
>      nfit/ars: Allow root to busy-poll the ARS state machine
>      nfit/ars: Avoid stale ARS results
>
>Dmytro Linkin (1):
>      net/mlx5e: Protect against non-uplink representor for encap
>
>Dragos Bogdan (1):
>      iio: ad_sigma_delta: select channel when reading register
>
>Eric Biggers (1):
>      crypto: x86/poly1305 - fix overflow during partial reduction
>
>Eric Dumazet (2):
>      tcp: tcp_grow_window() needs to respect tcp_space()
>      ipv4: ensure rcu_read_lock() in ipv4_link_failure()
>
>Fabrice Gasnier (1):
>      iio: core: fix a possible circular locking dependency
>
>Felix Fietkau (1):
>      mac80211: do not call driver wake_tx_queue op during reconfig
>
>Geert Uytterhoeven (2):
>      serial: sh-sci: Fix HSCIF RX sampling point adjustment
>      serial: sh-sci: Fix HSCIF RX sampling point calculation
>
>Georg Ottinger (1):
>      iio: adc: at91: disable adc channel interrupt in timeout case
>
>Greg Kroah-Hartman (1):
>      Linux 5.0.10
>
>Gustavo A. R. Silva (1):
>      net: atm: Fix potential Spectre v1 vulnerabilities
>
>Gwendal Grignou (1):
>      iio: cros_ec: Fix the maths for gyro scale calculation
>
>Hangbin Liu (1):
>      team: set slave to promisc if team is already in promisc mode
>
>Hoang Le (1):
>      tipc: missing entries in name table of publications
>
>Hui Wang (1):
>      ALSA: hda/realtek - add two more pin configuration sets to quirk tab=
le
>
>Ian Abbott (4):
>      staging: comedi: vmk80xx: Fix use of uninitialized semaphore
>      staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
>      staging: comedi: ni_usb6501: Fix use of uninitialized mutex
>      staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf
>
>Ido Schimmel (5):
>      mlxsw: spectrum_switchdev: Add MDB entries in prepare phase
>      mlxsw: core: Do not use WQ_MEM_RECLAIM for EMAD workqueue
>      mlxsw: core: Do not use WQ_MEM_RECLAIM for mlxsw ordered workqueue
>      mlxsw: core: Do not use WQ_MEM_RECLAIM for mlxsw workqueue
>      mlxsw: spectrum_router: Do not check VRF MAC address
>
>Jaesoo Lee (1):
>      scsi: core: set result when the command cannot be dispatched
>
>Jakub Kicinski (5):
>      net/tls: fix the IV leaks
>      net/tls: don't leak partially sent record in device mode
>      net: strparser: partially revert "strparser: Call skb_unclone condit=
ionally"
>      net/tls: fix build without CONFIG_TLS_DEVICE
>      net/tls: prevent bad memory access in tls_is_sk_tx_device_offloaded()
>
>Jann Horn (1):
>      device_cgroup: fix RCU imbalance in error case
>
>Jarkko Sakkinen (1):
>      tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete
>
>Jason Wang (1):
>      vhost: reject zero size iova range
>
>Jean-Francois Dagenais (1):
>      iio: dac: mcp4725: add missing powerdown bits in store eeprom
>
>Joe Perches (1):
>      s390/mem_detect: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD)
>
>Jonathan Lemon (1):
>      route: Avoid crash from dereferencing NULL rt->from
>
>KT Liao (1):
>      Input: elan_i2c - add hardware ID for multiple Lenovo laptops
>
>Kan Liang (1):
>      perf/x86: Fix incorrect PEBS_REGS
>
>Kim Phillips (1):
>      perf/x86/amd: Add event map for AMD Family 17h
>
>Konstantin Khlebnikov (2):
>      net/mlx5e: Switch to Toeplitz RSS hash by default
>      mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=3Dy C=
ONFIG_SMP=3Dn
>
>Lars-Peter Clausen (1):
>      iio: Fix scan mask selection
>
>Leonard Pollak (1):
>      Staging: iio: meter: fixed typo
>
>Lorenzo Bianconi (1):
>      net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_=
recv
>
>Masami Hiramatsu (4):
>      x86/kprobes: Verify stack frame on kretprobe
>      kprobes: Mark ftrace mcount handler functions nokprobe
>      x86/kprobes: Avoid kretprobe recursion bug
>      kprobes: Fix error check when reusing optimized probes
>
>Matteo Croce (3):
>      net: thunderx: raise XDP MTU to 1508
>      net: thunderx: don't allow jumbo frames with XDP
>      percpu: stop printing kernel addresses
>
>Matthias Kaehlcke (1):
>      Revert "kbuild: use -Oz instead of -Os when using clang"
>
>Mike Looijmans (3):
>      iio/gyro/bmg160: Use millidegrees for temperature scale
>      iio:chemical:bme680: Fix, report temperature in millidegrees
>      iio:chemical:bme680: Fix SPI read interface
>
>Mikulas Patocka (1):
>      vt: fix cursor when clearing the screen
>
>Mircea Caprioru (1):
>      staging: iio: ad7192: Fix ad7193 channel address
>
>Nathan Chancellor (1):
>      arm64: futex: Restore oldval initialization to work around buggy com=
pilers
>
>Nikolay Aleksandrov (3):
>      net: bridge: fix per-port af_packet sockets
>      net: bridge: multicast: use rcu to access port list from br_multicas=
t_start_querier
>      net: bridge: fix netlink export of vlan_stats_per_port option
>
>Or Gerlitz (1):
>      Revert "net/mlx5e: Enable reporting checksum unnecessary also for L3=
 packets"
>
>Phil Auld (1):
>      sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup
>
>Pieter Jansen van Vuuren (2):
>      nfp: flower: replace CFI with vlan present
>      nfp: flower: remove vlan CFI bit from push vlan action
>
>Ronnie Sahlberg (1):
>      cifs: fix handle leak in smb2_query_symlink()
>
>Sabrina Dubroca (1):
>      bonding: fix event handling for stacked bonds
>
>Saeed Mahameed (5):
>      net/mlx5e: XDP, Avoid checksum complete when XDP prog is loaded
>      net/mlx5e: Rx, Fixup skb checksum for packets with tail padding
>      net/mlx5e: Rx, Check ip headers sanity
>      net/mlx5: FPGA, tls, hold rcu read lock a bit longer
>      net/mlx5: FPGA, tls, idr remove on flow delete
>
>Saurav Kashyap (1):
>      Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"
>
>Sean Christopherson (1):
>      KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU
>
>Sergey Larin (1):
>      iio: gyro: mpu3050: fix chip ID reading
>
>Si-Wei Liu (1):
>      failover: allow name change on IFF_UP slave interfaces
>
>Stanislaw Gruszka (1):
>      mt76x02: avoid status_list.lock and sta->rate_ctrl_lock dependency
>
>Stephen Suryaputra (1):
>      ipv4: recompile ip options in ipv4_link_failure
>
>Suthikulpanit, Suravee (1):
>      Revert "svm: Fix AVIC incomplete IPI emulation"
>
>Tadeusz Struk (1):
>      tpm: fix an invalid condition in tpm_common_poll
>
>Takashi Iwai (2):
>      ALSA: core: Fix card races between register and disconnect
>      ALSA: info: Fix racy addition/deletion of nodes
>
>Thomas Gleixner (1):
>      x86/speculation: Prevent deadlock on ssb_state::lock
>
>Toke H=F8iland-J=F8rgensen (3):
>      sch_cake: Use tc_skb_protocol() helper for getting packet protocol
>      sch_cake: Make sure we can write the IP header before changing DSCP =
bits
>      sch_cake: Simplify logic in cake_select_tin()
>
>Vijayakumar Durai (1):
>      rt2x00: do not increment sequence number while re-transmitting
>
>Vitaly Kuznetsov (1):
>      KVM: x86: svm: make sure NMI is injected after nmi_singlestep
>
>Vitor Soares (2):
>      i3c: dw: Fix dw_i3c_master_disable controller by using correct mask
>      i3c: Fix the verification of random PID
>
>WANG Chao (1):
>      x86/kvm: move kvm_load/put_guest_xcr0 into atomic context
>
>Will Deacon (1):
>      kernel/sysctl.c: fix out-of-bounds access when setting file-max
>
>Yue Haibing (1):
>      tpm: Fix the type of the return value in calc_tpm2_event_size()
>
>Yuya Kusakabe (1):
>      net: Fix missing meta data in skb with vlan packet
>
>ZhangXiaoxu (3):
>      cifs: Fix lease buffer length error
>      cifs: Fix use-after-free in SMB2_write
>      cifs: Fix use-after-free in SMB2_read
>
>he, bo (1):
>      io: accel: kxcjk1013: restore the range after resume.
>
>zhong jiang (1):
>      mm/memory_hotplug: do not unlock after failing to take the device_ho=
tplug_lock
>



--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAlzE1wUACgkQsjqdtxFL
KRUnawgAsuVtcDlEujESbiuUXPfzDPLA8okOTA0BrMFAw9w/lxQTUbrwQo8+aXeT
g4a/e5BQD4g/Lb/EGO/lCaOpPtF5kc28vJEEtvgmQwT+Ma1FO4ZATmWkDXH7CB1+
iQVk1yySSt2rKtKxWnJg3f0YicLO63LgkDEwkCFS/QoiHLKqbUbDYfeiVlARUogj
nUZy9qZrunuXdwfidq1sN7U27HHR8E2DCEE0hXHB6DCZz8JHXhHft8AK5UMlxnYz
savvaTGi53tfDdjy/NeOj/tiJtYkAxVfoPOB3kF8WcThb/71N1PXThOWriJdfbqW
PsZdQzMAUsdhczOgcolxesPNwiDnGA==
=HpRD
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
