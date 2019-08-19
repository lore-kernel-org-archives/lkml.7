Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EA0C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ED92086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfHSL2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:28:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41626 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHSL2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:28:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so1308986ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 04:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+WLB0FVyCSSGWK9WQDE9HGUVYBGxnjuzOBWuf7f81E=;
        b=q5hfH6qQAdHuc+BMbKTjwmsyFwn61MUCqO4KRg84lnZi54NYUZE5X35u2oWo6E1oNU
         9Asj7zZ1e518p/60yLXV5YhZOFj7kkIU+eIJjJAErBDRpchYZyDuIpYKfpMS/iVYT1Fp
         4ZbV3FBcjcGgVLoY8SHGYn7S++VsslQpQaq4gCQD+G2GL/ik9kDDp6PKJlGJRDmDBV+6
         sJNMrbPjh/cZGY8EkHow7C6fJCmhzRCFjquVqnCHwlHJ5SlCL7eXBtlMzbW5hJZ6CNsk
         coF0qx2Ey74LeYeNGfD2PN8NVbpnCXs/kHa33Uf0XuDknmTXds61LktJQ9y7sW0va/N0
         Kp+w==
X-Gm-Message-State: APjAAAUf2joxVCqkLD2Ve/d1omTC29qz+G6dVjx5V0tMdSgdThptCzva
        0pKudr7TsYwcLFXftOVoFFYzmngmuhg5eZKArsg=
X-Google-Smtp-Source: APXvYqwj+fbchNus7XKq9kP8ns/dxZ1XJLXMd9ZVrm/iQwTml5A+YPxUaw2UknQCJJS1mSjXZ+eYCfWy/thmnxdo4G8=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr1462180otk.107.1566214089829;
 Mon, 19 Aug 2019 04:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <0cb35e79fef09b12af2c3448ac4cccfda2d205eb.1562578282.git.fthain@telegraphics.com.au>
In-Reply-To: <0cb35e79fef09b12af2c3448ac4cccfda2d205eb.1562578282.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 13:27:58 +0200
Message-ID: <CAMuHMdVSGCdoDeWmQtYpx5+U51i=j4VHK+RC+=zSWEMpnF_1Cg@mail.gmail.com>
Subject: Re: [PATCH v2] m68k/mac: Revisit floppy disc controller base addresses
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Laurent Vivier <lvivier@redhat.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 11:34 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Rename floppy_type macros to make them more consistent with the scsi_type
> macros, which are named after classes of models with similar memory maps.
>
> The MAC_FLOPPY_OLD symbol is introduced to change the relevant base
> address from 0x50F00000 to 0x50000000 (consistent with MAC_SCSI_OLD).
>
> The documentation for LC-class machines has the IO devices at offsets
> from $50F00000. Use these addresses for MAC_FLOPPY_LC (consistent with
> MAC_SCSI_LC) because they may not be aliased elsewhere in the memory map.
>
> Add comments with controller type information from 'Designing Cards and
> Drivers for the Macintosh Family', relevant Developer Notes and
> http://mess.redump.net/mess/driver_info/mac_technical_notes
>
> Adopt phys_addr_t to avoid type casts.
>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Joshua Thompson <funaho@jurai.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Laurent Vivier <lvivier@redhat.com>

Thanks, applied and queued for v5,4.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
