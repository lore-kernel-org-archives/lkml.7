Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46731C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DDC20840
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXYgnB8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfILXyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:54:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42033 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfILXyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:54:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so1395143pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=epB8CH0IOuw5TsX1fUGnwbGIVGe9v0LlpjCzGxP60TQ=;
        b=pXYgnB8v9vuvLFdz1UIqGnHVmsaO3b0KOiGh94bEt4QtpedVNNzipx+iIyYTwI9Obp
         XO2uCQ95ITV+w4RvV4PyxkNHy+kpiezsIVRJv8PAJogfMw2vTb9xDyWb7D3JhTT3iT0B
         jvM76OsIptNMydQYZA9B5ztqtWw1qSuDVXvMIbL6N0t1jesIi2xmx2Yha5x/RhMVF3KB
         BgW/7PYc2HrGuo52dVHBTSxe80oMM70A8aPVWGjpJDye5OCJLyXU+7hak0kxTsR47VwG
         KCbqs5X+Aq8SymUGWQCh/dFK4DIJ4Lz0VTuEDEPWhLWLNLekup1nd+lkC13UMqbwrmqA
         +NRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epB8CH0IOuw5TsX1fUGnwbGIVGe9v0LlpjCzGxP60TQ=;
        b=ulLEF+hZvIELrHV72tgnpHfeBjMiuqZ73PszpyDvsKEIlTn2zTTw9/doLM+/7DYLUw
         /7Ww0GIBusOzaBnlBw51V4yazByXX4XEa/v4IHyWS4pndOY2kZdLqfilVFd3R4Jjl9Oa
         RSSKfg5TxcXjpIiIuaMtdDrPbKtVpvGB7YA3hm3vumaLoEfmo7OVzZGPQqaQKqy5d7ku
         TdqkFqndnyF+fw0mSLKVtWAEo7YQQZ2IvaqUtlFqFhTzq0RYq2Hd33OisIKKmV/k/lf2
         6Pv/FNYDt13QrIPTtjUoYtGXwUuM3NrUxwev1KV+GHfoOdsPAx+BBBkdeqZmZ6Y8uvuM
         4X0w==
X-Gm-Message-State: APjAAAWYDXNAltOSh3DQ4BflxHcVO8pU0batdK74AGhc3xzADhstNKnY
        KcQum1HBipajYzIKEjuvk1E=
X-Google-Smtp-Source: APXvYqwzde8vJPDro3KBWaFAJc6Uo/3ggP569vDzVpDisDugeNgt80nBA+MCUnil+1LZlDzNpLDpvA==
X-Received: by 2002:a17:902:9d90:: with SMTP id c16mr34653633plq.12.1568332450067;
        Thu, 12 Sep 2019 16:54:10 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a20sm24584085pfo.33.2019.09.12.16.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 16:54:09 -0700 (PDT)
Date:   Thu, 12 Sep 2019 16:53:48 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Message-ID: <20190912235348.GE24937@Asurada-Nvidia.nvidia.com>
References: <cover.1568025083.git.shengjiu.wang@nxp.com>
 <2b6e028ca27b8569da4ab7868d7b90ff8c3225d0.1568025083.git.shengjiu.wang@nxp.com>
 <20190910015212.GA16760@Asurada-Nvidia.nvidia.com>
 <20190911110807.GB2036@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911110807.GB2036@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:08:07PM +0100, Mark Brown wrote:
> On Mon, Sep 09, 2019 at 06:52:13PM -0700, Nicolin Chen wrote:
> 
> > And a quick feeling is that below code is mostly identical to what
> > is in the soc-generic-dmaengine-pcm.c file. So I'm wondering if we
> > could abstract a helper function somewhere in the ASoC core: Mark?
> 
> That's roughly what sound/core/pcm_dmaengine.c is doing -
> possibly we should move more stuff into there.

It looks like a right place to me. Thank you!
