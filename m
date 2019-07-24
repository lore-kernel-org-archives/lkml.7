Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF8AC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756A1229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3P1lO6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGXINS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:13:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38085 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfGXINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:13:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so11512750edo.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=+rNRJY68IIsD9nh+g9TvsIleBslPfLPXnzcgzuZEN48=;
        b=I3P1lO6M7mukJ8KziuxO4lwxZaCAEl58oUX+PO1XCwcZyQwz3JtUDGwgufNide1IPU
         Q7YNLXYcjqeHdQKGY8/cvpw/sv2h35skgV1k8YlZlW62GNfBPPbi2nnAOeqYJbShHm3v
         2F0rU4+6x5NgLoN7doN5wb9j0sy1IHdQNCfp9aGSubZjGl9sAGRLy9lZnO6NzIlopx6V
         RUIjlm5lSh9geksn3AT3RAcweH/lhkcgrj0rPndv/4XXANjOlLSnFo2VDcab+7jus4fg
         +zCdTioMfVUew0SNjSjaVkFZh4eQItDnlcrwolp7ZBtE4vMSr3/VpMqgYcWfJkk1GGDg
         bsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=+rNRJY68IIsD9nh+g9TvsIleBslPfLPXnzcgzuZEN48=;
        b=tYEJByjbHoaCWu14VLGYPu7DZgt/OI4ZfOcPGYMnIwdZMXH0st4946WHig19H3v31S
         YEZS89GRnvUPNpeADw12uLzu3Qgj6NvlIqWIN9BJj3zWQBrTHdWs0maJ20CWxiViTD3W
         T+NP2gIit8g42Hy8uv/iwSXwc8NIlAPQEdL/Yg1ln3pfnNf/cwC4FMmVc4q9RJcGCtTC
         hU9fMBB6hz1cKtG1nyyUmK38WB6U4ATUNNNewf74PKqXzbsijyMnEfJXnYaCamagzRQ7
         ViTo1g+0UfeiCDVmrOQHGeWRerwUu+gBrkHpQd+KIYpi1sGJEeqM64MiJRn7zltUzkoB
         uSAw==
X-Gm-Message-State: APjAAAUx9p/lI/Nh84BgwO0nSCXvsl/hE9uN4g+yPWVK+qjsrMTJzFu0
        pPD2p3WH4GSz9z+hxhcF64PWAFhRZCkWI5tmeGc=
X-Received: by 2002:a05:6402:896:: with SMTP id e22mt65279499edy.202.1563955993753;
 Wed, 24 Jul 2019 01:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190724060512.23899-1-hslester96@gmail.com>
In-Reply-To: <20190724060512.23899-1-hslester96@gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Wed, 24 Jul 2019 16:13:03 +0800
Message-ID: <CANhBUQ0gYF+cF1EjfSA-WVvAKipQHWgkasXN91mphHYsZV+uMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/8] Use dev_get_drvdata where possible
Cc:     Steffen Klassert <klassert@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        Rasesh Mody <rmody@marvell.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Guo-Fu Tseng <cooldavid@cooldavid.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 2:05 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> These patches use dev_get_drvdata instead of
> using to_pci_dev + pci_get_drvdata to make
> code simpler where possible.
>
> Changelog:
>
> v1 -> v2:
> - Change pci_set_drvdata to dev_set_drvdata
>   to keep consistency.
>

Hi all,
I checked the cases which mentioned the consistency
of get/set_drvdata usages.
The cases' commit IDs are
488d040e3a3452a0dceef5d3ec4f61942262f57f
b77c98780e682fe780d899b91543769d4cf94585

After checking, I think that the consistency problem
refers to inconsistency between probe and remove.
But the changes of these patches are not related
to probe and remove.

So I think the previously sent and applied v1 patches
which do not change pci_set_drvdata to dev_set_drvdata
are okay.
Therefore there may be no need to use these v2 patches.

Regards,
Chuhong


> Chuhong Yuan (8):
>   net: 3com: 3c59x: Use dev_get_drvdata
>   net: atheros: Use dev_get_drvdata
>   net: broadcom: Use dev_get_drvdata
>   e1000e: Use dev_get_drvdata where possible
>   fm10k: Use dev_get_drvdata
>   i40e: Use dev_get_drvdata
>   igb: Use dev_get_drvdata where possible
>   net: jme: Use dev_get_drvdata
>
>  drivers/net/ethernet/3com/3c59x.c               |  8 +++-----
>  drivers/net/ethernet/atheros/alx/main.c         |  8 +++-----
>  drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 10 ++++------
>  drivers/net/ethernet/atheros/atlx/atl1.c        |  8 +++-----
>  drivers/net/ethernet/broadcom/bnx2.c            |  8 +++-----
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  8 +++-----
>  drivers/net/ethernet/broadcom/tg3.c             |  8 +++-----
>  drivers/net/ethernet/intel/e1000e/netdev.c      |  9 ++++-----
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 10 ++++------
>  drivers/net/ethernet/intel/igb/igb_main.c       |  5 ++---
>  drivers/net/ethernet/jme.c                      |  8 +++-----
>  12 files changed, 38 insertions(+), 58 deletions(-)
>
> --
> 2.20.1
>
