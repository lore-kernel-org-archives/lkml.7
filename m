Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED185C4CEC4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DF6217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="p1MWiAA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394413AbfITAVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 20:21:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46514 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390178AbfITAVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 20:21:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so5374752qkd.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=pro9C8zmq7NLgMwYhgr/6LGSa3Q7PkAjnibnN9csKE0=;
        b=p1MWiAA5FV5GBwt2EIlFX7PlfM/JFWtZLute0zB9YM/osQ/11szyWWaic3ZyQ/SZu0
         OaIeERsRiVOXxjZTRZHLJmQyAxo/c8IFFvCkTRmHb1sdpA+kVVk0KoyaIEVYpyup26K5
         8aWcL3YrjS5i9AmbE1j0wwip7zSi2eMDhrjRBRU5JdaJTrZYulLsGCtoAINRRy3XjiTV
         xYwJG57TEFA7gT7L0LxRvT0Ip0F+GdOmEhF5rw4i7vpn/VKhXQdLw6cr98ORRot5912x
         L429S8bA/t8FHPSd27P3ogpl3W6I76jDOmk+s8tuFL+HlbVTKBANkA+/RDrhrxeN/aOV
         hpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pro9C8zmq7NLgMwYhgr/6LGSa3Q7PkAjnibnN9csKE0=;
        b=eFESDWNtbkDFriyjGaSDTfjr5mRXnZ2p/CMHfagzeNB1iGO+NKLI+tBaMcdawtKR7T
         jj5qqWpGVOSSpoc4paUA1y6CWcdMMd/uiNieT2wD3aOuUhoB2ZNt4SzmyYx4VLAcBaaw
         eEjdCYECvUHrbQjBc3QuKi6BGrBXY5wJeKn77fuXbjaPPoENNUbRDyygMvhcFB1IKSoR
         vXh9TH0Ys9XuLlaFTRX0BPErbwscP41nCfN/xy8NJ0mtLsCZ6R/TtQOmc8cDvpw46oO8
         UK2H6S44YJbpTvGrJ+yC7WKABtvVBl127TYnWktQz0UGLz1rEZV2dUYi/TTbJd38CtOk
         NDuA==
X-Gm-Message-State: APjAAAW6JM5qMx31BNLJ2ZjPrkVfZDKB5J2AMw/8jP16uyFDnTdeSvD9
        2ncQ3cdAMoyZy+rEMFcY5mFhLc2ZpWA=
X-Google-Smtp-Source: APXvYqyzA42ktG/dDx6jAshGH/zvVqakR5TOxSDRcxunSBtsZ5MhzkJALycMc3DcCWG56RQKg+CuZw==
X-Received: by 2002:a37:c441:: with SMTP id h1mr589905qkm.16.1568938909826;
        Thu, 19 Sep 2019 17:21:49 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e42sm127840qte.26.2019.09.19.17.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 17:21:49 -0700 (PDT)
Date:   Thu, 19 Sep 2019 17:21:45 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Shannon Nelson <snelson@pensando.io>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pensando Drivers <drivers@pensando.io>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ionic: remove useless return code
Message-ID: <20190919172146.47bc95f4@cakuba.netronome.com>
In-Reply-To: <6cdb1e21-44d9-bba9-1931-78f7109bff2b@pensando.io>
References: <20190918195745.2158829-1-arnd@arndb.de>
        <6cdb1e21-44d9-bba9-1931-78f7109bff2b@pensando.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 13:46:34 -0700, Shannon Nelson wrote:
> On 9/18/19 12:57 PM, Arnd Bergmann wrote:
> > The debugfs function was apparently changed from returning an error code
> > to a void return, but the return code left in place, causing a warning
> > from clang:
> >
> > drivers/net/ethernet/pensando/ionic/ionic_debugfs.c:60:37: error: expression result unused [-Werror,-Wunused-value]
> >                              ionic, &identity_fops) ? 0 : -EOPNOTSUPP;
> >                                                           ^~~~~~~~~~~
> >
> > Fixes: fbfb8031533c ("ionic: Add hardware init and device commands")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> > index 7afc4a365b75..bc03cecf80cc 100644
> > --- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> > +++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> > @@ -57,7 +57,7 @@ DEFINE_SHOW_ATTRIBUTE(identity);
> >   void ionic_debugfs_add_ident(struct ionic *ionic)
> >   {
> >   	debugfs_create_file("identity", 0400, ionic->dentry,
> > -			    ionic, &identity_fops) ? 0 : -EOPNOTSUPP;
> > +			    ionic, &identity_fops);
> >   }
> >   
> >   void ionic_debugfs_add_sizes(struct ionic *ionic)  
> 
> This has just recently been addressed by Nathan Chancellor 
> <natechancellor@gmail.com>

Yup, should be in the net tree now.

> Either way,
> 
> Acked-by: Shannon Nelson <snelson@pensando.io>

Thanks for quick reviews!
