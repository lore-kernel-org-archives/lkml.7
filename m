Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9F3C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE9320862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="Heyrg98N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfEWIDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:03:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34522 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:03:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id j24so4572219ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GPOuorQ32uJ+YRQwwZE95bT2omKKOwwwtpWjGVHMWoc=;
        b=Heyrg98N4Wo26gnY/JVGTBNNmNoWbhwP0yo4dKt8H+O8ILQDm1qKexfQsxO7gNi1GT
         S7SHMEETOSgo5Joz3ay/FP4fFXkduXjtlpBbDX5lk3eWOKhg5xaH6fhamfXysIWm+kUh
         Hmwp5bh9RrKnQDbQwhrnGQsIGG9WNAPMdomWdMGEEvTMNO+zbduR3Mpx83FcWC3ZLTDp
         cmlMeY9LFjqiDOV9m6NVxZcIhiwBFgFdg1+fmVBbhfSR4tCRcVzxRGoOuOKGllD9rYZ/
         YQhOeOnC19jtgPxSN4yqu/3vMsT6tdGJFQrXx69LNdX8TJtbYyEediVig3ukUfUgYKgB
         w/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GPOuorQ32uJ+YRQwwZE95bT2omKKOwwwtpWjGVHMWoc=;
        b=FUhZRsXzSEj7EvQI/LWGz9UrnQalnUYCW9bYZSjoCx2hwRNWRtAAmfL08j/P/FbaGL
         obcoftnVFSpxqfzoHroZ/qy1hbpIxbEmZny1I2rak9Bibb+xAXJ6uYl71aQPMHEnspba
         aCcFO3cHxhqIloo2wCnHEL97ByrJp50MPvlAEQa04rlcZ6lqtUo77uga8OFtGahb1wEF
         2Ts8oJwvx+JrskVlzLtyM/rj/JExkaVYFCpMReWjAzxmXOe9r2QBWlFTXBI96mmoIezi
         Dtf8SNKRD1YRvJ/Y+nr+x1ksvtvrfz357kNh88WYbOo5dG5IfDV25R2HbfQCwhGV4+3y
         Un9g==
X-Gm-Message-State: APjAAAV1nhWbgKK5y0SeziS5WFFZzk/XKM13D9TQDwfimLOjcien+bi2
        3AagdNEsPUtjMmiQV4uwUuc/Ww==
X-Google-Smtp-Source: APXvYqyoOD/ptktk0ASGAWXNuvhw2DiZr5qttk4R7BCV+c0nQHZ/sm8WqfO9PEdrq6z1NP1e4oRcpg==
X-Received: by 2002:a2e:5bca:: with SMTP id m71mr45364215lje.116.1558598582716;
        Thu, 23 May 2019 01:03:02 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id p5sm5891662lfc.80.2019.05.23.01.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 01:03:02 -0700 (PDT)
Date:   Thu, 23 May 2019 10:03:00 +0200
From:   Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: kpc2000: fix indent in cell_probe.c
Message-ID: <20190523080300.kri23fma2sqabvh4@dev.nikanor.nu>
References: <20190522205849.17444-1-simon@nikanor.nu>
 <20190522205849.17444-2-simon@nikanor.nu>
 <20190523072625.GA16429@kroah.com>
 <20190523072759.GA16656@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523072759.GA16656@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:27:59AM +0200, Greg KH wrote:
> On Thu, May 23, 2019 at 09:26:25AM +0200, Greg KH wrote:
> > 
> > This chunk does not match what you said this commit did :(
> > 
> > Please fix up and resend.
> 
> Actually, wait, rebase and resend after I apply your other patches.
> I'll hand-edit this patch to remove this chunk as your other fixes are
> good...
> 
> thanks,
> 
> greg k-h

Wops. OK, will do.

Thanks

- Simon
