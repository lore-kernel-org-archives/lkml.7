Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FE8C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FB320652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHu69qMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfFFIBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:01:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51080 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:01:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so1374665wme.0;
        Thu, 06 Jun 2019 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TB7C9wcf8PFXwPAACMih5rxgrGoAW/VScanIebs1BEE=;
        b=PHu69qMAbjuoGKnHcOkjYV0QDj5qj2uNYwYpwOOhY/jPUKDrZKOV4IcdjK5+6/0LVp
         S6FlqnnxddlwLCqItW+UmQ/boYbv3a5zdcQVgPn3sYLnOFffMukGT3VgL4tAqxStsLMg
         6o4pKu68RCb0t6Pw3yEHGIhvOXCC30Qpoek8bb2qB7YV3Ix/nWa/F5+nxplCp1u1Okai
         /rxpqfCK+fm+BcvH8Zq3Q2tDRr9Hi1bVTdzWA0o69teOWCZ7KL/AllXxfTapKHVmrWZm
         VhC225X6ryPBYMPZ6D3Cz28aOGGrG0Ape/VDTQW/K4fvE4kXIeKqBGaT5dAiK2JJyzzg
         OnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TB7C9wcf8PFXwPAACMih5rxgrGoAW/VScanIebs1BEE=;
        b=mHwz6UCQYxvxaLqglvnk1FdT4VcyXNkXEGjEtuHZrcgdT5DInE1jp1O2LHRJZ/4dEC
         MY+M7RBu+j7agAZJTJ0ogvXYE1dFrC6ydFNSGZXTy+Vf8kEvHF7eJlrK/57AUq82rgP6
         inRYh+Gf/E8SN0SuoOHjvq1DQXXBe+36j5HS7DRj2xrq55RN4E6P8xFn1yfyUJaPaRsF
         B9xRf6TnkNLboD5LsU2lMLfzns79gctxDsw1RcMj+A1AqrAR8+7TvGgwDVD5NApVBFdg
         BlQf67u4zhcKmPCkZC81qLyWj6vsD+YVMF46kmrGLbG49SspxO9mrGJ6CkehF8iAeQ26
         Zfgw==
X-Gm-Message-State: APjAAAVuD0/uv1ssb/Qw2DdKv48MTsX/l71jQUv8yv7mi81VB82TcOOe
        8PuwYBz4Qx91crdZgV2yfuk=
X-Google-Smtp-Source: APXvYqyKS/M2cbCYiNH11Voj4grF6S9NQ7iS9OtU5ZsrzC4u3leDfYNhY6itcXuAF0oO06fN03yJCA==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr16870281wme.125.1559808065906;
        Thu, 06 Jun 2019 01:01:05 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id o13sm1260908wra.92.2019.06.06.01.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:01:05 -0700 (PDT)
Date:   Thu, 6 Jun 2019 16:00:59 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sg: Fix a double-fetch bug in drivers/scsi/sg.c
Message-ID: <20190606080059.GA7919@zhanggen-UX430UQ>
References: <20190523023855.GA17852@zhanggen-UX430UQ>
 <d7cb94f3-f136-62ff-3067-b3e5f6ac63ce@suse.cz>
 <da6f10b8-3b9a-f8d6-33c4-0d8f5711bb23@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da6f10b8-3b9a-f8d6-33c4-0d8f5711bb23@interlog.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:07:25PM -0400, Douglas Gilbert wrote:
> On 2019-06-05 2:00 a.m., Jiri Slaby wrote:
> >On 23. 05. 19, 4:38, Gen Zhang wrote:
> >>In sg_write(), the opcode of the command is fetched the first time from
> >>the userspace by __get_user(). Then the whole command, the opcode
> >>included, is fetched again from userspace by __copy_from_user().
> >>However, a malicious user can change the opcode between the two fetches.
> >>This can cause inconsistent data and potential errors as cmnd is used in
> >>the following codes.
> >>
> >>Thus we should check opcode between the two fetches to prevent this.
> >>
> >>Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> >>---
> >>diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> >>index d3f1531..a2971b8 100644
> >>--- a/drivers/scsi/sg.c
> >>+++ b/drivers/scsi/sg.c
> >>@@ -694,6 +694,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
> >>  	hp->flags = input_size;	/* structure abuse ... */
> >>  	hp->pack_id = old_hdr.pack_id;
> >>  	hp->usr_ptr = NULL;
> >>+	if (opcode != cmnd[0])
> >>+		return -EINVAL;
> >
> >Isn't it too early to check cmnd which is copied only here:
> >
> >>  	if (__copy_from_user(cmnd, buf, cmd_size))
> >>  		return -EFAULT;
> >>  	/*
> >>---
> >>
> 
> Hi,
> Yes, it is too early. It needs to be after that __copy_from_user(cmnd,
> buf, cmd_size) call.
Yes, it is.
> 
> To put this in context, this is a very old interface; dating from 1992
> and deprecated for almost 20 years. The fact that the first byte of
> the SCSI cdb needs to be read first to work out that size of the
> following SCSI command and optionally the offset of a data-out
> buffer that may follow the command; is one reason why that interface
> was replaced. Also the implementation did not handle SCSI variable
> length cdb_s.
> 
> Then there is the question of whether this double-fetch is exploitable?
> I cannot think of an example, but there might be (e.g. turning a READ
> command into a WRITE). But the "double-fetch" issue may be more wide
> spread. The replacement interface passes the command and data-in/-out as
> pointers while their corresponding lengths are placed in the newer
> interface structure. This assumes that the cdb and data-out won't
> change in the user space between when the write(2) is called and
> before or while the driver, using those pointers, reads the data.
> All drivers that use pointers to pass data have this "feature".
> 
> Also I'm looking at this particular double-fetch from the point of view
> of the driver rewrite I have done and is currently in the early stages
> of review [linux-scsi list: "[PATCH 00/19] sg: v4 interface, rq sharing
> + multiple rqs"] and this problem is more difficult to fix since the
> full cdb read is delayed to a common point further along the submit
> processing path. To detect a change in cbd[0] my current code would
> need to be altered to carry cdb[0] through to that common point. So
> is it worth it for such an old, deprecated and replaced interface??
> What cdb/user_permissions checking that is done, is done _after_
> the full cdb is read. So trying to get around a user exclusion of
> say WRITE(10) by first using the first byte of READ(10), won't succeed.
> 
> Doug Gilbert
> 
Thanks for your explaination. I guess this patch should be dropped for
the above reasons.

Thanks
Gen
