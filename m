Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9118C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D4C206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKqdgDOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfIPFOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 01:14:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33275 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfIPFOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 01:14:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so19111579pgn.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 22:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PH5LjA/vTjid2RCqIIE4xm+dpGypCq4jxOgvo9V7/js=;
        b=oKqdgDOqbws0DtNmZyJNHWcSmTmFKeLKcqBIycP1SncNejAbSr3FgyAUa49zltLYsb
         b8gsQIGXYLjdOBgxGF7zgaGukkBwG3014p49eo+9LZQdNitELX853IViL07erW/HB1IC
         Eh61ueBrYm7yKEyQUpdLcmepAW57huUJK7VP/0eNw36Ti+gZ49psjNTjl8xwYBRTHlzw
         OGEg7uJFVeLQY78pFK2reYVFnPTHq7ZnxBrvAHFb9NrmtykUR4q7y7AUSEr7QcTXDm0X
         TYzDyUPHYgMhmEk8DuFSwh6ZePi73+y+TMUj97Gt+Z6xHJ10cHlKx3iplxMupMz8vkak
         CEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PH5LjA/vTjid2RCqIIE4xm+dpGypCq4jxOgvo9V7/js=;
        b=Sypm5BxUlRH2rwhmqwOUwPuadtzhs06FfOXcGcQ17904nY5a4Q6JWepYZ7C474SYJP
         /F1DZaish4SqAvmUKUKWaxlOb275rL7czaPs03DgbWvRGOP4xHZ7oCqkgy6jEbz8FMQF
         6AZdsqiTvVtKclxyJU7yDbQFWdMH4gFTXg22yqodKNeCjBVaIikZGpVbA7dPxzESuKwY
         yml16SOXevU8m/g8pm7lvs9VlhKfvqP4jsXsNOH8ie3K64zczcbhX2j/dLidw/Dr7I8E
         BkYli+xlj1nczTuVxa7Wl30KxPC/5skuu3+A/E4WQCbHOfiFHUyuUpDekuaRWpUybhCB
         hZjg==
X-Gm-Message-State: APjAAAWX5CMSY+EcLzjKcfNhROu2QL2GaCsb0tS1qCs8kNBaA4eopqAA
        ua17ksb9T5TQDlIpbfMy1/k92VT16dM=
X-Google-Smtp-Source: APXvYqxpm/J4MkF5M4Pyuok5VW31lnRnhhWWjTMuD27LnZxzkiCjsRrk7QgJibx7IuWbsP0q6FPchA==
X-Received: by 2002:a63:bd49:: with SMTP id d9mr28530519pgp.129.1568610884251;
        Sun, 15 Sep 2019 22:14:44 -0700 (PDT)
Received: from Gentoo ([103.231.90.173])
        by smtp.gmail.com with ESMTPSA id k95sm9394537pje.10.2019.09.15.22.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 22:14:43 -0700 (PDT)
Date:   Mon, 16 Sep 2019 10:44:31 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3
Message-ID: <20190916051427.GA3238@Gentoo>
References: <CAHk-=wiP4K8DRJWsCo=20hn_6054xBamGKF2kPgUzpB5aMaofA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiP4K8DRJWsCo=20hn_6054xBamGKF2kPgUzpB5aMaofA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:00 Sun 15 Sep 2019, Linus Torvalds wrote:
>So we've had a fairly quiet last week, but I think it was good that we
>ended up having that extra week and the final rc8.
>
>Even if the reason for that extra week was my travel schedule rather
>than any pending issues, we ended up having a few good fixes come in,
>including some for some bad btrfs behavior. Yeah, there's some
>unnecessary noise in there too (like the speling fixes), but we also
>had several last-minute reverts for things that caused issues.
>
>One _particularly_ last-minute revert is the top-most commit (ignoring
>the version change itself) done just before the release, and while
>it's very annoying, it's perhaps also instructive.
>
>What's instructive about it is that I reverted a commit that wasn't
>actually buggy. In fact, it was doing exactly what it set out to do,
>and did it very well. In fact it did it _so_ well that the much
>improved IO patterns it caused then ended up revealing a user-visible
>regression due to a real bug in a completely unrelated area.
>
>The actual details of that regression are not the reason I point that
>revert out as instructive, though. It's more that it's an instructive
>example of what counts as a regression, and what the whole "no
>regressions" kernel rule means. The reverted commit didn't change any
>API's, and it didn't introduce any new bugs. But it ended up exposing
>another problem, and as such caused a kernel upgrade to fail for a
>user. So it got reverted.
>
>The point here being that we revert based on user-reported _behavior_,
>not based on some "it changes the ABI" or "it caused a bug" concept.
>The problem was really pre-existing, and it just didn't happen to
>trigger before. The better IO patterns introduced by the change just
>happened to expose an old bug, and people had grown to depend on the
>previously benign behavior of that old issue.
>
>And never fear, we'll re-introduce the fix that improved on the IO
>patterns once we've decided just how to handle the fact that we had a
>bad interaction with an interface that people had then just happened
>to rely on incidental behavior for before. It's just that we'll have
>to hash through how to do that (there are no less than three different
>patches by three different developers being discussed, and there might
>be more coming...). In the meantime, I reverted the thing that exposed
>the problem to users for this release, even if I hope it will be
>re-introduced (perhaps even backported as a stable patch) once we have
>consensus about the issue it exposed.
>
>Take-away from the whole thing: it's not about whether you change the
>kernel-userspace ABI, or fix a bug, or about whether the old code
>"should never have worked in the first place". It's about whether
>something breaks existing users' workflow.
>
>Anyway, that was my little aside on the whole regression thing.  Since
>it's that "first rule of kernel programming", I felt it is perhaps
>worth just bringing it up every once in a while.
>
>Other than that aside, I don't find a lot to really talk about last
>week. Drivers, networking (and network drivers), arch updates,
>selftests. And a few random fixes in various other corners. The
>appended shortlog is not overly long, and gives a flavor for the
>changes.
>
>And this obviously means that the merge window for 5.4 is open, and
>I'll start doing pull requests for that tomorrow. I already have a
>number of them in my inbox, and I appreciate all the people who got
>that over and done with early,
>
>                Linus
>

Thanks, man! time to dive in.

Bhaskar

>---
>
>Alexander Duyck (1):
>      ixgbe: Prevent u8 wrapping of ITR value to something less than 10us
>
>Alexei Starovoitov (1):
>      bpf: fix precision tracking of stack slots
>
>Andreas Kemnade (1):
>      regulator: twl: voltage lists for vdd1/2 on twl4030
>
>Andrew Jeffery (1):
>      pinctrl: aspeed: Fix spurious mux failures on the AST2500
>
>Arnd Bergmann (2):
>      ipc: fix semtimedop for generic 32-bit architectures
>      ipc: fix sparc64 ipc() wrapper
>
>Bj=C3=B8rn Mork (1):
>      cdc_ether: fix rndis support for Mediatek based smartphones
>
>Chris Wilson (2):
>      drm/i915: Restore relaxed padding (OCL_OOB_SUPPRES_ENABLE) for skl+
>      Revert "drm/i915/userptr: Acquire the page lock around set_page_dirt=
y()"
>
>Christophe JAILLET (3):
>      net/hamradio/6pack: Fix the size of a sk_buff used in 'sp_bump()'
>      ipv6: Fix the link time qualifier of 'ping_v6_proc_exit_net()'
>      sctp: Fix the link time qualifier of 'sctp_ctrlsock_exit()'
>
>Colin Ian King (4):
>      NFC: st95hf: fix spelling mistake "receieve" -> "receive"
>      net: lmc: fix spelling mistake "runnin" -> "running"
>      net: hns3: fix spelling mistake "undeflow" -> "underflow"
>      mlx4: fix spelling mistake "veify" -> "verify"
>
>Cong Wang (2):
>      net_sched: check cops->tcf_block in tc_bind_tclass()
>      sch_hhf: ensure quantum and hhf_non_hh_weight are non-zero
>
>Dan Carpenter (1):
>      regulator: slg51000: Fix a couple NULL vs IS_ERR() checks
>
>Daniel Drake (1):
>      Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD host contro=
ller"
>
>David Ahern (2):
>      ipv6: Fix RTA_MULTIPATH with nexthop objects
>      selftest: A few cleanups for fib_nexthops.sh
>
>David Howells (1):
>      rxrpc: Fix misplaced traceline
>
>Dmitry Torokhov (1):
>      gpiolib: of: fix fallback quirks handling
>
>Donald Sharp (1):
>      net: Properly update v4 routes with v6 nexthop
>
>Eric Biggers (1):
>      isdn/capi: check message length in capi_write()
>
>Eric Dumazet (1):
>      net: sched: fix reordering issues
>
>Eugene Syromiatnikov (1):
>      fork: block invalid exit signals with clone3()
>
>Fernando Fernandez Mancera (1):
>      netfilter: nft_socket: fix erroneous socket assignment
>
>Filipe Manana (2):
>      Btrfs: fix assertion failure during fsync and use of stale transacti=
on
>      Btrfs: fix unwritten extent buffers and hangs on future writeback at=
tempts
>
>Florian Westphal (1):
>      xfrm: policy: avoid warning splat when merging nodes
>
>Fred Lotter (1):
>      nfp: flower: cmsg rtnl locks can timeout reify messages
>
>Fuqian Huang (1):
>      KVM: x86: work around leak of uninitialized stack contents
>
>Hans de Goede (1):
>      gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot option
>and blacklist
>
>Harish Bandi (1):
>      Bluetooth: hci_qca: disable irqs when spinlock is acquired
>
>Hui Peng (1):
>      rsi: fix a double free bug in rsi_91x_deinit()
>
>Igor Mammedov (1):
>      KVM: s390: kvm_s390_vm_start_migration: check dirty_bitmap
>before using it as target for memset()
>
>Ilya Maximets (1):
>      ixgbe: fix double clean of Tx descriptors with xdp
>
>Jan Stancek (1):
>      x86/timer: Force PIT initialization when !X86_FEATURE_ARAT
>
>Jeff Kirsher (1):
>      ixgbevf: Fix secpath usage for IPsec Tx offload
>
>Jian-Hong Pan (1):
>      Bluetooth: btrtl: Additional Realtek 8822CE Bluetooth devices
>
>John Fastabend (1):
>      net: sock_map, fix missing ulp check in sock hash case
>
>Jouni Malinen (1):
>      mac80211: Do not send Layer 2 Update frame before authorization
>
>Juliet Kim (1):
>      net/ibmvnic: free reset work of removed device from queue
>
>Ka-Cheong Poon (1):
>      net/rds: An rds_sock is added too early to the hash table
>
>Kent Gibson (2):
>      gpio: fix line flag validation in linehandle_create
>      gpio: fix line flag validation in lineevent_create
>
>Leonardo Bras (2):
>      netfilter: bridge: Drops IPv6 packets if IPv6 module is not loaded
>      netfilter: nft_fib_netdev: Terminate rule eval if protocol=3DIPv6
>and ipv6 module is disabled
>
>Linus Torvalds (2):
>      Revert "ext4: make __ext4_get_inode_loc plug"
>      Linux 5.3
>
>Luca Coelho (1):
>      iwlwifi: assign directly to iwl_trans->cfg in QuZ detection
>
>Maciej =C5=BBenczykowski (2):
>      net-ipv6: fix excessive RTF_ADDRCONF flag on ::1/128 local route
>(and others)
>      ipv6: addrconf_f6i_alloc - fix non-null pointer check to !IS_ERR()
>
>Mao Wenan (5):
>      net: sonic: return NETDEV_TX_OK if failed to map buffer
>      net: sonic: replace dev_kfree_skb in sonic_send_packet
>      sctp: change return type of sctp_get_port_local
>      sctp: remove redundant assignment when call sctp_get_port_local
>      sctp: destroy bucket if failed to bind addr
>
>Marcel Holtmann (1):
>      Revert "Bluetooth: validate BLE connection interval updates"
>
>Mario Limonciello (1):
>      Revert "Bluetooth: btusb: driver to enable the usb-wakeup feature"
>
>Mark-PK Tsai (1):
>      perf/hw_breakpoint: Fix arch_hw_breakpoint use-before-initialization
>
>Matthias Lange (1):
>      virtio_ring: fix unmap of indirect descriptors
>
>Maxime Ripard (1):
>      drm/modes: Make the whitelist more const
>
>Michael S. Tsirkin (2):
>      vhost: block speculation of translated descriptors
>      Revert "vhost: block speculation of translated descriptors"
>
>Michal Suchanek (1):
>      net/ibmvnic: Fix missing { in __ibmvnic_reset
>
>Moritz Fischer (1):
>      net: fixed_phy: Add forward declaration for struct gpio_desc;
>
>Navid Emamdoost (3):
>      Bluetooth: bpa10x: change return value
>      wimax: i2400: fix memory leak
>      net: qrtr: fix memort leak in qrtr_tun_write_iter
>
>Neal Cardwell (1):
>      tcp: fix tcp_ecn_withdraw_cwr() to clear TCP_ECN_QUEUE_CWR
>
>Nicolas Dichtel (5):
>      xfrm interface: avoid corruption on changelink
>      xfrm interface: ifname may be wrong in logs
>      xfrm interface: fix list corruption for x-netns
>      xfrm interface: fix management of phydev
>      bridge/mdb: remove wrong use of NLM_F_MULTI
>
>Pablo Neira Ayuso (2):
>      netfilter: ctnetlink: honor IPS_OFFLOAD flag
>      netfilter: nf_flow_table: set default timeout after successful inser=
tion
>
>Paolo Bonzini (1):
>      KVM: nVMX: handle page fault in vmread
>
>Paul Walmsley (1):
>      riscv: modify the Image header to improve compatibility with the
>ARM64 header
>
>Raag Jadav (1):
>      regulator: act8945a-regulator: fix ldo register addresses in set_mod=
e hook
>
>Radhey Shyam Pandey (1):
>      MAINTAINERS: add myself as maintainer for xilinx axiethernet driver
>
>Randy Dunlap (1):
>      lib/Kconfig: fix OBJAGG in lib/ menu structure
>
>Roman Gushchin (2):
>      kselftests: cgroup: add freezer mkdir test
>      cgroup: freezer: fix frozen state inheritance
>
>Sean Christopherson (1):
>      KVM: x86/mmu: Reintroduce fast invalidate/zap for flushing memslot
>
>Shmulik Ladkani (1):
>      net: gso: Fix skb_segment splat when splitting gso_size mangled
>skb having linear-headed frag_list
>
>Stanislaw Gruszka (4):
>      mt76: mt76x0e: don't use hw encryption for MT7630E
>      mt76: mt76x0e: disable 5GHz band for MT7630E
>      rt2x00: clear up IV's on key removal
>      Revert "rt2800: enable TX_PIN_CFG_LNA_PE_ bits per band"
>
>Stefan Chulski (1):
>      net: phylink: Fix flow control resolution
>
>Stefan Wahren (1):
>      Revert "mmc: bcm2835: Terminate timeout work synchronously"
>
>Steffen Klassert (1):
>      ixgbe: Fix secpath usage for IPsec TX offload.
>
>Steve Wahl (1):
>      x86/purgatory: Change compiler flags from -mcmodel=3Dkernel to
>-mcmodel=3Dlarge to fix kexec relocation errors
>
>Subash Abhinov Kasiviswanathan (1):
>      net: Fix null de-reference of device refcount
>
>Thomas Huth (1):
>      KVM: s390: Do not leak kernel stack data in the KVM_S390_INTERRUPT i=
octl
>
>Ulf Hansson (3):
>      Revert "mmc: tmio: move runtime PM enablement to the driver
>implementations"
>      mmc: tmio: Fixup runtime PM management during probe
>      mmc: tmio: Fixup runtime PM management during remove
>
>Vasily Khoruzhick (1):
>      drm/lima: fix lima_gem_wait() return value
>
>Ville Syrj=C3=A4l=C3=A4 (1):
>      drm/i915: Limit MST to <=3D 8bpc once again
>
>Wei Yongjun (1):
>      gpio: mockup: add missing single_release()
>
>Wen Huang (1):
>      mwifiex: Fix three heap overflow at parsing element in
>cfg80211_ap_settings
>
>Xin Long (3):
>      sctp: use transport pf_retrans in sctp_do_8_2_transport_strike
>      tipc: add NULL pointer check before calling kfree_rcu
>      sctp: fix the missing put_user when dumping transport thresholds
>
>Yang Yingliang (1):
>      tun: fix use-after-free when register netdev failed
>
>Yizhuo (1):
>      net: stmmac: dwmac-sun8i: Variable "val" in function
>sun8i_dwmac_set_syscon() could be uninitialized
>
>Yunfeng Ye (1):
>      genirq: Prevent NULL pointer dereference in resend_irqs()
>
>Zhu Yanjun (1):
>      forcedeth: use per cpu to collect xmit/recv statistics
>
>yongduan (1):
>      vhost: make sure log_num < in_num

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl1/GhsACgkQsjqdtxFL
KRUkowf+NFFFH6l9KoNgSxymU/B1aWZ7Gom5DXLj1pcR70F2Jg0orlpTtzU/9xqc
d3cft2k9tQjhoDvEqKRi92OL3ppp5GFc11fuZWxg88Acjii9A66sG19X6Ufa7MQG
2n5PJSoYfx06L5o1RVA73aWkp9xEqqruHa1kFape69/MVGx9esL5alSWFV7tIZYY
v21OtkdwgTDi55/am9ywCSMwjYdT6NSUEi0r3VKZPi0LHY2kWQcIPc3ZugFOICiR
vVM02EYsMZIorb8PdB9Da+73LzyVCXoyFGtjULXVXUpLCgyEmKwSN1eJdaLLD9TB
plDxmLTNL5S61cBqcHPsB+qIyekwog==
=nOCO
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
