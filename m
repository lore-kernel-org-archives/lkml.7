Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE594C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B93120651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uplvGO2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfDQUMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:12:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43389 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:12:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so12593283pfd.10;
        Wed, 17 Apr 2019 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MzUMqQcBMnSNRUdBAvs212fcMrCTPBwD6uuZdMJuSIA=;
        b=uplvGO2sskszwut77LnGWgqVrsJ/RHCTdWCVqa7cLxTThQWQn4ijN49yBNXrutykCF
         nJI9pLvvWyFMqYus/lWPEsYrueLMt8KTom3VUQi2p7aKvF+IaslpDYZqNlYJkqwC5k00
         JHpawghOP4BHP9Dwn1XZctJCg/EiRQUaNNB2J/l17T0DA+F4wzORW1UQ7zr1Va5p6RsB
         TTFGxAFvPV/f6qZYiwEF+r+gCUxZc5kKlGhdfLsqYNPHz7WxtZbdnB3SA0QPufOcXpqC
         E4/kvXYjH2nArcFbfZTWVLfINgLDue+jis02OtPfZx0C5PiABNFdxoTxctAOEEusiX+U
         IkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MzUMqQcBMnSNRUdBAvs212fcMrCTPBwD6uuZdMJuSIA=;
        b=VCnSbfg/BdZ50CG5fG4zHZey/Tk152r94qLu2NezeWC1UV3U3l54yEAjX1r8i7QUcY
         fDf1c6kMUSmw7MTxXxAfIvLcHHRLxIKJDVhBooXr/aPsNxcS/Y3ZZPbom8ab33JhkGJ/
         2FXGkcvxsFpN2/N5/8B+ggccS2tRoDoABHrrKOuOATFQntN926ruuFqhFzOnrUh/ZRIL
         cUCAoDLpJXqeGvNidvMaKy2FUPNufOpdDx64bRlWzfUsRf+DnvkvWbWYQeD+lY3DjF5i
         hoJ0TJFBhHh4wlSiHZlVnbzuA6AXN3qGX69xvB3QPXI+tCiPuXCAv4GwG3/ubamQiVcJ
         yVMg==
X-Gm-Message-State: APjAAAUVcZGlr1tT4/qE6XhckJ3IdiPO6/ebywM/WegysqCnuqOSgqN4
        S9LLKJFX5ZYgUVIHdDj6G+M=
X-Google-Smtp-Source: APXvYqz5KgvlnXzN0ECBsM6/szbinsGUjwyl6ZJFNzN1Z5H5uBVEHFRu2UEgA3PaDM/GXJJX3rWJhA==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr92659770pfh.187.1555531969937;
        Wed, 17 Apr 2019 13:12:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w3sm6553pfn.179.2019.04.17.13.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:12:36 -0700 (PDT)
Date:   Wed, 17 Apr 2019 13:12:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Add voltage conversion time settings
Message-ID: <20190417201234.GA6223@roeck-us.net>
References: <20190416235548.22733-1-nicoleotsuka@gmail.com>
 <1ad27385-e62a-d4f0-2590-c50458119f12@roeck-us.net>
 <2a193494-a33e-dac0-456a-241d7b3e59ad@roeck-us.net>
 <20190417183949.GB5073@Asurada-Nvidia.nvidia.com>
 <20190417194817.GA22652@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417194817.GA22652@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:48:18PM -0700, Nicolin Chen wrote:
> On Wed, Apr 17, 2019 at 11:39:49AM -0700, Nicolin Chen wrote:
> 
> > > Thinking about it ... does it even make sense to cache reg_config twice,
> > > or would it be better to just update the local copy and use regmap_write()
> > > to send it to the chip ?
> > 
> > I remember the reason of adding the read-back was to prevent race
> > condition. But now we have mutex protections for all sysfs nodes,
> > maybe it's not necessary anymore. I will read the code carefully
> > and see if it's safe to remove it -- will do in a separate patch.
> 
> I just recalled a second thought for the reason why I left them
> there as it'd logically require a copy to restore upon failure
> of regmap_write, that might not look so neat as the read-back:
> 
> 	old_config = reg_config;
> 	reg_config &= mask;
> 	reg_config |= val;
> 	ret = regmap_write(reg_config);
> 	if (ret) {
> 		reg_config = old_config;
> 		return ret;
> 	}

	reg = (reg_config & mask) | val;
	ret = regmap_write(reg);
	if (ret) 
		return ret;
	reg_config = reg;

doesn't look that bad to me, and is much less costly.

Guenter
