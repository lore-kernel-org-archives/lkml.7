Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A6C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF1E20820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWHJnzpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfGNRE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:04:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34663 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfGNRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:04:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so10011038qkt.1;
        Sun, 14 Jul 2019 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fifFmsPpP77u9wn9Bi+cLuzl2ooK3wT2NlpPGgetbqQ=;
        b=GWHJnzpPem/cjvGASatoRSaiAB9BBZFDIYvrmGgVj2u5IOKLS6oWeaISk08IcyXBqr
         u+3X/iaGGriix4NneQL2oDn9JKSyTy15JV7A9NhDJKZ+oj67U/227zpPqvi+TXct1iIh
         JFjt2dX7sHcmuYAaXIGD8TH6tLu/MQyfBjAocsUbLGTFuVpXZBCo+nPJTvqrJ7bzSgiO
         dfYfixQcRyMWvp0Ka/SDYKi9lYzXIexKhqIBbfvvz3c6UWmC1zbm76ShVCLsTwojrlwR
         3TXKawqgYJXO0PJzlFc2AvoMyLX0fmsopvn1ISzgRhZBOhW/BFFgMfdnpSHebLz1OPfh
         Q9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fifFmsPpP77u9wn9Bi+cLuzl2ooK3wT2NlpPGgetbqQ=;
        b=Pusu7WrQ4K9nJR4ljncRbjnrue9FFpPNh+xJ2SDRPm4SSDwLQBdcNDHYOuh4GvZe89
         opDOh1Bam5pYkfy9YmSbBoRIU/0tFUBCgqZery5EaSAaPdcqFX+0WOnQ6Zsl/WqZ8wpb
         mu9AoVgOX9rO/beYX9KFE35DQRwVYAFUuQuvMqceqP5j8GlIWVBMRP2iaCaJV7uLnpU+
         PWYIQG1/GqAFsxoxwVL25YOQXKSkJJNh+aRvrZvidoJBmT7Hf0+bCAYLS5TfnVep2CHh
         ZdZ96s863vcrkUX3kpio0mg1/snvO0E1rDjU0SVcpHBsJ+WaH2qkANy+KV3nkAnCGcw5
         rpQA==
X-Gm-Message-State: APjAAAVTYHAFDiSLe8RxUbUCwRoE8iiGpvIN0MkvMRvD/pL9m2Z++vM/
        PhbmZwZ1mKkFXbd9XuvJ/A==
X-Google-Smtp-Source: APXvYqwRcksKUUflgv6z/92SVoaC+5Bz+I7zLvAWB4U35H7rkxhjCawisbZ7vv2azG2VmUgQ+kl/Ow==
X-Received: by 2002:ae9:ed4b:: with SMTP id c72mr13633944qkg.400.1563123867212;
        Sun, 14 Jul 2019 10:04:27 -0700 (PDT)
Received: from keyur-pc (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.gmail.com with ESMTPSA id c45sm8017047qte.70.2019.07.14.10.04.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 10:04:26 -0700 (PDT)
Date:   Sun, 14 Jul 2019 13:04:24 -0400
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [v4] staging: most: Delete an error message for a failed memory
 allocation
Message-ID: <20190714170424.GA3615@keyur-pc>
References: <20190711175055.25157-1-iamkeyur96@gmail.com>
 <20190714164126.3159-1-iamkeyur96@gmail.com>
 <dd7867db-1089-7366-165f-6accba233c38@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7867db-1089-7366-165f-6accba233c38@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think commit message is clear enough to understand why this is needed.
You can send me what should I include in commit description and I will
add and send it again. Otherwise, Greg can comment on this.

Thanks.


On Sun, Jul 14, 2019 at 06:55:30PM +0200, Markus Elfring wrote:
> > ---
> > Changes in v4:
> 
> I find this change log still incomplete.
> 
> You have chosen to adjust the commit message once more.
> (Some contributors might be also not satisfied with this variant.)
> 
> Such a change requires to increase the corresponding patch version number,
> doesn't it?
> 
> Regards,
> Markus
