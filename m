Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0946FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 22:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFB6205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 22:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SDs1XLSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLaWWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 17:22:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45327 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfLaWWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 17:22:00 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so51767007otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 14:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlT2jnj7z1iFkAKUNQWbQsSo+TR/YWaOOgSod0k7w7Q=;
        b=SDs1XLSXb/UhPFICpRz+QEz2jdxJ6mnD5z1RgiUjXl2kSN/SRjY9qdkxJyPAomSFTo
         4W9MT/Op5DGfy6j89Y0CN+wSoO62llB4hEsqZe/GklaDrEVyBKPBfqdEaWhDU8nIxLmJ
         9G0L5DxAM6OUB020gwJZmEOLfI2umTuE8DSX41pN9b6WJW23421YpX2Wkr4V9QE/5XC1
         TzPh49oF7f8lsyZ4X7hp8T26FyBOWgQZPAGfV5pzgheLaoIKmuE6AU6YHebo+rk5XUYQ
         tjdS2jb/XLEk3L/6NONnK54wVAI1n0emlo3so96l7qP/07/oL/REYGzpBJAAD9H4Sk7W
         lbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlT2jnj7z1iFkAKUNQWbQsSo+TR/YWaOOgSod0k7w7Q=;
        b=GqE+qlzdfL707OoeBYq5ge9UgGY4euC8YPzla52BQGvX6Re7W4eeEHCmySZc7kEjEG
         9w0uI6i/UHWOi8mhsTfaAA0DHo5P0hcJs0ypyYJ+KlYRloqcsSyctRkKWWNB/HIsC2NV
         yTqm2pnK/owF8Romr4CpD3exqZpad5iyrAIUkVBlF/1zRPC5joU2GRBL2C2H7xoca2v+
         bIE/JUmrQKgSZCuT9+sxYxY19jI1YbIt/4pMV9EFXMN46FMHTLoMDUkeru26X7+bbFB1
         tP4d56TWb8ogNVpjrNp7PHKGlxN4iqlJzLDFr4KCJifMdT4pVyITQlwu3wsBrhsDAxZF
         GrhA==
X-Gm-Message-State: APjAAAVIXA8WMIgWzDMRxbHf4DfA+g5Dz1ogx4n4xQWLdCEw5eER02HI
        jOswj/MUy4hEW7NEFAgURBhakZrv8gi8Yvns4ASsRg==
X-Google-Smtp-Source: APXvYqy1Nlu/1GbgH0I6iq3zMFnAaxwd8ZFUXv3pxT0OCb9TlTQPfJLMpeN7TKNH/fK7w1/i3uKBuqDIMtTj0BVo/Zw=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr84887327otk.363.1577830919298;
 Tue, 31 Dec 2019 14:21:59 -0800 (PST)
MIME-Version: 1.0
References: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191231014630.GA24942@dhcp-128-65.nay.redhat.com> <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
In-Reply-To: <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Dec 2019 14:21:48 -0800
Message-ID: <CAPcyv4idLx58iH0tA08vrVdvornd-jAwSwHQ6Eha+Z_UQUDDAQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix handling of multiple contiguous efi_fake_mem= entries
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 1:11 PM Dan Williams <dan.j.williams@intel.com> wrote:
> Perhaps a prettier way to do this is to push the handling of each
> efi_fake_mem entry into a subroutine. However, I notice when a memmap
> allocated by efi_memmap_alloc() is replaced by another dynamically
> allocated memmap the previous one isn't released. I have a series that
> fixes that up as well.

Available here:
http://lore.kernel.org/r/157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com
