Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C4CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC33D2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddqdt/lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCTMRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:17:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37110 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:17:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id u2so1697727lfd.4;
        Wed, 20 Mar 2019 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8altSk6k/Ezj4RpXnU3MDDzmmxlz8G3TW5qqD7DO/ho=;
        b=Ddqdt/ltX4pGcmedF67d9Y5RXDn2KRqUtbs4fnFF+0tRBkW+8/GCdV9szygYsZVdnw
         soascqcZ5bsUEm4/tvCPlP6VDxl16ohs2AYpgq/zE/AnQOUimKfsmYRqLjx/tuYFWHhE
         zJV8x0fkE3WEdwsnvLfnPMWMyKh6M3qkPbblwxEPHe7oQQJyFTvobmI4cy8PezaTtZzg
         eFuyFYXHFFGhkCDC+nkm7pF/oeM8e2nwgK/v03nKqIpa9vZCRYCJjTq2/xYk9WZC3PRi
         KB4jAksP4SuLfrX1zgBzlrsax+NTZmewq28uh78eSGOWp79NGugbBFSPgPP462o84ay8
         ZS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8altSk6k/Ezj4RpXnU3MDDzmmxlz8G3TW5qqD7DO/ho=;
        b=DQLJNSyVwXmqa1mmuMN+q6AnRT6Gy/IDpf09r/yw3XIAUAtoR12EekKMqUpVHDUkmX
         aeptWC3/MOo21NmFa5jACuujEsKkxy7PSjkdrY2FT226A3fy2pE5WCMVFfMhak2/HBNy
         BlO5XJ0GdhbDHIaDCYCAJXIl61p93q0ctaE8hbDqO2FCMMuB1K6+7Ob/O92HVv//AmwY
         kOPNn+mEaBvfRE1dB6yPKWUj53s13nfJkOYq04FdnGUzvgAnYoZ1sMbZMIFfalOi5gp+
         MwowOi3j10vlRwM+SKl2oxLcrEvQNE2kIiuZCrdEsLpxjoFHn/rqZR0KE6dwrEpgnkQM
         z64g==
X-Gm-Message-State: APjAAAUL37W9sQZHzdHwOzPIBYzo9fmLNeCoENmTLlUuUosirZOX9ita
        kdMD90FFapN4VTPZFPrQ3ICqz/bpFnBDrUCMZh0=
X-Google-Smtp-Source: APXvYqzKTSDYrqYhRLSFjOKswIcFaT0JOk4SYTgKy2/jBiJqv4E9ehlV7AGHrI/g3hf+q2IKlJTqnMbg1+kFzXomN4E=
X-Received: by 2002:a19:f208:: with SMTP id q8mr13604741lfh.107.1553084219461;
 Wed, 20 Mar 2019 05:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
In-Reply-To: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Mar 2019 09:16:49 -0300
Message-ID: <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use rgmii-id
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dialog Opensource Support <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, Mar 20, 2019 at 9:06 AM Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
>
> The PHY used on the Freescale i.MX6Q/DL SABRE boards is qualified as
> 'rgmii' instead of 'rgmii-id'. Meaning the RX and TX delays that were

This patch declares it as 'rgmii-id', which contradicts the commit log.

> previously added by the MAC when required, but are now provided
> internally by the PHY (and the MAC should no longer add the RX or TX
> delays in this case).
>
> This patch fixes the network problems seen on the Freescale i.MX6Q/DL

Please provide a Fixes tag. It would be good to know if this fix needs
to be applied to older kernels.
