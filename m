Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB81C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B7920811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Obr4e2HE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfCSR3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:29:43 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44480 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:29:43 -0400
Received: by mail-pg1-f169.google.com with SMTP id i2so829328pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=HYcpkctsuO8qvwPLbJucWyAWfpl5dGyDKK+VtkhUd3k=;
        b=Obr4e2HE5Vapn8RWTwwooJ4rC3w2ftk4xujKibAEbT9Wkwj+LmP9scwiZsA3lM3Bpp
         MN4GI/SlnfH29NWJokie5cIvydALZo++kU+dQzYCFHfukwfoIV5mnmv6qfWutmZuS9g1
         x/T9ylisw5JxGlcoXPLF0dBDIyvCioZ7vwImu/K4wzM9UPCJg8bzL+teWSGWytRYty5H
         WFddHDqluLqOizoiN46gY4IJSnJ9bwTtPgkZGxSsmMd23qZi5o19ORLZoHYfsPFDGoOg
         xTn+3ZqoWkq6UrklwqVJyYGDkVmQQo1UR4vmEY39Tn4uDmnWqjz4fQN28WQamOMut+TO
         nAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=HYcpkctsuO8qvwPLbJucWyAWfpl5dGyDKK+VtkhUd3k=;
        b=PaeQ3uNfhvfBVI4WyuwpckxJ0923yz9dPfnL861aEUPZm0eaMLGXpN4pDIv1fLId4B
         8FoSWNPmj60n6xtuTXBdH3bZodcA4Yh+ykLyPiCLa/LuLmG+MEzjzNZuauiNM5Xj7efM
         sba1018VYfOM0PYPiD5ILyTScuSdOjkhpByXb6ESpdM96boAg07V4KySM/zYAwNOMsVY
         zGgkP/FfqErRR/KBTMXhgoDVBvpOObQcJ+JmNoDD37K+hD/65ZEqgaD73hKQBr8hU672
         b9mOFw7Vzj/fWvt3syMkCZnBUWIK50+Rpw7nV0Fv65Km0Z6euBgNUz/FLNz9W//qb9AZ
         cklQ==
X-Gm-Message-State: APjAAAV+0jOimzpDqIZ5G/KOvOvlcKfki+ojtz7WlLwciqUn9Nyrz1rT
        eBOaZBgCL//OSh7CUCmuTwky26LJ/9qq1Q==
X-Google-Smtp-Source: APXvYqy+d0hSY1swV/H8RCXOSSe2aAqooAkwRe7KG9X+TpD/6Rs8vCGaLR13QK+4ftIFqjqgP82vCw==
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr3369190plf.320.1553016582734;
        Tue, 19 Mar 2019 10:29:42 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b138sm24849693pfb.48.2019.03.19.10.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 10:29:42 -0700 (PDT)
Date:   Tue, 19 Mar 2019 10:29:38 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 5.0.0
Message-ID: <20190319102938.61947769@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iproute2 5.0 has been released. Sorry for the delay.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.0.0.tar.gz

Repository for upcoming release: 5.1
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future releases:
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

TL;DR  notes:
      - Decrepit protocols no longer supported: IPX, Decnet
      - many json formatting fixes
      - tc gred fixes
      - ss buffering fixes
      - musl libc build fixes
      - bridge fdb related fixes
 
Report problems (or enhancements) to the netdev@vger.kernel.org mailing list.

---     

Adi Nissim (1):
      tc: m_tunnel_key: Allow key-less tunnels

Amritha Nambiar (2):
      tc: flower: Classify packets based port ranges
      tc: flower: Classify packets based port ranges

Chris Mi (1):
      libnetlink: linkdump_req: AF_PACKET family also expects ext_filter_mask

David Ahern (24):
      ip rule: Add ipproto and port range to filter list
      Update kernel headers
      Revert "rdma: make local functions static"
      Revert "tc: flower: Classify packets based port ranges"
      Update kernel headers
      Update kernel headers
      libnetlink: dump extack string in done message
      libnetlink: Use NLMSG_LENGTH to set nlmsg_len
      libnetlink: linkdump_req: Only AF_UNSPEC family expects an ext_filter_mask
      ip route: Remove rtnl_rtcache_request
      ip route: Add protocol, table id and device to dump request
      mroute: fix up family handling
      mroute: Add table id attribute for kernel side filtering
      ip address: Split ip_linkaddr_list into link and addr functions
      ip address: Set device index in dump request
      ip bridge: Set NETLINK_GET_STRICT_CHK on socket
      ip route: Rename do_ipv6 to dump_family
      neighbor: Add support for protocol attribute
      libnetlink: Add filter function to rtnl_neighdump_req
      ip neigh: Convert do_show_or_flush to use rtnl_neighdump_req
      bridge: Update fdb show to use rtnl_neighdump_req
      libnetlink: Add RTNL_HANDLE_F_STRICT_CHK flag
      bridge: fdb: Fix filtering with strict checking disabled
      libnetlink: linkdump_req is done for AF_BRIDGE as well

Dmitry V. Levin (1):
      configure: fix typo in check_xt_old_internal_h

Dmytro Linkin (1):
      tc/pedit: Fix wrong pedit ipv6 structure id

Eric Dumazet (3):
      tc: fq: support ce_threshold attribute
      man: tc: update man page for fq packet scheduler
      lib/libnetlink: ensure a minimum of 32KB for the buffer used in rtnl_recvmsg()

Hans Dedecker (1):
      f_flower: fix build with musl libc

Ido Schimmel (2):
      bridge: fdb: Use 'struct ndmsg' for FDB dumping
      bridge: fdb: Fix FDB dump with strict checking disabled

Jakub Kicinski (9):
      tc: gred: remove unclear comment
      json: add %hhu helpers
      tc: move RED flag printing to helper
      tc: gred: jsonify GRED output
      tc: gred: separate out stats printing
      tc: gred: use extended stats if available
      tc: gred: support controlling RED flags
      tc: gred: allow controlling and dumping per-DP RED flags
      ip route: get: only set RTM_F_LOOKUP_TABLE flag for IPv4

Jiri Pirko (1):
      devlink: relax dpipe table show dependency on resources

Kevin 'ldir' Darbyshire-Bryant (1):
      tc: m_connmark: fix action error messages

Konstantin Khlebnikov (1):
      ss: add option --tos for requesting ipv4 tos and ipv6 tclass

Leon Romanovsky (4):
      rdma: Update kernel include file to support IB device renaming
      rdma: Introduce command execution helper with required device name
      rdma: Add an option to rename IB device interface
      rdma: Document IB device renaming option

Luca Boccassi (4):
      man: ss.8: more line breaks
      man: tc-taprio.8: fix syntax error
      Makefile: check manpages for syntax errors
      ip route: get: allow zero-length subnet mask

Marcos Antonio Moraes (1):
      tc: use bits not mbits/sec in rate percent

Matteo Croce (3):
      iplink: document XDP subcommand to force the XDP mode.
      ip route: print route type in JSON output
      ip route: get: print JSON output when -j is given

Michael Guralnik (1):
      rdma: Add print of link CapabilityMask2 flags

Petr Vorel (1):
      man: Document COLORFGBG environment variable

Phil Sutter (1):
      ip-address: Use correct max attribute value in print_vf_stats64()

Shalom Toledo (2):
      devlink: Add string to uint{8,16,32} conversion for generic parameters
      devlink: Add support for 'fw_load_policy' generic parameter

Stefano Brivio (3):
      iplink_vxlan: Add DF configuration
      iplink_geneve: Add DF configuration
      ss: Render buffer to output every time a number of chunks are allocated

Stephen Hemminger (12):
      drop support for IPX
      drop support for DECnet
      doc: remove trailing whitespace
      testsuite: drop unrunnable test
      uapi: update headers from 4.21-rc1
      rdma: update uapi headers
      uapi: in.h change
      tc: fix memory leak in error path
      tc: avoid problems with hard coded rate string length
      uapi: update inet_diag_info.h
      ipaddress: print error message on stderr
      v5.0.0

Thomas De Schampheleire (1):
      ss: fix compilation under glibc < 2.18

Thomas Haller (2):
      ip-rule: fix json key "to_tbl" for unspecific rule action
      iprule: fix printing hint about unresolved iifname and oifname

Vivien Didelot (1):
      bridge: make mcast_flood description consistent

Yonghong Song (1):
      bpf: add btf func and func_proto kind support

wenxu (1):
      iproute: Set ip/ip6 lwtunnel flags

