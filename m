Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A6C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9968321920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrkFlb7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfIIKP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:15:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36513 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfIIKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:15:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so8874435pfr.3;
        Mon, 09 Sep 2019 03:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eR0ilnRAfilkxH900ZHRgTRnftEfS8psnkYh74iN2G8=;
        b=YrkFlb7Ouz0PAGbWQPPET9Vm1z6rB9MKeH2TUiQOfxqfpd8IYwMax+ynsXGcePSstf
         pty7Jyq7IY38DemBpRJVYg+LyMBDbItdUJqA0iDWcyVLS2DcQO2jSRKhhF0CEZ8KiG4G
         Zu0UnruSlDHyzsPPg3s4tRwGaFgvOeKanVzxcYrUmjFLgYWfRe0p5a72K2LW5S8YJoLP
         5PCZJ4vs5DIB6ZvC9I6qSN0mZrj2dV2werYFUgCw5cGSinoacm1SooKKfBEXCKl8ryCh
         Lqw77PEpT8oujYE8YaQkggTNsTgekLwyS8GjIM9GncBKN0IY/DfPrN49Qvb79LE6oSch
         arcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eR0ilnRAfilkxH900ZHRgTRnftEfS8psnkYh74iN2G8=;
        b=TEsPADUZuM+8nOsohHhljlolm2UISmlrtbrIcqSh/bc+QLfJn0NUKDlZ0ifREUXIC7
         nVDcvpW35uAAxJYADp/jwdKz729ZSPJ04nmwczE4sGaGsVdrafqFUYmHNHesO+vr9ZnR
         rWP0qQhgPW+rSmwiK+rex8mEMslOtGDM1k9Qq484+/H56kqeKFhUBFHrJnPADZjhise8
         nuKZJux/t5jxYC1fHudA1VesiJAn66aKmMFXL2pbLktZzxkUy93TmVnfdFWxyk6PS7GS
         qAtYYS2A0b8YiUsxIz7kPn3793HRI2p5RbEeeNiiK52OE197ERtrNkj3JK4KkMcjRdfz
         jluQ==
X-Gm-Message-State: APjAAAUsQv9hxaUqJKGyaHA7D64eBpIxUB1wfjQxn/icbzu3CnQvupNM
        hTXq9LSL2cLGYGtN+1JGJXE=
X-Google-Smtp-Source: APXvYqxS2O+zqfJizPPe+/IqtHW21XlsLT7myUVM5OksTn6TphABvgwS/AfMz3KKlQe+ewkTC7hvHw==
X-Received: by 2002:a17:90a:b116:: with SMTP id z22mr24702277pjq.108.1568024157961;
        Mon, 09 Sep 2019 03:15:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v7sm14812756pff.87.2019.09.09.03.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:15:57 -0700 (PDT)
Date:   Mon, 9 Sep 2019 03:15:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 03/13] software node: get rid of property_set_pointer()
Message-ID: <20190909101555.GC145199@dtor-ws>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
 <20190909081557.93766-4-dmitry.torokhov@gmail.com>
 <20190909095505.GQ2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909095505.GQ2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 12:55:05PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 09, 2019 at 01:15:47AM -0700, Dmitry Torokhov wrote:
> > Instead of explicitly setting values of integer types when copying property
> > entries lets just copy entire value union when processing non-array values.
> > 
> > When handling array values assign the pointer there using the newly introduced
> > "raw" pointer union member. This allows us to remove property_set_pointer().
> 
> Is this reincarnation of 318a19718261?
> Have you read 63dcc7090137?

Okay, I think if I squash this and the followup patch to
property_get_data() then we'll only go through the "raw" pointer to get
to the non-inline data and therefore we will not have the union aliasing
issue.

The in-line values never change their type when storing/accessing.

-- 
Dmitry
