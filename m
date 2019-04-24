Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6E820878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfDXJ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbfDXJ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:29:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F5B830BA359;
        Wed, 24 Apr 2019 09:29:57 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B37A960C70;
        Wed, 24 Apr 2019 09:29:46 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     bp@alien8.de, j-nomura@ce.jp.nec.com, kasong@redhat.com,
        dyoung@redhat.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, hpa@zytor.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 0/2] x86/boot: Use efi_setup_data for searching RSDP on kexec-ed kernel
Date:   Wed, 24 Apr 2019 17:29:42 +0800
Message-Id: <20190424092944.30481-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 24 Apr 2019 09:29:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this series, patch 2/2 has dependency on patch 1/1, otherwise
it may cause system to reset to firmware on some machines.

The patch 2/2 is the version Boris organized:
http://lkml.kernel.org/r/20190416095209.GG27892@zn.tnic

Patch 1/1 is based on Kairui's v1 patch, and add ACPI tables mapping:
http://lkml.kernel.org/r/20190422092804.15534-1-kasong@redhat.com

Dave Young confirmed this patchset passed test on his t420 laptop, where
the system resetting issue caused by patch 2/2 was found.

Junichi Nomura (1):
  x86/boot: Use efi_setup_data for searching RSDP on kexec-ed kernels

Kairui Song (1):
  x86/kexec: Build identity mapping for EFI systab and ACPI tables

 arch/x86/boot/compressed/acpi.c    | 143 +++++++++++++++++++++--------
 arch/x86/kernel/machine_kexec_64.c |  86 +++++++++++++++++
 2 files changed, 193 insertions(+), 36 deletions(-)

-- 
2.17.2

