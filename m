Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA01C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797DE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbfC0Iol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:44:41 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51819 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfC0Ioh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:37 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 4E35140003;
        Wed, 27 Mar 2019 08:44:33 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 00/18] net: mvpp2: Classifier updates and cleanups
Date:   Wed, 27 Mar 2019 09:44:04 +0100
Message-Id: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In preparation for the future addition of classification offload
support, this series cleans-up the current code dealing with the
classification engines.

As of today, the classification code only deals with RSS, which is a
very narrow use-case when considering all of the classifier's features.

This lead to design and naming decisions that don't really stand when
considering using more classification features.

This series therefore includes quite a lot a renaming of functions and
macros, and tries to make the naming schemes more consistent and the
code more readable.

The debugfs interface that allows reading the various Parsing and
Classification engines has been cleaned-up and made more generic,
allowing to read the Flow Table and C2 engine hit counters on a
per-entry basis.

The Classifier itself has been made more robust by introducing the
lu_type field in classification lookups, that prevents false-positive
matches in the future. We also initialise the various engine in a more
extensive and less error-prone way by assining default values to all
entries in the C2 and Flow table.

This is a pretty big series considering it's mostly cleanup, but my goal
is to make the future series that will contain new big features easier
to review, focusing on the real logic.

Besides the debugfs interface, this series doesn't intend to introduce any
new features or change in behaviours.

Maxime Chevallier (18):
  net: mvpp2: Don't use an int to store netdev_features_t
  net: mvpp2: cls: Add missing MAC_DA field extraction
  net: mvpp2: cls: Start cls flow entries from beginning of table
  net: mvpp2: cls: use Lookup Type in classification engines
  net: mvpp2: cls: Rename MVPP2_N_FLOWS to MVPP2_N_PRS_FLOWS
  net: mvpp2: cls: Make the flow definitions const
  net: mvpp2: debugfs: Store debugfs entries data in mvpp2 struct
  net: mvpp2: debugfs: Allow reading the flow table from debugfs
  net: mvpp2: debugfs: Allow reading the C2 engine table from debugfs
  net: mvpp2: cls: Use iterators to go through the cls_table
  net: mvpp2: cls: Write C2 TCAM data last when writing a C2 entry
  net: mvpp2: cls: Move C2 read/write helpers around
  net: mvpp2: cls: Rename classifer per-port functions
  net: mvpp2: cls: Don't use the sequence attribute for classification
  net: mvpp2: cls: Rename the flow table macros
  net: mvpp2: cls: Invalidate all C2 entries except the ones we use
  net: mvpp2: cls: Initialize lookup priorities for all entries in the
    flow
  net: mvpp2: cls: Rework C2 engine macros

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  10 +
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    | 212 ++++++++-------
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    |  92 ++++---
 .../ethernet/marvell/mvpp2/mvpp2_debugfs.c    | 253 +++++++++++-------
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   8 +-
 5 files changed, 341 insertions(+), 234 deletions(-)

-- 
2.20.1

