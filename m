Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02219C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6EC2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFRGI1VS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfC2AJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:09:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33157 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfC2AI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:08:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so157252pfd.0;
        Thu, 28 Mar 2019 17:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Db6/otPwdertTCJYFGI8hRJ1SF1pSt8tFFwNr9TFPDo=;
        b=aFRGI1VSrymKZFo23apuoNaINo9HaGxLpHbt0iQen2m4ivOlPYBh7xzRu97hp2hCm4
         9FISYX/1y/nLLAkGJ1ISQkGJt57gUzXujz2UvqLOuTFoCbFtAP+bYPDtI0xxRQHjS/3x
         fN/NBidEZma66cuMq8SYktsOXqwevVDcEbdcy1VZXzSL7k3D1MagNPicOmanKd58nk34
         ZfMIl5qOBcECQ9/CjeIkbdZlJRoRRReLMG7SEcEqjfdMcUnbRxmc2UVZ6PNZxRwltPfv
         sJl1y2vwrcPk59hw0sxxDpsOPze4LpiCQv9+Mk+n2f40Pll6ilk0kG+GeM0PgWxRjyoT
         DJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Db6/otPwdertTCJYFGI8hRJ1SF1pSt8tFFwNr9TFPDo=;
        b=arcdGW7iCr+HBlY61LJwaJlBXFgSdh5CAD5tFYG/TxHfDlnHQeLaqD5AQdX1vsKi5X
         MnPMT68ee/nGbutfxJ6MRNu4PO2NYNGlcx79Whew+9dbWUT6qsGpo4DPBe/P4Qgf7iMn
         5m0b8doeqsQVP9O1Z2K8+Cjh2HI5XW5KE3sXLdAYCo6UADA2SxqobcTizl6r7AZ2zKnI
         ubohkd94OadHXDw6Ryt8lhUmXors7YJX2gtTUmWpNkRgSYfaOMcqEC1IvTdJqcA4d2lf
         nxUMXma7iTeqO3IAf7l8MpJ5h6nwVoUouPamPS1qQmUUAxPorhnWJblkLJe4twCJ93Ee
         66Uw==
X-Gm-Message-State: APjAAAX3VuGjrCKOKY/dplrA+CYSaYKgHlyL1jDsFJnfb/KRXT0XJwsF
        DKKwQ1bjYs33Y88xIIuxhsU=
X-Google-Smtp-Source: APXvYqyi45jo6uqcO/YnGwQHtpsz/DCrbFuhDnhvON+RIPljfRg9FGXViXO9xWCs+Q6sKGTQHe3erQ==
X-Received: by 2002:a63:360e:: with SMTP id d14mr29605831pga.188.1553818138875;
        Thu, 28 Mar 2019 17:08:58 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id k26sm371714pfo.111.2019.03.28.17.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 17:08:58 -0700 (PDT)
Date:   Fri, 29 Mar 2019 08:08:50 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190329000849.mwwktjbllqzwytcz@mail.google.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
 <158b68a902139066f53d308cc5a428774445a05b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158b68a902139066f53d308cc5a428774445a05b.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 09:34:50AM -0700, Joe Perches wrote:
> On Fri, 2019-03-29 at 00:26 +0800, Changbin Du wrote:
> > Hi Corbet and All,
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted most of the Linux ACPI docs to rst
> > format in this serias.
> []
> >  ...pio-properties.txt => gpio-properties.rst} |  76 +++--
> 
> Please also update this MAINTAINERS entry
>
sure.

> MAINTAINERS-GPIO ACPI SUPPORT
> MAINTAINERS-M:  Mika Westerberg <mika.westerberg@linux.intel.com>
> MAINTAINERS-M:  Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> MAINTAINERS-L:  linux-gpio@vger.kernel.org
> MAINTAINERS-L:  linux-acpi@vger.kernel.org
> MAINTAINERS-S:  Maintained
> MAINTAINERS:F:  Documentation/acpi/gpio-properties.txt
> MAINTAINERS-F:  drivers/gpio/gpiolib-acpi.c
> MAINTAINERS-
> 
> 

-- 
Cheers,
Changbin Du
