Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70093C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F00520872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e930KWxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfIYJ3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:29:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42022 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfIYJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:29:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so2866181pgp.9;
        Wed, 25 Sep 2019 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s5WL1PikIGDCDiVlnVAjHbpWFfMH8+XVfK0RmImiiVc=;
        b=e930KWxSGHghdJBKCpMUuMtQhEDrg/+rnZA72/dAq8pEs1fOOe3aA7chmi5B5PUSy1
         oz8rLr1IsMyr8O00LKc5r/kXgdu533e1PzE80TUeIPAvYQsM9/2Fj5551V+rqqF/tvGQ
         ApkTltDXrTGJlAjxLAOt/FbTjbC8+iuthPbr3nr4zVginpLJbBagS5WXmLOFUvwxyVy1
         9PndxKRt1MsURb/w+g1TtrUuYZTz2e+tixplVKtRjThTARIcFYgxsLoXHVKp4zMDFW2n
         rnGOoZTC3XfX1Et4rjBtZnt+GFALmjjP2KJLY/hJOOETQllOexvHspTPB7W5qjd0ZGR5
         qZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5WL1PikIGDCDiVlnVAjHbpWFfMH8+XVfK0RmImiiVc=;
        b=Hw039itljGSJg8snqVufGPE70xiGZgDLAHNEd0UANjOOoSIg99/VSBmkv2LsIz2VvR
         F98Hs4/tpOPCabrwbYHOEmxJHo/J7uKPTevj/C+9nVD5TQOGd0PAjZra01Eq23kBZJMP
         tF+nFKP5eXhXuz9wTPyo7B7w2pHssinutejtzvxB+h//WyULXPa+m8IN4phfscwQ10KM
         1I9arCrSCM+L56Oo4ILm9fqgDUvxOo7Au0t91PnH1p87zfHQslyu0z9B4hLEdsevswBM
         7a/k5Se23JLHvBA1JrfH1FsCWmebk5msbURKUIuijg7Xw9+98TLbjfAHBm3u8mgMH4zW
         WhDw==
X-Gm-Message-State: APjAAAX4aW/Ifbi6Fkqm1AvDh70PMH+CkpjPL2tje1NzTaH4yw9EnRbL
        9Bph/n0CQVQj8vWjw04BMP0=
X-Google-Smtp-Source: APXvYqzG3UHencNXAsax8bV7Egkj+Al/7mrQP/ufz4bFTb0r9910ChvMxITsezqtevBQO3DHG5diXw==
X-Received: by 2002:a17:90a:e50b:: with SMTP id t11mr5348045pjy.50.1569403759948;
        Wed, 25 Sep 2019 02:29:19 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id b20sm8493571pff.158.2019.09.25.02.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 02:29:19 -0700 (PDT)
Date:   Wed, 25 Sep 2019 17:29:13 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
        Eric Biggers <ebiggers@google.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH xfstests v3] overlay: Enable character device to be the
 base fs partition
Message-ID: <20190925092913.GR2622@desktop>
References: <1569393333-128141-1-git-send-email-chengzhihao1@huawei.com>
 <CAOQ4uxjfko0+G_BUOt=fL1iTXdnWA=-=Kn-bgszF08g7yj4zqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjfko0+G_BUOt=fL1iTXdnWA=-=Kn-bgszF08g7yj4zqQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:18:39AM +0300, Amir Goldstein wrote:
> On Wed, Sep 25, 2019 at 9:29 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> >
> > When running overlay tests using character devices as base fs partitions,
> > all overlay usecase results become 'notrun'. Function
> > '_overay_config_override' (common/config) detects that the current base
> > fs partition is not a block device and will set FSTYP to base fs. The
> > overlay usecase will check the current FSTYP, and if it is not 'overlay'
> > or 'generic', it will skip the execution.
> >
> > For example, using UBIFS as base fs skips all overlay usecases:
> >
> >   FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay'
> >   MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
> >   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
> >
> >   overlay/001   [not run] not suitable for this filesystem type: ubifs
> >   overlay/002   [not run] not suitable for this filesystem type: ubifs
> >   overlay/003   [not run] not suitable for this filesystem type: ubifs
> >
> > When checking that the base fs partition is a block/character device,
> > FSTYP is overwritten as 'overlay'. This patch allows the base fs
> > partition to be a character device that can also execute overlay
> > usecases (such as ubifs).
> >
> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> Looks fine.
> Eryu, you may change this to Reviewed-by

Sure, thanks for the review!

Eryu
