Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8B4C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7687208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="aZZBbp3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfFQMAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:00:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42930 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:00:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so8989226lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xGIILVfXf7VmS4FvscoSNixWx+XWfKfE5N4G3kPEMwo=;
        b=aZZBbp3yrNPfUMQPOcjDFQV9k2zoDpsVWrIXoMpLQrpqRYkS1vahaodU+eBIGDVXJz
         kI2kTUdwax/aS4nnG3MDZ8DhyuYmE+cSOHvgZpgGL7RULOilnoUmCZi8TFDXiJsq2dQ+
         BDXIMsDwFhMnB+kub7yEt6iq/RZj+KS6PSIXX6wqpENgJUYOK3OawX/qVRQQJX2KwO+S
         HHnqnU1JnuYnXBYtxCW7kD12ik2XNeAcTqqjNuxYb0k6bGP2yZobZnr2hS0VSj613A2t
         sC0sUqWRmHYL3D0TbyuoJmiMaRs0D0SUhux+mEGPiEkd6V+AStCgIEYq/1XeM6VFOGBi
         5O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xGIILVfXf7VmS4FvscoSNixWx+XWfKfE5N4G3kPEMwo=;
        b=WaJX8ShswYDoj0u32UQ0Cra0CRuCtl+n0eO3dtDABb/kl8kXSqo6VLBZPn9Rr7m1x0
         P0pXn69TPwkmNVfNSD0GxENpfnXQ1n57HxAUpE+NtieC+XRsJ+jTFDiXoZ/0Zn28tEzC
         LTJxBOHGD4PG9ZHMQsVPchKsReB0giYtTg2Ekgv0YdqhKcr80BD7JCukVfR2hmN8L+75
         0z/XWTmSwwn7CnIJwIdsgVQGdOu7FlaitwJ0mEjCn5VjE8h9YNIdvFlInKkM6ZsOfF/l
         hiRLGGvNDvQWEb/ixaLJvENL3Tu3tS7FjEvyTF3VppzY1wRXg/SyICCt7zyu4CoHoJ61
         Q9YQ==
X-Gm-Message-State: APjAAAUvbMbI3eDnhK3VXh0d3b4525+qA90Q0f4so4//j/p1V8ax0OKf
        HZRDtQeivIrjRGiUXyCy5090Mg==
X-Google-Smtp-Source: APXvYqyp6cCFvtccc98Mr7cwSB/h75VTWC+F6gFL8fxb/D1x44pKnPB27rv0DjAhw1uUrmL7CbcgEw==
X-Received: by 2002:a2e:8741:: with SMTP id q1mr31348628ljj.144.1560772845064;
        Mon, 17 Jun 2019 05:00:45 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id m21sm1725308lfh.20.2019.06.17.05.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 05:00:43 -0700 (PDT)
Date:   Mon, 17 Jun 2019 04:40:22 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [GIT PULL] updates to soc/fsl drivers for v5.3
Message-ID: <20190617114022.54oznl3l35dzespw@localhost>
References: <20190520195215.26515-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520195215.26515-1-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 02:52:15PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> This is a rebase of patches that missed 5.2 merge window.  Please
> help to review and merge it.  Thanks.
> 
> 
> Regards,
> Leo
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.3
> 
> for you to fetch changes up to 5d1d046e2868fc876a69231eb2f24f000b521f1c:
> 
>   soc: fsl: qbman_portals: add APIs to retrieve the probing status (2019-05-20 14:28:16 -0500)

Merged, thanks!


-Olof
