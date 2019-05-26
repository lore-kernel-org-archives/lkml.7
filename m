Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A848C07542
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 02:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68EA2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 02:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPZUYHcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfEZCXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 22:23:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35826 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfEZCXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 22:23:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so5358151pfd.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lS+49dcTMUboNF3n3ygbqDWMefcchVrBwfQ3VCmkRYg=;
        b=RPZUYHcyOc23gKFscBiDVRGZNetBRCiZ6RQO1Bm2JrPD9niMS2Nu+/rc0LkELeGlhT
         3viMmyz+oRDvGgqQR2q1VZmez81RItkVXaGbk05TZ2lTZSZjhQW5VVs/G1Y1Q+UCcerK
         t7sz+5SNhGVyN+QeRL72zXnGabx6hgwHY54ROim8tam+ItTfxf1Hyn6li+3LJBn7bp1r
         ZFFyMcWC2X57wS9BBGQ1hNE3IfVE7acVgjEy9HqDfBQ80361ZwCM8qnUtAPPwfMdwFm5
         9d+MA7R0L9b+Zfzq++j4YjSmv2VLdhH4f4KvSqO9JB/Ey0XN6znMrx0LfDNj9lXkkN9f
         v74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lS+49dcTMUboNF3n3ygbqDWMefcchVrBwfQ3VCmkRYg=;
        b=XyxgOGMqA1TKQ6AgHIMG2v1jWdTyFOZrBfsI8OteHzIEGog702kurgVh81Kc2DFe8F
         2l4eapqYFvco+xRuQqieSkPpgawXNEs2lpfqWl9Z1fd/VR5VJsY6aD8rZIhs0dgCjufg
         L07wTJgHOamzf7Mr+r9KIeTnM+SqIKtM+ZYoZGRi2HGjauIKM/GymIwIWMulp5HkpeJV
         QOTShX/LYID6XJDEmb7Xv1Nq1OrqBqErI47dzBz99ZWTgje3xLFlI0jg1+HaBxvD3lAV
         A9jPgFAoQG10BjEsCV3ikblZNyHybAODTF7JywL2EZrBg1NhiIN3YQ4tbyPEPQKZlMpy
         rkPA==
X-Gm-Message-State: APjAAAVe1XlXYbc7I01srgb5GBXH+qi8xwcvOBCyoijF92IK+UQN4lX0
        CO82HzvfxcNWnD2cPjDps2I=
X-Google-Smtp-Source: APXvYqyc1wPoxm+m2i32KvJ/IufXk65qzbzwJtEcZ78/FxnbPCtQWwgLg33ar+yuz0/CQY7sUgphLg==
X-Received: by 2002:a63:ff23:: with SMTP id k35mr85131457pgi.139.1558837390806;
        Sat, 25 May 2019 19:23:10 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id n12sm6493054pgq.54.2019.05.25.19.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 19:23:10 -0700 (PDT)
Date:   Sun, 26 May 2019 10:22:58 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [A General Question] What should I do after getting Reviewed-by
 from a maintainer?
Message-ID: <20190526022258.GA14109@zhanggen-UX430UQ>
References: <20190523011723.GA15242@zhanggen-UX430UQ>
 <7510e8a7-3567-fc22-d8e3-6d6142c06ff3@infradead.org>
 <20190525021241.GA11472@zhanggen-UX430UQ>
 <20190525050648.GA20705@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525050648.GA20705@1wt.eu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 07:06:48AM +0200, Willy Tarreau wrote:
> On Sat, May 25, 2019 at 10:12:41AM +0800, Gen Zhang wrote:
> > On Fri, May 24, 2019 at 04:21:36PM -0700, Randy Dunlap wrote:
> > > On 5/22/19 6:17 PM, Gen Zhang wrote:
> > > > Hi Andrew,
> > > > I am starting submitting patches these days and got some patches 
> > > > "Reviewed-by" from maintainers. After checking the 
> > > > submitting-patches.html, I figured out what "Reviewed-by" means. But I
> > > > didn't get the guidance on what to do after getting "Reviewed-by".
> > > > Am I supposed to send this patch to more maintainers? Or something else?
> > > > Thanks
> > > > Gen
> > > > 
> > > 
> > > [Yes, I am not Andrew. ;]
> > > 
> > > Patches should be sent to a maintainer who is responsible for merging
> > > changes for the driver or $arch or subsystem.
> > > And they should also be Cc-ed to the appropriate mailing list(s) and
> > > source code author(s), usually [unless they are no longer active].
> > > 
> > > Some source files have author email addresses in them.
> > > Or in a kernel git tree, you can use "git log path/to/source/file.c" to see
> > > who has been making & merging patches to that file.c.
> > > Probably the easiest thing to do is run ./scripts/get_maintainer.pl and
> > > it will try to tell you who to send the patch to.
> > > 
> > > HTH.
> > > -- 
> > > ~Randy
> > Thanks for your patient instructions, Randy! I alrady figured it out.
> 
> Then if your question is what to do with these "Reviewed-by", you should
> edit your patches and place these fields next to your Signed-off-by line
> to indicate that these persons have reviewed this code (and didn't have
> anything particular to say about it). From this point you should not
> modify the patches with this tag.
> 
> When you'll resend your final series to the maintainer, it will include
> all these reviewed-by tags and will generally save the maintainer some
> review time by skipping some of them.
> 
> Willy
Thanks for your instructions, Willy! I already figured out what to do
now.

Thanks
Gen
