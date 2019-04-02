Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B270C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6E0207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FK03rLKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfDBDcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:32:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46318 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfDBDci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:32:38 -0400
Received: by mail-io1-f65.google.com with SMTP id b9so9667255iot.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKtA2OgqesJBgzJYv1b+Ap0iRtQayk+lqCYbZ43xI8w=;
        b=FK03rLKmh+06R2ISmVFdO7t/8HBcyHS2UDZoQoNlv9KGwRE+69v+4KB4ebmrk2/J71
         0DeUU2S8KwGTfOSfxly4wSnuwxE6ewXSxBLMstzrDwfu/4Qx+1hPDmjBBIFj4yhIvEIA
         Bpzv5Rci63I0JFxRytOShr4IFrPuCGvBtpoTWNY6fs4ENlG/LB3Wqsdm3jFeKSuKXY+s
         99k9Y7eyKX8e/aGaI5E7jx2G9iOq+NYuWLfwX/mopoJiTmbm23d+Zsim3b/YwNb0nsuh
         WEZUY7IFvGoag9ePUe2PMs9DXUvVU6iyp5yk06iroetquCDju7bjtWGovkql1pXOyLvE
         sdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKtA2OgqesJBgzJYv1b+Ap0iRtQayk+lqCYbZ43xI8w=;
        b=Cxd93v45Cea3WexGqp+e7eH/JPtAdQ9bjV72tcogunpXbSAGPnl+yMq1CF1Ff3Nhrk
         Qtia3glUXfu1OpElo0xfTd/40rXBg4sGlFx+KyJOxye14Dda9+GL8jMNeXX8BNO4JtBg
         7LPuDyFWbrC4/8BlVzZXotd89C90iWUUhDCHYDVUXzRJwhnGTJIKrv2y01TePFjzQ9VV
         WBRJUdP+0XE8dlz2HgDpNguqS+QvhSa6sYp6t7V/MHfEbNCZm42Boelh/xnULB2TRrmA
         t9AqqoaMDIMk8UrCysFY7XZZOnLXWpNwPoA663DTxwfS3Tw2pVcH6iTFyvFevpu7u/dN
         cbng==
X-Gm-Message-State: APjAAAVdRlIhtotSI5DuJnpM2TCP1IFM2WCCQ5FqmRShfdQGYfKldL8C
        xPZVMUZS4/dPzHmgYhowbuZ2DresrwVb6+5WawqXGg==
X-Google-Smtp-Source: APXvYqyZsfl/tvgNCDWz0p3ouDKb+EqMbRCuHOu/5wT+soY7NpSaj22jNyr0K+QB2W87ITBd0Ec0w4XjUQ+pDdk4A7E=
X-Received: by 2002:a6b:3106:: with SMTP id j6mr2342777ioa.147.1554175957400;
 Mon, 01 Apr 2019 20:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com> <20190401235245.GA29282@linux.intel.com>
In-Reply-To: <20190401235245.GA29282@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 1 Apr 2019 20:32:26 -0700
Message-ID: <CACdnJutCC7n++Nz5qy1YzmsSchEApDUvMH9-qpxYXckh-Dzf-Q@mail.gmail.com>
Subject: Re: Add support for TCG2 log format on UEFI systems
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     tomas.winkler@intel.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 4:52 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Feb 27, 2019 at 12:26:54PM -0800, Matthew Garrett wrote:
> > Identical to V4, but based on tpmdd-next
>
> OK, so on my GLK NUC I get valid final log and invalid event log
> after adding some extra klogs.
>
> I.e.
>
> -       if (efi.tpm_log == EFI_INVALID_TABLE_ADDR)
> +       if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {

Just to make sure - are you booting via the EFI boot stub? We need to
obtain the boot log before ExitBootServices() is called, so if you're
booting directly into the 32-bit entry point (eg, by using the "linux"
command in grub) then you won't get a log.
