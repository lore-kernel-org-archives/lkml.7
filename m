Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62353C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B79217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565420593;
	bh=j3o2I6/nAgp98LE0CK60cAiv7Ns+ZvZsp9cgjjg7OUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i2Mx7dpSkiIZjFR2UToqyjY45SeMn1ki5eOpkPFiSDa2nEdTUvpMRWljIVOLOKEXd
	 J8Gv+h3uETFiWNiKzfNvRzzcqcPa1IYSHKW9qr3iMNsvDEZFMW85hnAJiuapb2Xu5s
	 UUMYWfVq8iGcvB3qHBYOhV+AiQfbAuXBqnt2dVJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfHJHDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfHJHDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:03:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0872208C3;
        Sat, 10 Aug 2019 07:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565420591;
        bh=j3o2I6/nAgp98LE0CK60cAiv7Ns+ZvZsp9cgjjg7OUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmFGNzTTTXJ3aZjvnBjLK8baXIiRf1t9rlTbYhp/0bdNPj3bBfU1+UeCyqEKaNbmH
         uZry4cY/QxywKrsZVi8KJEhqytd3i71giBVfyc7Ru6locgKUzRTNsJHYgxYLSXeqdr
         nGnloxOG/DFHateAN2a7zO4dyJOEMwwAvEb6BvCM=
Date:   Sat, 10 Aug 2019 09:03:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/3] soundwire: cadence_master: add debugfs register dump
Message-ID: <20190810070308.GB6896@kroah.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809224341.15726-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:43:40PM -0500, Pierre-Louis Bossart wrote:
> +/**
> + * sdw_cdns_debugfs_init() - Cadence debugfs init
> + * @cdns: Cadence instance
> + * @root: debugfs root
> + */
> +void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
> +{
> +	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> +}
> +EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);

You create this function but never actually call it.  Don't add apis
that no one uses :(

thanks,

greg k-h
