Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A96C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C43421019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksC3eCaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfEWNCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:02:24 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37682 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:02:24 -0400
Received: by mail-oi1-f182.google.com with SMTP id f4so4274715oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNTxg7bVPZmS33ui0X46cGpgoHbHka7Jatfgd+05r0A=;
        b=ksC3eCaUf4c9SziYbr35L/hYzF9ZaG5TbfHH6tVpupboGJa9b77/If5Mmhwr5dllY/
         sOZ7+ZCJhg62PVMtRTx1P1tjtgr4EXdHsqKZ0q/pwZmT3GFjF3mwcIQidi0Zp/HJ201Z
         cAZO4tfzZjgrby4BLXLqTlhP3OcMa2V4WSy7r4PCyDfTe7CT43LHN6EZta8KIHVDGZxk
         UqUzDpFAfp+gZoSkktkZGyTl+XYtXHThstAHieI2ZZLmjEX3b5bsP2APbW+nxiA3hRxq
         9PSmBV8TZSHFQjtYDNgt5jDN4l6Am0nGcsdRkimRKBG9dz412CoFhTT3PLA6zXU4+SFD
         IMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNTxg7bVPZmS33ui0X46cGpgoHbHka7Jatfgd+05r0A=;
        b=ArNbQSDriKEWmSM0RuFXWuyipk0M+dgRVrN+R3UGH9mPMGdPSCYdO7ZsAQIQpr+yrq
         jURiTLR9m4gqcVc95ypd9dT6SLqQX97YNeCNVUIYZgvrAZBo9aSNnp0xs+aEQcuaUVDH
         00oMled2ss7rzLOy067+Ndk9Ae9xcO/2f3ypWezKkhskAensu/WntKYLHccSRkPrwuxj
         gjBTDcJ2HfmTTVjsN5Ny0CxFcHGs3ZLyboRaD4FEWUPtzkvJ05DZUxndbIWy56VQ5kdv
         oPbGedVgKBnk2vgy1YK9k6xwPE8OmrPGO8qJtBjgx1RZAMKCg9d83Yzsx1g3hGkRD2ys
         1yhw==
X-Gm-Message-State: APjAAAVfUWQ1qZ3t5TqguLpu/s9lzvtvmqwhC0GwhbZP03TP5TpRwM2b
        SvvkbqevRRzuMdTU5OKnSGDSA3zhCUsAf2TSMz+LZg==
X-Google-Smtp-Source: APXvYqzPq6u1bW7frG+lxPr4cHztCZGidS1iWMvvxUPCE6evmBgLNIR25ve8juJpQmUQyy35gSn4H8ph1pgY1Qy/8oI=
X-Received: by 2002:aca:7250:: with SMTP id p77mr2703246oic.103.1558616543038;
 Thu, 23 May 2019 06:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190523063504.10530-1-nishka.dasgupta@yahoo.com>
 <20190523072220.GC24998@kroah.com> <b8cc12d9-2fe3-754b-be08-f23055a31ffe@yahoo.com>
 <20190523082702.GB28231@azazel.net> <20190523090918.GU31203@kadam>
In-Reply-To: <20190523090918.GU31203@kadam>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 23 May 2019 09:02:11 -0400
Message-ID: <CAGngYiWT3a5EYZsgxdRQsrEnu4Cw6FNmNWhzx721SY8DXYL4Rw@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: Remove unnecessary variables
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeremy Sowden <jeremy@azazel.net>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 5:09 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Sven, you should add yourself to the MAINTAINERS file.

Greg, what do you think?
