Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D71C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7756D21841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544296;
	bh=mGWwuvYHtCOEdqUhryn/C5GcCwcG5zTHTlMA26N2pvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z43WID36mUeDIfzTR4upAtp+Lo49xJBZppdVQ77oD1ejg7Jj1uugNGNZE9tDyMixD
	 E3FzeI5negrXtZ9gie7q28vHias2HD4wfjhTNCQBcXWmmx/oskA1G3vBdNlb9ZwYR4
	 iEG1/XzKSRj+3ntTdGS/Citbph6tyxbdEEzVzM7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfFNUau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbfFNUap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:45 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793E421897
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 20:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544244;
        bh=mGWwuvYHtCOEdqUhryn/C5GcCwcG5zTHTlMA26N2pvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sx81Q/xpvwk4mFA/RoOKvG+QEjJIGN65Z2wayQOScvrbjGUaFxkkl/qN1cBp1Hbw5
         0EcRu3IJwiI1KBX2GNsbwbJrCdyBiDNpGQutFZDd1WJkAxH2FCmhT+rlijUA7hEIHi
         U+0QReilDuUyHSZ87o9v3uWqeVFUgwti/gdDS1+k=
Received: by mail-qt1-f170.google.com with SMTP id n11so4011464qtl.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:30:44 -0700 (PDT)
X-Gm-Message-State: APjAAAXly3OKvQFWmjFUcH78kEiBfzJoFfWVah4RSqde0NWDraEJU0DZ
        bQNR07HhqQHkvZUvyfVjrXLEVGPpx8yVd5SKsg==
X-Google-Smtp-Source: APXvYqyEa40ZqholttyFEwOyFtfBSULLcL6K/CiDOleixhkANZ8lnSHU37BmhI1pZBhMVJKbKKBIEza4Y7nBOCUemac=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr81739065qtb.224.1560544243650;
 Fri, 14 Jun 2019 13:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com> <1560534863-15115-5-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1560534863-15115-5-git-send-email-suzuki.poulose@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 14 Jun 2019 14:30:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKuFN=3OVMa6iBQSiCrPvDP30KFZKDmUh1WczoYexDyMg@mail.gmail.com>
Message-ID: <CAL_JsqKuFN=3OVMa6iBQSiCrPvDP30KFZKDmUh1WczoYexDyMg@mail.gmail.com>
Subject: Re: [PATCH v2 04/28] bus_find_device: Unify the match callback with class_find_device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andreas Noever <andreas.noever@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Corey Minyard <minyard@acm.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Kershner <david.kershner@unisys.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Jamet <michael.jamet@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:54 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> There is an arbitrary difference between the prototypes of
> bus_find_device() and class_find_device() preventing their callers
> from passing the same pair of data and match() arguments to both of
> them, which is the const qualifier used in the prototype of
> class_find_device().  If that qualifier is also used in the
> bus_find_device() prototype, it will be possible to pass the same
> match() callback function to both bus_find_device() and
> class_find_device(), which will allow some optimizations to be made in
> order to avoid code duplication going forward.  Also with that, constify
> the "data" parameter as it is passed as a const to the match function.
>
> For this reason, change the prototype of bus_find_device() to match
> the prototype of class_find_device() and adjust its callers to use the
> const qualifier in accordance with the new prototype of it.
>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Kershner <david.kershner@unisys.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michael Jamet <michael.jamet@intel.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sebastian Ott <sebott@linux.ibm.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: rafael@kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Corey Minyard <minyard@acm.org>
> Acked-by: David Kershner <david.kershner@unisys.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Rob Herring <robh@kernel.org>
