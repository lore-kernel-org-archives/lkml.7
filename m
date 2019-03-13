Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30250C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C792087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLOw/x4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfCMWGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:06:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33663 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfCMWGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:06:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so2357431pfd.0;
        Wed, 13 Mar 2019 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnfITYU7y5bBOIxlrIvn104WKZ6R1s6DCeo0qJsrhdI=;
        b=uLOw/x4R+0NafddNQ3K4rsO6vl318WxEsBPHBcgYBca8FDVWWkOVvHP26ityYQV+I+
         ibpDkmdI+59g6sQ5CEh1IKoSbZgJtWMlI7Y1EK7lbI/6FvWptxcz5ewvEp8YdE+Hdq5P
         cwkOn0XXT9XfjtwDABxYolCwNqoIMf5FbLQKDxW6jd4lKSWTTpsIIEGUQ2W9OPnkNWdL
         OoQN6mrQqHCPHw1Q9s5Zo+QCWuTXb7WN85GgBdyiBB5AH4RdgKjbScAzSBzUx4ljP9Zy
         Q3bC8+6c3HSYrHCkbsR+hJ3iqi09rLfzO1V3CkoNu8oiHlfqzTYbiy0q89/2JzF8tuaN
         E3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnfITYU7y5bBOIxlrIvn104WKZ6R1s6DCeo0qJsrhdI=;
        b=Nu8hNaC25aYsfmly3Z48G8doXduCiCsbVuivR6zgmwSUiJI60T5FEHXNenGPjt30sJ
         ctCWDhNvxV6rVbwBBcjigCx0tN7dNwRjocH4XQzRqKP8zf9CxVjMJ/JaxxG2KJl9tCAU
         PmZ0BwKTmPbOzdnWnav+J14by7OtjN6kAjbWveVLp9zENGqjWq2DcCZ/uxsy1vv7f7s6
         m9m/DnXv1wIn0JXaobcsHvXaAQsfCFx0V/uURqGq1ZTnHu5PbXzaza23BYmclgEW/NcH
         0ZrzhP63/dwVAzfegvRiNgqjeXM+jIjI7Sy0fRMf4V5vnmUfSJ5UQgKERtcVuhfiZ31o
         BJGg==
X-Gm-Message-State: APjAAAXXfQlom6etLjdUxz4ZCEhY3JXbkj5NESOJO2oMsZeS7H66fVZm
        EKCn2EVxjuKheqfz4lG+ELk=
X-Google-Smtp-Source: APXvYqwvxtsYZre2Rum3rQOVSMMfRk1mhllDE+gg+OpG5fIMsi+NF8yeNM3oWIHyaGxLdXdBWU+acw==
X-Received: by 2002:a65:5c01:: with SMTP id u1mr42339708pgr.197.1552514796130;
        Wed, 13 Mar 2019 15:06:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h126sm34339877pfc.135.2019.03.13.15.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 15:06:34 -0700 (PDT)
Date:   Wed, 13 Mar 2019 15:06:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
Message-ID: <20190313220633.GA1613@roeck-us.net>
References: <20190312171034.530434962@linuxfoundation.org>
 <20190313203441.GA26634@roeck-us.net>
 <20190313204949.GA1088@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313204949.GA1088@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 01:49:49PM -0700, Greg Kroah-Hartman wrote:
> On Wed, Mar 13, 2019 at 01:34:41PM -0700, Guenter Roeck wrote:
> > On Tue, Mar 12, 2019 at 10:09:18AM -0700, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.163 release.
> > > There are 96 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu Mar 14 17:10:06 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 172 pass: 170 fail: 2
> > Failed builds: 
> > 	i386:tools/perf 
> > 	x86_64:tools/perf 
> > Qemu test results:
> > 	total: 316 pass: 316 fail: 0
> > 
> > Culprit is commit 386ca5754fad ("perf trace: Support multiple "vfs_getname"
> > probes"), which introduces a call to strstarts() but not the necessary
> > include file or declaration. Unfortunately, fixing that is quite complex
> > (commit 8e99b6d4533c ("tools include: Adopt strstarts() from the kernel")
> > doesn't apply).
> 
> Thanks for tracking this down, I'm lost in a maze of gcc8 issues with
> perf on 4.9 and 4.4 at the moment trying to fix that.
> 
> I'll go drop this patch from the 4.9 and 4.4 queues.
> 
Agreed; the same patch also introduces a call to evlist__for_each_entry_safe(),
which does not exist in v4.4.y.

Guenter
