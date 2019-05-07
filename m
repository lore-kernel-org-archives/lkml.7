Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A69C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4466E21019
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WudCQKf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEGXMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:12:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32886 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:12:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so9440946pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tWjHfDmr6zfr6uEFNgoTwl3QSdpsHDKdbL7emu6+I7o=;
        b=WudCQKf19/mQ7OgzsTY0vSgIImKPxFoM+sLFaezbTXhZSZsHqHy/pa6pV7OSMAj4dS
         z3ly6js80G0ExrYvBa72ezekQM9t8P1HTXKJdAQNCk/7pNEJ2PA7nnmAlCYPpCNRffWe
         XQgdvbtSATNbm1b0KOFkF1oGs1Casxn/XmLj3tHNnUkq5BmnpWiiT4iu7b/rJg7EnKaE
         hzXDpYYsvIMN6SajuJDlOT9wYLQzI5SpQt3lKsHfWwvLcMZkk0+J7WN4+YAV1rGD0lZz
         UuYEMtjmWp/wj9DYwiG6MoX52ZbZ5niZ3Jlhn/bUqUUMiz1JL2fmIRweGvJMdG2mUMgG
         oDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tWjHfDmr6zfr6uEFNgoTwl3QSdpsHDKdbL7emu6+I7o=;
        b=IIA04g62CVu3S3zYFtgphDklKBYJ9PYcdLzgKfuhDSwdkD8xXYMLFdKJD1v0SqvWQD
         6SzLCXcu06YHjMwajssgU9DdDbL85QacRGbF06slw0cPPbopXZKKXGZ55DPtwSYvoMeu
         WD2vIBReMZYMabRrsr1Vc8FT+z0FheFsbhOdlPtHnBOCDZ31weLbgPUqoDq1Mk8XTugN
         JRnCLlcnmks3X4QqxY7uxVV0zpOXPhu9eZvLZb9NTf/ZbZ2qzNGT92cR6cHPVKr6N/ic
         HJroumCSoCF8BT1tUQyZq5mzocL28L+S8ELYgWnIcSZZQGyl2M0T8x6mAhDIrWJ8pDvo
         XQwA==
X-Gm-Message-State: APjAAAUhbBEkHvFTZwn8sXiJrR4iNT6N+i/Fbp+ThDkh7JGdmhbYESMN
        896o00YwDgDAuipqU21+ppg=
X-Google-Smtp-Source: APXvYqyV4BvuDtnxbZwvhHc6+bHTU8WcX0OlbIakNQEfaZpg7WJRgZytOsIoQ08/5s95SNQG3ij7CA==
X-Received: by 2002:a63:7d0a:: with SMTP id y10mr42516704pgc.292.1557270760058;
        Tue, 07 May 2019 16:12:40 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a9sm728073pgw.72.2019.05.07.16.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 16:12:39 -0700 (PDT)
Date:   Tue, 7 May 2019 16:11:09 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3] ASoC: fsl_sai: Move clock operation to PM
 runtime
Message-ID: <20190507231108.GA22188@Asurada-Nvidia.nvidia.com>
References: <20190507140632.15996-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507140632.15996-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 02:06:52PM +0000, Daniel Baluta wrote:
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
> Reviewed-by: Viorel Suman <viorel.suman@nxp.com>
  
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
