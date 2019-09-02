Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF874C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A3B21882
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431569;
	bh=W3r6SXXhEywcasxMAGxdNnY+8iFcKarDejGBmiJbAtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uq2xnDEgyTj1tN5we6IDTqskNkKpoP7TLEp1S5i0oSH3Ug/Rs8mYtfdGriqM9BoRM
	 9tVR1Rx76tMCgVDpe1V7XbSrL6moG0SQeQWt5CJt15GLRrdtEKlmJpEneQzLNLYrQo
	 FOUbDc+p+XqzHOtDMyWwL1fqomTYj7cA0ZUvadvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfIBNjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:39:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55526 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbfIBNjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so10661512wmg.5;
        Mon, 02 Sep 2019 06:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=PkDpB4sth3sTgCnaLAVjJ1mLztUz5Y7mplxR5CYkQGc=;
        b=MEQdDmBhS5IkOVumaiwNjqdFJtPTM+HKbzEcF+uijl9CIxfVaQHly88/4CN+gu1FqO
         Sfhzvxb1i0b80DkH8pH4IqlrWp20gN9Rv0Urem4PmCHxYqWju93ATqaAa4F2gftfyLJw
         9GdZmAnS+xKj9MwbENs2wgd9fxqs94X1VOnOTJgHO938+fA1eE18NWZ/PV5k0DPvGqO7
         zL6sDL0YBTjDi4A52Ec3rH9hcMb1HDdJKvoDxUaN4ykGRjP+lK73bMgsG/h2A46RhUSB
         KnSyX65x/wwq+FYjhKg2Y629slxovjpZb7fOI9BczmGwiBdI6aTSIy9VfcQE7t7a4T0R
         dAzw==
X-Gm-Message-State: APjAAAXkN7SMmVBWEJggmt5gw/Sa2fXzBY4fwm18iBjSc0k5UmdDk3AU
        cDjdNAumzaazXSYbH+1doQ==
X-Google-Smtp-Source: APXvYqwYm2s6Gmmrf6ryiQK0P0Y0VG6vrlmGJlljuLZ0cRK11tDXzUM3GY5iH8aQZK9NTww/KJUsIg==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr5204994wml.177.1567431558279;
        Mon, 02 Sep 2019 06:39:18 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id l9sm11671308wmi.29.2019.09.02.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:17 -0700 (PDT)
Message-ID: <5d6d1b85.1c69fb81.96938.0315@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:17 +0100
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, jwboyer@gmail.com,
        boris.brezillon@free-electrons.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, vigneshr@ti.com,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: cadence-qspi:add support for
 Intel lgm-qspi
References: <20190827035827.21024-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190827035827.21024-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827035827.21024-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 11:58:25 +0800, "Ramuthevar,Vadivel MuruganX"          wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add new vendor specific compatible string to check Intel's Lightning
> Mountain(LGM) QSPI features enablement in cadence-quadspi driver.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

