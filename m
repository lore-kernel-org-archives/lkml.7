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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBF7C28D1A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65084207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEVBYQ/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFFHnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:43:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46421 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:43:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1246680wrw.13;
        Thu, 06 Jun 2019 00:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hMKmVMGvuYghM2RFGeSJw2TVBQZRwZNWp/oZeq+70J8=;
        b=ZEVBYQ/jzqpS6ukiE7bRSgDO82tLgsQV02m3WFjdt/MLOQEmp+qt1SFqiuW+RaTHTt
         nzh3W01MCjlfAHeEDBmmB0/vQU5Z/9Ce+L32CgRBMijRobxpmX2/8VG/cT1NY8FWklUf
         dplk6FE5NMxLAHF7aJoZ5LC15XN+4kCNBluSM11tIp4t9a90dg0IEx0b9rrqppfFS9X1
         6Kk2E9Oi9OcYEldLyRxAVKb6DyKEgZBuhMIE8Qn4duffT0Epedy/vjw+FWCirRsm7Viq
         B505bt/FV5fCT6jyKRm3q3IfK5MOAJVBkFdGmKpgDOowZ1DYXUOnwLYBIaeITcToAefk
         dlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMKmVMGvuYghM2RFGeSJw2TVBQZRwZNWp/oZeq+70J8=;
        b=PJ65+6lHvVkAaHPEMwm2Zqo/HfViEcYK/ay/AeOuVTz5KUKg3gOiNUmADe1Nya5ROB
         hXAmlYpqAS5vmGQjZJLiyXTpMYer/pM/d8zAwJPgOPeTnlr/DVDa8T5jIMzUUMxDg58+
         eAMF3h5xcZh4ufTkd4P+vcr07rMxl48ZYVW7fZOiRZrvq2yizJWNbsulYQln43s+ngRV
         CBrRxUG7998yDbvoobH36K/wNlPhfjhoMloX+9qKCEkx8LvTfVjWXb60x9MaKnICOsPz
         C4OfazO9Q+FKuPz9jLsaqr6x09ASRh/lKanK9FF4viYFyloNak3EeD1PILGpfQS1ExKw
         xrFw==
X-Gm-Message-State: APjAAAUE5v1w/+JZGbXoG79nsrSII8DIMqJ2eiknlnIxFh5qTHY2u9PS
        0G1Tq3UQBrxeToJx/LBtJesSYmcl
X-Google-Smtp-Source: APXvYqyl60FHgPIDeBya3Spzwu8TBxapowa2m12QndF+5rNT+N5MQCJhdyssMJmG6DrWouswtBHSxg==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr30759497wrn.94.1559807021232;
        Thu, 06 Jun 2019 00:43:41 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id t140sm1002151wmt.0.2019.06.06.00.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:43:40 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:43:33 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sg: fix a double-fetch bug in sg_write()
Message-ID: <20190606074333.GA7078@zhanggen-UX430UQ>
References: <20190531012704.GA4541@zhanggen-UX430UQ>
 <38bbd54f-d85b-e529-36ad-5c1809bb435f@suse.cz>
 <20190605153532.GA4051@zhanggen-UX430UQ>
 <2d322852-4861-929a-28ed-c4b41bea5ba6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d322852-4861-929a-28ed-c4b41bea5ba6@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 07:01:26AM +0200, Jiri Slaby wrote:
> On 05. 06. 19, 17:35, Gen Zhang wrote:
> > On Wed, Jun 05, 2019 at 08:41:11AM +0200, Jiri Slaby wrote:
> >> On 31. 05. 19, 3:27, Gen Zhang wrote:
> >>> In sg_write(), the opcode of the command is fetched the first time from 
> >>> the userspace by __get_user(). Then the whole command, the opcode 
> >>> included, is fetched again from userspace by __copy_from_user(). 
> >>> However, a malicious user can change the opcode between the two fetches.
> >>> This can cause inconsistent data and potential errors as cmnd is used in
> >>> the following codes.
> >>>
> >>> Thus we should check opcode between the two fetches to prevent this.
> >>>
> >>> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> >>> ---
> >>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> >>> index d3f1531..a2971b8 100644
> >>> --- a/drivers/scsi/sg.c
> >>> +++ b/drivers/scsi/sg.c
> >>> @@ -694,6 +694,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
> >>>  	hp->flags = input_size;	/* structure abuse ... */
> >>>  	hp->pack_id = old_hdr.pack_id;
> >>>  	hp->usr_ptr = NULL;
> >>> +	if (opcode != cmnd[0])
> >>> +		return -EINVAL;
> >>>  	if (__copy_from_user(cmnd, buf, cmd_size))
> >>>  		return -EFAULT;
> >>
> >> You are sending the same patches like a broken machine. Please STOP this
> >> and give people some time to actually review your patches! (Don't expect
> >> replies in days.)
> >>
> > Thanks for your reply. I resubmitted this one after 8-day-no-reply. I 
> > don't judge whether this is a short time period or not. I politely hope
> > that you can reply more kindly.
> 
> There is no reason to be offended. I am just asking you to wait a bit
> more before reposting. 8 days is too few. My personal experience says to
> give patches like these something close to a month, esp. during the
> merge window. The issues are present for a long time, nobody hit them
> during that timeframe, so there is no reason to haste.
Thanks for your reply, and I will keep this in mind.
> 
> > I am just a PhD candidate. All I did is submitting patches, discussing 
> > with maintainers in accordance with linux community rules for academic papers.
> 
> Yes, despite I have no idea what "linux community rules for academic
> papers" are.

I mean, these patches come from a research project prototype. Submitting
patches, and getting it applied can be demonstrated in the experiment 
part of research paper.

Thanks
Gen
> 
> > I guess that you might be busy person and hope that submitting patches 
> > didn't bother you.
> 
> It does not bother me at all. Patches are welcome, but newcomers tend to
> send new versions of patches (or reposts) too quickly. It then leads to
> wasting time of people where one person comments on one version and the
> others don't see it and reply to some other.
> 
> thanks,
> -- 
> js
> suse labs
