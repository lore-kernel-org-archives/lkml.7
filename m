Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44B2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A132D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5Ekj3g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbfDQTOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:14:14 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39623 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfDQTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:14:14 -0400
Received: by mail-pf1-f174.google.com with SMTP id i17so12539417pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1c/bh1hlYVfEn4mKBRVU1xOPhJniefdwWFTlRx2729o=;
        b=M5Ekj3g6xU5onSICGt0zQ0oa9dv7xRpU3VjENPfcTbDOxbStSxVLhEiK553/NAow6G
         ID395JJvodH6Wpq4bIhyzsy7xBxbJkn0Lniqp/WY2XRwVGHKs4aVPCcHT57Y7qutCydy
         g0kzKaJDxgDsbpVAf4RPGYgtdmE1CbasYOK1yaLOi3KaISLXzEmqKkdXmI8uZIam78LP
         B2VczDgV/kkHFsrhGyChHO1aShQ0VxVUZvQjlkCuwfcnBB6veeNbL/5ZJn6+ryPAy7+4
         gKBsIZC3C6+u3+NaRFiEKVc1Voj8O31UWKoBpZEjKpoLFRMXZglr+4F0YMm6hrFcpxai
         tIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1c/bh1hlYVfEn4mKBRVU1xOPhJniefdwWFTlRx2729o=;
        b=F3s3eyMiBUzyms6dAGvVPVkfKCscO8a6urILg1EyTiC2tBEcwj6Av1h+h8ryu9HOgy
         J64aS0mDzjTDBY+WbG1ZugeVPHUb2hZhWaiX3z/y/2i0BcAmJdXSQewODusGoCV7o+nK
         mR/QyS5w1VCvBT8XzpPoCfLETbmlxKI47eUcxRLUJ8gmFdG67htk/RmLSpVfZitrLhdB
         D6/vHqgBHriLLSp3/dw9C1Z/gtUiU6c+P6/d/RdQhZrGprsokxahre//N0F7Jsf7eWfB
         HOtzScDIBU1Ky5HSwFGfbkf5DClhf9V2esjblRLgpBwpZJfoeLN2qdN3BufDQwPm+sRL
         6T4g==
X-Gm-Message-State: APjAAAXtBY3fGyEPz0Hy3pSruMJF3sxIE/s6Z5L3zX5SiLWkHgTC2IpB
        7T7LQo3IAJ6zU+9od63zsxQ=
X-Google-Smtp-Source: APXvYqyI5RNsi8PMQe96X08s3l275RB7mFk8KZHzrARaarX1ahlM8C5V0A+7ajALDJ1dY5k1wyxR/Q==
X-Received: by 2002:a62:565c:: with SMTP id k89mr90211140pfb.175.1555528452883;
        Wed, 17 Apr 2019 12:14:12 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z7sm53843108pgh.81.2019.04.17.12.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 12:14:12 -0700 (PDT)
Date:   Wed, 17 Apr 2019 12:14:07 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     gabrielcsmo@gmail.com
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used variable
 'osr'
Message-ID: <20190417191406.GA14405@Asurada-Nvidia.nvidia.com>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
 <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
 <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
 <3228ff50862b0bad95561bd5276cbfcad5d6213c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3228ff50862b0bad95561bd5276cbfcad5d6213c.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:58:37PM +0300, gabrielcsmo@gmail.com wrote:

> Nicolin, I am pretty sure I've ran the get_maintainer.pl script but
> I will pay more attention next time... sorry if I forgot to add you.

It's okay for that one as I trust Mark's review anyway. Just
adding us would offload some of his burden, especially for a
device specific change.

Thanks
