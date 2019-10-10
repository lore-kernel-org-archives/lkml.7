Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B747C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC34220650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570709219;
	bh=klbi8+Xn9AUhAWJ7QRO+cu9K5+OXVapALbCnh10Dgtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y0CAzhljQBdPx8tcv1RvPA2U9T70lrm19+yFolTssREW+3oo9cgInV/xZh4TbcdU3
	 GjXh3PtrUc5RkVq+h25dbMBTAA1Hzkjhoyoa1SiQkw6ADAPwzfS+7kUt8Aynr2lBVS
	 Z6SVgNQrtX5DkEaIKWOB6tAAg/zwjMr9D1I5nTbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfJJMG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:06:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42910 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfJJMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:06:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id q12so3759589pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 05:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZpW6NasBdQ+N03nyefznl+Gsn941N3H0W4keOoXT9Y=;
        b=egQEFWUnAcYklLAC0OWyXu3R4OilNYMONqSFJV045+9Y6prngT0aCzNbm1lzY67dPe
         yTeOUeWfsmdCKZhCnUnWb19cBF6gwYXjj8jL/9OiPEcrLe6cz+/MM95jj1rWqQzeBgJJ
         99YFvqnZ6nkCrG2t40TDe/xxV+W1qzRMX4U4rxjNCpxhG3Dru0keY6JMupl3SIbOL68A
         SP5x2omz4eUq7H2A9AIrzYPIRld5eTVAE3PF5mL/Uy6cofyDCLO1Jt1woExX17fJWPYA
         cl0ooEnqxP0aeI/64j8eefr1FBJ5KYJJH1ZenzB0l9T6tSYiJn8vhcaVi0IMGHw2oVhr
         SM2A==
X-Gm-Message-State: APjAAAWMbGCBwnQ8OUDnGLh2XcC1hVDS0028FOKun2cFON1IhynJQIOb
        gaouegg43XUJ785KLZqa2Kk=
X-Google-Smtp-Source: APXvYqwwPtljLc+E7mdSEi/Cy24U1kSFxmODJsmG7M6qAr3pNWylABfn7/G+MoxdxveLPkBHqOc6zw==
X-Received: by 2002:a63:a556:: with SMTP id r22mr8291118pgu.167.1570709216748;
        Thu, 10 Oct 2019 05:06:56 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u3sm5963356pfn.134.2019.10.10.05.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 05:06:55 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DD4834024E; Thu, 10 Oct 2019 12:06:54 +0000 (UTC)
Date:   Thu, 10 Oct 2019 12:06:54 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH v3 1/2] lib: devres: add a helper function for ioremap_uc
Message-ID: <20191010120654.GC16384@42.do-not-panic.com>
References: <20191010030335.204974-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010030335.204974-1-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:03:34PM -0600, Tuowen Zhao wrote:
> Implement a resource managed strongly uncachable ioremap function.
> 
> Tested-by: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
