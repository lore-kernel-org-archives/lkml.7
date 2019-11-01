Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263CCCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6850204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V95yI61Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfKAJAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:00:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36653 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKAJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:00:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so8406258wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z6VIallazyVW2gnaDH0dlgNEJHptgWdXOaqvgfmB32A=;
        b=V95yI61YpqLnaov22fsDZlcPX6FzYrjNU5v/MzYOrYhrPUZmX4Ywqs5SFxl6LY+Ap7
         erhMI26+MpwlhxrZAs4NOTKSLlIxpRMJOpMcXJVzbTi75KV+h2xk9VUmuX84ap4nKVnL
         oDW3LUfjaorx/E7gqsh3ItFTYdquNRrcqZ+fjnxDtcJz7qvaPFaE8ayb9GX3I3Mtzd2I
         zITDdIpSXeBl70dmO6Pyiv9YYpe5lcO/o8vcqpJcS5M2mfUSffyE9XCQASai6XNL0hdY
         opjXFr3mBteogYUHjR3n73kNAue3ioX68PQFVhMdRt8euhfsEaBQcEXkq4Zoj3sKLtJW
         brbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z6VIallazyVW2gnaDH0dlgNEJHptgWdXOaqvgfmB32A=;
        b=L9UpchbtMQ26WzeY0BhjOI4mKMt1hIrRAUGUj3saXbHykZGmnIJO5JLBljIRra5sZj
         GvykZl9OFf0qj+/O1LkufiGhohYa4A1AaLVXKk1ehuvCrcPMoB9U8tUzHkjWAOkCKaWE
         8MyjIN3jffXOw63Q8wzIDGkB51qAZnoUpvNHQdhLAJpoNPdjRpIV0lWCIhPY3txl+Ii3
         F8ACjjdrS5l5EYTZ7aZK8z27pN3BohQnwID6MmNu/u4h3RiZo0YO0HSEUbd7pNX6DXPb
         VfeyHIurcnNmBGfFn+2HOBvF5A/cp9XqrbJNjMso6lSsGYvXf9aLst9w1ILBwqk8Wde1
         cwYA==
X-Gm-Message-State: APjAAAVlQ0FWma8ZqzxHuh9ufkaICWqQBU/n2E41EzeQNJ+8Gk1pEjvk
        ROArVUmgS0qrUydXMFcbrTlBZw==
X-Google-Smtp-Source: APXvYqw5xpkWweDsElT5oorj6ZqZwyiP5jmbGdBy2KGR6B9RaT1x4myrBMtVs6piCQ2/e6+4ilEtjg==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr378855wmd.39.1572598807344;
        Fri, 01 Nov 2019 02:00:07 -0700 (PDT)
Received: from dell ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id v128sm8370576wmb.14.2019.11.01.02.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 02:00:06 -0700 (PDT)
Date:   Fri, 1 Nov 2019 09:00:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/18] mfd: cros_ec: Add sensor_count and make
 check_features public
Message-ID: <20191101090004.GF5700@dell>
References: <20191021055403.67849-1-gwendal@chromium.org>
 <20191021055403.67849-3-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021055403.67849-3-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2019, Gwendal Grignou wrote:

> Add a new function to return the number of MEMS sensors available in a
> ChromeOS Embedded Controller.
> It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> registers to find out.
> 
> Also, make check_features public as it can be useful for other drivers
> to know what the Embedded Controller supports.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v2:
>   Fix spelling in commit message.
>   Cleanup the case where DUMP command is not supported.
>   Move code from mfd to platform/chrome/
> 
>  drivers/mfd/cros_ec_dev.c                   |  32 ------
>  drivers/platform/chrome/cros_ec_proto.c     | 116 ++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |   5 +
>  3 files changed, 121 insertions(+), 32 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
