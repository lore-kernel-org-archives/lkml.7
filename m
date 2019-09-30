Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD8C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746BF20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="c55I2Lc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfJAACl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:02:41 -0400
Received: from alpha.anastas.io ([104.248.188.109]:53211 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732515AbfJAACl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:02:41 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id B632F7FD54;
        Mon, 30 Sep 2019 18:55:37 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1569887738; bh=g3OgtUkIzypG8+fYbjfl8N5a0geT6PHfCSF+f6yKY4w=;
        h=From:To:Cc:Subject:Date:From;
        b=c55I2Lc3KA7Qfe5EifBioGNSMzktIB8/T0DtOgzmnJqsdoAm0vSgTj9VFpoEdCjrQ
         ev6X7k2agIDSQtpBmjGQngPa6yxt77uq5LMRGcH2zvtR2z1Bflh/lFSFT8Nh47YKyk
         c0gWJaOMLapnoaFRd9lSW7Bh3K1UGZ+79MrEvvcgNtn/5UJUjLq3yPMnAznEv+EVvK
         bGmkj68eRdVk7FYrprbX1uIe1Zlv+6N33zY/bUwyfBZ15rOKvFFgdAGdPac+Un2g48
         /NBhWacKtfAZzO7d2SuL3PBychaFQgGyL6IvJpGGXDiMjHRUU1XzduhPkdZvVMmdde
         MJwFK6QN8vA0w==
From:   Shawn Anastasio <shawn@anastas.io>
To:     alex.williamson@redhat.com, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/1] VFIO: Region-specific file descriptors
Date:   Mon, 30 Sep 2019 18:55:32 -0500
Message-Id: <20190930235533.2759-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds region file descriptors to VFIO, a simple file descriptor type
that allows read/write/mmap operations on a single region of a VFIO device.

This feature is particularly useful for privileged applications that use VFIO
and wish to share file descriptors with unprivileged applications without
handing over full control of the device. It also allows applications to use
regular offsets in read/write/mmap instead of the region index + offset that
must be used with device file descriptors.

The current implementation is very raw (PCI only, no reference counting which
is probably wrong), but I wanted to get a sense to see if this feature is
desired. If it is, tips on how to implement this more correctly are
appreciated.

Comments welcome!


Shawn Anastasio (1):
  vfio/pci: Introduce region file descriptors

 drivers/vfio/pci/vfio_pci.c         | 105 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |   5 ++
 include/uapi/linux/vfio.h           |  14 ++++
 3 files changed, 124 insertions(+)

-- 
2.20.1

