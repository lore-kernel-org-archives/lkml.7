Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC8B20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCGAHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:07:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:33835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfCGAHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:07:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 16:07:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,449,1544515200"; 
   d="scan'208";a="131885272"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 06 Mar 2019 16:07:03 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D1EDA301BB3; Wed,  6 Mar 2019 16:07:03 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
Cc:     gladkov.alexey@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] moduleparam: Save information about built-in modules in separate file
References: <20190306165425.GD14017@MacBook-PC.fortress>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Cancel-Lock: sha1:+ngZPz4f8xkSzaw0K/q7E8D445M=
Date:   Wed, 06 Mar 2019 16:07:03 -0800
In-Reply-To: <20190306165425.GD14017@MacBook-PC.fortress> (Alexey Gladkov's
        message of "Wed, 6 Mar 2019 17:54:25 +0100")
Message-ID: <871s3jv97c.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> Problem:
>
> When a kernel module is compiled as a separate module, some important
> information about the kernel module is available via .modinfo section of
> the module.  In contrast, when the kernel module is compiled into the
> kernel, that information is not available.
>
> Information about built-in modules is necessary in the following cases:
>
> 1. When it is necessary to find out what additional parameters can be
> passed to the kernel at boot time.
>
> 2. When you need to know which module names and their aliases are in
> the kernel. This is very useful for creating an initrd image.

I would just keep it in the vmlinux as a non loadable segment, which
won't make it into bzImage. vmlinux passed around anyways, and
it's easier to handle than extra files, and it already has plenty
of metadata in it.

-Andi
