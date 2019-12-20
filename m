Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D1DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABD424680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576825692;
	bh=ShcbXlpFdXilKh58f9Dmtn2A8cXnIYIsKLvamhRUsQU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=biokS2f7yJ0U09Zs9j03jZgr5Pz+yaZDTNkjL9duYTHcOQKJKEySMtvp9jHLeLdwj
	 T2F0w2/FpMH10TYb+6TGIu7AE6IctfXMUjvIiB7GrPfiOpqwUinK88pWkOP6t/WRo9
	 XG5uXrT4mAASrHbOZZ9v4Rij1CWFL5Ziu+nZlanI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLTHIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:08:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLTHIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:08:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE2C824679;
        Fri, 20 Dec 2019 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576825690;
        bh=ShcbXlpFdXilKh58f9Dmtn2A8cXnIYIsKLvamhRUsQU=;
        h=Date:From:To:Cc:Subject:From;
        b=X8932mrlA4KqrE33D0NO1+bWX1GSbKRYyA1kIi5eFcID5yezP95okCEruFFpKXfPW
         NpaYKFbxOS26/LKFNQXZnaxaPF7u6VQA83jjZHeEHqXN+wGrfs9GwyitsVX05R/Viq
         4su0K1aFz4ZBHtgplyhN/1VrfQWKdmVr6aj75mdY=
Date:   Fri, 20 Dec 2019 08:08:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.5-rc3
Message-ID: <20191220070808.GA2190290@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc3

for you to fetch changes up to c05c403b1d123031f86e65e867be2c2e9ee1e7e3:

  staging: wfx: fix wrong error message (2019-12-18 15:51:06 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.5-rc3

Here are some small staging driver fixes for a number of reported
issues.

The majority here are some fixes for the wfx driver, but also in here is
a comedi driver fix found during some code review, and an axis-fifo
build dependancy issue to resolve some reported testing problems.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Brendan Higgins (1):
      staging: axis-fifo: add unspecified HAS_IOMEM dependency

Ian Abbott (1):
      staging: comedi: gsc_hpdi: check dma_alloc_coherent() return value

Jérôme Pouiller (10):
      staging: wfx: fix the cache of rate policies on interface reset
      staging: wfx: fix case of lack of tx_retry_policies
      staging: wfx: fix counter overflow
      staging: wfx: use boolean appropriately
      staging: wfx: firmware does not support more than 32 total retries
      staging: wfx: fix rate control handling
      staging: wfx: ensure that retry policy always fallbacks to MCS0 / 1Mbps
      staging: wfx: detect race condition in WEP authentication
      staging: wfx: fix hif_set_mfp() with big endian hosts
      staging: wfx: fix wrong error message

 drivers/staging/axis-fifo/Kconfig         |  2 +-
 drivers/staging/comedi/drivers/gsc_hpdi.c | 10 +++++++++
 drivers/staging/wfx/data_tx.c             | 35 ++++++++++++++++++++++---------
 drivers/staging/wfx/data_tx.h             |  5 +++--
 drivers/staging/wfx/hif_tx_mib.h          |  1 -
 drivers/staging/wfx/main.c                |  2 +-
 drivers/staging/wfx/queue.c               |  1 +
 drivers/staging/wfx/sta.c                 |  6 +++++-
 8 files changed, 46 insertions(+), 16 deletions(-)
