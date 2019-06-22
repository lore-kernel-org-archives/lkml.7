Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E7C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FED920673
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561223852;
	bh=9op3f/aOw5PzwuJb7DMvgjmIbpDkClb5eW+qaH+oN0g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XQsrZJikvXF/wWecS1ZWtn6b255o4Gviptjau3dSl4y9lBfWjantsNLtw91A2TZkV
	 ehi2uhutJDvLWyg2R9E7LNOCNE5vpcykR2kfAng5G+JjUeE8aaPtlU4Whs1RFmLMRX
	 Mc08DWQbNPSlJA0NtRsCXsQOxUUCSIeM4YgkGz8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfFVRR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:17:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfFVRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G7/AfeCAHKDpHfFhd5zmds9lnZrNn3aoa9+LzQJaNa0=; b=nPSy3aB+GOSmSYxSPZBIE3FYj
        cMxI8zy99GHouI/cmeMj/jEbIL6Bvro59dXjPfCFB8eeHDTl79rx+RwU5m3ZsHMmBFKGOcszAaXmL
        W7STvDhj31l4ROAmUNeH+U0FeKDOMdXSIulFt8y3N8b/CwcDvm2vvwUQRWIYLaILbEDNjRGN8TtTw
        pdxbisDGVcdCcajFFyIrQF7uT9YF5qQIQhYpXmMenHjeAQsUwOK2RMcXQsPhDZ8ABNlG/mWO2Z2UT
        6KGi3fOEkZ0/RNEn5HvwAT8P8uBW1KumrJkMJalvHpHd/xMiNapJCyCig5ZBjYtaz2ijm0mKb51rH
        FQmB5n1iQ==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejdX-0002tj-Rs; Sat, 22 Jun 2019 17:17:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejdV-00014D-49; Sat, 22 Jun 2019 14:17:09 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 0/4] Add Documentation/features to admin-guide and x86
Date:   Sat, 22 Jun 2019 14:17:03 -0300
Message-Id: <cover.1561222784.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon, Greg & all:

Not sure what tree this would fit better.

The first 2 patches on this series reimplement the logic at:

	Documentation/features/list-arch.sh

I opted to not remove the old script, as someone could depend on
its specific format. The new script does the same with:

	./scripts/get_feat.pl current

The difference is that it outputs with using ascii table artwork.

The way it works is that it parse all feature files and produce 3 different
types of contents, depending on its arguments:

- a feature x arch matrix:

	./scripts/get_feat.pl rest

- a per-architecture feature table:

	./scripts/get_feat.pl current
		or
	./scripts/get_feat.pl rest --arch=arm64

- a per-feature table:

	 ./scripts/get_feat.pl rest --feat=perf-regs

All outputs are compatible with the ReST format.

Patch 3 adds a new Sphinx plugin with handles its output.

Patch 4 adds the feature x arch matrix at the admin-guide.

Patch 4 also adds the features supported on x86 at the x86 arch guide.

IMHO, it makes sense to have a similar table on all other architectures, but
the best is to wait for the next Kernel version, in order to see what arch
conversion files got included.

So far, I didn't add the per-feature table anywhere.

Mauro Carvalho Chehab (4):
  scripts/get_feat.pl: add a script to handle Documentation/features
  scripts/get_feat.pl: handle ".." special case
  sphinx/kernel_feat.py: add a script to parse feature files
  docs: admin-guide, x86: add a features list

 Documentation/admin-guide/features.rst |   3 +
 Documentation/admin-guide/index.rst    |   1 +
 Documentation/conf.py                  |   2 +-
 Documentation/sphinx/kernel_feat.py    | 169 +++++++++
 Documentation/x86/features.rst         |   3 +
 Documentation/x86/index.rst            |   1 +
 scripts/get_feat.pl                    | 474 +++++++++++++++++++++++++
 7 files changed, 652 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/features.rst
 create mode 100644 Documentation/sphinx/kernel_feat.py
 create mode 100644 Documentation/x86/features.rst
 create mode 100755 scripts/get_feat.pl

-- 
2.21.0


