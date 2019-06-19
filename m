Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CB7C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C4F21734
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfFSSgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:36:42 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:40510 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:36:42 -0400
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 2E7187A0318;
        Wed, 19 Jun 2019 20:36:41 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: fdomain: fix building pcmcia front-end
Date:   Wed, 19 Jun 2019 20:36:37 +0200
User-Agent: KMail/1.9.10
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617111937.2355936-1-arnd@arndb.de> <yq1v9x2uv2a.fsf@oracle.com>
In-Reply-To: <yq1v9x2uv2a.fsf@oracle.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201906192036.37384.linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2019 05:13:01 Martin K. Petersen wrote:
> 
> Arnd,
> 
> > Move the common support outside of the SCSI_LOWLEVEL section.
> > Alternatively, we could move all of SCSI_LOWLEVEL_PCMCIA into
> > SCSI_LOWLEVEL. This would be more sensible, but might cause surprises
> > for users that have SCSI_LOWLEVEL disabled.
> 
> It seems messy to me that PCMCIA lives outside of the LOWLEVEL section.
> 
> Given that the number of users that rely on PCMCIA for their system disk
> is probably pretty low, I think I'm leaning towards cleaning things up
> instead of introducing a nonsensical top level option.
> 
> Or even better: Get rid of SCSI_FDOMAIN as a user-visible option and
> select it if either of the PCI/ISA/PCMCIA drivers are enabled.

SCSI_FDOMAIN is not an user-visible option. PCI/ISA/PCMCIA drivers select it:

Symbol: PCMCIA_FDOMAIN [=m]
Type  : tristate
Prompt: Future Domain PCMCIA support
  Location:
    -> Device Drivers
      -> SCSI device support
        -> PCMCIA SCSI adapter support (SCSI_LOWLEVEL_PCMCIA [=y])
  Defined at drivers/scsi/pcmcia/Kconfig:22
  Depends on: SCSI_LOWLEVEL_PCMCIA [=y] && SCSI [=y] && PCMCIA [=m] && m && MODULES [=y]
  Selects: SCSI_FDOMAIN [=m]


Symbol: SCSI_FDOMAIN [=m]
Type  : tristate
  Defined at drivers/scsi/Kconfig:666
  Depends on: SCSI_LOWLEVEL [=y] && SCSI [=y]
  Selected by [m]:
  - SCSI_FDOMAIN_PCI [=m] && SCSI_LOWLEVEL [=y] && PCI [=y] && SCSI [=y]
  - SCSI_FDOMAIN_ISA [=m] && SCSI_LOWLEVEL [=y] && ISA [=y] && SCSI [=y]
  - PCMCIA_FDOMAIN [=m] && SCSI_LOWLEVEL_PCMCIA [=y] && SCSI [=y] && PCMCIA [=m] && m && MODULES [=y]


Symbol: SCSI_FDOMAIN_ISA [=m]
Type  : tristate
Prompt: Future Domain 16xx ISA SCSI support
  Location:
    -> Device Drivers
      -> SCSI device support
        -> SCSI low-level drivers (SCSI_LOWLEVEL [=y])
  Defined at drivers/scsi/Kconfig:687
  Depends on: SCSI_LOWLEVEL [=y] && ISA [=y] && SCSI [=y]
  Selects: CHECK_SIGNATURE [=y] && SCSI_FDOMAIN [=m]


Symbol: SCSI_FDOMAIN_PCI [=m]
Type  : tristate
Prompt: Future Domain TMC-3260/AHA-2920A PCI SCSI support
  Location:
    -> Device Drivers
      -> SCSI device support
        -> SCSI low-level drivers (SCSI_LOWLEVEL [=y])
  Defined at drivers/scsi/Kconfig:670
  Depends on: SCSI_LOWLEVEL [=y] && PCI [=y] && SCSI [=y]
  Selects: SCSI_FDOMAIN [=m]



-- 
Ondrej Zary
