Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4D3C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C2A215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222744;
	bh=cVTZv2mBRqo0/m//JNa/bl7jZvshs64wS8/qI0xdSco=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=t5wG6plEDZ5PQS/YlPMW7po/23O/N88xpcP1f1IPBtbCAfA8Xc8BZXwTZbMOrTKaX
	 nPg8cEPHNXhogWS48GsH8DQHwHpnvZzaIInav5meC+Q3d7gP0vSxU0NCcBG824PZp8
	 4alZ2X49coidfe/E8LZbjM4p2SL34qX3GcGubvO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFVQ7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:59:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nqhxUWeu7PVWFSTsz/lHoY/3ToIX8DIdYUQ0uB/39IY=; b=qmHCcjUSr7SUV3SnjknFIfxRO
        sLeAlifLvqZamTKw9Cqx6nL2ij8aEWvuUfDzfUX2OJ1R7qW6fISUbuTqoR5p6pGk6FHm8CccO4U5o
        vPjNjOXn+0Wi5UV587mlfUsnOTT4Hfu+VYAI3+u0ZCeuoHm5u6LD91KGiq+5o7ib9X2o9YZed6jbB
        VvDqvMP9wL9im0rTGru4gewNKCZQTPjowVywK3g7hTI/t3xQm8CIctWSoZCZH5BhqACXFbVpGCA39
        HIOc3nFhEf8z96niR/hELEoh5pGS9pt6ys2xsnEQgtTjCebw1z30RUEZCpWVJtNM1nB2LyrAzHleI
        EVipl0PFA==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054m-H4; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLr-0000v6-Pk; Sat, 22 Jun 2019 13:58:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] Add the ABI documentation to the admin guide
Date:   Sat, 22 Jun 2019 13:58:41 -0300
Message-Id: <cover.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg/Jon,

That's the rebased patches with add the ABI documentation to the
admin-guide. It is rebased on the top of driver-core/driver-core-next,
and it can work both on the "old" mode, where the scripts will
avoid codes that would cause troubles for ReST, or at the new mode,
with parses the description to the ReST output untouched.

Patches 1 to 3 improves the get_abi.pl for it to parse ReST format,
and to report where the errors/warnings occur at the ABI file.

Patch 4 is implements support for a Sphinx log facility (info). 

Patches 5 to 10 adds the new kernel ABI extension, making it ready
to parse files in ether "normal" or "rst-source" mode.

Patch 11 addresses a Sphinx issue, with is there since old vesions,
but it gets worse on Sphins 2.0: basically, the ReST parser is lazy:
if it receives too much stuff, it silently ignores the end of the content.
So, the extension needs to split the content on small chunks.

IMO, it is safe to apply patches 1 to 11 via Greg's tree. The only
potential conflict would be at patch 4, but looking at docs-next,
I don't see any changes at Documentation/scripts/kernelog.py.

Patch 12 actually enables everything. 

If Patch 12 gets merged via Greg's tree, it may rise a single-line
trivial conflict with docs-next, as it will be adding kernel_abi to the 
list of extensions at Documentation/conf.py, and Jon is likely
adding another extension. too.

So, it could be wise postpone patch 12 to be merged after both 
trees got merged upstream.

Patch 12 adds ABI with ReST-scaping code. I'll submit soon a
second version for the RFC patches with turns it to "clean" mode.

The entire ABI series (plus Documentation/features) is at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v4.2

And the ReST output (with Sphinx 2.0 - with IMO provides a nicer
output) is at:

	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html


Mauro Carvalho Chehab (12):
  scripts/get_abi.pl: change script to allow parsing in ReST mode
  scripts/get_abi.pl: fix parsing on ReST mode
  scripts/get_abi.pl: Allow optionally record from where a line came
    from
  docs: kernellog.py: add support for info()
  docs: kernel_abi.py: add a script to parse ABI documentation
  docs: kernel_abi.py: fix UTF-8 support
  docs: kernel_abi.py: make it compatible with Sphinx 1.7+
  docs: kernel_abi.py: Update copyrights
  docs: kernel_abi.py: add a SPDX header file
  docs: kernel_abi.py: use --enable-lineno for get_abi.pl
  docs: kernel_abi.py: Handle with a lazy Sphinx parser
  docs: add ABI documentation to the admin-guide book

 Documentation/admin-guide/abi-obsolete.rst |  10 ++
 Documentation/admin-guide/abi-removed.rst  |   4 +
 Documentation/admin-guide/abi-stable.rst   |  13 ++
 Documentation/admin-guide/abi-testing.rst  |  19 +++
 Documentation/admin-guide/abi.rst          |  11 ++
 Documentation/admin-guide/index.rst        |   1 +
 Documentation/conf.py                      |   2 +-
 Documentation/sphinx/kernel_abi.py         | 189 +++++++++++++++++++++
 Documentation/sphinx/kernellog.py          |   6 +-
 scripts/get_abi.pl                         | 104 ++++++++----
 10 files changed, 325 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/admin-guide/abi-obsolete.rst
 create mode 100644 Documentation/admin-guide/abi-removed.rst
 create mode 100644 Documentation/admin-guide/abi-stable.rst
 create mode 100644 Documentation/admin-guide/abi-testing.rst
 create mode 100644 Documentation/admin-guide/abi.rst
 create mode 100644 Documentation/sphinx/kernel_abi.py

-- 
2.21.0


