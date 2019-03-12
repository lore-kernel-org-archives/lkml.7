Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A272CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C186206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M5I4Z+ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfCLRdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:33:06 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:15221 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbfCLRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1552411982; x=1583947982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zr1zhmwYLJhlOljFXMtFIz+O6pxf9ekI5Xz6wB4Amg8=;
  b=M5I4Z+ejW4VCyqeyXagBpJg4S8tRVTRfghQXnAt0r2GY/lqIGLr1dPTS
   kqnQ08WJTme4qceC3iwrdbIocuMldhcEeVfZvVoI/zgcNodbKPJwQeMue
   wCSSziqnMvHpD+w79wjzs+scZWZ/ilMVQgcstvlCQ319fu3ufuB3FD75Z
   I=;
X-IronPort-AV: E=Sophos;i="5.58,471,1544486400"; 
   d="scan'208";a="385048082"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Mar 2019 17:32:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2CHWsWR015915
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Mar 2019 17:32:57 GMT
Received: from EX13D08UEE004.ant.amazon.com (10.43.62.182) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Mar 2019 17:32:57 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D08UEE004.ant.amazon.com (10.43.62.182) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Mar 2019 17:32:57 +0000
Received: from dev-dsk-alisaidi-i31e-4ac69482.us-east-1.amazon.com
 (10.200.136.151) by mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Mar 2019 17:32:57 +0000
Received: by dev-dsk-alisaidi-i31e-4ac69482.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 0E05B47D39; Tue, 12 Mar 2019 17:32:57 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Anthony Liguori <aliguori@amazon.com>
Subject: [PATCH 0/2] handle worst-case heap randomization in mmap_base
Date:   Tue, 12 Mar 2019 17:32:46 +0000
Message-ID: <20190312173248.13490-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.15.3.AMZN
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase mmap_base by the worst-case brk randomization so that the stack and
heap remain apart.

In Linux 4.13 a change was committed that special cased the kernel ELF
loader when the loader is invoked directly (eab09532d400; binfmt_elf: use
ELF_ET_DYN_BASE only for PIE). Generally, the loader isn’t invoked
directly and this issue is limited to cases where it is, (e.g to set a
non-inheritable LD_LIBRARY_PATH, testing new versions of the loader). In
those rare cases, the loader doesn't take into account the amount of brk
randomization that will be applied by arch_randomize_brk(). This can
lead to the stack and heap being arbitrarily close to each other.

Ali Saidi (2):
  arm64/mmap: handle worst-case heap randomization in mmap_base
  x86/mmap: handle worst-case heap randomization in mmap_base

 arch/arm64/mm/mmap.c | 8 ++++++++
 arch/x86/mm/mmap.c   | 4 ++++
 2 files changed, 12 insertions(+)

-- 
2.15.3.AMZN

