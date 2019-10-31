Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A891ECA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C8820650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZixWELQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfJaMil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:38:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35507 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:38:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id x5so5739778wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uhoxQTqJS7TN8UEiHDJUbummgXcJZdDKj/YEdaqojMA=;
        b=sZixWELQR5cQZ8lnCI3d78Zr4QlSClG+ptOiYGwAf+PKvZsCDCAbPcr9vDxEfUG7tl
         wPbQUw+8FmP7IRyrt/96p3cLR/dOCT8xcf0s7QFTnwXDrUShJBp5m1HxNaVeOqJlphBt
         L1acY9lKZB/4OakIuAlFXE6Zr03/RIaRGYg/mxZmQv43fj7yq7cIR8oUbGlSwnIvbJgg
         ntAMXH/dbr4hZxW5lHu7vw5mRTCJN3QIuJOdpwTQzHfxrXCbIrLKEkaz15TudlW0/ynd
         ouNuxHgsEjl/Wa0k2OXKSIHnymMAooX7vbbyD9lreDZfA1QT0BbRz9iD/N3QXIXOiFu4
         qYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uhoxQTqJS7TN8UEiHDJUbummgXcJZdDKj/YEdaqojMA=;
        b=OgT2QHTSc9Ir1cTjHam5lIIALnWTcj6dJ8J58qZ4qeFIf/6RaNcAdEKI1Vf2msJusc
         w5feiCnqM9Cjr1uaTXUK0ZA8V1ZW+wc/36SdMEvW/G4D2d7dXkGSgL40kRrnSpgjo7g0
         jC5EOgGvIgyi72/UwF9Ofh/A2BVpPTs71EI/+d5I69aYlhGxbRYfny1efHFGOXWcxlWQ
         r+Fh3e/2OHe1uRnpNshGPiA0wF85HNR3HEgwkizACEuRhK8vQPPIGcVnIYgZNBPJgR3w
         Yuv6h+HyxGSxTnqpOkY7SqleD5nQvu8+rsSrpzNKqCHSuqeaOFGJvVQOfkfFaxe7VZPR
         F5cw==
X-Gm-Message-State: APjAAAVDr1yCXeGOd0aUjDKaN7Ruw+tjOSDU4uB9QttDbgzN8puYqStx
        RekEs1Gc7S8lJJURzdL0YZ8=
X-Google-Smtp-Source: APXvYqyobm4skG4Pd0DzqgekVRXwjSGHQx3GvfNg+Ad/meMFuELyqVIlhbD/fD9yrrI26HrwDMUBug==
X-Received: by 2002:a1c:7ec2:: with SMTP id z185mr4767560wmc.69.1572525518925;
        Thu, 31 Oct 2019 05:38:38 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id u7sm4429632wre.59.2019.10.31.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 05:38:38 -0700 (PDT)
Date:   Thu, 31 Oct 2019 13:38:36 +0100
From:   Roi Martin <jroi.martin@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: exfat: replace kmalloc with kmalloc_array
Message-ID: <20191031123836.GA6924@miniwopr.localdomain>
References: <20191030010328.10203-1-jroi.martin@gmail.com>
 <20191030010328.10203-7-jroi.martin@gmail.com>
 <20191030094222.GA678631@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191030094222.GA678631@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch failed to apply.  Please fix it up and resend it as a new
> version.

I have rebased the patch against the branch "staging-testing" of the
tree:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git

And sent the new version.

Thanks,

	Roi Martin
