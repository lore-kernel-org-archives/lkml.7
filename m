Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E98DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E082521850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="OnAD3sQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfC1VGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:06:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37817 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfC1VGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:06:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so232915qtn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 14:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=C/99GerV3GeiTHEZ0KDUbh9xh10S+/GOIQtL20fq40E=;
        b=OnAD3sQBXFDgFGuGjBEVNloLLNSNGLN74N/cv2j1V4BLOA/srNurPuy8sTPBqq1zBp
         1NjDSrqjh3vBn0vAU6ZXx6GeBk/UHRi4VKi/DygagDPad2vnE+DS1CkD51lKXudm5R+L
         MFnS114Fafn7m/fD6tche7Z6sAO3jRw51VnccglVU9/e48434dNRtTWikcXeK/dIw04k
         X+Ctk+Z/a+IiXU0yyi9Juf/wKHL5F3mJPoeU6ecsF+gPii2OQLHZjRW9xX3ooUJukDBh
         3uuhy154b1hwH2hQTsOAxAGM2Vhb0tZ68z/KaEDtI21mkUhlLN9ALigtpqyAwh6lLfJV
         5aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=C/99GerV3GeiTHEZ0KDUbh9xh10S+/GOIQtL20fq40E=;
        b=YyYRrcRUsSWPearIcz02SFwHY5DHFEsEDQ+0lzAvmc+vUKpIwAcKcwtq2vsxdlwY5c
         dpbuVKHt7ZIxEkGfOsYz+n42TZPeIAQM6/9zQ43l+8zDLYQfJlp99UK4ajo1Z8/hSeBX
         4BOIodZWwj8VUJy9eEUw7K1kzDnPBqQfys1GCRMJNORS80oMqYKqz11LYhpZv0I+EUSN
         aKNP7/XbVBncDsL+hC8w/d0BLHR7T6W5yz4uN8bvzmKyd4JpNK8Rg8rKAwhItOXt1L4Z
         FXtNJQkBzL00TDeCQZXDOotWzNOresSMpdfZtc8Yx77R40t5XnKYobr6Gg4gFt9z4qVw
         pc4w==
X-Gm-Message-State: APjAAAXUfFI01n8sGTLOd0FPa4m9I30cA+OLdsfM9/MQlCKooW3I30KK
        vsA+8OZR5hyc1apYJtYcX2j5zw==
X-Google-Smtp-Source: APXvYqxmV6yT58FGv467G+DGoSYHb5PTxFCx1Op/Pj5Y3NDgvkJDTSYZINaFJAxJpS0WQRyYbiHueg==
X-Received: by 2002:aed:3b14:: with SMTP id p20mr38268219qte.240.1553807172449;
        Thu, 28 Mar 2019 14:06:12 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i11sm71499qkg.33.2019.03.28.14.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 14:06:12 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:06:07 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190328140607.285dbfc6@cakuba.netronome.com>
In-Reply-To: <20190328204329.GH26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
        <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
        <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
        <20190328071853.GY26076@unicorn.suse.cz>
        <20190328134313.GO14297@nanopsycho>
        <20190328140428.GG26076@unicorn.suse.cz>
        <20190328173524.GR14297@nanopsycho>
        <20190328115256.2a7cb952@cakuba.netronome.com>
        <20190328204329.GH26076@unicorn.suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 21:43:29 +0100, Michal Kubecek wrote:
> On Thu, Mar 28, 2019 at 11:52:56AM -0700, Jakub Kicinski wrote:
> > On Thu, 28 Mar 2019 18:35:24 +0100, Jiri Pirko wrote:  
> > > Thu, Mar 28, 2019 at 03:04:28PM CET, mkubecek@suse.cz wrote:  
> > > >On Thu, Mar 28, 2019 at 02:43:13PM +0100, Jiri Pirko wrote:    
> > > >> 
> > > >> I don't like this. This should not be bitfield/set. This should be
> > > >> simply nested array of enum values:
> > > >> 
> > > >> enum ethtool_link_mode {
> > > >> 	ETHTOOL_LINK_MODE_10baseT_Half,
> > > >> 	ETHTOOL_LINK_MODE_10baseT_Full,
> > > >> 	ETHTOOL_LINK_MODE_100baseT_Half,
> > > >> 	ETHTOOL_LINK_MODE_100baseT_Full,
> > > >> 	ETHTOOL_LINK_MODE_1000baseT_Full,
> > > >> };    
> > > >
> > > >We already have such enum. The problem with your "no string" approach is
> > > >that it requires all userspace applications to (1) keep this enum in    
> > > 
> > > That is how it is usually done. UAPI defines ATTRS and values, userspace
> > > assigns appropriate strings.  
> > 
> > +1 FWIW, I'm with Jiri on the string situation.  
> 
> And I'm still waiting for any of you to tell me how would you handle
> private flags, stats, tests etc. without the string sets.
> 
> Ditching the verbose form of bit sets would be a nuisance for userspace
> using the interface but compared to e.g. having to mix three different
> kernel interfaces, it's just a minor problem. Ditching the static string
> sets would mean giving up the opportunity to get rid of having to sync
> all kinds of tables with every userspace consumer whenever a new flag is
> introduced. Pity... but still doable. But how do you want to do without
> the string sets which are provided by drivers?

I don't think there is a disagreement about stuff which is private to
the driver.  The strings have to be exposed there.
