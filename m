Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0607F20643
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/cL5f/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDLLOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:14:01 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33885 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:14:01 -0400
Received: by mail-wr1-f54.google.com with SMTP id p10so11453538wrq.1;
        Fri, 12 Apr 2019 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZwnreY9Virg776q245sNEhlR7y/TfuwZYc0qQtIK70=;
        b=K/cL5f/5R8Z3iBIfn/xuEYd0Ay+oUgdCkr9mLoQqW7TLo0lU4fXIx4v6/zUqYJkjV5
         VpC8EhrW2DqVa0tnBZZktYMH1dAR67P0RcqtylHXNrjrNCGoCRTT3bHQbloDQuH/pj0x
         YrJx0NFGdhAcNtLL42wnKO2VH90DqB1LLwhaEYN4kQu9gEzyKj9W2hxPgyrLQxp1rYpn
         48Z+2ePRK6d5uYxVTPTEDRkXaypVFHWPY874F9BnTSGmek6x5K+XTvrBND7hWhNbLpCy
         zCuESMTox4Qtzra4vjzuE4xEPp/uUUfmNzMCdTXvWfmEJ817MFfbDetSDinGdSNGz5+Z
         7aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZwnreY9Virg776q245sNEhlR7y/TfuwZYc0qQtIK70=;
        b=MvuFlXFYGR+m5MJGZeXS8KrkwKA/AENr+eBcdC9tw2/XowQGnTfJH48YmS0uz/xCCB
         tJVvG5skbue3mmaWb/dEmSxeo9w96yy11Uswc6HuRRoeKFo6eS5au9cv4v1KZsv8gXPV
         EOdbuYa26LgVFJw0/yTe3zpL7upJchayFpmQBn0uPh+rPla1/YnFd1YxqOIRihb0zMxF
         cFJ7Pypt1KDKmw7puByrJKGBbx6a6tpbQjgCu0MeFJxa1v0wZ3D9fXGEDbXosJeHv7Mx
         F9CkXHFPXOamALQ/IeYiBZoPVKZKOm6wo2GdzQCGdULhiyYiv+2hd5OlzG8Taw4slINQ
         Z+LA==
X-Gm-Message-State: APjAAAW2+cpJo9r0nxdH5DTscX0yLUuEetPvF7nld+0/Ps4Q8RJOqKLI
        69cWXqbg7oPzJONuGIe5qI4=
X-Google-Smtp-Source: APXvYqx7epSItcGrHjc0lS/6AG86LNU+MuRmSc5gNlaVYMI10YPlY5WPtt6L2En3v4VRlT3yjv0z0g==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr12864555wrw.68.1555067637394;
        Fri, 12 Apr 2019 04:13:57 -0700 (PDT)
Received: from X555LD ([2a02:85f:510:b900:bdc2:4688:e9a7:8693])
        by smtp.gmail.com with ESMTPSA id r196sm10935189wmf.22.2019.04.12.04.13.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Apr 2019 04:13:56 -0700 (PDT)
Date:   Fri, 12 Apr 2019 14:13:52 +0300
From:   "Leonidas P. Papadakos" <papadakospan@gmail.com>
Subject: RE: [PATCH 1/2] stmmac: introduce flag to dynamically disable TX
 offload for rockchip devices
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>,
        Christoph =?iso-8859-1?q?M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Message-Id: <1555067632.1216.0@gmail.com>
In-Reply-To: <78EB27739596EE489E55E81C33FEC33A0B4566A9@DE02WEMBXB.internal.synopsys.com>
References: <20190401181840.31255-1-papadakospan@gmail.com>
        <9d65a22a-2288-dc53-0059-ec4a31424dd8@arm.com> <2312344.mOsv7YkeBG@diego>
        <9EC67532-2D43-4AAD-BFA7-8B6797067427@theobroma-systems.com>
        <78EB27739596EE489E55E81C33FEC33A0B421348@de02wembxa.internal.synopsys.com>
        <4a9839d6-3d90-4354-7b64-78d5c1126e99@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B423811@de02wembxa.internal.synopsys.com>
        <c45d05f1-47b0-89d5-886d-d456d0111b7a@arm.com> <1554245296.1271.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4254A0@de02wembxa.internal.synopsys.com>
        <1554305721.1328.0@gmail.com> <1554306954.1328.1@gmail.com>
        <c863f88a-65e2-4093-7cc1-f37e4443b871@arm.com>
        <78EB27739596EE489E55E81C33FEC33A0B44985F@DE02WEMBXB.internal.synopsys.com>
        <1554488052.1193.1@gmail.com> <85c1d945-d49b-3350-6ff4-a058c5a8c1d7@arm.com>
        <1554489537.1199.0@gmail.com> <1555016970.28872.0@gmail.com>
        <78EB27739596EE489E55E81C33FEC33A0B4566A9@DE02WEMBXB.internal.synopsys.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you please share the stacktrace here ? I can't access pastebin=20
> due to
> corporate policy.

This happens seconds after I change the MTU. I remember it used to=20
happen with 1500 as well, before the gmac tweaks. It makes sense

[  111.111639] NETDEV WATCHDOG: eth0 (rk_gmac-dwmac): transmit queue 0=20
timed out
[  111.112374] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:461=20
dev_watchdog+0x2b8/0x2c0
[  111.113112] Modules linked in: lz4 lz4_compress zram rockchipdrm=20
realtek analogix_dp dw_mipi_dsi dw_hdmi cec rc_core dwmac_rk=20
stmmac_platform drm_kms_helper stmmac rtc_rk808 drm rockchip_thermal=20
drm_panel_orientation_quirks dw_wdt syscopyarea sysfillrect sysimgblt=20
fb_sys_fops ip6t_REJECT nf_reject_ipv6 xt_hl ip6t_rt ipt_REJECT=20
xt_recent xt_multiport xt_comment xt_limit xt_addrtype xt_conntrack=20
ip6table_filter ip6_tables nf_conntrack_netbios_ns=20
nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack=20
nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter bpfilter tcp_bbr tcp_lp=20
nfsd
[  111.117725] CPU: 0 PID: 0 Comm: swapper/0 Not tainted=20
5.1.0-rc4-1-ARCH #1
[  111.118326] Hardware name: Firefly roc-rk3328-cc (DT)
[  111.118778] pstate: 20000005 (nzCv daif -PAN -UAO)
[  111.119204] pc : dev_watchdog+0x2b8/0x2c0
[  111.119568] lr : dev_watchdog+0x2b8/0x2c0
[  111.119928] sp : ffff000010003d50
[  111.120223] x29: ffff000010003d50 x28: ffff00001166a000
[  111.120695] x27: 0000000000000140 x26: 00000000ffffffff
[  111.121166] x25: 0000000000000000 x24: 0000000000000000
[  111.121635] x23: ffff8000383c4480 x22: 0000000000000001
[  111.122104] x21: ffff000011687000 x20: ffff8000383c4000
[  111.122579] x19: 0000000000000000 x18: 0000000000000010
[  111.123052] x17: 0000000000000000 x16: 0000000000000000
[  111.123520] x15: ffffffffffffffff x14: ffff00001168d6c8
[  111.123995] x13: ffff000090003a67 x12: ffff000010003a6f
[  111.124470] x11: ffff0000116b7000 x10: ffff0000100039f0
[  111.124938] x9 : 00000000ffffffd0 x8 : ffff0000108395d0
[  111.125411] x7 : 0000000000000179 x6 : 0000000000000001
[  111.125885] x5 : 0000000000000000 x4 : 0000000000000001
[  111.126359] x3 : 0000000000000000 x2 : ffff00001168ea58
[  111.126828] x1 : 576938cacdaf1700 x0 : 0000000000000000
[  111.127309] Call trace:
[  111.127533]  dev_watchdog+0x2b8/0x2c0
[  111.127864]  call_timer_fn+0x34/0x170
[  111.128195]  expire_timers.part.5+0xc8/0x158
[  111.128578]  run_timer_softirq+0xd4/0x218
[  111.128940]  __do_softirq+0x130/0x330
[  111.129273]  irq_exit+0xc0/0xd0
[  111.129560]  __handle_domain_irq+0x70/0xc0
[  111.129924]  gic_handle_irq+0x58/0xa8
[  111.130255]  el1_irq+0xb8/0x140
[  111.130542]  arch_cpu_idle+0x3c/0x1c8
[  111.130874]  default_idle_call+0x38/0x40
[  111.131226]  do_idle+0x23c/0x2b8
[  111.131513]  cpu_startup_entry+0x2c/0x30
[  111.131868]  rest_init+0xb8/0xc4
[  111.132161]  arch_call_rest_init+0x14/0x1c
[  111.132529]  start_kernel+0x484/0x4b0
[  111.132862] ---[ end trace 7efe323f823d5938 ]---
[  111.133352] rk_gmac-dwmac ff540000.ethernet eth0: Reset adapter.
[  111.134637] rk_gmac-dwmac ff540000.ethernet eth0: Link is Down
[  111.138412] RTL8211E Gigabit Ethernet stmmac-0:00: attached PHY=20
driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=3Dstmmac-0:00,=20
irq=3DPOLL)
[  111.151252] rk_gmac-dwmac ff540000.ethernet eth0: No Safety Features=20
support found
[  111.151962] rk_gmac-dwmac ff540000.ethernet eth0: PTP not supported=20
by HW
[  115.352150] rk_gmac-dwmac ff540000.ethernet eth0: Link is Up -=20
1Gbps/Full - flow control rx/tx
[  115.352965] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

I also have another one that happened while wireguard was loaded:
I brought down eth0. changed the mtu, and brought ot up again.

=CE=91=CF=80=CF=81 11 16:06:11.411210 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Down
=CE=91=CF=80=CF=81 11 16:06:38.621145 renegade kernel: RTL8211E Gigabit Eth=
ernet=20
stmmac-0:00: attached PHY driver [RTL8211E Gigabit Ethernet]=20
(mii_bus:phy_addr=3Dstmmac-0:00, irq=3DPOLL)
=CE=91=CF=80=CF=81 11 16:06:38.641228 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: No Safety Features support found
=CE=91=CF=80=CF=81 11 16:06:38.642602 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: PTP not supported by HW
=CE=91=CF=80=CF=81 11 16:06:45.901192 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
=CE=91=CF=80=CF=81 11 16:06:45.902237 renegade kernel: IPv6:=20
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
=CE=91=CF=80=CF=81 11 16:08:41.781166 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Down
=CE=91=CF=80=CF=81 11 16:08:54.791163 renegade kernel: RTL8211E Gigabit Eth=
ernet=20
stmmac-0:00: attached PHY driver [RTL8211E Gigabit Ethernet]=20
(mii_bus:phy_addr=3Dstmmac-0:00, irq=3DPOLL)
=CE=91=CF=80=CF=81 11 16:08:54.801388 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: No Safety Features support found
=CE=91=CF=80=CF=81 11 16:08:54.802780 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: PTP not supported by HW
=CE=91=CF=80=CF=81 11 16:09:02.061182 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
=CE=91=CF=80=CF=81 11 16:09:02.062327 renegade kernel: IPv6:=20
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
=CE=91=CF=80=CF=81 11 16:09:03.214823 renegade kernel: ------------[ cut he=
re=20
]------------
=CE=91=CF=80=CF=81 11 16:09:03.215300 renegade kernel: refcount_t: underflo=
w;=20
use-after-free.
=CE=91=CF=80=CF=81 11 16:09:03.215472 renegade kernel: WARNING: CPU: 2 PID:=
 0 at=20
lib/refcount.c:190 refcount_sub_and_test_checked+0xc8/0xd8
=CE=91=CF=80=CF=81 11 16:03:25.240754 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet: TX Checksum insertion supported
=CE=91=CF=80=CF=81 11 16:03:25.242650 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet: Wake-Up On Lan supported
=CE=91=CF=80=CF=81 11 16:03:25.244155 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet: Normal descriptors
=CE=91=CF=80=CF=81 11 16:03:25.247336 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet: Ring mode enabled
=CE=91=CF=80=CF=81 11 16:03:25.248837 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet: Enable RX Mitigation via HW Watchdog Timer
=CE=91=CF=80=CF=81 11 16:03:25.351198 renegade kernel: rockchip-drm=20
display-subsystem: [drm:rockchip_drm_platform_probe [rockchipdrm]]=20
*ERROR* No available vop found for display-subsy>
=CE=91=CF=80=CF=81 11 16:03:25.391228 renegade kernel: libphy: stmmac: prob=
ed
=CE=91=CF=80=CF=81 11 16:03:25.391708 renegade kernel: RTL8211E Gigabit Eth=
ernet=20
stmmac-0:00: attached PHY driver [RTL8211E Gigabit Ethernet]=20
(mii_bus:phy_addr=3Dstmmac-0:00, irq=3DPOLL)
=CE=91=CF=80=CF=81 11 16:03:25.393255 renegade kernel: RTL8211E Gigabit Eth=
ernet=20
stmmac-0:01: attached PHY driver [RTL8211E Gigabit Ethernet]=20
(mii_bus:phy_addr=3Dstmmac-0:01, irq=3DPOLL)
=CE=91=CF=80=CF=81 11 16:03:25.541243 renegade kernel: RTL8211E Gigabit Eth=
ernet=20
stmmac-0:00: attached PHY driver [RTL8211E Gigabit Ethernet]=20
(mii_bus:phy_addr=3Dstmmac-0:00, irq=3DPOLL)
=CE=91=CF=80=CF=81 11 16:03:25.561202 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: No Safety Features support found
=CE=91=CF=80=CF=81 11 16:03:25.562458 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: PTP not supported by HW
=CE=91=CF=80=CF=81 11 16:03:25.563674 renegade kernel: A link change reques=
t failed=20
with some changes committed already. Interface eth0 may have been left=20
with an inconsistent configu>
=CE=91=CF=80=CF=81 11 16:03:26.841235 renegade kernel: zram: Added device: =
zram0
=CE=91=CF=80=CF=81 11 16:03:26.941263 renegade kernel: random: crng init do=
ne
=CE=91=CF=80=CF=81 11 16:03:26.941801 renegade kernel: random: 7 urandom wa=
rning(s)=20
missed due to ratelimiting
=CE=91=CF=80=CF=81 11 16:03:27.571191 renegade kernel: phy=20
phy-ff450000.syscon:usb2-phy@100.0: charger =3D USB_DCP_CHARGER
=CE=91=CF=80=CF=81 11 16:03:27.921230 renegade kernel: zram0: detected capa=
city=20
change from 0 to 1025568768
=CE=91=CF=80=CF=81 11 16:03:28.813838 renegade kernel: Adding 1001528k swap=
 on=20
/dev/zram0.  Priority:32767 extents:1 across:1001528k SSDscFS
=CE=91=CF=80=CF=81 11 16:03:32.861210 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
=CE=91=CF=80=CF=81 11 16:03:32.862527 renegade kernel: IPv6:=20
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
=CE=91=CF=80=CF=81 11 16:05:25.932408 renegade kernel: wireguard: loading=20
out-of-tree module taints kernel.
=CE=91=CF=80=CF=81 11 16:05:25.936144 renegade kernel: wireguard: WireGuard=
=20
0.0.20190406 loaded. See www.wireguard.com for information.
=CE=91=CF=80=CF=81 11 16:05:25.936467 renegade kernel: wireguard: Copyright=
 (C)=20
2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
=CE=91=CF=80=CF=81 11 16:05:26.451886 renegade kernel: NFSD: starting 90-se=
cond=20
grace period (net f0000041)
=CE=91=CF=80=CF=81 11 16:05:27.252030 renegade kernel: nf_conntrack: defaul=
t=20
automatic helper assignment has been turned off for security reasons=20
and CT-based  firewall rule not found>
=CE=91=CF=80=CF=81 11 16:06:11.411210 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Down
=CE=91=CF=80=CF=81 11 16:06:38.621145 renegade kernel: RTL8211E Gigabit Eth=
ernet=20
stmmac-0:00: attached PHY driver [RTL8211E Gigabit Ethernet]=20
(mii_bus:phy_addr=3Dstmmac-0:00, irq=3DPOLL)
=CE=91=CF=80=CF=81 11 16:06:38.641228 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: No Safety Features support found
=CE=91=CF=80=CF=81 11 16:06:38.642602 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: PTP not supported by HW
=CE=91=CF=80=CF=81 11 16:06:45.901192 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
=CE=91=CF=80=CF=81 11 16:06:45.902237 renegade kernel: IPv6:=20
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
=CE=91=CF=80=CF=81 11 16:08:41.781166 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Down
=CE=91=CF=80=CF=81 11 16:08:54.791163 renegade kernel: RTL8211E Gigabit Eth=
ernet=20
stmmac-0:00: attached PHY driver [RTL8211E Gigabit Ethernet]=20
(mii_bus:phy_addr=3Dstmmac-0:00, irq=3DPOLL)
=CE=91=CF=80=CF=81 11 16:08:54.801388 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: No Safety Features support found
=CE=91=CF=80=CF=81 11 16:08:54.802780 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: PTP not supported by HW
=CE=91=CF=80=CF=81 11 16:09:02.061182 renegade kernel: rk_gmac-dwmac=20
ff540000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
=CE=91=CF=80=CF=81 11 16:09:02.062327 renegade kernel: IPv6:=20
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
=CE=91=CF=80=CF=81 11 16:09:03.214823 renegade kernel: ------------[ cut he=
re=20
]------------
=CE=91=CF=80=CF=81 11 16:09:03.215300 renegade kernel: refcount_t: underflo=
w;=20
use-after-free.
=CE=91=CF=80=CF=81 11 16:09:03.215472 renegade kernel: WARNING: CPU: 2 PID:=
 0 at=20
lib/refcount.c:190 refcount_sub_and_test_checked+0xc8/0xd8
=CE=91=CF=80=CF=81 11 16:09:03.215603 renegade kernel: Modules linked in:=20
iptable_nat ipt_MASQUERADE wireguard(O) ip6_udp_tunnel udp_tunnel lz4=20
lz4_compress zram realtek rockchipdrm a>
=CE=91=CF=80=CF=81 11 16:09:03.215845 renegade kernel: CPU: 2 PID: 0 Comm:=20
swapper/2 Tainted: G           O      5.1.0-rc4-1-ARCH #1
=CE=91=CF=80=CF=81 11 16:09:03.215959 renegade kernel: Hardware name: Firef=
ly=20
roc-rk3328-cc (DT)
=CE=91=CF=80=CF=81 11 16:09:03.216060 renegade kernel: pstate: 80000005 (Nz=
cv daif=20
-PAN -UAO)
=CE=91=CF=80=CF=81 11 16:09:03.216160 renegade kernel: pc :=20
refcount_sub_and_test_checked+0xc8/0xd8
=CE=91=CF=80=CF=81 11 16:09:03.216256 renegade kernel: lr :=20
refcount_sub_and_test_checked+0xc8/0xd8
=CE=91=CF=80=CF=81 11 16:09:03.216344 renegade kernel: sp : ffff000010013ca=
0
=CE=91=CF=80=CF=81 11 16:09:03.216434 renegade kernel: x29: ffff000010013ca=
0 x28:=20
ffff80003406c8c0
=CE=91=CF=80=CF=81 11 16:09:03.216550 renegade kernel: x27: ffff80002792d10=
0 x26:=20
ffff80003406c8c0
=CE=91=CF=80=CF=81 11 16:09:03.216648 renegade kernel: x25: 000000000000006=
0 x24:=20
0000000000000000
=CE=91=CF=80=CF=81 11 16:09:03.216734 renegade kernel: x23: 000000000000014=
b x22:=20
0000000000000001
=CE=91=CF=80=CF=81 11 16:09:03.216826 renegade kernel: x21: 000000000000000=
4 x20:=20
0000000000000000
=CE=91=CF=80=CF=81 11 16:09:03.216922 renegade kernel: x19: ffff80002792d10=
0 x18:=20
0000000000000010
=CE=91=CF=80=CF=81 11 16:09:03.217014 renegade kernel: x17: 000000000000000=
0 x16:=20
0000000000000000
=CE=91=CF=80=CF=81 11 16:09:03.217109 renegade kernel: x15: fffffffffffffff=
f x14:=20
0720072007200720
=CE=91=CF=80=CF=81 11 16:09:03.217197 renegade kernel: x13: 072007200720072=
0 x12:=20
0720072007200720
=CE=91=CF=80=CF=81 11 16:09:03.217283 renegade kernel: x11: 072007200720072=
0 x10:=20
0720072007200720
=CE=91=CF=80=CF=81 11 16:09:03.217427 renegade kernel: x9 : 072007200720072=
0 x8 :=20
072007200720072e
=CE=91=CF=80=CF=81 11 16:09:03.217537 renegade kernel: x7 : 000000000000018=
4 x6 :=20
0000000000000001
=CE=91=CF=80=CF=81 11 16:09:03.217637 renegade kernel: x5 : 000000000000000=
0 x4 :=20
0000000000000001
=CE=91=CF=80=CF=81 11 16:09:03.217740 renegade kernel: x3 : 000000000000000=
7 x2 :=20
0000000000000007
=CE=91=CF=80=CF=81 11 16:09:03.217833 renegade kernel: x1 : 576938cacdaf170=
0 x0 :=20
0000000000000000
=CE=91=CF=80=CF=81 11 16:09:03.217928 renegade kernel: Call trace:
=CE=91=CF=80=CF=81 11 16:09:03.218016 renegade kernel: =20
refcount_sub_and_test_checked+0xc8/0xd8

> If it's a queue timeout then please share your "dmesg | grep -i=20
> stmmac"
> since boot.

The only time I see it mentioned is basically when the link is brought=20
up

$ dmesg | grep -i stmmac
[  +0,134955] libphy: stmmac: probed
[  +0,000352] RTL8211E Gigabit Ethernet stmmac-0:00: attached PHY=20
driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=3Dstmmac-0:00,=20
irq=3DPOLL)
[  +0,001253] RTL8211E Gigabit Ethernet stmmac-0:01: attached PHY=20
driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=3Dstmmac-0:01,=20
irq=3DPOLL)
[  +0,256702] RTL8211E Gigabit Ethernet stmmac-0:00: attached PHY=20
driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=3Dstmmac-0:00,=20
irq=3DPOLL)

> This is not a workaround neither an issue. It's well stablished that=20
> PBL
> setting interferes with COE so one must choose a setting that depends=20
> on
> FIFO size. I would like to make it automatic in the driver but I=20
> didn't
> have the time to submit a patch yet, sorry.
>=20
> Thanks,
> Jose Miguel Abreu

When you say FIFO size, is that related to the tx/rx_delay?

=

