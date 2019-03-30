Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ACBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2BA218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553970973;
	bh=ycL/FmvTFv31dFiOYMFqKEzYgUmDeDoDHFggDEipugA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vXEwJ8gU7z8yF2Mn/Zqoj9dQJIdDAc1nj3KMFvzJolFBdbxAv/xJAA2KAv8RYBjzC
	 49Fyq3qz1ggnCwuzEyaK0zpmIAjBbP7RUSybZC6Qe60kuMRf7B7ZiVfPwLZ1LWHXvk
	 N0nNw7Tp2pid9h4jPiv9DKYF/n5nKmoAgL16KgfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfC3SgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbfC3SgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:36:11 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BABA2082C;
        Sat, 30 Mar 2019 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553970970;
        bh=ycL/FmvTFv31dFiOYMFqKEzYgUmDeDoDHFggDEipugA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zlt/v5ibXSjFpchuLpB73RkXRco8CF92/sIL6QbT2ofzA/AJdgv3oMRGQvEFy5cDk
         MU95b5/5ztMeH/NUYMwkKnv6QYgzkl3Aj+HkACges0vyjlxKGorp/nLeMp/Wh+boiC
         nomLtUrWDlLaEOIXJDAs7htf5HyKUqOZf4NX+iDQ=
Date:   Sat, 30 Mar 2019 18:36:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shinji Kanematsu <kanematsu.shinji@socionext.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 0/2] Add Updown Counter support for Milbeaut M10V SoC
Message-ID: <20190330183603.55886d4f@archlinux>
In-Reply-To: <1553581954-13487-1-git-send-email-kanematsu.shinji@socionext.com>
References: <1553581954-13487-1-git-send-email-kanematsu.shinji@socionext.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 15:32:34 +0900
Shinji Kanematsu <kanematsu.shinji@socionext.com> wrote:

> This is a series of patch which adds Updown Counter support on
> Milbeaut M10V SoC.
> 
> The Updown Counter counts input pulse signal from external quadrature encoder.
> It also has input pulse signal counter function.
Hi Shinji,

Are you aware of the counter subsystem that has been proposed (and
as far as I am concerned is ready to be merged)?

https://patchwork.kernel.org/project/linux-iio/list/?series=147
(I think that's the latest version posted)..
William, perhaps you could give an update?

(bad luck, you are getting popular ;)

I'll take a quick review as it stands, as some issues may carry over.
I appreciate that it's always unfortunate to try to upstream stuff at the
same time as a new framework is being developed / upstreamed, but I don't
intend to take any additional counter drivers into IIO.  We just
end up having to maintain old interfaces in more and more drivers.

Thanks,

Jonathan

> 
> Shinji Kanematsu (2):
>   dt-bindings: iio: counter: Add Milbeaut Updown Counter
>   iio: counter: Add support for Milbeaut Updown Counter
> 
>  .../bindings/iio/counter/milbeaut-updown_cnt.txt   |  22 ++
>  drivers/iio/counter/Kconfig                        |  12 +
>  drivers/iio/counter/Makefile                       |   1 +
>  drivers/iio/counter/milbeaut-updown.h              |  38 ++
>  drivers/iio/counter/milbeaut-updown_cnt.c          | 385 +++++++++++++++++++++
>  5 files changed, 458 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
>  create mode 100644 drivers/iio/counter/milbeaut-updown.h
>  create mode 100644 drivers/iio/counter/milbeaut-updown_cnt.c
> 

