Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20037C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3742085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEAS7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 14:59:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40010 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEAS7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 14:59:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id y64so8991555oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 11:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+2ax8ZyIZztFylyBB7zkL9d45BwY6plRBtZFuq3Y0w=;
        b=oyJ09WdWiVE0ksKnaDfs0Z4mLFfDvEXJw6m608TVk1sKMmop0OjokhympI+55/xnLo
         lAXc9+Xx71OTCA30IlLTbymxlotbE2lUGrGx0Gui/mDqchB5iT7KyWbhL7c5npaalhgG
         HFhTaP3ouDosEdzpld7AiDIxcLQSJwhjoSe9uACpeJrElf7MgWiIl6rKPqw7TQdXkxbz
         HyWBiBv7TfKB1WP+b/4m4/89hajS/fm9mr+IdvbuZvMT7RUpUdT43a/KOuGpKWlQK7Ir
         cGpJX8JH3WWF5n6tYd5TsaHUwtuDan/dAo6bC1VfE/rtqJOQuZpDl+h8iAsesKCz188v
         FTfw==
X-Gm-Message-State: APjAAAXDZIKGBq/M+grnoeYc5XseQCPBfRLN6sUeK7lteVAoTUssOI70
        eevV02ccgir0kFzL1wPMj7Apymesikw=
X-Google-Smtp-Source: APXvYqxuF4ZrOgKgDN0G9B9VnqV2zgqYYxKIGoLFBWyyXfd2L57ctRqtiDPclK1WMovCbQvG0Z7shg==
X-Received: by 2002:aca:4c51:: with SMTP id z78mr5464667oia.106.1556737171215;
        Wed, 01 May 2019 11:59:31 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id p1sm16039834otl.75.2019.05.01.11.59.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:59:30 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id t184so12006422oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 11:59:30 -0700 (PDT)
X-Received: by 2002:aca:d984:: with SMTP id q126mr7776664oig.108.1556737169867;
 Wed, 01 May 2019 11:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <1554475256-4805-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1554475256-4805-1-git-send-email-roy.pledge@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 1 May 2019 13:59:18 -0500
X-Gmail-Original-Message-ID: <CADRPPNSLGYDGnhVfJAYk66=bP2oZVtJiynwwgLiKiAKeSseR7w@mail.gmail.com>
Message-ID: <CADRPPNSLGYDGnhVfJAYk66=bP2oZVtJiynwwgLiKiAKeSseR7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] soc: fsl: dpio: Add support for memory backed
 QBMan portals
To:     Roy Pledge <roy.pledge@nxp.com>
Cc:     "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 9:42 AM Roy Pledge <roy.pledge@nxp.com> wrote:
>
> This patch series adds support for QBMan memory backed portals which is
> avaialble in devices containing QBMan verion 5.0 and above (for example
> NXP's LX2160A SoC).
>
> Memory backed portals can be mapped as normal cacheable/shareable memory
> which allows the portals to migrate between cores without needing manual
> cache manipulations by the CPU.
>
> The patches add support for the new portal attributes in the fsl-mc bus
> drivers as well as modifying the QBMan driver to use the new portal read
> trigger mechanism.
>
> Changes since v1:
>  * Support older DPRC command in case of older MC firmware
>  * Fix issue with padding in command
>
>
> Roy Pledge (2):
>   bus: mc-bus: Add support for mapping shareable portals
>   soc: fsl: dpio: Add support for memory backed QBMan portals

Both applied for next.  Thanks.

>
>  drivers/bus/fsl-mc/dprc.c           |  30 +++++++-
>  drivers/bus/fsl-mc/fsl-mc-bus.c     |  15 +++-
>  drivers/bus/fsl-mc/fsl-mc-private.h |  17 ++++-
>  drivers/soc/fsl/dpio/dpio-driver.c  |  23 ++++--
>  drivers/soc/fsl/dpio/qbman-portal.c | 148 ++++++++++++++++++++++++++++++------
>  drivers/soc/fsl/dpio/qbman-portal.h |   5 ++
>  6 files changed, 199 insertions(+), 39 deletions(-)
>
> --
> 2.7.4
>
