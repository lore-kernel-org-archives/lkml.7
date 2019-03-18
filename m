Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E488FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF422064C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552950919;
	bh=7KPP+qvG/eHzgeW+EKO3a2k7gT1Hi3LfqWiOkr0+AJc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rpyHnNIaDM+aC2Ij56rIn1bdTqbX1TjFZNqPlGaKV1X6UnHdKyc2PNyZsb9JYmWld
	 BAIHHhfGKLb8kdWNH/M9eB8D7igP/FQWxKZWNvk0Ah19rI16QEvXsBhpoopA4/O9x6
	 DCl635mHuYqtG/ODgI1mLDTV9daAu7ojJXUrqHZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCRXPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:15:18 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49109 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfCRXPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:15:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4723522B1A;
        Mon, 18 Mar 2019 19:15:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Mar 2019 19:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZqGykYVH77djLZne5
        01caV0WFSaOMDiHjm0OWGztsTI=; b=k5cIjSmcJJmizGgRPpbxCqmDEmWSjNnrG
        FIvGrDIZR6Kabx+IyvYo6muZGyyGCNrsoma0H8o4+S40m9w1pYgUzuEcNP/tVC3L
        rqf9feIMeDHS1qbt9NPtpqqgjl1WoeyuwNxxMwTohTDLH5WyBiumWpTf50gjDRzu
        qRI3kxg/oZj2pN1a2GSGjP1RWAXOc1BzU1gnhMr6DwXo0wOp6GPgAEr6FJm7ZRCq
        27yV7icg/iA3QTbEMN93THL/y5yiw12kFKGO1PqIxD8sFbumA8RCeLxZ3syf0mQq
        WaJBqHdJ4hpxgRhjXbcvHLCZ5yw3hNfPF+nPE+YiyautPYifo/O0Q==
X-ME-Sender: <xms:giaQXL7TJx83zgdsFg0IE5g2JzqQGtmvP9bRRArEVtK8Z0_U1lNy9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudeiledrudegledrgedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:giaQXMbiMVq9FxLc4HIXkuRwa0W05KJqPKh_IAznx2qV76kCSMi0gQ>
    <xmx:giaQXIcpNOOhIhoNSca32RUJ2bOQ82Jp4fGjwxr4FcHsAebLI62LnQ>
    <xmx:giaQXJ7NgCusYRX777KSnKXxSln0T56fHQvuFDqTUzzkE5gUqfM-eQ>
    <xmx:hSaQXGwU-8fYiYpWc2Gqhtb62mN9p0Mwsu8KwlSpvQo7WNTNNMj9Kg>
Received: from eros.localdomain (124-169-149-40.dyn.iinet.net.au [124.169.149.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D31110315;
        Mon, 18 Mar 2019 19:15:11 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] Convert vfs.txt to vfs.rst
Date:   Tue, 19 Mar 2019 10:14:24 +1100
Message-Id: <20190318231437.1666-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

v2 Re-based and tagged for your merging pleasure!

This set converts the VFS overview documentation to RST format.

Patch set introduces no new warnings/errors to the html docs build

      $ make htmldocs 2> ../docs-pre-vfs.stderr	

	Apply patch set  ...

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


Changes since v1:

 - Re-base onto commit 9834857754ff ("doc:it_IT: translations for documents in process/")
 - Add 'Tested-by:' tag for Randy (thanks!)


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
 Documentation/filesystems/vfs.rst   | 1283 +++++++++++++++++++++++++++
 Documentation/filesystems/vfs.txt   | 1264 --------------------------
 3 files changed, 1284 insertions(+), 1264 deletions(-)
 create mode 100644 Documentation/filesystems/vfs.rst
 delete mode 100644 Documentation/filesystems/vfs.txt

-- 
2.21.0

