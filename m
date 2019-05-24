Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225B217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k//C0g7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbfEXPnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:43:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33704 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389206AbfEXPnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:43:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so5284567pgv.0;
        Fri, 24 May 2019 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b667PaiUgQ8Q7PpALzJt/7gtzGVjETB3D6yMZYIALTM=;
        b=k//C0g7exdcOJUzXWpFbNqGCMszp+12V7HlLpivolIypgaoPAXyanHxWMU4qG1gZcw
         j1aKpX5rg9hmij2IMvONUlM7bHhfdSlddZ9/R01ZA/zH/TJ5ijO7uDi0K2YYu7Rp+sAO
         vydLknKzVLK8+FqaHvqN7AmvInf2J6sfzVZNkLzeIAkAksKw1kc1y4VO6zlrDoBE2pVs
         da+DIMZQSrtnYqqjXcd+MybTXwHcrqDWHYikIlBJFmraFEGxoqcBklt7RwffmlQUXlkC
         Zd15JQuglsWt0Bmx0kQy2RRFlZH8ZwL+eEJQr1PoD989P1TC75l4ymQk7jyq81nc/YAS
         jGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b667PaiUgQ8Q7PpALzJt/7gtzGVjETB3D6yMZYIALTM=;
        b=mtqTagC6fE2MvlfdVBfUnwjPFbJNqW9coFtwoHa9ZQeKTG20WvfUSLEPsU0HHK+2gk
         MpONsvGlLgFt0Osx8BP+PhXQHL9RG9huHlCW0q8I/IzHXqoAHSnjDBaqFweiBC+vf/pi
         EbAVieQ8Z4qNOaQ2f/X1y20x/3wu6m4uMQBXcTXKF9jA9BA3lyzjYAfksz0XhnbbunSm
         c7lxIeOadkjOdpCKI9mtqoP0zXHPJcb+2XCgPoWn7yCSH5VclUnZfj71rQemTXUhY9Xv
         lQoKu3D9Fv6iAFsf58yXUijZdt7Gh0meTsFkz5gVzDVjUD0RoOuAwhhgopP8JNIXd2uM
         dAVg==
X-Gm-Message-State: APjAAAWoVeSDiVStdz091e+KRFF8ffkIVW4XynVft4cJUpErWCUj8aIC
        ITdxYvdU880NRCj0axxeIPY=
X-Google-Smtp-Source: APXvYqwhRl211cWfEVTBxkcGOE9w1J3jhmtE5k3PSWuOj9tEW3/mOIt0iLAt0La053XLjoZSI4kECg==
X-Received: by 2002:a62:e0cb:: with SMTP id d72mr20598365pfm.242.1558712597167;
        Fri, 24 May 2019 08:43:17 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e73sm4397753pfh.59.2019.05.24.08.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:43:16 -0700 (PDT)
Date:   Fri, 24 May 2019 23:42:52 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tegra_wm9712: Fix a memory leaking bug in
 tegra_wm9712_driver_probe()
Message-ID: <20190524154252.GA10186@zhanggen-UX430UQ>
References: <20190524005014.GA2289@zhanggen-UX430UQ>
 <b2d43dfe-17e5-a975-435b-49f2aa2ad550@nvidia.com>
 <20190524143309.GA8631@zhanggen-UX430UQ>
 <e52f4140-a119-a584-40a2-6359d6e1784a@nvidia.com>
 <20190524150053.GA9235@zhanggen-UX430UQ>
 <1740686f-a466-430c-9d01-ab83ea6998ac@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740686f-a466-430c-9d01-ab83ea6998ac@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 04:36:54PM +0100, Jon Hunter wrote:
> There could well be cases where you need to explicitly call
> devm_kfree(), but having a quick glance at the example above, I don't
> see why you would call devm_kfree() here and yes looks like that code
> could be simplified significantly. Notice that hisi_sas_debugfs_exit()
> does not free any memory as it is not necessary to explicitly do so.
> 
> Cheers
> Jon
> 
> -- 
> nvpublic
Thanks for your suggestions, Jon! I think I need to e-mail to those
maintainers about this issue.

Thanks
Gen
