Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B936EC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B2C218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563867857;
	bh=W1pktAKF03cIz53doeXTQHVhEL7V7JEMh+LhGGeLU/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cv6yxPgxe+N0zjSm599tXz65NJNJrbkzA5eq+DvE4UdKlUU32aAjDFKBQ4msD352O
	 eiHYuKoJiG3r+wi9UONABO/z0hGbspPGRkPkS3MtCmJGHQCwWJVkDfgOND16U+7Aem
	 5FhjLc2m13g6r7+M1fwap3pTkIciMlThc4/7QNQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbfGWHoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:44:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37228 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbfGWHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:44:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so31639566oih.4;
        Tue, 23 Jul 2019 00:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUTn3Sefne0u1sZcKAcuS7rONC55CaT6SS/Ew5YKSHk=;
        b=MJGQnPjUdLeI0G9kio1G1x5TcVTSqOW7Jnaki5x8ZK0xlmH3CQnrnNx71RONSOxQgx
         IAgejlfl2iE/bbJBx2qFY87EQ/odeCO1/ynKWQRAXKmVb2UKua8TD95OOstK4cmxCCBi
         pVk+3WNuVioOfN1c/gJgR7wcOyuCVbYUpL3wKrg7UViWKYQY1WVY162rrDM+PL5s+CP6
         +aoX3ji7Ys4AMEQ9cIj51sXGvLBDXyyGyxxijzsQmnWBr6d+/MrFBfGCQ15R2vIPItZ4
         iXao+8spWcTKFlh4FUHQPD4AelsjzUEP6BdCWMumuptTR6Blha4cNeHb9zw43ttRcvep
         iHNQ==
X-Gm-Message-State: APjAAAXrge1GV/9wPzjbQpNFsFtyU+vIcfskcJutTgyUsAszmkWvFDAq
        4JiseTk9wpqDI1Qz+4fqaeAMWy08NIQrxgYtnOA=
X-Google-Smtp-Source: APXvYqyC6laAsyvmocrQ0ElRtkXSHMaP9OFG1frZHCrsm+toMCKMW2G0KC80bxrjGhpdfd5XvT/y+hdJIWwNvv6uoF8=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr32899440oig.115.1563867855388;
 Tue, 23 Jul 2019 00:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190722182451.GB24412@kroah.com> <20190722223337.36199-1-ravisadineni@chromium.org>
In-Reply-To: <20190722223337.36199-1-ravisadineni@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Jul 2019 09:44:02 +0200
Message-ID: <CAJZ5v0ikknRGPg0fhPRB2oLxtC0kD=8DX=6Z9MgtAYTO+YZ3ng@mail.gmail.com>
Subject: Re: [PATCH 0/2] power: Refactor device level sysfs.
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, tbroch@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 12:33 AM Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
>
> wakeup_abort_count and wakeup_count attributes print the
> same (wakeup_count) variable. Thus this patchset removes the
> duplicate wakeup_abort_count sysfs attribute. This patchset also
> exposes event_count as a sysfs attribute.
>
> Ravi Chandra Sadineni (2):
>   power: sysfs: Remove wakeup_abort_count attribute.
>   power:sysfs: Expose device wakeup_event_count.

I don't think you need this at all, because
https://patchwork.kernel.org/patch/11045069/ is exposing what you need
already.

Thanks!
