Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB34FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C6E206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573087370;
	bh=bS+06BKFVBMopebFdn92pM+vZl3ufTRnH2kDNb1bqgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nZ9o3I9JvTqGoX2mAcS1EBmFD5PHUO+A22ZW7AReJrBdT0Zy6fkAYwKxwmzh0Oslf
	 /3ifM0VSo23r4s9odOZR3ls+CUNi1Lw+/si9Do1EORsVzVcTaFx0JGSwsaSBaQzfZt
	 qgtOJFG4HwsvJcaLwU3Ef5XpIORxQVje3O5VjAAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfKGAms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:42:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33038 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:42:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id m193so461337oig.0;
        Wed, 06 Nov 2019 16:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BaMdvkX6/gm3yb6AlranOT6hft3gk4DYx/JF5HREgUo=;
        b=lOlyXTl94smq72Cbu4a2uiCKhhSCwALIUG4kPzTq0vgJ4q3sNBQ5C/sjLm3qWtyAsO
         np2p6K+YrAYkvR/F0zYpkh2ztL5dh9HYZyjSkb9Dc/dNLNIdeAxfoy2HDZVeh/uYVl4B
         W0kU0t/EA5eV2wAgJLNXZfxqDJA20fhZ6mLGpJPeqp6Aw8BSlRtq2O5D2Ip8SQPl3GGJ
         RoSovC52xTKbt8uJ91mZ0x8jdKhYuKMJlZgua2on7TxHe6z1fg/DiU0LmOZk9WNZ1JdG
         gYq94XixAQiR/hN5914+0QVA14X428BIwZBvVsCZg1otaUGod4GadS6JxTpZA4Y7ksCH
         1fnA==
X-Gm-Message-State: APjAAAWJX8bpt8rh5LYvXoHg0QT4LNiIS67I2gb2Bnqh8bMxibB60KY+
        AknPIYY2FNTXxL5nHZgRlw==
X-Google-Smtp-Source: APXvYqxrHH+YnkVD3+kslRvib3caC0bMHC4QtIxKI8BHGFEvOVsvW/wzw1myltvY5FsF0LMGzOcEnQ==
X-Received: by 2002:a05:6808:8e4:: with SMTP id d4mr743881oic.55.1573087367436;
        Wed, 06 Nov 2019 16:42:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q82sm121716oif.11.2019.11.06.16.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:42:46 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:42:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/3] of: property: Make it easy to add device links
 from DT properties
Message-ID: <20191107004246.GA11401@bogus>
References: <20191105065000.50407-1-saravanak@google.com>
 <20191105065000.50407-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105065000.50407-3-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Nov 2019 22:49:59 -0800, Saravana Kannan wrote:
> Add a DEFINE_SIMPLE_PROP macro to make it easy to add support for simple
> properties with fixed names that just list phandles and phandle args.
> 
> Add a DEFINE_SUFFIX_PROP macro to make it easy to add support for
> properties with fixes suffix that just list phandles and phandle args.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 62 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
