Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC86C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C5E217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560535665;
	bh=yyxXSF/H0yluDAVoShROjwt8oXor3+jPraQS4qferto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oZFIofQnlJceht/ChJAMP4EeWn0nFvKUndwqMLz220XC3s4/r6vPAc2+vu58Ksldl
	 SkTztrAn9mJiMRkZFr/iFGrEu6TT1sa/ZbqKN6lr4JYDjPr+0VzwXZoCGRGMyNz3rM
	 XuB5A164MwNdsU1hdQei46j0b5c1FRrqUALDXvys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfFNSHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:07:43 -0400
Received: from casper.infradead.org ([85.118.1.10]:35586 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNSHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6u3mWzVqiKIvqHULlxY1C85MLfXNyfBlevwK2rEBH34=; b=c9CVcMTrd5qh68PGzm8/cyI1Az
        1E86bzW84EvAUdQbm2C2w0eEMHFo1WtoZHj3tI5mhowzy2cfhJkGnc3SupxCP9SearFY/aN3gH8ZD
        958kwU/VadVPM98/mPv9xglbMralS78z8X2FDRGGNdAI94SOTT14XT8Nw6Rk151aEK/zf+JPY/Y/d
        MDVVX9uVkCue0JYpM6vzf87HozsrxVDdxgtXrizNT2NyrOy83VET2Oesb3OLQN2fgEwi41ofmx+5l
        JxJk2jclPPW3E0ZMhCdcZSfo/eOeVqCHShkXKaqIFZZm1WEvmxe7fBh2fUqw4pIgbtCS4q/UXRvoT
        GwYrKRIQ==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqc0-0008Cj-G3; Fri, 14 Jun 2019 18:07:41 +0000
Date:   Fri, 14 Jun 2019 15:07:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 00/16] Add support to generate ABI documentation at
 admin-guide
Message-ID: <20190614150736.043cb2dd@coco.lan>
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

In time: forgot to add a 00/16 patch... someone come to my desk while I was
sending this... sorry for that.

That's the second version of the doc ABI updated logic.

Changes from version 1:

- I updated my e-mail on older patches;

- Two new ABI fix patches;

- Improved the parser to detect a few more issues I discovered on
  some ABI files.

- There's now a "validate" command at get_abi.pl. It simply runs
  the parser without any output, except for warnings;

- It now runs "get_abi.pl validate" during the build (if enabled).

Please notice that the last patch will conflict with another patch
merged via docs-next tree, with creates a Documentation/Kconfig and
adds a check at Documentation/Makefile for broken documentation
links. The conflict is trivial to solve, through: just add the contents
on both tress.

This series is based on your driver-core git tree.

-

On this series:

- The first two patches contain two extra ABI fixes;

- The next 10 patches contain the ABI parsing script. I don't
  mind if you prefer folding them on a single patch, but IMO,
  preserving the history may help tracking bugs, if any;

- The 13th patch adds the new script to the documentation build
  system, together with a new python Sphinx extension with calls it;

- The 14th patch fixes the python script when running with newer
  Sphinx versions (1.7 and upper);

- The 15th patch fixes an UTF-8 troubles;

- The final patch adds a Kconfig var that will check for ABI
  file problems, if COMPILE_TEST and WARN_ABI_ERRORS are
  enabled.


Mauro Carvalho Chehab (16):
  ABI: sysfs-bus-pci-devices-aer_stats uses an invalid tag
  ABI: Fix KernelVersion tags
  scripts: add an script to parse the ABI files
  scripts/get_abi.pl: parse files with text at beginning
  scripts/get_abi.pl: avoid use literal blocks when not needed
  scripts/get_abi.pl: split label naming from xref logic
  scripts/get_abi.pl: add support for searching for ABI symbols
  scripts/get_abi.pl: represent what in tables
  scripts/get_abi.pl: fix parse issues with some files
  scripts/get_abi.pl: avoid creating duplicate names
  scripts/get_abi.pl: add a handler for invalid "where" tag
  scripts/get_abi.pl: add a validate command
  doc-rst: add ABI documentation to the admin-guide book
  docs: sphinx/kernel_abi.py: fix UTF-8 support
  sphinx/kernel_abi.py: make it compatible with Sphinx 1.7+
  docs: Kconfig/Makefile: add a check for broken ABI files

 Documentation/ABI/testing/pstore              |   2 +-
 .../sysfs-bus-event_source-devices-format     |   2 +-
 .../ABI/testing/sysfs-bus-i2c-devices-hm6352  |   6 +-
 .../testing/sysfs-bus-pci-devices-aer_stats   |  24 +-
 .../ABI/testing/sysfs-bus-pci-devices-cciss   |  22 +-
 .../testing/sysfs-bus-usb-devices-usbsevseg   |  10 +-
 .../ABI/testing/sysfs-driver-altera-cvp       |   2 +-
 Documentation/ABI/testing/sysfs-driver-ppi    |   2 +-
 Documentation/ABI/testing/sysfs-driver-st     |   2 +-
 Documentation/ABI/testing/sysfs-driver-wacom  |   2 +-
 Documentation/Kconfig                         |  11 +
 Documentation/Makefile                        |   5 +
 Documentation/admin-guide/abi-obsolete.rst    |  10 +
 Documentation/admin-guide/abi-removed.rst     |   4 +
 Documentation/admin-guide/abi-stable.rst      |  13 +
 Documentation/admin-guide/abi-testing.rst     |  19 +
 Documentation/admin-guide/abi.rst             |  11 +
 Documentation/admin-guide/index.rst           |   1 +
 Documentation/conf.py                         |   2 +-
 Documentation/sphinx/kernel_abi.py            | 164 ++++++
 lib/Kconfig.debug                             |   2 +
 scripts/get_abi.pl                            | 475 ++++++++++++++++++
 22 files changed, 753 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/Kconfig
 create mode 100644 Documentation/admin-guide/abi-obsolete.rst
 create mode 100644 Documentation/admin-guide/abi-removed.rst
 create mode 100644 Documentation/admin-guide/abi-stable.rst
 create mode 100644 Documentation/admin-guide/abi-testing.rst
 create mode 100644 Documentation/admin-guide/abi.rst
 create mode 100644 Documentation/sphinx/kernel_abi.py
 create mode 100755 scripts/get_abi.pl

-- 
2.21.0
