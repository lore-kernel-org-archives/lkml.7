Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4B6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA83420835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RH8LeJhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfK0Sqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:46:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44287 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0Sq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:46:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id a67so20509303edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tpI2XoAW/k1mZjy4gzuYvN2YL24d+FpjBX490TbnwUE=;
        b=RH8LeJhvVzlMCXZ7WjoiTtiM9N/So7uV3pgPiPV7vKSq/PW1mZ1u5DwGUkxNZYEuOE
         e5Z7Qsn+A0tUMMAoWegrtL2O64E4FgS6loxu/UM+cXi2JMBYH87LuyZMB/RSdXvhLtYm
         DEAgkP9gDh78EeN0vs6/VRGYYfyBllv8qhI9zmOdq2d8Z+MnfH33AwMB77n7qG8eTTQq
         0R00yySmFT074wdZ/W7URfBlaP1Epqn9FU74eMCZc4szX45AKQJB649QOtmGsbzHjUrR
         nNo/IBNQnWbwb3iO2Y9cm8ePzpJ97HiwmBW4sqOssrUPcTGwLzIMmo6SMS1yrPv8b5ch
         hLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tpI2XoAW/k1mZjy4gzuYvN2YL24d+FpjBX490TbnwUE=;
        b=JNMEHsdyo6nXnEOcCTBK8nlRcfyxYioOdlS8R/aYc7ErmaW+Eyv6FGrNPEQoDr4jS9
         ho/StSM0RwaugqjLg9JW76AO/k7rScZ1C+qDKwyy+qgUD6sKLgsUsNlVbc4Zy43gUyi3
         l3MbdiUcanMVU5T8bWo2nNq3rePbzp99ZM5HBB2GA3XGWw8e7/lcneD+auinrExVRT1Y
         0qaVvSuQN9Up2r5tv6XbUYUvCqAXwVAotoVNtS5sfuFkiw1bJsrCovG5Fx27k85ecI55
         dYOTwIncMEDEAxHPV2aEXX+RtQoXqZfGDfEYwsN2MJkt88asKMA///6PeNnHlCXozXzR
         ZXIQ==
X-Gm-Message-State: APjAAAUkxO19ofk9PrhIgEdE+ldLJIxmNmrMit/Oqt1aDU88QqIx9Z+H
        2jvSktAEBXpbIqZ4kuoR+K89iCYI9v/o6FOP/kG+PA==
X-Google-Smtp-Source: APXvYqxzK9b1CLo07dbU3ghSiRxdeAWfozjlG21pdzxsPLtKe5C44CL7hIgPgRxjHBMEtB/mwGcYWK9arS+KDvH76zw=
X-Received: by 2002:a17:906:b30c:: with SMTP id n12mr49955881ejz.96.1574880387878;
 Wed, 27 Nov 2019 10:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20191127184453.229321-1-pasha.tatashin@soleen.com>
In-Reply-To: <20191127184453.229321-1-pasha.tatashin@soleen.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Nov 2019 13:46:17 -0500
Message-ID: <CA+CK2bDk13O5-Yx9Kz_ZXj=JpfBWbqVUVgpsXcjW0TvKaRnxAw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Use C inlines for uaccess
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to set the subject prefix correctly. It should be: [PATCH v3 0/3].

On Wed, Nov 27, 2019 at 1:44 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Changelog
> v3:
>         - Added Acked-by from Stefano Stabellini
>         - Addressed comments from Mark Rutland
> v2:
>         - Addressed Russell King's concern by not adding
>           uaccess_* to ARM.
>         - Removed the accidental change to xtensa
>
> Convert the remaining uaccess_* calls from ASM macros to C inlines.
>
> These patches apply against linux-next. I boot tested ARM64, and
> compile tested ARM change
> Pavel Tatashin (3):
>   arm/arm64/xen: use C inlines for privcmd_call
>   arm64: remove uaccess_ttbr0 asm macros from cache functions
>   arm64: remove the rest of asm-uaccess.h
>
>  arch/arm/include/asm/assembler.h       |  2 +-
>  arch/arm/include/asm/xen/hypercall.h   | 10 +++++
>  arch/arm/xen/enlighten.c               |  2 +-
>  arch/arm/xen/hypercall.S               |  4 +-
>  arch/arm64/include/asm/asm-uaccess.h   | 61 --------------------------
>  arch/arm64/include/asm/cacheflush.h    | 39 ++++++++++++++--
>  arch/arm64/include/asm/xen/hypercall.h | 28 ++++++++++++
>  arch/arm64/kernel/entry.S              | 27 +++++++++++-
>  arch/arm64/lib/clear_user.S            |  2 +-
>  arch/arm64/lib/copy_from_user.S        |  2 +-
>  arch/arm64/lib/copy_in_user.S          |  2 +-
>  arch/arm64/lib/copy_to_user.S          |  2 +-
>  arch/arm64/mm/cache.S                  | 42 ++++++------------
>  arch/arm64/mm/flush.c                  |  2 +-
>  arch/arm64/xen/hypercall.S             | 19 +-------
>  include/xen/arm/hypercall.h            | 12 ++---
>  16 files changed, 130 insertions(+), 126 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/asm-uaccess.h
>
> --
> 2.24.0
>
