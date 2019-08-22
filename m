Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F53C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6091A2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566478157;
	bh=2jaWBCrOQ0yuu85NYyiu721Y016fScbcX6gjgMxXnr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cNocqLuaGmWCf+iZsmF785405l06HCXT4WwkkDfJr6P07oS8aLCpzz9c+vWMIAn6K
	 p0j4cdp2kZU/hwQSyRDEMV6l/uUTS2MxEGuc//uXhQ4mux7s3OCsBwLTjRv8ttiI4w
	 WCfPJH+gdEwSGEc6fnDLwqU4Lw4lPZqcAW2LQOcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfHVMtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbfHVMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:49:16 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6995423400;
        Thu, 22 Aug 2019 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566478155;
        bh=2jaWBCrOQ0yuu85NYyiu721Y016fScbcX6gjgMxXnr0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2bQAAPqDuCPhfPuMs0tpE6vN3uBcdrm2yVjXtOoUGIvVHTuwP6ecLZlheBZf8pGdC
         AKIgU2DTTyLlFCkps6leFmpCukseM6ZGo6V9LcUyhkuYagvHPBqQD8COGECKgknWXl
         nTFDC0KYYkwVolMTHw1xIp2ICCmpYV/E4vZ+yJDw=
Received: by mail-qk1-f179.google.com with SMTP id s14so4972623qkm.4;
        Thu, 22 Aug 2019 05:49:15 -0700 (PDT)
X-Gm-Message-State: APjAAAWelSbP6IBp8/k+Ti9gmmREG2OjD3ZTm/9VI0Iyrw3ZnHqJceFS
        RAOhtXqaSpAjPSvAHZEigJwXdkcvmyDTGnUyJA==
X-Google-Smtp-Source: APXvYqyBMDyPkKQlrL4F7PdNmYQzAWJgtlXak0rnzRNH21bjRVARC3G2rMD+eLD5LmndSLSMbzDZswfGkzeJi1x6FMY=
X-Received: by 2002:a37:4941:: with SMTP id w62mr3533362qka.119.1566478154602;
 Thu, 22 Aug 2019 05:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190822102843.47964-1-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20190822102843.47964-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Aug 2019 07:49:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJEW0UDqYDTvOeRsZh9WJTeT99JZP8PtkvbnBU2dhYJEQ@mail.gmail.com>
Message-ID: <CAL_JsqJEW0UDqYDTvOeRsZh9WJTeT99JZP8PtkvbnBU2dhYJEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 5:28 AM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
> changes in v4:
>   - As per Rob's review: validate 5.2 and 5.3
>   - drop unrelated items.
>
> changes in v3:
>   - resolve 'make dt_binding_check' warnings
>
> changes in v2:
>   As per Rob Herring review comments, the following updates
>  - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>  - filename is the compatible string plus .yaml
>  - LGM: Lightning Mountain
>  - update maintainer
>  - add intel,syscon under property list
>  - keep one example instead of two
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
