Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA0CC072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F38208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfE0KcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:32:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50890 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfE0KcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:32:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BF7BC80490; Mon, 27 May 2019 12:32:07 +0200 (CEST)
Date:   Mon, 27 May 2019 12:31:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        bp@suse.de, hpa@zytor.com, mingo@redhat.com, x86@kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     pavel@ucw.cz
Subject: ACPI enable on Thinkpad X60 hangs when temperatures are high
Message-ID: <20190527103155.GB12391@xo-6d-61-c0.localdomain>
References: <20190527085155.GA11421@xo-6d-61-c0.localdomain>
 <20190527093938.GA12391@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527093938.GA12391@xo-6d-61-c0.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So if you compile a kernel, then reboot, boot will hang after "Freeing SMP
> > alternatives memory" (and then wastes power, making thermal situation even worse).
> 
> Normally, next message is "smpboot: CPU0: Genuine Intel...".
> 
> I added some printks, and check_bugs() returns. Then it goes to ACPI and never
> comes back...
> 
> kernel-parameters.txt points to Documentation/acpi/debug.txt, but that one does not exist.
> 
> Any ideas what debugging parameters to use for ACPI? I either get nothing or
> so much that machine does not boot...

I ended up adding printks...

It hangs in acpi_hw_set_mode().

ACPI enable: set mode: acpi
ACPI: hw_set_mode
ACPI: hw_set_mode mode switch
ACPI: write_port?
ACPI: os write port

we write to the port but that never returns.

I assume SMM is doing its magic at that point. Any ideas how to debug it further?

Is it possible that it is some kind of screaming interrupt?

										Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
