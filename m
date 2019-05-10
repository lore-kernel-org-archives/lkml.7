Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E115C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B79216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="0KQEPROF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfEJPyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:54:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37472 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfEJPyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:54:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so3457048pfi.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=R+L/q0eBmRC66UxN3KjFp1ob/k3wh1/Zp6NlpOqRHNY=;
        b=0KQEPROFS06bgTJD5PfPoeA9dftwOx19I/YNH6mNvJ/HYd8qCbVYh6U0p6jUyR2MLF
         MElCjO6WBVDuBioubVGJP4inf2Drg4gw7Jo3YQymtKISxo+JrrIurEyg7NpZkb0EyGbd
         2ne/ZypCIoHVs/5x7TQImOtP+xOQkGmLou6P9p5gXQyEqo3pe+G/DX9Xet1j2QnfJx0k
         Vjvb/jFIXFNQEBQOnNvazeRQCjic8zGI+87EOrkt4NB7LMCqphAR9jW6ET36xyKqhd83
         bDujyS6FlzHKfjN/qdknmpKFFRVncUGFNDm1lnfUrixYVEcKoC3bDqACqOQXP2dkSMXa
         anYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=R+L/q0eBmRC66UxN3KjFp1ob/k3wh1/Zp6NlpOqRHNY=;
        b=m36lDILWQdAcFxFfMRw7b0wh0lg9bcBU6oq7KxyS1RVBeHRgUlnE76IqXHJJbu+Pya
         PWWDbsImOCFucEF5bv0fUnx7Pbgj0SOBLNhw/9nCqEOXfzx95F/V+3aX6YR1QoW/XLlX
         0gJvJX3aLm5sox/jjxuxyOhl7W1PQyW7qqFGeI4Bb/rsQr2ZLkFXqnuqOtPTB5yC21uf
         3jrrmTArV/qho6oYvJxFJMNyPcJPNQmkMgGUYXkwC2maF9LDSN8mo0eTPz0wT2njdkrI
         lgQZAIzxXMubynB+fHjJ/3+t2sXhTmZLiucv2vGriNvPyd2IixIiJ1vt9eKw5ByP88X4
         6QlA==
X-Gm-Message-State: APjAAAUA/D5QWdyLWnWqjZLTshvB/aDhR+EtIJG7mkZjL0MykL680wmh
        QeCxTU7ugCBR8ArXjD87Sa+5/w==
X-Google-Smtp-Source: APXvYqwX2oaus3nwsNUj0tqpBABgn+lqsn44yxLAH5MPqkle4Uhffg0wn6gfTedA+om9MVfX3AbMhA==
X-Received: by 2002:a63:fb01:: with SMTP id o1mr14555300pgh.135.1557503690192;
        Fri, 10 May 2019 08:54:50 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d15sm11828935pgf.22.2019.05.10.08.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 08:54:50 -0700 (PDT)
Date:   Fri, 10 May 2019 08:54:42 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 5.1.0
Message-ID: <20190510085442.5fac679e@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iproute 5.1 has been released.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.1.0.tar.=
gz

Repository for upcoming release: 5.2
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Most of the new features for this release are in the devlink and rdma utili=
ties.
And most of the bug fixes are in fixing the output format glitches
that resulted from converting most of the tools to have JSON
output.

Thanks for all the contributions.

Report problems (or enhancements) to the netdev@vger.kernel.org mailing lis=
t.

---

Aya Levin (11):
      devlink: Refactor validation of finding required arguments
      devlink: Fix print of uint64_t
      devlink: Fix boolean JSON print
      devlink: Add helper functions for name and value separately
      devlink: Add devlink health show command
      devlink: Add devlink health recover command
      devlink: Add devlink health diagnose command
      devlink: Add devlink health dump show command
      devlink: Add devlink health dump clear command
      devlink: Add devlink health set command
      devlink: Add devlink-health man page

Benedict Wong (1):
      xfrm: add option to hide keys in state output

Beniamino Galvani (1):
      ip: add missing space after 'external' in detailed mode

Bj=C3=B6rn T=C3=B6pel (1):
      ss: add AF_XDP support

Cong Wang (1):
      tc: add hit counter for matchall

David Ahern (7):
      Update kernel headers
      Update kernel headers and add xdp_diag.h
      Update kernel headers
      ll_map: Add function to remove link cache entry by index
      ip link: Drop cache entry on any changes
      Improve batch and dump times by caching link lookups
      Update kernel headers

Davide Caratti (3):
      tc: full JSON support for 'bpf' actions
      tc: add 'kind' property to 'csum' action
      use print_{,h}hu instead of print_uint when format specifier is %{,h}=
hu

Eyal Birger (1):
      ip xfrm: support setting/printing XFRMA_IF_ID attribute in states/pol=
icies

Ido Schimmel (1):
      devlink: Fix monitor command

Jakub Kicinski (3):
      devlink: report cell size
      devlink: add info subcommand
      devlink: add support for updating device flash

Leon Romanovsky (22):
      clang-format: add configuration file
      rdma: Add unbound workqueue to list of poll context types
      rdma: update uapi headers
      rdma: Remove duplicated print code
      rdma: Provide unique indexes for all visible objects
      rdma: Provide parent context index for all objects except CM_ID
      rdma: Move resource PD logic to separate file
      rdma: Refactor out resource MR logic to separate file
      rdma: Move out resource CQ logic to separate file
      rdma: Move out resource CM-ID logic to separate file
      rdma: Move resource QP logic to separate file
      rdma: Properly mark RDMAtool license
      rdma: Simplify code to reuse existing functions
      rdma: Simplify CM_ID print code
      rdma: Refactor CQ prints
      rdma: Move MR code to be suitable for per-line parsing
      rdma: Place PD parsing print routine into separate function
      rdma: Move QP code to separate function
      rdma: Unify netlink attribute checks prior to prints
      rdma: Perform single .doit call to query specific objects
      rdma: Provide and reuse filter functions
      rdma: Add the prefix for driver attributes

Leslie Monis (2):
      tc: pie: change maximum integer value of tc_pie_xstats->prob
      tc: pie: update man page

Matt Ellison (1):
      ip: support for xfrm interfaces

Matteo Croce (1):
      netns: add subcommand to attach an existing network namespace

Nikolay Aleksandrov (6):
      ip: xstats: add json output support
      ip: bridge: add xstats json support
      ip: bond: add xstats support
      bridge: mdb: restore valid json output
      bridge: vlan: fix standard stats output
      ip: mroute: add fflush to print_mroute

Phil Sutter (1):
      ip-xfrm: Respect family in deleteall and list commands

Ralf Baechle (1):
      ip: display netrom link type

Roopa Prabhu (1):
      bridge: fdb: add support for src_vni option

Stephen Hemminger (10):
      tc: replace left side comparison
      rdma: update uapi headers from 5.1-rc1
      uapi: add CAKE FWMARK
      uapi: in6.h add router alert isolate
      uapi: bpf add set_ce
      man: break long lines in man page sources
      ip: fix typo in iplink_vlan usage message
      uapi: update bpf.h
      tc/ematch: fix deprecated yacc warning
      v5.1.0

Thomas Haller (4):
      iprule: avoid printing extra space after gateway for nat action
      iprule: avoid trailing space in print_rule() after printing protocol
      iprule: refactor print_rule() to use leading space before printing at=
tribute
      iprule: always print realms keyword for rule

Tobias Jungel (1):
      ip: bridge: add mcast to unicast config flag

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      q_cake: Add support for setting the fwmark option

Zhiqiang Liu (1):
      ipnetns: use-after-free problem in get_netnsid_from_name func

