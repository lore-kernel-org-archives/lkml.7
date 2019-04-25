Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5920FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8967C206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Ksz6Xw2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfDYPcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:32:45 -0400
Received: from a9-37.smtp-out.amazonses.com ([54.240.9.37]:42332 "EHLO
        a9-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729689AbfDYPcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1556206362;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=pO2pP6FljQafTmg62m+I2qdYl7zhRSiQcJpHjYrZsOI=;
        b=Ksz6Xw2LBldNY0PeACCSCxyacWYJi2nwVBs9e+UrzD4PQHyFDVKetoqaWKWpQnf0
        WM46Uqwjfx9t2aT4o6gE4SwbHRswpzYhPz0+X6YzhW2kWmvYu3dGcDZzhQLlo06NBK3
        KiN0MpVrYl1Ekn3YvEVgztvzplukXEXDA+f/sMhI=
Date:   Thu, 25 Apr 2019 15:32:42 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] mm: Allow userland to request that the kernel clear
 memory on release
In-Reply-To: <20190424191440.170422-1-matthewgarrett@google.com>
Message-ID: <0100016a55209db0-efc46978-fa1e-48be-b17a-fcb6b58ae882-000000@email.amazonses.com>
References: <20190424191440.170422-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.25-54.240.9.37
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Matthew Garrett wrote:

> Applications that hold secrets and wish to avoid them leaking can use
> mlock() to prevent the page from being pushed out to swap and
> MADV_DONTDUMP to prevent it from being included in core dumps. Applications
> can also use atexit() handlers to overwrite secrets on application exit.
> However, if an attacker can reboot the system into another OS, they can
> dump the contents of RAM and extract secrets. We can avoid this by setting

Well nothing in this patchset deals with that issue.... That hole still
exists afterwards. So is it worth to have this functionality?

> Unfortunately, if an application exits uncleanly, its secrets may still be
> present in RAM. This can't be easily fixed in userland (eg, if the OOM
> killer decides to kill a process holding secrets, we're not going to be able
> to avoid that), so this patch adds a new flag to madvise() to allow userland
> to request that the kernel clear the covered pages whenever the page
> reference count hits zero. Since vm_flags is already full on 32-bit, it
> will only work on 64-bit systems.

But then the pages are cleared anyways when reallocated to another
process. This just clears it sooner before reuse. So it will reduce the
time that a page contains the secret sauce in case the program is
aborted and cannot run its exit handling.

Is that realy worth extending system calls and adding kernel handling for
this? Maybe the answer is yes given our current concern about anything
related to "security".

