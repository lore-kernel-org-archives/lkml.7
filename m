Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA441C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BBC21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576799779;
	bh=X9Gvfcz5XvPk5AqQjQn2AwvYGipNuWHe0Phe+pHxP+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+FI73HCP/b73JEftTbMTW0VrKe7ycDg6mBiliSh6tq8j4vFNtIYNY0NwKq/V6Xdv
	 sKWDwn+LkwmulH+GhE49ihsxknSeKFqn0jRPclGHynjGLjsr2eJRAWhWP5JVnEqdBE
	 zZQSwxsBIjjeb5eWFbBesLrPjb7t8vvVsiilmkxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLSX4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 18:56:18 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41101 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLSX4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:56:18 -0500
Received: by mail-yw1-f68.google.com with SMTP id l22so2888679ywc.8;
        Thu, 19 Dec 2019 15:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARCZQqxf+0FzEB5iVazPT6aK74bYUEn3HXg9HU6qLcQ=;
        b=ft4CGVGj9P3ADcFH2s0rWIZqKgjcZUAA3MNbf05NPZY1mM00zhiVvN3jLvPpb0R6pt
         x0dfNuNC1ocn2NFfsusOGDrZZndPGS7VHWjI5p/bW5Omi+gW+m66YyjHihnPnaeA3MAo
         eqjYbQp6cN6r8NFjkL2Pp57Q1/tKYIoW6cX0drdwMONW8en25UwQOedK8uyxp/7K5RLP
         qUUkVTsHmHUImGghHFxgc10q0VPKZbygYyXYinLRUatc+UgiWQ4DOt0MqOiYG+fvN6E/
         5LsNC9J5zmRNIqjeVoPXxmSZmRzb7LC5Zcgp0BXYjj06cgtPm2Xofwg94E6nEK7qNTDV
         g4cg==
X-Gm-Message-State: APjAAAXlE5zB2Inxl/qOD11wKhG4NmYG0ATeotWUo+1Ud98tdeJ/CtJq
        bPlosmROMD1xgSJ2gIHjYzSd/Rg=
X-Google-Smtp-Source: APXvYqywBAQDOyS21IT+zvRVl4XolNmnzFYexAWz8fo5ibiktWXARwDGoYAPr7Xhqa1RU911jzX1Pg==
X-Received: by 2002:a9d:5885:: with SMTP id x5mr11347193otg.132.1576799776295;
        Thu, 19 Dec 2019 15:56:16 -0800 (PST)
Received: from localhost (ip-184-205-174-147.ftwttx.spcsdns.net. [184.205.174.147])
        by smtp.gmail.com with ESMTPSA id z12sm2730992oti.22.2019.12.19.15.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:56:15 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:56:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 01/14] dt-bindings: media: sun4i-csi: Add compatible for
 CSI1 on A10/A20
Message-ID: <20191219235613.GA9523@bogus>
References: <20191215165924.28314-1-wens@kernel.org>
 <20191215165924.28314-2-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215165924.28314-2-wens@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 00:59:11 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The CSI1 block has the same structure and layout as the CSI0 block.
> Differences include:
> 
>   - Only one channel in BT.656 instead of four in CSI0
>   - 10-bit raw data input vs 8-bit in CSI0
>   - 24-bit RGB888/YUV444 input vs 16-bit RGB565/YUV422 in CSI0
>   - No ISP hardware
> 
> The hardware found in the A20 is the same as in the A10.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/media/allwinner,sun4i-a10-csi.yaml       | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
