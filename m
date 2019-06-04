Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86964C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAC4248D3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559647610;
	bh=LYFF90I25JY7V0ZhSu4XFP/RPOk2v/6uwiYk7ki5MAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DAuLKH4/nn+1kc8de8HLHAd5tfen/hnkh2JCO0Bgo4isy9gTO9iLIPMu1EACk6zeP
	 LVF/0UP0cqTsK2E6iVR/WZbvuDjtA7XgLNxMHHXMG6naQIBPJjHsR3KooJcpndfM4I
	 GfoYNchV2TSVQtOdIZudivfpad2wsA4QWQvgGIQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfFDL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:26:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34847 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfFDL0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:26:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id n14so19177101otk.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+bLIXaZ17N12ujpsyYbaNmHRjzt3Mh0NBkU6cPWx/k=;
        b=ao5Gdw/MCly4LSDpj0v2ThPqkp5IF3jUEbM4zKLBSxOFKabeeEtcSAMnRNhIUdAhdT
         d3gPhmwfldEMUrqkJXcJ3TbfjukjbEzKiHjQ16ECKXY5A+o2hFJ+vBo/dq9nOJM8BnII
         FhJhdH8ugJVfwSTY2lPNCLsU8MI0H0zw1F9rMSU/Hdu7VW9cl1RJz/2bQRYTeVA5Egbz
         cUSGbN1GVkJUnJ+eL/12e27Ur5uJv5LTDXHKGj+FaZ54M92hpto9vrdQ3qNzgQL0+xDG
         n6HIDsVjBj9gx0FrGDk6qTrHTuQGP9CuMIl+iZit+CtYkHlBlP6hVdbie8ZEoD88edtF
         i5qg==
X-Gm-Message-State: APjAAAUh2jPRJLZuQWEiUPd2I12OVQ4um/U9uTwEPSs7JsEyXD0Pdt1+
        IFgyirOsLzUEnCzRbMqxYqM9vGF8cnAwWqdfv3U=
X-Google-Smtp-Source: APXvYqwbCd7Da1EmQl1d1NP4qH8OhiH1lq3bzfOZttdZb6aQhIcEINmifkjA6pyDjBayUkh/1zPKudcAeJetLOGoxeM=
X-Received: by 2002:a9d:3285:: with SMTP id u5mr5132565otb.266.1559647608261;
 Tue, 04 Jun 2019 04:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com> <1559577023-558-28-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559577023-558-28-git-send-email-suzuki.poulose@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jun 2019 13:26:37 +0200
Message-ID: <CAJZ5v0ghb969phwKDJd_hJV6mBm0_B8R9Lrk8RG3Tu9ieO69OQ@mail.gmail.com>
Subject: Re: [RFC PATCH 27/57] drivers: Unify the match prototype for
 bus_find_device with class_find_device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        David Kershner <david.kershner@unisys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 5:51 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> We have iterators for devices by bus and class, with a supplied
> "match" function to do the comparison. However, both of the helper
> function have slightly different prototype for the "match" argument.
>
>  int (*) (struct device *dev, void *data)  // bus_find_device
>   vs
>  int (*) (struct device *dev, const void *data) // class_find_device
>
> Unify the prototype by promoting the match function to use that of
> the class_find_device(). This will allow us to share the generic
> match helpers with class_find_device() users.

The patch looks good to me, but the changelog might be a bit better.

It seems to be all about the bus_find_device() and class_find_device()
prototype consolidation, so that the same pair of data and match()
arguments can be passed to both of them, which then will allow some
optimizations to be made, so what about the following:

"There is an arbitrary difference between the prototypes of
bus_find_device() and class_find_device() preventing their callers
from passing the same pair of data and match() arguments to both of
them, which is the const qualifier used in the prototype of
class_find_device().  If that qualifier is also used in the
bus_find_device() prototype, it will be possible to pass the same
match() callback function to both bus_find_device() and
class_find_device(), which will allow some optimizations to be made in
order to avoid code duplication going forward.

For this reason, change the prototype of bus_find_device() to match
the prototype of class_find_device() and adjust its callers to use the
const qualifier in accordance with the new prototype of it.".

Also, it looks like there is no need to make all of the following
changes in the series along with this one in one go and making them
separately would be *much* better from the patch review perspective.
