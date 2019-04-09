Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D243320883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDICVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:21:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43524 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDICVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:21:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C2E0145FFAA6;
        Mon,  8 Apr 2019 19:21:30 -0700 (PDT)
Date:   Mon, 08 Apr 2019 19:21:27 -0700 (PDT)
Message-Id: <20190408.192127.739987515695173484.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Apr 2019 19:21:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Off by one and bounds checking fixes in NFC, from Dan Carpenter.

2) There have been many weird regressions in r8169 since we turned
   ASPM support on, some are still not understood nor completely
   resolved.  Let's turn this back off for now.  From Heiner Kallweit.

3) Signess fixes for ethtool speed value handling, from Michael
   Zhivich.

4) Handle timestamps properly in macb driver, from Paul Thomas.

5) Two erspan fixes, it's the usual "skb ->data potentially
   reallocated and we're holding a stale protocol header pointer".
   From Lorenzo Bianconi.

Please pull, thanks a lot!

The following changes since commit 7f46774c6480174eb869a3c15167eafac467a6af:

  Merge tag 'mm-compaction-5.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux (2019-04-05 06:09:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to e063f4598249480edaea947679ff950d56f2cc32:

  Merge branch 'bnxt_en-fixes' (2019-04-08 16:39:41 -0700)

----------------------------------------------------------------
Dan Carpenter (2):
      NFC: nci: Add some bounds checking in nci_hci_cmd_received()
      nfc: nci: Potential off by one in ->pipes[] array

David S. Miller (3):
      Merge branch 'erspan-use-after-free'
      Merge branch 'ethtool-fix-use-of-SPEED_UNKNOWN-constant'
      Merge branch 'bnxt_en-fixes'

Heiner Kallweit (1):
      r8169: disable ASPM again

Lorenzo Bianconi (2):
      net: ip_gre: fix possible use-after-free in erspan_rcv
      net: ip6_gre: fix possible use-after-free in ip6erspan_rcv

Miaohe Lin (1):
      net: vrf: Fix ping failed when vrf mtu is set to 0

Michael Chan (2):
      bnxt_en: Improve RX consumer index validity check.
      bnxt_en: Reset device on RX buffer errors.

Michael Zhivich (3):
      ethtool: avoid signed-unsigned comparison in ethtool_validate_speed()
      broadcom: tg3: fix use of SPEED_UNKNOWN ethtool constant
      qlogic: qlcnic: fix use of SPEED_UNKNOWN ethtool constant

Nicolas Dichtel (1):
      selftests: add a tc matchall test case

Paul Thomas (1):
      net: macb driver, check for SKBTX_HW_TSTAMP

Stefan Schmidt (1):
      MAINTAINERS: ieee802154: update documentation file pattern

 MAINTAINERS                                                    |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                      | 16 +++++++++++++---
 drivers/net/ethernet/broadcom/tg3.c                            |  8 ++++----
 drivers/net/ethernet/broadcom/tg3.h                            |  4 ++--
 drivers/net/ethernet/cadence/macb_main.c                       |  4 +++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h                    |  2 +-
 drivers/net/ethernet/realtek/r8169.c                           |  6 ++++++
 drivers/net/vrf.c                                              |  8 ++++++--
 include/net/nfc/nci_core.h                                     |  2 +-
 include/uapi/linux/ethtool.h                                   |  2 +-
 net/ipv4/ip_gre.c                                              | 15 ++++++++++-----
 net/ipv6/ip6_gre.c                                             | 20 +++++++++++++-------
 net/nfc/nci/hci.c                                              |  8 ++++++++
 tools/testing/selftests/tc-testing/tc-tests/filters/tests.json | 20 ++++++++++++++++++++
 14 files changed, 89 insertions(+), 28 deletions(-)
