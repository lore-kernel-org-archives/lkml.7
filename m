Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B2FFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796242168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571230580;
	bh=yr8sJGTkKH+ltatSfVb9f1KPMV4M0N9Xhule5PwFdnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JWjsF+JG4GIDkTM4N8RGY7GrZzpyyvav0F8ITWPIIRe6caSkWlUKU3RCysu9+jsdZ
	 jCzkiWF+p4qj4iQTE1unfpCxi1/53nC/bW/QauzDL+fN50i44RsvqF8hcu0CKgOU8A
	 DdVc+tm+oiXP6mCGMwXO4zcdk7QDBWuYOpEgyhWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391670AbfJPM4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:56:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38234 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbfJPM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:56:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so11234213plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bRc1GtlPPjwny7sjixLD6ZlTcXzrj+SkdWDIX6ncizs=;
        b=N6dOIGZS7fWn2mFZf8QsDqu5SDaNttBpP/ZpC2M6uQsL8HvPZ3n8Cn+818vlyXQ6VO
         OsOOTKTlcRlInPQC1zEcxPK9JhirZV8z+Bzdy0putDc9YN3iqK/9qXnx4O5On6xvLFyN
         yUL4wrN3h7OxiNckBBIS3TtOQx0ucOnjX3e6UUOUJHFOanAMBH2x6s/9NXKh4saUArC7
         Lbh8uQAchOIEYy0g5Plqmycv5M9QXBpsdVqQuvm4Q82M3j99P/QMO42ToTg4ettE3CTX
         g7VsP0FY4D2zE2GCFALxdymzy1nbSv9ZgQdaeYfS0qahQSULOljZcGgBc86A1wRynkEL
         y0VQ==
X-Gm-Message-State: APjAAAV1Ao7uWfdppyUQIkDQU5Sq0aaEO5LCahY2bo9qeJSXs5uzXyOo
        dzbTOyTtimlT/EiyuqNjj2M=
X-Google-Smtp-Source: APXvYqze4TOAgxRhsFBZZTM9pJJGteMtIAro1HvC6RAfu1K8geleYckSQtqZ3bRcASTE8EJ4yIm0aA==
X-Received: by 2002:a17:902:524:: with SMTP id 33mr41660741plf.123.1571230577801;
        Wed, 16 Oct 2019 05:56:17 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c7sm22871357pfr.75.2019.10.16.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:56:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6EF4040251; Wed, 16 Oct 2019 12:56:15 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:56:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tuowen Zhao <ztuowen@gmail.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/2] lib: devres: add a helper function for ioremap_uc
Message-ID: <20191016125615.GI16384@42.do-not-panic.com>
References: <20191014153344.8996-1-ztuowen@gmail.com>
 <201910150232.F7RTW83B%lkp@intel.com>
 <c4bcdf14e0a60a679429eebd439b2380d97dafe9.camel@gmail.com>
 <20191015074434.GU32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015074434.GU32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:44:34AM +0300, Andy Shevchenko wrote:
> On Mon, Oct 14, 2019 at 01:15:53PM -0600, Tuowen Zhao wrote:
> > On Tue, 2019-10-15 at 02:46 +0800, kbuild test robot wrote:
> > > -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         GCC_VERSION=7.4.0 make.cross ARCH=sparc64 
> > 
> > Oops, I'm not sure how would we best fix this. Clearly the patch is not
> > intended for sparc64. Maybe adding devm_ioremap_uc is rather not safe
> > right now.
> 
> It seems you need a preparatory patch to satisfy sparc64.

Indeed, can you add that? If you are not comfortable the way to leave
behind lazy architectures is the HAS_FOO feature and then have your
driver require that or depend on the archs that support this. This
allows non-lazy architecturess to move forward with life.

  Luis
