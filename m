Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66138C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315D9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0ptLuEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438995AbfIXVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:52:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfIXVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:52:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id t14so1586877pgs.3;
        Tue, 24 Sep 2019 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E1xMc24hYDUgJip/G3+nSaUWwisuKmB+ZHuc94zHHzk=;
        b=d0ptLuEYVEam1DP6UXz3ufvlKv0Rh2f7QGWIYd0pimxpen92m1nCjH63Y3oUmfgXdM
         e9vRofKj6tTXOAtvr+g2/9a4OV7tQDiVwVV3Kh3Sve7pqmIzmgRUghHnaZynH67SHnHW
         rIgf7ruRl3rhqnhyBHw02V8XZZKblWPDyB8D3/iet4MIZpE4iw5EZtcTjUztACEmkZLL
         1qjjugP3Ww2u7zIQkdavyfSi2BMnClZMrdlHfrmnhP4EwsJZcIS9b6CNLzqrxxbn7x7b
         fO0hIcWTRFU/XT3rix7PftJL6Pji5+QETeii4ZwTtvNk/+xxeGBV169AGXUu6Hlki8Xd
         onNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E1xMc24hYDUgJip/G3+nSaUWwisuKmB+ZHuc94zHHzk=;
        b=nZ+hFJF7PBiAnu8O3Ub6k/bUgpr68NjurfcNV1ml/sNdFncFYz4BOFNaBFa7CUF0da
         HvaO8S7g6EbxRcbcevftnj7O6NDCFksFwlyw+V5wazU5Y7NT/YSU4QimKQBK0uPaGhDF
         S7Ik1fEUpx4O/BoJTk28UvMHW/XOixy0jFR+lC/aXu6cq7GthRIAi/59Kt9+R3UIFc7u
         +EMCKNqCrkv4P4Leulf1vfICIyHP3fVroAhakHKAiZtU8rQTP6KMhrKp1rB6Og1VvKXP
         X3gcdyr+kGh3jiCdau4yNqVb7/sL1dm6gWvtna7cDScg7tSFnAxEHS6IyOHLlV6hRXIc
         hX+A==
X-Gm-Message-State: APjAAAVgIuQC9bvgqGCPGeqnXj7v8jSWVMpqMs9/p2Ob9KvrvtJ4sS17
        RK1v1NjrEMrNd863p9v3xEg=
X-Google-Smtp-Source: APXvYqxe9O60bRaCPe/n2UFtUr8or3Vyc6C0TkkVo5BRee9PILbNcSSLNYNYmW98WrHaMtrjV5ZrRw==
X-Received: by 2002:a63:20d:: with SMTP id 13mr5329837pgc.253.1569361943377;
        Tue, 24 Sep 2019 14:52:23 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h2sm6197465pfq.108.2019.09.24.14.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 14:52:23 -0700 (PDT)
Date:   Tue, 24 Sep 2019 14:51:35 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH V4 3/4] ASoC: pcm_dmaengine: Extract
 snd_dmaengine_pcm_refine_runtime_hwparams
Message-ID: <20190924215135.GA2277@Asurada-Nvidia.nvidia.com>
References: <cover.1569296075.git.shengjiu.wang@nxp.com>
 <4d9aab898650c68ea57c10067830dac884eb7439.1569296075.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d9aab898650c68ea57c10067830dac884eb7439.1569296075.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 06:52:34PM +0800, Shengjiu Wang wrote:
> When set the runtime hardware parameters, we may need to query
> the capability of DMA to complete the parameters.
> 
> This patch is to Extract this operation from
> dmaengine_pcm_set_runtime_hwparams function to a separate function
> snd_dmaengine_pcm_refine_runtime_hwparams, that other components
> which need this feature can call this function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Looks good to me.

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
