Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691CBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A9A20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwWIdpSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDKVHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:07:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36401 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:07:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so4094442pgc.3;
        Thu, 11 Apr 2019 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8QoNjccgba2liRazhiXGtqN9gYFAnXX0AWzdPDl8NkQ=;
        b=NwWIdpSgYRaMTZTU9y+/4NO/PZdDflMH5TZPEoovewndnSXv5wWys54Yv27xbBieIE
         0H5Jv5+eLbeJuiZ7J8oqVPneGeCPFudUnsSQontJdKa4nPMHpNjarTPzirb+rG2QXbo2
         wOt5VeshQ2fFU/P32wnfYhu5ekPXKTJkppCVYDBebWW1ySafeFVWXY99rIq2Nv/Jd86G
         7BXjb70htCT8tRke6nbOb6faHMZ8CqJcZkooUj4fSh0+ErHTwHH7t7lu/hv65siFEyUV
         74RxRXd1glNl/mrGIAJ91+fAdSRxxPWjjrXq55wtIUWxKQg4ZohhC8uJcC0FiBVpkZXZ
         6uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8QoNjccgba2liRazhiXGtqN9gYFAnXX0AWzdPDl8NkQ=;
        b=KnTlMFATA159IobWxJyVib8WluKFcWFwwbO2Gbt9mLuh6jntoPtHSkjiyTHWYNYE6k
         vlR5uoePX345YvYKioTnXIhLCSLug5+P3SVI6Xv6ISQkGL/wYFSNfyPwbrti/pbDsg5L
         Vaz4Js3IDIbPujld8GqSIUZtrZYeDbB2oUnhblwO8oq6JKpfZCfWeKShTKenbEy+WEIa
         jClAwATCfws1EHPyiPovNF0v/rSvWJ1EvX1ljriPw8akWoJ1Bv8pkz7AijMXHhO/C8d1
         5tdUsHjKy4iD7dDop3dE+m4+wSLgVq9sKow6gql0Ql5WELhe/W/SuCO9C437+jQHEQtY
         5PHQ==
X-Gm-Message-State: APjAAAXmfbFr3X50epqlDc5U98Dz7Ono738GmtU9hqUSDJ0B2rm2wnqR
        5r8W1eXyHpcpVK8AKylJtvs=
X-Google-Smtp-Source: APXvYqxu2TSmC4/JxGq7Qq4fzyWNHJUPxpDT+BVQpAKIQ8eBBRLGjWm8DqgaMIkYpmUCgWHaQrKP7g==
X-Received: by 2002:a63:e845:: with SMTP id a5mr50493631pgk.246.1555016853736;
        Thu, 11 Apr 2019 14:07:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3sm56709579pfn.167.2019.04.11.14.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:07:32 -0700 (PDT)
Date:   Thu, 11 Apr 2019 14:07:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
Message-ID: <20190411210731.GA29378@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
 <20190411174357.251904f5@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411174357.251904f5@coco.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 05:43:57PM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 11 Apr 2019 12:43:24 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > On Wed, 10 Apr 2019 16:22:37 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > 
> > > This series converts the contents of Documentation/hwmon to ReST
> > > format.
> > > 
> > > PS.: I opted to group the conversion files per groups of maintainer
> > > set, as, if I were to generate one patch per file, it would give around
> > > 160 patches.
> > > 
> > > I also added those patches to my development tree at:
> > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=hwmon
> > > 
> > > If you want to see the results, they're at:
> > > 	https://www.infradead.org/~mchehab/hwmon/  
> > 
> > This set seems generally good and could probably be applied as-is.  But I
> > have to ask...is there a reason to not take the last step and actually
> > bring this stuff into the Sphinx doc tree?
> > 
> > We seem to be mostly documenting sysfs files and such.  I am *guessing*
> > that perhaps the set should move to Documentation/admin-guide/hwmon?  Or
> > have I misunderstood the intended audience here?
> 
> :-)
> 
> Yeah, I'd say that 80% of the contents there are user-faced.
> 
> Yet, the main issue with this (and other driver subsystems) is that there's
> a mix of userspace and Kernelspace stuff. One somewhat simple case is
> the abituguru: it has a "datasheet" file:
> 
> 	abituguru-datasheet
> 
> This contains programming information for the corresponding drivers,
> while abituguru and abituguru3 contains mostly userspace
> stuff (still, it also contains the I2C address, with shouldn't mean
> anything for the user).
> 
> However, if you take a look at w83781d, you'll see a mix of both
> userspace and driver developer info there... it has a chapter called
> "Data sheet updates", for example, with is probably meaningless for
> anyone but the hwmon driver developers.
> 
> That's, btw, a pattern that happens a lot inside device driver
> documents on almost all subsystems I checked: driver-specific
> documentation is usually not split into user-facing/kernel-facing.
> 
> While nobody does such split, IMHO, the best would be to keep the
> information outside Documentation/admin-guide. But hey! You're
> the Doc maintainer. If you prefer to move, I'm perfectly fine
> with that.
> 

Same here, but please don't move the files which are kernel facing only.

How do you want to handle this series ? Do you expect it to be pushed
through hwmon, or through Documentation, or do you plan to push yourself ?

If the series isn't pushed through hwmon, we'll likely have a couple of
conflicts against hwmon-next.

Thanks,
Guenter
