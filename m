Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74BBC4360D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F6222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmhqPRhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391466AbfIZBty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:49:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33113 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388759AbfIZBty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:49:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so768212pfl.0;
        Wed, 25 Sep 2019 18:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uI3653QvRfDun5vRH9qyIawnNKEumCLQmRxicnF+xIE=;
        b=BmhqPRhlQgpby6NkH48NMswsV+CwXScc+2OJ4w/Kc48zNgHHAfS2FqHNPwzS+O0xB6
         6ocLda3/dxNOPh9j3Rv4CSYsH+9gMHSJKJblwGho55ICTrYxOb6AdPD8tdBI3DtrleLI
         i7Fcl/1yXHmmVQeNqf39ZNrySFVSen2JoClH6PQhbsFZWrxgPm9Gj4TxA+Vp7L7RnLTd
         Ogwiv5cMP6Lvy6MjRCbnuVAQkAw9iHmCnOiLSbdgQ/ybBe85RQkDQ63NhNgHiQ621/Zc
         DsHnR7LUv8gvc57oGKi1HAnqVnRM1qfPt0kZJFNzgXDQw+rWN+BfxVItLiGg/ED/h0c+
         tx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uI3653QvRfDun5vRH9qyIawnNKEumCLQmRxicnF+xIE=;
        b=TOTuX6qAFBGiAjFi18M6MSRwPW2BDZpvmAJn6k+oRUWpTclbJxXRz3Uec9wI33nAx3
         5wQq051aaOj54lgGqqu7AL3KN0AH/X/8DmyOGuB42FoCWE+0em0pDDBZS3Zzni+diXOg
         PCMC4bQpL7Qa3WmtuY1qm8vex88MwtoolmbNx/UYD1f7e13nqKaTbBdK+/qNqR37fprJ
         aenbcAeoA3ZvlqQrYYiFbg3aYiTw9DHc+2JWCKoQkYkMG1uhhRwPOuFJrCarxC2NnRsk
         QDMd+Ugtx97GUUsscfuyGYOnBZZKMUx7P9N9H87c/iTNnA57yvk3oAN6Y/uREPEuCgxj
         0O4g==
X-Gm-Message-State: APjAAAUX+CJBZH+YGZf3iPyi2q/Sh7xg7V5NbN4Iq6s80UBxNgMZBVYH
        cEIykvAT2AGaRuB4Yti9OQ8=
X-Google-Smtp-Source: APXvYqxBJIYCpZx86R9ytnHhKp607PqA7avrf7WrBtzA3FCSAUzgHNDVzVxOo3YZNahIPTbhg92bhg==
X-Received: by 2002:a17:90a:1b46:: with SMTP id q64mr817457pjq.76.1569462593023;
        Wed, 25 Sep 2019 18:49:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d14sm324463pfh.36.2019.09.25.18.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 18:49:52 -0700 (PDT)
Date:   Wed, 25 Sep 2019 18:49:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH V5 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Message-ID: <20190926014905.GA24545@Asurada-Nvidia.nvidia.com>
References: <cover.1569387932.git.shengjiu.wang@nxp.com>
 <7c05d8396fd8c4f9d41c13a85e7486f3664bc73f.1569387932.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c05d8396fd8c4f9d41c13a85e7486f3664bc73f.1569387932.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small concern...

On Thu, Sep 26, 2019 at 09:29:51AM +0800, Shengjiu Wang wrote:
>  static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
>  {
> +
> +	release_pair = false;
> +	ret = snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);

This set_runtime_hwparams() always returns 0 for now, but if
one day it changes and it fails here, kfree() will be still
ignored although the startup() gets error-out.

We could avoid this if we continue to ignore the return value
like the current code. Or we may check ret at kfree() also?

> +
> +out:
> +	dma_release_channel(tmp_chan);
> +
> +dma_chan_err:
> +	fsl_asrc_release_pair(pair);
> +
> +req_pair_err:
> +	if (release_pair)
> +		kfree(pair);
> +
> +	return ret;
>  }
