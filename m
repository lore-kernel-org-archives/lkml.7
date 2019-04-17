Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B4DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510E52183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1KYIOL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733038AbfDQVKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:10:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39004 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDQVKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:10:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so43538pfo.6;
        Wed, 17 Apr 2019 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tn+37+XDAd+/JBY7zfs8apH2ixBIPVzCz+3j8mVbjhw=;
        b=s1KYIOL2gqie+9wCjvjUMEwNdgoG19Lekg1qhwvc9NA5o/NsI1AI+IjX1yYjAjNBTC
         Z4BzKeqtOVVzr7rfwnfUJAH57Bt39t4gw2cjMEPHffuY4wSlWeNrpCG7WNtvThIQhtYa
         f7BcWfSH43ZufZHZnDqK0Nl+J4uF6OYdrdOsVwRXYeF9LcneOLtgiV+5Yoha4eZj6vv8
         YEqiagJZxHSRaqjm5s27o81689z8uQ0NcKMNNjPvAKZgyQefUqTZmFIsIMalP+kP91x9
         foGUWOFl8BX27yAsptVNDHORZy8B4xvUJZYiP+maks8VMXzzbIj8WeQB9ZzKPvKYESOA
         6FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tn+37+XDAd+/JBY7zfs8apH2ixBIPVzCz+3j8mVbjhw=;
        b=M/xKjAkbrEwBxmwraS7ungajTvwKCOr8DccYbUkFY3RCQEyGBPAEinzeQkKWVCOQcl
         HD82ZAI0eZFrEglQPXNztTamzdXgqAJinW2a0yvpvhetAdZ6QSS10b3TaETF8cM5me/F
         TIz1VzcwPDCVU0JWtKAGEWLIZaAPJRxGcMrjuh+fjeSXqI0sNYzmkn+gWeMtWEBZ++tK
         Z1Rx5PcTOVrb8KkVaIwe5m7pKkx3OpPFRvC6RO+x/bVFMOWQNuWweTC6tv4WcJi7mTOn
         32GtSs+5hS1EdNsiM4J3ULcv8RjOmfH0i22x0zbFNR72cxTEC8GOFyixHR2gG2Ktc6t+
         zshw==
X-Gm-Message-State: APjAAAUMGWzceEZkLfSWg/8HZoNnkhkcEPLIm5ZNcYCCgb/GrjUJwwlA
        xbu+CM/Gj9usnEOPFjLmkiuZOfMcQPc=
X-Google-Smtp-Source: APXvYqx0UHZFlzaNDC5nPiMns51PY3X3adBvT+lymhcZzc7iUX+rh+KaqWS69uwm6W5O5D57jVXCiw==
X-Received: by 2002:a63:d250:: with SMTP id t16mr83195813pgi.288.1555535431423;
        Wed, 17 Apr 2019 14:10:31 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j19sm107828pfr.155.2019.04.17.14.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 14:10:31 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:10:26 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Add voltage conversion time settings
Message-ID: <20190417211026.GA9565@Asurada-Nvidia.nvidia.com>
References: <20190416235548.22733-1-nicoleotsuka@gmail.com>
 <1ad27385-e62a-d4f0-2590-c50458119f12@roeck-us.net>
 <2a193494-a33e-dac0-456a-241d7b3e59ad@roeck-us.net>
 <20190417183949.GB5073@Asurada-Nvidia.nvidia.com>
 <20190417194817.GA22652@Asurada-Nvidia.nvidia.com>
 <20190417201234.GA6223@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417201234.GA6223@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:12:34PM -0700, Guenter Roeck wrote:
> On Wed, Apr 17, 2019 at 12:48:18PM -0700, Nicolin Chen wrote:
> > On Wed, Apr 17, 2019 at 11:39:49AM -0700, Nicolin Chen wrote:
> > 
> > > > Thinking about it ... does it even make sense to cache reg_config twice,
> > > > or would it be better to just update the local copy and use regmap_write()
> > > > to send it to the chip ?
> > > 
> > > I remember the reason of adding the read-back was to prevent race
> > > condition. But now we have mutex protections for all sysfs nodes,
> > > maybe it's not necessary anymore. I will read the code carefully
> > > and see if it's safe to remove it -- will do in a separate patch.
> > 
> > I just recalled a second thought for the reason why I left them
> > there as it'd logically require a copy to restore upon failure
> > of regmap_write, that might not look so neat as the read-back:
> > 
> > 	old_config = reg_config;
> > 	reg_config &= mask;
> > 	reg_config |= val;
> > 	ret = regmap_write(reg_config);
> > 	if (ret) {
> > 		reg_config = old_config;
> > 		return ret;
> > 	}
> 
> 	reg = (reg_config & mask) | val;
> 	ret = regmap_write(reg);
> 	if (ret) 
> 		return ret;
> 	reg_config = reg;
> 
> doesn't look that bad to me, and is much less costly.

Okay. Will submit a change. Thanks
