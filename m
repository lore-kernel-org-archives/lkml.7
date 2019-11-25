Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DA3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D23207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574642833;
	bh=ur14J20FDHsRW5sZaN2ZdSgfa2m+xIhuSZNdqHjOuDU=;
	h=From:Date:Subject:To:List-ID:From;
	b=dLf2LcNNyB+JsGmDO67dFKIO2AvPjs9+/dRzVbp5sgbOuIWM6ooYB9fmWQrrLNhcP
	 0mjE8NjcDjuxZvZLmSRJf+YY1OJ/qYZA2Oo4btrV5TA3YHK4vHUAta1z0ZFgUTjVG1
	 vpoeq7gUGzCT4Z/+OV5pfinPlF8hOaqFKs226Kcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKYArM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 19:47:12 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46159 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfKYArL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:47:11 -0500
Received: by mail-lj1-f182.google.com with SMTP id e9so13673159ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 16:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=71i6XAnis5QNqOaioSv5KcdL5ixS6PrUa+11m9oCwL0=;
        b=AnaJqdL3xrMjoBYuzPxSxDGN9L22At6/OhtaED1hGCh5VmD3hjzbZMc0QcFJT2pK5S
         JgW3vZ3AqKgmvmhbzxbORuM3mLPm4cHCPmp7GSpHcxHcEUdaa8p9iAouZ41XtRs+WLtO
         Q+Li0hxOPbMqsgO+0yokb9k6FD4JqXryOqRSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=71i6XAnis5QNqOaioSv5KcdL5ixS6PrUa+11m9oCwL0=;
        b=OvA054/WqcaxUVIZ6hYyizfq0xKhO+2gkEKZ7JYK3hrRzXDHUBsM3LWp747xnYdZ+Q
         oZmhcisTbR7XDh08DdnUUDeCL+rqdp0TvqvHMJ/TaD6hlSU1puUpAeurhIVLbkNQJ7Q+
         BTSSC50w3avuyAwCEUlNHbdO56eeqki/GPumb/otRbqzfOocmTbHS0bk3LLz8P+dj9RY
         KyU2RHS6HFM7jEnYfV01YV7yWa4N8My5CTb1UkGNlc8gHFgF+/pZRFE1/Mgx1SRBhjWN
         jChLi1HhdLS4rrMwpBJYmI7XxulUP153h3QRUEY/9nX511JWPxgThpElwDZf09xlHE7T
         R+fw==
X-Gm-Message-State: APjAAAU1vOvFMCkspdyPz4HXJebfDBI57pZDh8PUKCOFbn5zVDpS9KNO
        8CZWcb8qGBEzBSIW8Vobx1lP83UbEKo=
X-Google-Smtp-Source: APXvYqxn1oZTLiQ9t6sJRMyNsCI3ujWCqWHkhqsWrzHblytpCvLTKTv8xV+haThHr/EHrlKH94LgDw==
X-Received: by 2002:a2e:8188:: with SMTP id e8mr19969845ljg.152.1574642828606;
        Sun, 24 Nov 2019 16:47:08 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id k10sm2620481lfo.76.2019.11.24.16.47.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2019 16:47:07 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id e9so13673106ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 16:47:07 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr6900799ljj.1.1574642827345;
 Sun, 24 Nov 2019 16:47:07 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Nov 2019 16:46:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmzaD=BZ1hjUYu+RTnSGDLfCRwCdg99GeQpCjEwo9uzw@mail.gmail.com>
Message-ID: <CAHk-=wjmzaD=BZ1hjUYu+RTnSGDLfCRwCdg99GeQpCjEwo9uzw@mail.gmail.com>
Subject: Linux 5.4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not a lot happened this last week, which is just how I like it. And as
expected, most of the pull requests I got were for the 5.5 merge
window, which I'll obviously start working through tomorrow.

What little there is here is mostly some networking updates (mix of
network drivers and core networking), and some minor GPU driver
updates. Other than that it's a small collection of random other
things all over. The appended shortlog is small enough that you might
as well just scroll through it.

Anyway, this obviously opens the merge window for 5.5. It's not ideal
timing with Thanksgiving week coming up, but it hopefully shouldn't be
too much of an issue. If I fall behind (not because I'm all that big
of a fan of the indiscriminate and relentless turkey-killing holiday)
it's because we've got all three kids back for the holiday, and I
might push some ot the merging to the second week as a result. We'll
see what happens.

Go do the testing thing.

               Linus

---

Adi Suresh (1):
      gve: fix dma sync bug where not all pages synced

Aditya Pakki (1):
      net: atm: Reduce the severity of logging in unlink_clip_vcc

Alex Deucher (4):
      drm/amdgpu: remove experimental flag for Navi14
      drm/amdgpu: disable gfxoff when using register read interface
      drm/amdgpu: disable gfxoff on original raven
      Revert "drm/amd/display: enable S/G for RAVEN chip"

Alex Vesker (3):
      net/mlx5: DR, Fix invalid EQ vector number on CQ creation
      net/mlx5: DR, Skip rehash for tables with byte mask zero
      net/mlx5: DR, Limit STE hash table enlarge based on bytemask

Andrey Ryabinin (1):
      mm/ksm.c: don't WARN if page is still mapped in remove_stable_node()

Chris Wilson (4):
      drm/i915/pmu: "Frequency" is reported as accumulated cycles
      drm/i915/userptr: Try to acquire the page lock around set_page_dirty(=
)
      drm/i915: Protect request peeking with RCU
      drm/i915/fbdev: Restore physical addresses for fb_mmap()

Chuhong Yuan (2):
      phy: mdio-sun4i: add missed regulator_disable in remove
      net: fec: fix clock count mis-match

Corinna Vinschen (1):
      r8169: disable TSO on a single version of RTL8168c to fix performance

Dan Carpenter (2):
      bpf, offload: Unlock on error in bpf_offload_dev_create()
      net: rtnetlink: prevent underflows in do_setvfinfo()

David Hildenbrand (1):
      mm/memory_hotplug: don't access uninitialized memmaps in
shrink_zone_span()

David Howells (1):
      afs: Fix missing timeout reset

David S. Miller (1):
      Revert "mdio_bus: fix mdio_register_device when RESET_CONTROLLER
is disabled"

Davide Caratti (1):
      net/sched: act_pedit: fix WARN() in the traffic path

Eli Cohen (2):
      net/mlx5e: Fix error flow cleanup in mlx5e_tc_tun_create_header_ipv4/=
6
      net/mlx5e: Fix ingress rate configuration for representors

Eran Ben Elisha (2):
      net/mlx5e: Do not use non-EXT link modes in EXT mode
      net/mlxfw: Verify FSM error code translation doesn't exceed array siz=
e

Eric Dumazet (1):
      net-sysfs: fix netdev_queue_add_kobject() breakage

Evan Quan (2):
      drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on unsupported AS=
ICs
      drm/amd/powerplay: correct fine grained dpm force level setting

Florian Westphal (1):
      udp: drop skb extensions before marking skb stateless

Geert Uytterhoeven (2):
      mdio_bus: Fix init if CONFIG_RESET_CONTROLLER=3Dn
      mdio_bus: Fix init if CONFIG_RESET_CONTROLLER=3Dn

Haiyang Zhang (2):
      hv_netvsc: Fix offset usage in netvsc_send_table()
      hv_netvsc: Fix send_table offset in case of a host bug

Halil Pasic (1):
      virtio_ring: fix return code on DMA mapping fails

Hangbin Liu (1):
      ipv6/route: return if there is no fib_nh_gw_family

Hans de Goede (1):
      gpiolib: acpi: Add Terra Pad 1061 to the run_edge_events_on_boot_blac=
klist

Hayes Wang (1):
      r8152: avoid to call napi_disable twice

Huazhong Tan (1):
      net: hns3: fix a wrong reset interrupt status mask

Ivan Khoronzhuk (1):
      taprio: don't reject same mqprio settings

Joseph Qi (1):
      Revert "fs: ocfs2: fix possible null-pointer dereferences in
ocfs2_xa_prepare_entry()"

Jouni Hogander (1):
      net-sysfs: Fix reference count leak in rx|netdev_queue_add_kobject

Julian Wiedmann (2):
      s390/qeth: fix potential deadlock on workqueue flush
      s390/qeth: return proper errno on IO error

Juliet Kim (2):
      Revert "net/ibmvnic: Fix EOI when running in XIVE mode"
      net/ibmvnic: Ignore H_FUNCTION return from H_EOI to tolerate XIVE mod=
e

Laura Abbott (1):
      tools: gpio: Correctly add make dependencies for gpio_utils

Laurent Vivier (1):
      virtio_console: allocate inbufs in add_port() only if it is needed

Linus Torvalds (1):
      Linux 5.4

Luc Van Oostenryck (1):
      fork: fix pidfd_poll()'s return type

Luigi Rizzo (1):
      net/mlx4_en: fix mlx4 ethtool -N insertion

Lyude Paul (1):
      Revert "Input: synaptics - enable RMI mode for X1 Extreme 2nd Generat=
ion"

Maciej =C5=BBenczykowski (1):
      net-ipv6: IPV6_TRANSPARENT - check NET_RAW prior to NET_ADMIN

Maor Gottlieb (1):
      net/mlx5: Fix auto group size calculation

Marc Dionne (2):
      afs: Fix possible assert with callbacks from yfs servers
      afs: Fix large file support

Marcelo Ricardo Leitner (1):
      net/ipv4: fix sysctl max for fib_multipath_hash_policy

Marek Beh=C3=BAn (1):
      mdio_bus: fix mdio_register_device when RESET_CONTROLLER is disabled

Marina Varshaver (1):
      net/mlx5e: Add missing capability bit check for IP-in-IP

Martin Habets (1):
      sfc: Only cancel the PPS workqueue if it exists

Matthew Auld (1):
      drm/i915: make pool objects read-only

Maxime Bizon (1):
      cramfs: fix usage on non-MTD device

Michael Heimpold (1):
      net: qca_spi: fix receive buffer size check

Michael S. Tsirkin (1):
      virtio_balloon: fix shrinker scan number of pages

Oliver Neukum (1):
      nfc: port100: handle command failure cleanly

Pankaj Sharma (2):
      can: m_can_platform: set net_device structure as driver data
      can: m_can_platform: remove unnecessary m_can_class_resume() call

Pavel Tatashin (2):
      arm64: uaccess: Ensure PAN is re-enabled after unhandled uaccess faul=
t
      arm64: uaccess: Remove uaccess_*_not_uao asm macros

Petr Machata (1):
      mlxsw: spectrum_router: Fix determining underlay for a GRE tunnel

Prashant Malani (1):
      r8152: Re-order napi_disable in rtl8152_close

Rafael J. Wysocki (1):
      PM: QoS: Invalidate frequency QoS requests after removal

Roi Dayan (1):
      net/mlx5e: Fix set vf link state error flow

Russell King (2):
      net: phylink: update documentation on create and destroy
      net: phylink: fix link mode modification in PHY mode

Shani Shapp (1):
      net/mlx5: Update the list of the PCI supported devices

Stefan Wahren (1):
      net: qca_spi: Move reset_count to struct qcaspi

Stefano Garzarella (1):
      MAINTAINERS: Add myself as maintainer of virtio-vsock

Sun Ke (1):
      nbd:fix memory leak in nbd_get_socket()

Tariq Toukan (1):
      net/mlx4_en: Fix wrong limitation for number of TX rings

Thierry Reding (2):
      gpio: max77620: Fixup debounce delays
      gpio: bd70528: Use correct unit for debounce times

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Don't oops in dumb_create ioctl if we have no crtcs
      drm/i915: Preload LUTs if the hw isn't currently using them

Vlad Buslov (1):
      net/mlx5e: Reorder mirrer action parsing to check for encap first

Wei Wang (1):
      virtio_balloon: fix shrinker count

Willem de Bruijn (1):
      net/tls: enable sk_msg redirect to tls socket egress

Xin Long (1):
      net: sched: ensure opts_len <=3D IP_TUNNEL_OPTS_MAX in act_tunnel_key

Zhu Yanjun (1):
      MAINTAINERS: forcedeth: Change Zhu Yanjun's email address
