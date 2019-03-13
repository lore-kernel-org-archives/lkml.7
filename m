Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A075BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6142173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552450198;
	bh=vjEJand68LR+D4I/HEwf9qmr/8FfeRE8WXWFBtPsbyU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XE5ibdcdahKNkl/2l2nhSwFTh3Z+dsTgfNknBlfSnexHNn3Vb801hmOdsWvJeAX9/
	 wwHV+2J6XR8+ql/tVsfj0w+BQMQrfTZbKQ88k93BQpQAdY8Pb18xvmUIMlh3xI0Bgz
	 1X3IrnFbLcL2GT43Dx5wcLsPCdUMy1YDaYbNwlT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfCMEJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:09:57 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56731 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbfCMEJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:09:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1D28038D9;
        Wed, 13 Mar 2019 00:09:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 00:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CcuNGGoS05STV+ubM
        wGB5nTWGo43u9oskHnErglPjYM=; b=ysJ2B9Q2A9ZFOTWy3UOh115YSZ7FHGwH7
        biOid/sG4IgnTQtc0Mr3gQ6Jnxdo4iRpdwlGPLmPuPNfXqx0IWphxfAl+JpGz4EL
        bq/CBJPpTVAyqU/G35avoFRNDn5S65V4D9elnS1U561MPQuT3AEsLz3miQH8SUL4
        HzUT4LmlHsft9Ge/ni23zQ9++/cLUA9+sreft75bRO92m48QxfHX7l66VZVQhkqt
        NijzG+QuwtzX4J0IlqGUJ04pNBsqyT/3dFH/1/okqLckNjRh4DOqFkdWnU5vxzil
        y5GFkMzL1Ka9l/6ydxSL3dpRGfuvVmh54YNyri8obUkS0JpNG1P1A==
X-ME-Sender: <xms:kYKIXIiovwRIj_8KMzg3gYLbEzWqznMxkcYI8mUPk78AF_7DbvfSgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:kYKIXK050Pflm3tVHEMLjqTtoGoAQAK6Jo5VgmE5OL8iiJ3MLeRy-A>
    <xmx:kYKIXO7nns5T-Y_yw1R70JboKTfKbtsmQFCtfosh0_xX3UNzoJCG4g>
    <xmx:kYKIXEq-1Y_a7KNsS1pMjLzLQATlqaI0A4FaPNr0UAKmaSD5UKjX8Q>
    <xmx:koKIXAZeq8HnWLSQEa8HeqefDZTXjHndBScgxpPMTrt8Ff0UaE2oyQ>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id B32D7E408B;
        Wed, 13 Mar 2019 00:09:51 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] Convert vfs.txt to vfs.rst
Date:   Wed, 13 Mar 2019 15:09:06 +1100
Message-Id: <20190313040919.6937-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This set converts the VFS overview documentation to RST format.  I think
I'm slowly getting better at structuring these conversions to ease
review, if you disagree or you notice any way to further improve please
say so.

Patch set introduces no new warnings/errors to the html docs build

      $ make htmldocs 2> ../docs-pre-vfs.stderr	

Apply patch set

      $ make cleandocs
      $ make htmldocs 2> ../docs-post-vfs.stderr
      $ diff ../docs-pre-vfs.stderr ../docs-post-vfs.stderr


Patch 1-4 - Whitespace fixes.
Patch 5 - Adds the document title adornments (above and below)
Patch 6 - Adds a SPDX license identifier
Patch 7 - Fixes some custom indentation at the top of the file that will
    	  cause Sphinx to warn when we switch to .rst
Patch 8 - Converts custom list format to use RST formatted lists, this
          is in preparation for switching to .rst 
Patch 9 - Adds '.. code-block:: c' and fixes indentation of code
	  blocks.  We rename the file to .rst in this patch (introducing
	  some new warnings).
Patch 10 - Adds back ticks to all the list items.  This is in
	   preparation for fixing the indentation in the next patch.
	   This was found to help when reading both plain text and HTML.
Patch 11 - Cleans up the lists, indentation and missing periods.  This
	   was kept separate to assist review.  This patch is benign,
	   the less meticulous reviewer could safely skip over this one
	   quickly (this was the intention of separating these changes).
Patch 12 - Fixes a few minor grammar mistakes I notice while reading the
	   file, I'm taking bonus points for actually reading every word
	   of the file and not just trying to haphazardly do the
	   conversion like I have previously done :)
Patch 13 - Fixes two remaining Sphinx warnings.

If/when this goes in perhaps I, or someone else, will update the content
to document a newer kernel version.


thanks,
Tobin.


Tobin C. Harding (13):
  docs: filesystems: vfs: Remove space before tab
  docs: filesystems: vfs: Use uniform space after period.
  docs: filesystems: vfs: Use 72 character column width
  docs: filesystems: vfs: Use uniform spacing around headings
  docs: filesystems: vfs: Use correct initial heading
  docs: filesystems: vfs: Use SPDX identifier
  docs: filesystems: vfs: Fix pre-amble indentation
  docs: filesystems: vfs: Use list character for lists
  docs: filesystems: vfs: Add code-block and txt->RST
  docs: filesystems: vfs: Use ticks for listed items
  docs: filesystems: vfs: Clean up lists
  docs: filesystems: vfs: Do minor grammar fixes
  docs: filesystems: vfs: Use backticks to guard star

 Documentation/filesystems/index.rst |    1 +
 Documentation/filesystems/vfs.rst   | 1279 +++++++++++++++++++++++++++
 Documentation/filesystems/vfs.txt   | 1261 --------------------------
 3 files changed, 1280 insertions(+), 1261 deletions(-)
 create mode 100644 Documentation/filesystems/vfs.rst
 delete mode 100644 Documentation/filesystems/vfs.txt

-- 
2.21.0

