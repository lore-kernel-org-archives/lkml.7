Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73606C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA142082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554229684;
	bh=p2vac/PvgYjmRUWgNY6t5VCBn6XLBmcK6FXROsSb7oA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XNo6i/xmnD01264uw7j7WiuLeqb8i3Xo5Bt5kHVyWSIoAmb/hKvELr+77xJU6fr04
	 n3msdsGxt9EywhTlRWiWd3z1iHeubOM7Y78so1y4gkaJUsaOphb62vV3SBRT92GyqO
	 LExOLdhyu+V7yUb9/q8zUE35r5fumuCIGshIP9LY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfDBS2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfDBS2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:28:02 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2B92082C;
        Tue,  2 Apr 2019 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554229681;
        bh=p2vac/PvgYjmRUWgNY6t5VCBn6XLBmcK6FXROsSb7oA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XYVgmd4Gt3v/QWQr0qe68OIJCzmH14K+vsGXpOrZFsM+uTv0J3LVtwS3hxJ8THwqT
         c/j6/sb0MXKOLZtGslLNotCw0Ot9M04JjNBOVCHI8OtLtMI2u5lOLy6X/uwVHkqRM+
         XWmz5noJ91I8jWWfWlKxH2/vQV8Qyymu03pBv88A=
Received: by mail-ed1-f48.google.com with SMTP id s16so12567007edr.3;
        Tue, 02 Apr 2019 11:28:00 -0700 (PDT)
X-Gm-Message-State: APjAAAX3K5AvFIRqEAP7Kam0hTggSjjVwBqkpVuFzcQmahKFlebkTDpu
        UX9dJWrrffRUgAc7e1arKK0KjJ7Cprwiomg3ZH0=
X-Google-Smtp-Source: APXvYqwsywFoxkKDpR4AJ7cstgyIkZjNJd29jZiKGA2hoNuppmZIkyCHOwtj0kX74JpsymvkxsfbfiGT8yHC3sAK/lw=
X-Received: by 2002:a50:94aa:: with SMTP id s39mr49592784eda.191.1554229679567;
 Tue, 02 Apr 2019 11:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190402123123.915-1-nava.manne@xilinx.com> <20190402123123.915-4-nava.manne@xilinx.com>
In-Reply-To: <20190402123123.915-4-nava.manne@xilinx.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 2 Apr 2019 13:27:23 -0500
X-Gmail-Original-Message-ID: <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
Message-ID: <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 7:32 AM Nava kishore Manne <nava.manne@xilinx.com> wrote:

Hi Nava,

Looks good.

>
> This patch adds FPGA Manager support for the Xilinx
> ZynqMP chip.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
> Changes for v4:
>                 -Updated the Fpga Mgr registrations call's
>                  to 5.0
>                 -Removed dma_set_mask_and_coherent() As the FW
>                  supports only 32-bit address operations.
>
> Changes for v3:
>                 -Created patches on top of 5.0-rc5.
>                  No functional changes.
>
> Changes for v2:
>                 -Fixed some minor coding issues as suggested by
>                  Moritz
>
> Changes for v1:
>                 -None.
>
> Changes for RFC-V2:
>                 -Updated the Fpga Mgr registrations call's
>                  to 4.18

Thanks,
Alan
