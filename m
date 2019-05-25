Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E5CC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F9D217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYLFZkl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfEYCMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 22:12:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37214 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEYCMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 22:12:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so6342709pff.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 19:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRDE8zF4HYPjOCqdG8lC3nxgKH0V38BmEnSIPI9sFw8=;
        b=UYLFZkl8IJmwIFCA8qvyNuh98srotDtLaopvcyJPJBLxAtsP0W+4Gera1xQDqnmH0a
         1TOxqqwGQx1haiv7yQR6sbE7OLPiYwEA2Pi7kVdrA13+9y5TUUuaVwC+RzhQRmUQA6Fj
         mE5qL38rueRbbBqdQZCYf5Jpvz4qaku6mEeSvPK6i4IVsEckGj4EyKhZSBssXxRSpgDg
         W0FwziDBRN8K5tebnLX/cSBHQGn+SYOnBFanpPu/ATm8RtoWZ1JFZ8xksXwhIt0GZt/T
         XUtjE69uCy672Ls6dXrMtATF4JHahBdKhj00kMivKDZp0D/0oMc957OyuNQs4m2O64Yt
         jozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRDE8zF4HYPjOCqdG8lC3nxgKH0V38BmEnSIPI9sFw8=;
        b=UgfQwEfj0iVkAkocllKAYxS68DOoWD/ol/FXRc3eC4Zy33/BFKx1mB3MW1Kn+ae6O1
         ac9SASR2DPZsxfmSFzoGtT/zocNNrwSL9xQzwXZW+jvPyBxOe1Y7veE7Cw4yJq95djoD
         0gM/cRgn4gkU5EShklKDn6DWyaf0bCk4YpmXyLqv5FkLw/0LsGQIj8lwKEBUFnBlVRHZ
         mhbfNHnOYCTZvGqN+p1ChGNyjZqlc1Um0jG/RkgoVjfvYcbxgXOVvf/7kIhXEuUPGShM
         f5OKXAmIX/HyQ10q37q2KEeHW817cclNtQX5gP+MB+B2mIaaY81Gpq5JmTIGpsBeMvY+
         SxMw==
X-Gm-Message-State: APjAAAUEXKkiLIxnucdrDG9Y4PKDmDqbwRGpWSMnWUZbgZlbHFbHGTP0
        0Sanih55JLGv/7CfuCRvWy+Ilc+l/rM=
X-Google-Smtp-Source: APXvYqypLIELMrs+fdRtN94TJOHWAuh6nlm9jd5xqNsuV+tcwc54hP0RiDLjIuah0akPCGFCKJIAEw==
X-Received: by 2002:a17:90a:808a:: with SMTP id c10mr13269730pjn.67.1558750374065;
        Fri, 24 May 2019 19:12:54 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id d13sm4331537pfh.113.2019.05.24.19.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 19:12:53 -0700 (PDT)
Date:   Sat, 25 May 2019 10:12:41 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [A General Question] What should I do after getting Reviewed-by
 from a maintainer?
Message-ID: <20190525021241.GA11472@zhanggen-UX430UQ>
References: <20190523011723.GA15242@zhanggen-UX430UQ>
 <7510e8a7-3567-fc22-d8e3-6d6142c06ff3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7510e8a7-3567-fc22-d8e3-6d6142c06ff3@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 04:21:36PM -0700, Randy Dunlap wrote:
> On 5/22/19 6:17 PM, Gen Zhang wrote:
> > Hi Andrew,
> > I am starting submitting patches these days and got some patches 
> > "Reviewed-by" from maintainers. After checking the 
> > submitting-patches.html, I figured out what "Reviewed-by" means. But I
> > didn't get the guidance on what to do after getting "Reviewed-by".
> > Am I supposed to send this patch to more maintainers? Or something else?
> > Thanks
> > Gen
> > 
> 
> [Yes, I am not Andrew. ;]
> 
> Patches should be sent to a maintainer who is responsible for merging
> changes for the driver or $arch or subsystem.
> And they should also be Cc-ed to the appropriate mailing list(s) and
> source code author(s), usually [unless they are no longer active].
> 
> Some source files have author email addresses in them.
> Or in a kernel git tree, you can use "git log path/to/source/file.c" to see
> who has been making & merging patches to that file.c.
> Probably the easiest thing to do is run ./scripts/get_maintainer.pl and
> it will try to tell you who to send the patch to.
> 
> HTH.
> -- 
> ~Randy
Thanks for your patient instructions, Randy! I alrady figured it out.

Thanks
Gen
