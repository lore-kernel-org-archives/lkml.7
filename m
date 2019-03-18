Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84787C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD372133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HASW/sUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfCRQBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:01:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42434 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCRQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:01:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id b2so11668215pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Va0f51gZs88P/h+T9j2fVVC89pmI5CVVooNtP8M9xtA=;
        b=HASW/sUO4i0c+KuRC/gVVeebR7MWXOlJpxSQZqF9qvjGBYny1mKkA8jOmG6MFwedNt
         HP5NVBJd6bxxiQ4UBWspCN8hrXlfNA03anji1vEbFU0GK1cfDFoLLf1E6iKaDYRUppiH
         yYyxb9kcDt+OGlC1SK62C6sepDToZ2FNI/WZ8tGK74HurHauT7T1Sue4XAH2Cws/qNRE
         8ZsQ9KSuIkJPuJfVQPnE/XC79+Hc0S79vpnv3Vks3nJ9fX4IbjpcO3b8MAkbhUcLHPk7
         +pqd1b3OeLMW5TjlCvu4ZLAYbsmeQoG4Wt2NHDuO4wYI6cttSS50PiPryqm5wftgDBVJ
         5w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Va0f51gZs88P/h+T9j2fVVC89pmI5CVVooNtP8M9xtA=;
        b=ce5suGGCMyi66S0UJYVd9QgqXpi8OSJWkucldtF1kSo+Z/eSDeUTuE6JJVaPMHUKWJ
         mknbsuFZ4i+ZRhRWdtsIjE2WJ4IcP+NXLDdrbb2okAJp0SC6a1Q46wk7qV7KkvJsunah
         X6Vav/+ths68qaJq6o0mPAMpczsa2+v8nMXxSHT8b3SbpsuamZJla20yljdMxElT2wPy
         t00ZiVgJEsknVLfxweZrnmRHP25eMsiJ7QC+8V9FKYq3a8QcAZ+JptYd8/fuzCjwvmR8
         NvqJ4OLQCgCKswIQAcGPIU6k7+yP4HBissPWXyL7SQz4QCiZ3pqFyzM7WcBnDdKFHz1U
         gVCw==
X-Gm-Message-State: APjAAAVQfLeugXZEmXHSKxzvSCjdJ2YlcC/3iMGuUu0G8lQsgE1IdgLK
        O+eBf60zaN21lFCOKHb1LfgAl4Bn
X-Google-Smtp-Source: APXvYqybNWM7IJISzofE+hgB/3+KVq6cHvNuwY5lJ/I3ZRw9zs5Nx0co70Z7NcStrwC4iSX+kDI+DA==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7mr19878436plr.146.1552924864188;
        Mon, 18 Mar 2019 09:01:04 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id h75sm23857680pfd.150.2019.03.18.09.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:01:03 -0700 (PDT)
Date:   Mon, 18 Mar 2019 21:30:56 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yuchao0@huawei.com,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: erofs: Add whitespace after declaration
Message-ID: <20190318160056.GA4640@bharath12345-Inspiron-5559>
References: <20190318153224.GA3596@bharath12345-Inspiron-5559>
 <20190318153816.GA15943@kroah.com>
 <863a7266-0068-a751-bbe6-cea78caf9355@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863a7266-0068-a751-bbe6-cea78caf9355@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:40:35PM +0800, Gao Xiang wrote:
> 
> 
> On 2019/3/18 23:38, Greg KH wrote:
> > On Mon, Mar 18, 2019 at 09:02:24PM +0530, Bharath Vedartham wrote:
> >> Add whitespace after declaration. Fixed the checkpatch.pl warning.
> >>
> >> ---
> > 
> > No signed-off-by?
> > 
> >> changes since v2
> >> 	- mutt gave me a lot of problems. Hence 3 patches for a really
> >> 	  small problem.
> >> 	- Fixed the extra missing line.
> >>
> >> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > 
> > It needs to be above the --- line, otherwise it will be stripped off
> > when applied.
> > 
> > v4 please?
Missed that! Really sorry!
>
> Actually a duplicate commit, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=8af36478f9516d51fcfedf9b9ed8905a1c00d278
> 
> several people submit patches on this line in erofs_iget()....
> 
Oh alright then! I ll stop this patch here! Thank for your time! I have
noticed that there are a few functions and structs local to a file in erofs without static
declaration. I ll send a patch soon.
> Thanks,
> Gao Xiang
> 
> > 
> > thanks,
> > 
> > greg k-h
> > 
