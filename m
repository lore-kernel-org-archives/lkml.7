Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC31C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEF82075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1+8h9SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfDVBUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 21:20:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32905 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfDVBUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 21:20:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so5099684pgh.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 18:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4T9osTIaYcEG3Jpu+4MnJ8Kx526Y6fIP1TYF6wab5o=;
        b=E1+8h9SIN6TOR8HthrY4iVTKnGaRoSKmf917JfgPybxyIqlcABLTgmCYyH8rPcI8b5
         BRnN9YnRoaLSNENo1qleqNfAT0tsVGf+2CDuhGXz1ByWvk6Fx1sZWpGeTfJW+diNbTDb
         jXNs8wXKXRTes24cvXjnLaGRHi1fNMMslgRqQg6lEGDl+ySpWaBy6ujfSo9/2iOHIPyb
         uOEjDx+S7Cbeu/2fwlj4qddf5dAf6YnWjzrLgB3PaR7alUuEZtRbLTLItnW4pGs0buOH
         W9XC1cyOWNUvDiE4MI7h6LQyiohcOm2IsrVW3OL+2Um1lZaM54HPsCnPmB6CV1NAgfJ5
         gRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4T9osTIaYcEG3Jpu+4MnJ8Kx526Y6fIP1TYF6wab5o=;
        b=bJdhdRe1gDcuWYgYxTNtZ4jLTxcNJv/NpLKzGOHKyAT//+W9wZueYJsHg9tNKBRVnS
         VKWQPKbIJHS/f3k5mcpoAND+guuZwZMDxZY160GfPT1kyo/TcIjMdThHB3NnuH6XqAF6
         zNJxGDaTriDeYxUgv+0PsxU7M4WGuBHGCO9A2NiGX4F02KDCrmabk/pEP/dIfoqgSGOQ
         cTXtIx1wHUwqhTxFDxuAiaXuPqeI2NoGjsvvEyF/psofZnFq00kZvKAFU1oefgkGxlYO
         YpjkF4vxCqF95NITWLHoQadNgoatqXszLQlBngK/uhR4s1aZJ627X34KMic85/eHqNBI
         saQg==
X-Gm-Message-State: APjAAAWiXfXmYd+YV87zZp/eMLPFtVLotTFEGWOVLgIcXlfL9lXzlgYp
        wp7SQYWiX+GcPb80SulWgiYvLHue
X-Google-Smtp-Source: APXvYqxNTUGam6v9UkbLLk79znfD79PeYEHi8gq7z71DBmfiF74Y3imut97y2oSm8Nv6lZ5X3dCjOQ==
X-Received: by 2002:aa7:8c13:: with SMTP id c19mr17273412pfd.225.1555896022323;
        Sun, 21 Apr 2019 18:20:22 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id d11sm12672773pgq.6.2019.04.21.18.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 18:20:22 -0700 (PDT)
Date:   Sun, 21 Apr 2019 18:20:17 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation to PM runtime
Message-ID: <20190422012017.GC8364@Asurada>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-4-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-4-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 07:39:10PM +0000, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Turn off/on clocks when device enters suspend/resume. This
> can help saving power.
> 
> As a further optimization, we turn off/on mclk only when SAI
> is in master mode because otherwise mclk is externally provided.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
