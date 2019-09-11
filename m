Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF0ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3279C20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNoM3s7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfIKIh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:37:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42962 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKIh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:37:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so11155638pgb.9;
        Wed, 11 Sep 2019 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XcgXl6vcI7fky/pyqfiJ2ZU/L3oI062mhDlNkD5vbkY=;
        b=TNoM3s7RpMnHi7rVVC8z/RaWTFsUbcW2SItU6YdhdWxyDWyI0MwwmvDcrfMNR0XIXa
         hNEOtQqvM5bTpCrsUdjlbzf8sQTfQ3/JQRc1jnh4VLsYkuSFqBcgf+t2h2EQkjazO6cF
         9CvFluD2KBoabY9jevT51GUg8RQbjQEJL4zfCwTInYOS5lsIPuKDPvnOAYk7DS0DhTxB
         o1jqDvZJ8v90TOrqVZkfpDBfrLUrFa2nMxehVLSIWMYzWnHTQv0LUYwvIvtk3ARPkHjr
         coEDdt65vcq1EC4rdh1bzGKF8I200cDPBVMDZSr6+YOauIcrRQYflY+4SDjNnGJ6xkjF
         dwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XcgXl6vcI7fky/pyqfiJ2ZU/L3oI062mhDlNkD5vbkY=;
        b=h0c0SuCMXAuCRhrlIOaABmWsIMMAthKhERqq+l8kpvUxBAg9oB5xzAByvP5Ee09MWB
         rPceCSx+MJ2RFyavzyLpyFI4pwjY6+4IW543Q43oqu3Sv5N2USrGRDWsTJ4Ch76QSySb
         nbi60XJuNzFQFjIabI/gkwd5cBdDu8Px7KhA19ALRmnu+OT9xvKsqt9CVSHh+nHlunhk
         l83T1EpI8OqpZlNK4OhACdcEype0g6bNgj8GEagM6dyQbeFcTUydHTYn2Sf+msWDHMEK
         ig+y+hcyWY2YG8jFL03nCh8hptZEohhNekZX6NB7VjV7pltPqFPneHRMjgC7GyVpT3W3
         RDLw==
X-Gm-Message-State: APjAAAUiQijZsJIoovsJIpbOlsAixODREQdDy6iNjY3BhPK/NByhFAZY
        BcjJHyTXUAEsNNs7eyotdWM=
X-Google-Smtp-Source: APXvYqxGnmNFIw1jCzeXu52A256RgHcF15CP6NRxYaVRdLJYFAuDQkWCJhlUPQelWxrS25JnzmSu5A==
X-Received: by 2002:a17:90a:f0cc:: with SMTP id fa12mr4072557pjb.138.1568191048048;
        Wed, 11 Sep 2019 01:37:28 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u69sm18469729pgu.77.2019.09.11.01.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 01:37:27 -0700 (PDT)
Date:   Wed, 11 Sep 2019 01:37:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4 06/14] software node: get rid of property_set_pointer()
Message-ID: <20190911083725.GF145199@dtor-ws>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
 <20190911051231.148032-7-dmitry.torokhov@gmail.com>
 <CAHp75Ve5NvhzOQ96OgbPh1LdsAtvk+A=aVu-oXKdhnB4PpL_og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve5NvhzOQ96OgbPh1LdsAtvk+A=aVu-oXKdhnB4PpL_og@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 11:29:10AM +0300, Andy Shevchenko wrote:
> On Wed, Sep 11, 2019 at 8:15 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Instead of explicitly setting values of integer types when copying
> > property entries lets just copy entire value union when processing
> > non-array values.
> >
> > When handling array values assign the pointer there using the newly
> > introduced "raw" pointer union member. This allows us to remove
> > property_set_pointer().
> >
> > In property_get_pointer() we do not need to handle each data type
> > separately, we can simply return either the raw pointer or pointer to
> > values union.
> 
> Same as before, typechecking is good thing to have for my point of view.
> Others may have different opinions.

OK, I'll just point out that typechecking is a red herring here as
everything was and still is accessed through void pointers, and we
trusted the type set on property. Users of static properties should use
PROPERTY_ENTRY_XXX() for initialization and do not poke into struct
property_entry directly.

I suppose it is up to Rafael to decide here.

Thanks.

-- 
Dmitry
