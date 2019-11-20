Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E95FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B482240D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKTEZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:25:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:58654 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfKTEZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 23:25:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 20:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,220,1571727600"; 
   d="scan'208";a="209625675"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga006.jf.intel.com with ESMTP; 19 Nov 2019 20:25:33 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 440B330084E; Tue, 19 Nov 2019 20:25:33 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
References: <20191115191728.87338-1-jannh@google.com>
        <20191115191728.87338-2-jannh@google.com>
Date:   Tue, 19 Nov 2019 20:25:33 -0800
In-Reply-To: <20191115191728.87338-2-jannh@google.com> (Jann Horn's message of
        "Fri, 15 Nov 2019 20:17:27 +0100")
Message-ID: <87lfsbfa2q.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> +
> +		if (error_code)
> +			pr_alert("GPF is segment-related (see error code)\n");
> +		else
> +			print_kernel_gp_address(regs);

Is this really correct? There are a lot of instructions that can do #GP
(it's the CPU's equivalent of EINVAL) and I'm pretty sure many of them
don't set an error code, and many don't have operands either.

You would need to make sure the instruction decoder handles these
cases correctly, and ideally that you detect it instead of printing
a bogus address.

-Andi
