Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B379C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95202075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTVCTQwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfE1HFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:05:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42005 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfE1HFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:05:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id r22so8003798pfh.9;
        Tue, 28 May 2019 00:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E/ZAaCWtOroQWVvLC5q9wuH/qlBcoxb4vLQTQm3UQbo=;
        b=sTVCTQwcjOUbBeDTPZ9slIgPL7vc7+8M/O2YOnWqEz0DAzf2tUwdnTlU0GzopMLZJq
         mG8Nq01ounojAaiDTcwXpLoOCOfxfzprjI3G7jL2No2j89M8v51FdKkrH6eimAPl6ifx
         Ki3tWybo3KPGSaRLa/U+9d+PeIEdjH5EFMtzJlYcCnLR1sCkNUix7HMiWGK/c3Riidzj
         eVak/YJO22tACt/XU1quCIZ1d3CurojyziZydPbyttk0mk6zjFWroMJ2MY30Ys3OUA5a
         G8pzUEHYUXNswLQ74XLHjMj2bKfvgVcCzJ+YzapQqtnEUa6HwC1mxJXaW9T/5BUxw1RE
         gA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E/ZAaCWtOroQWVvLC5q9wuH/qlBcoxb4vLQTQm3UQbo=;
        b=EFPv7I6iQ8EfxafSkJ9a9A+QY27AReyG0DSSsBLvN+45WeSDDHHElOlA9Z1V/DXiu8
         4rW/KUJyFnz7JUPSFOzsWbq5dwaA0zRDzvci10b6iOX8LGN4Gx6nwjICzVp1k2HRsTTN
         Omn254Wka3k4jvuJLjrV7ggfJ6R3v4iZHpND53S41KBvlnXUP3clERsMRrDk2TGnK9P5
         fcRE91mX9WouiooI5g1t8BkxjAk8o9V0VLDgyBHtfJLdlGLYW0+5wCZAIvt1zXgomMgn
         VomFCGzsyl1CLyMskI+zKmsMOV11X5pl7+Z5Nr1ozg31eQVL9LNuXAnKCov8OQdMQkg1
         CJxg==
X-Gm-Message-State: APjAAAU92PQ15Ron68dPNYSRAN5+LR57NyjJYf8bumiu8pIsThbJeLNr
        ny9PlV8skY438c8Jj4qtHAQ=
X-Google-Smtp-Source: APXvYqwjuycOJymYacAnddrW34eMUmkeWw3rETyOEQpBXYDURHWelTLHkKdBzzVDLXiSgtPyJdGQhw==
X-Received: by 2002:a63:ec02:: with SMTP id j2mr107551727pgh.340.1559027129956;
        Tue, 28 May 2019 00:05:29 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id d15sm33527932pfm.186.2019.05.28.00.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 00:05:29 -0700 (PDT)
Date:   Tue, 28 May 2019 15:05:08 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpt3sas_ctl: fix double-fetch bug in _ctl_ioctl_main()
Message-ID: <20190528070508.GA18498@zhanggen-UX430UQ>
References: <20190527005716.GA17015@zhanggen-UX430UQ>
 <CA+RiK64ddLM1Uhp_neqaX3HeaGqn-b=MgK3fGzXnee-o3SAVdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+RiK64ddLM1Uhp_neqaX3HeaGqn-b=MgK3fGzXnee-o3SAVdg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:44:35AM +0530, Suganath Prabu Subramani wrote:
> Please consider this patch as Ack-by: Suganath Prabu S
> <suganath-prabu.subramani@broadcom.com>
> 
> Thanks,
> Suganath.
> 
> 
> On Mon, May 27, 2019 at 6:27 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> >
> > In _ctl_ioctl_main(), 'ioctl_header' is fetched the first time from
> > userspace. 'ioctl_header.ioc_number' is then checked. The legal result
> > is saved to 'ioc'. Then, in condition MPT3COMMAND, the whole struct is
> > fetched again from the userspace. Then _ctl_do_mpt_command() is called,
> > 'ioc' and 'karg' as inputs.
> >
> > However, a malicious user can change the 'ioc_number' between the two
> > fetches, which will cause a potential security issues.  Moreover, a
> > malicious user can provide a valid 'ioc_number' to pass the check in
> > first fetch, and then modify it in the second fetch.
> >
> > To fix this, we need to recheck the 'ioc_number' in the second fetch.
> >
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > index b2bb47c..5181c03 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > @@ -2319,6 +2319,10 @@ _ctl_ioctl_main(struct file *file, unsigned int cmd, void __user *arg,
> >                         break;
> >                 }
> >
> > +               if (karg.hdr.ioc_number != ioctl_header.ioc_number) {
> > +                       ret = -EINVAL;
> > +                       break;
> > +               }
> >                 if (_IOC_SIZE(cmd) == sizeof(struct mpt3_ioctl_command)) {
> >                         uarg = arg;
> >                         ret = _ctl_do_mpt_command(ioc, karg, &uarg->mf);
Thanks for your reply, Suganath.

Thanks
Gen
