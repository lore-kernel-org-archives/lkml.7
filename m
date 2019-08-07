Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE855C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D89A205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFTUI9Ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfHGBjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:39:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36268 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfHGBjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:39:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so42507325pfl.3;
        Tue, 06 Aug 2019 18:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Edh1s2+Hz0JvWJr5X8N4ASrf1QiKcSFMMDMTTyV4qrI=;
        b=WFTUI9Rik4s7rXx4cO7m45CIyjoVkafBvHO/YsjRKbDPMoSfV8ZUbL2i1/BYT0xSn8
         QloGiMApvuVHF8wOpxJvalYyEkEars2YRjoTUD3Dwzodi6U6OV5gE6M51IqNFtMMZycv
         hWVffE1TBXS+N/RGa+hPiM+70KEeZVFzsQKFvY0eLaLGV9Up7sB9XTpilX2XRgER7Hja
         JTZidlrZ61rIylwhcDewSR+6bkR1N+PCf/Lond9BAQdzKVNgHy8CEhP43R+hrqTAm9o6
         dkVYQ11a5mwrvTbmB9FUoq21dY7Ou95siHu7afyBFs8yc+LG/BoOfkXadDR/sTkACn4x
         iDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Edh1s2+Hz0JvWJr5X8N4ASrf1QiKcSFMMDMTTyV4qrI=;
        b=S/LT02ZPlWB541U1USlil+mvWMWWEEhSGAxmBRngH1Lti8pj4ZAGClHdedrQiblK2F
         OvPPGe20zsm1CSdVRFhGzjnc6utiMGRsD0hjZtwjiONC/lZvRNuJKz7Kn1x/ldP97ALH
         XDR99x9uNH++/bDzKgIvKwt2AH5SuRTvQKTXPMlE4MAwKPLGjzj8vYHIzcXhxOuzatjO
         2Sj8pbDB1tftF4SW6g8H573Lf5sfmwZwBoLwxVNtb3zcFqgR28twGBnwqYG6Lgia4t4g
         ACLcp4kj066i61Fs3MRIM1aZWOO4kkBzb3aJF40NMpOByOHbHja2e3GH0nOfUK+LC4cf
         aI7A==
X-Gm-Message-State: APjAAAX+EbWUkM1zQOp5qDDr9bcjBRxb4RWfZcVydDjL4UKc5PESZsKI
        rpwrzMxyb2WtCxmQr0wFzC8=
X-Google-Smtp-Source: APXvYqz0y6FnZKy0wvbDLBt46tymafR+AbNRcHSbRCLBxC27KsBM3Wa8A16eke7Tm8rYHNLD9NfUKA==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr5719740pgv.315.1565141980407;
        Tue, 06 Aug 2019 18:39:40 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w4sm110141105pfn.144.2019.08.06.18.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 18:39:40 -0700 (PDT)
Date:   Tue, 6 Aug 2019 18:40:35 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, timur@kernel.org,
        shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Mihai Serban <mihai.serban@nxp.com>
Subject: Re: [PATCH v3 3/5] ASoC: fsl_sai: Add support for SAI new version
Message-ID: <20190807014035.GF8938@Asurada-Nvidia.nvidia.com>
References: <20190806151214.6783-1-daniel.baluta@nxp.com>
 <20190806151214.6783-4-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806151214.6783-4-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:12:12PM +0300, Daniel Baluta wrote:
> New IP version introduces Version ID and Parameter registers
> and optionally added Timestamp feature.
> 
> VERID and PARAM registers are placed at the top of registers
> address space and some registers are shifted according to
> the following table:
> 
> Tx/Rx data registers and Tx/Rx FIFO registers keep their
> addresses, all other registers are shifted by 8.
> 
> SAI Memory map is described in chapter 13.10.4.1.1 I2S Memory map
> of the Reference Manual [1].
> 
> In order to make as less changes as possible we attach an offset
> to each register offset to each changed register definition. The
> offset is read from each board private data.
> 
> [1]https://cache.nxp.com/secured/assets/documents/en/reference-manual/IMX8MDQLQRM.pdf?__gda__=1563728701_38bea7f0f726472cc675cb141b91bec7&fileExt=.pdf
> 
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> [initial coding in the NXP internal tree]
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> [bugfixing and cleanups]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [adapted to linux-next]

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

One small request that we can do with a separate patch later:

>  struct fsl_sai_soc_data {
>  	bool use_imx_pcm;
>  	unsigned int fifo_depth;
> +	unsigned int reg_offset;
>  };

I think we need a list of comments for the structure defines.
It might be okay for the old two entries but reg_offset isn't
that explicit any more.
