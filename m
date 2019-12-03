Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C51C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE6E20705
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T00bsc0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfLCAnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:43:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39668 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfLCAnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:43:10 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so1654009ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 16:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jnL6iDubLY8gL5JP3QSc0ju+BQUG+h8VIAOn+X5oWQ=;
        b=T00bsc0APIQpp0kFPoFsLBa72cSKQI8/kvf/jrmlw4YTXIkoV3Uo9vYbKOVb/uvmMa
         Fx0TgLfE1CVyHBCn7J7nM976Z7PON3M3w+uSZtQ2kTxe+7DNpYO1vky1kHc7MGIzcifk
         Rsgk4WafvGso2zBq8zzPlQSTSk797b7OEJlbteHeDpdZ+gwvXPs5Nniz0vbM33QLo++f
         5WJ3xnuNz/Crxcb8d8IUNaOA8+ssCGZqzJbMWlPmvRzBWmuRrGqBI8UecAbi+m6cUljH
         FvUNkjv38k90sNUFreVKS1i8TAkgxv4pKR1dCeBNykyTp5S+fR9yd6wQ6dhzRH2CzVjC
         hetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jnL6iDubLY8gL5JP3QSc0ju+BQUG+h8VIAOn+X5oWQ=;
        b=DhF6ynmi9mAssKJKmN5Kx1oC0TyAYlbXUalbAkIHRMPz2j6ZdDweK7/24Ky86tiAuG
         xFUGx98h6xfS2KCyboMYtzI517Yc1WjRAg0Njnbd6+HAyu2L164FHg9DX8BJaTPsGF/l
         eeIlNorT6sn7FqjfWPW+Y41uM4+K2BeeidR0/deuidqn7/a8GvqKVCPlt5HpFf0nFbog
         nRfG0gT1xn/Xg70kOBg/H7hYfgFq9I3HdX4w4MURpINod7mrTONTVgkCl0mWSVPZ0Pkt
         4bYaA7Bg4fd7dGFmQQHxKQ8G83NGzEMe7kutIC5VSWDtVwPx+W+nh3ky6qWKlovobZl9
         MqnA==
X-Gm-Message-State: APjAAAX8EacICCHMhPRo2zyUCkznCPMl2/PwBxeR4M8ZP9OvYDDiF/2N
        zAMCiVMadLpCXf0bsnjoUlzwrYL73z2UAqTANMU0nQ==
X-Google-Smtp-Source: APXvYqxJrkK1ZdE65kA4EuWOJ5vb0zsDMEQ4ZrjeW7uzvZYJCxvo09UHOuHs6AjLENBNZOWUxi9WR6+6dwVQ5+rKKQ4=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr235848ioq.84.1575333788813;
 Mon, 02 Dec 2019 16:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
In-Reply-To: <20191203004043.174977-1-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Dec 2019 16:42:57 -0800
Message-ID: <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 4:40 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Add an option to disable the busmaster bit in the control register on
> all PCI bridges before calling ExitBootServices() and passing control to
> the runtime kernel. System firmware may configure the IOMMU to prevent
> malicious PCI devices from being able to attack the OS via DMA. However,
> since firmware can't guarantee that the OS is IOMMU-aware, it will tear
> down IOMMU configuration when ExitBootServices() is called. This leaves
> a window between where a hostile device could still cause damage before
> Linux configures the IOMMU again.

I don't know enough about ARM to know if this makes sense there as well. Anyone?
