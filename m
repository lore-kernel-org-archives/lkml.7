Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6DCC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B36206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573691173;
	bh=WtL7aiuZseF/2Lo8jL3TCUd++OBOX5m98Opc9vYuDo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=urJ0Eph0QoEpWFZBG2qzRtB0gm42/yuryNWGskTD13GV3+pxpsj1um+jUDp3O2Bws
	 Ssd/nSW+Kp7f95azRR9Oeyp+X6vFvVCXjC13xpQDLAq2UjjVrDkGErDecMdrLcgX86
	 OzLbNa3carC6ZkXBILxGEuGzezn37Hte4Pmgvh+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKNA0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:26:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35947 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfKNA0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:26:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so2476765pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wbA9LJyHfmL8JOWFOa0vSA8aoWEs4lz4urE7q+emuws=;
        b=sLyN2j7T26sNjPregNE61IHWMLyN+I5AWe8kUecKwVyZpR8roU6myoFAC8SGexOzpo
         BSmDUE7n//RWMm7ApC17GES7IVJRMxxzaczQmRDv62eoN6dpNXKSI/fNObMw7NFunHO7
         PmAs63lmZCVdFFCYzx37/ZQklbCulVU3Da2kSMrsozzE13AKxNLy4NHZgwrs5rDljXrD
         XHGy6K5Ge9C3C6vg+THDWl8w3ELaF3YSX5bQRXOh/t3SeHuD/ZmCHU61OXVBOgqyHamY
         0nkR0vovqd0n00ghnYBQx+oYCvSdL7SDSHfMpWjATrqFoLnHw8T+zfe1Y2NjyqKeILOt
         MwVQ==
X-Gm-Message-State: APjAAAUpxcFuefOErU4zL2OuGnRA746W0EMuvINwqSOnrWEoZw/F4xgA
        W529OgaWm91WkOgczspnDyQ=
X-Google-Smtp-Source: APXvYqysJoIW33FxtPXED/zzoC2eM/qLkJe1e+uQ7ZywkJf7bQqVg871jvl4PxMu5TzA/SYF5rywtw==
X-Received: by 2002:a62:e811:: with SMTP id c17mr7710859pfi.136.1573691171052;
        Wed, 13 Nov 2019 16:26:11 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j11sm3605922pgk.3.2019.11.13.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 16:26:10 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 60605403DC; Thu, 14 Nov 2019 00:26:09 +0000 (UTC)
Date:   Thu, 14 Nov 2019 00:26:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] firmware_class: make firmware caching configurable
Message-ID: <20191114002609.GC11244@42.do-not-panic.com>
References: <20191113210124.59909-1-salyzyn@android.com>
 <20191113225429.118495-1-salyzyn@android.com>
 <20191113231602.GB11244@42.do-not-panic.com>
 <33f2baa2-944a-2bfc-1c50-0e437bf11959@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f2baa2-944a-2bfc-1c50-0e437bf11959@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:16:38PM -0800, Mark Salyzyn wrote:
> On 11/13/19 3:16 PM, Luis Chamberlain wrote:
> > On Wed, Nov 13, 2019 at 02:54:26PM -0800, Mark Salyzyn wrote:
> > > +config FW_CACHE
> > > +	bool "Enable firmware caching during suspend"
> > > +	depends on PM_SLEEP
> > > +	default y if PM_SLEEP
> > I think the default y would suffice given you have depends on PM_SLEEP,
> > however this also works. So, again:
> > 
> > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> >    Luis
> 
> Worried about setting FW_CACHE w/o PM_SLEEP, this enforces it.

I understand, but its an impossibility to turn on FW_CACHE without
PM_SLEEP since it depends on it. How would one do that?

However, since it makes no difference we can leave it.

  Luis
