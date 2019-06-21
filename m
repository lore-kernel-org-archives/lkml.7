Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E43FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D032166E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561115156;
	bh=ReCmP6mZfL1ydIGUwQ4K2uET7mhSIXqXsNY0Kqa1ySw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KPvp+Ko2SOoSRFG6nay1Kk7gAYsvnQ+cKhxnxD3CZMm4aM0tYpGec5twqUMe+qKhR
	 cjDGPx2hz/n4cxUY9sE1c6J5cCghpSqw6UEG49i6D/k3M2+10PK8zJbXsjhqg0JVTB
	 xSSwom2NfEdvfJVP01gWilTVGu2G69poKhrd6lpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFULFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfFULFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:05:54 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164A92166E;
        Fri, 21 Jun 2019 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561115153;
        bh=ReCmP6mZfL1ydIGUwQ4K2uET7mhSIXqXsNY0Kqa1ySw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NIC2KOGLU15vwFdrXsQ21f9HMYashjo+GAIUq6aifrxmM89h8cRes6df3JvCiA7eq
         2DU/z/gk090aRiPnYt4ngLLocux78M7bA8oaGNvZXxPpV78wQjOzz8AxZKgp8xaFRk
         xDli3JazZtxwjq8C6BEzFWnnz0XkygQ00Q2fhhMY=
Received: by mail-wr1-f46.google.com with SMTP id n9so6208745wru.0;
        Fri, 21 Jun 2019 04:05:53 -0700 (PDT)
X-Gm-Message-State: APjAAAVFUdqBp+EiemohGH3+QizgWYIoMp03p4ryAUSP3opqTnxStBSP
        QrRxJ5eGdDFk98YNEAKf2FmCvQ3VadrcBgUNKDM=
X-Google-Smtp-Source: APXvYqy3WEx+tbb1lSRS7oX70n7cxQ8/V6LHDFq6jUOe/chVbdAzS0mtEBdOyy3UK2+rxyQyjrTafv2Wkf8jsgV+2d8=
X-Received: by 2002:adf:dd89:: with SMTP id x9mr18958136wrl.7.1561115151644;
 Fri, 21 Jun 2019 04:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1561109999-4322-1-git-send-email-guoren@kernel.org>
 <1561109999-4322-3-git-send-email-guoren@kernel.org> <2c6acec4-07b7-b214-9eeb-964dc3a0d632@arm.com>
In-Reply-To: <2c6acec4-07b7-b214-9eeb-964dc3a0d632@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Jun 2019 19:05:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ0xQtQY1t-g9FgWaxfDXppMkFooCQzTFy7+ouwUfyA6w@mail.gmail.com>
Message-ID: <CAJF2gTQ0xQtQY1t-g9FgWaxfDXppMkFooCQzTFy7+ouwUfyA6w@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] csky: Add new asid lib code from arm
To:     Julien Grall <julien.grall@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Arnd Bergmann <arnd@arnd.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot delete arm's. It's mistake, no change arm64 file.

On Fri, Jun 21, 2019 at 6:10 PM Julien Grall <julien.grall@arm.com> wrote:
>
> Hi,
>
> On 21/06/2019 10:39, guoren@kernel.org wrote:
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Arnd Bergmann <arnd@arnd.de>
> > Cc: Julien Grall <julien.grall@arm.com>
> > ---
> >   arch/arm64/lib/asid.c        |   9 ++-
>
> This change should be in a separate e-mail with the Arm64 maintainers in CC.
>
> But you seem to have a copy of the allocator in csky now. So why do you need to
> modify arm64/lib/asid.c here?
>
> Cheers,
>
> --
> Julien Grall



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
