Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCA7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhRPPknW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbfDRJFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:05:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43314 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfDRJFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:05:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so888963pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mw07+ygDicv9TP/v0i5onh329mIidrytyEynXCO/hFo=;
        b=qhRPPknWeBW9G71Oe3gNvtJddZ65QlL8lnumFGTmHHg1WBSZM/drMc/yxvL5oAYWyC
         QTNAXxEVDimHvqsNaVkcZ5Te8Duqq32yCJIVSBwZSpQZ7QEI3YyKXK3FOigtrvqV5sYf
         ssA3ZvjcdOXSKEevXrGsjuJKaBWgsIbg6AkgDlNLeaI6vmwg3Xe5ivDUXeT9x/Pdwz7L
         mVCZyZhaJ/9HwFja6eKxJlvK6fX0o2x3r+4ibZdKVRguj01uvcTr/FToX1aVxoIvxx0O
         mWnMbFw0dABYojHQ/os0DxoSxO8cj/NhQ5BZgU39FvyQBM/EcT56I3FdgisyJinOBP/k
         IwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mw07+ygDicv9TP/v0i5onh329mIidrytyEynXCO/hFo=;
        b=bVW4lPK0QePBt1/9hQIdYJQRQJ8MEvpkPvIqEwPYV0IjcJyco/jn3kfj//xUCXuNm5
         JwjhnGxwAIjBkxay9S2ib43Ao6mehUs5CWugY3iDNofr/vOcVsvS57DC1aZZ8MduGmUo
         uRNL222CMTMPnIn8RSd713WeHINEabmi08Z90PavGMDnbs0oEnj42DORrfFMDRoQ827F
         ZmuZkWwRTBRJvuD8UhAm7kptuDZNbBYJpa0lGj0NRk+jRlQHoOWQq0ja358a1HCgQqhp
         x6DeBWIYHrc+UeIhQYKo5BxTAOkGxuL2LrKPl/Ln6dG7JuUqcvFoGeT0MAFPmN+WFrRr
         Rqvg==
X-Gm-Message-State: APjAAAV9pVBKFclMxX/TCN+Tdd0Pynst0nkCoHjwSKJk1zpCS1PYV8nZ
        3l/jYwbY+7+DIratud6xdA5GxxQk
X-Google-Smtp-Source: APXvYqzjJ2S/f0g+n091XtubI+Cj5X0L/JXkSvovNUDzGVVzCVcJf9G4slAIv7RyoT+/yzql8uNeDA==
X-Received: by 2002:a63:4c:: with SMTP id 73mr49571539pga.210.1555578340723;
        Thu, 18 Apr 2019 02:05:40 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id q75sm2109865pfi.102.2019.04.18.02.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 02:05:40 -0700 (PDT)
Date:   Thu, 18 Apr 2019 02:05:35 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190418090534.GB4028@Asurada>
References: <VE1PR04MB647965FEAF3506E1775397AEE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB647965FEAF3506E1775397AEE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 08:50:48AM +0000, S.j. Wang wrote:
> > And this is according to IMX6DQRM:
> >     Limited support for the case when output sampling rates is
> >     between 8kHz and 30kHz. The limitation is the supported ratio
> >     (Fsin/Fsout) range as between 1/24 to 8
> > 
> > This should cover your 8.125 condition already, even if having an outrate
> > range between [8KHz, 30KHz] check, since an outrate above 30KHz will not
> > have an inrate bigger than 8.125 times of it, given the maximum input rate
> > is 192KHz.
> > 
> > So I think that we can just drop that 8.125 condition from your change and
> > there's no need to error out any more.
> > 
> No, if outrate=8kHz,  inrate > 88.2kHz, these cases are not supported. 
> This is not covered by
> 
>         if ((outrate > 8000 && outrate < 30000) &&
>             (outrate/inrate > 24 || inrate/outrate > 8)) {

Good catch. The range should be [8KHz, 30KHz] vs. (8KHz, 32KHz)
in the code. Then I think the fix should be at both lines:

-         if ((outrate > 8000 && outrate < 30000) &&
-             (outrate/inrate > 24 || inrate/outrate > 8)) {
+         if ((outrate >= 8000 && outrate =< 30000) &&
+             (outrate > 24 * inrate || inrate > 8 * outrate)) {

Overall, I think we should fix this instead of adding an extra
one, since it is very likely saying the same thing.
