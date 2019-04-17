Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D83E21841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555501175;
	bh=MImM7Jk8Vf2oFW1DCr04PPI+PYHLDueFCNiIijArP0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SQFfDWx8dap0VHDWlDVA5LVn2L04pL3yer/dSoGtJ4ir0CKdymtGj/KJg95iT+pG+
	 ObmvIv0+p3x7ZeIzSuEY3tEDAcGr6AQuZZoDsR8qElOxEAEFTENSOqRUa7egH7Hj8O
	 dgV+ma+7BG3E/GOP4TKaiXfP8qPqwJcnPFmBn3QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfDQLjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:39:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40264 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:39:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id a28so18630991lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 04:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iaQ9dMyM/mdqTRSrB7M+KSMNaVGOb28EtpPR3MYUHks=;
        b=gkkKoiBGSWKA8qYIpb5+KkasisXTEu5wnh7exbYX6E7z7fGltlhNFE+i4XvCZGBSgg
         twOZpwUw6KYTrmEtu1Yeo8wFJkbnm9RqHkMInYzYbZiOeVVYM/ZI42+a7gWenTpTlSl7
         +zCT26jWp5SnpCjA0QY1oTpbjOUZVgb68vUFbwW/LnooE+IMMROx9zBkE5q2Gsmi7DDV
         I8MaOkdoMt4cP8Gfi57XgorjA7mRAqNJVxsMHmBYnf/wxK2HvHGm/6WLa+w2+TWIcJDs
         jxY7JiSwnhcBdT8aJUwVURpTpqnKv5IvTZ5b8NNq5Modi01x6Ut4sd1+Mo+4493VnNQP
         B1CQ==
X-Gm-Message-State: APjAAAXU51yQVW6xzOfsdpuZ2AVHWPjVy7AZ9lwOb+aBpWXWBM4szP7e
        CvyJEcyPTUfIafK3SA07TZ8=
X-Google-Smtp-Source: APXvYqxBu4zzsKOLveb1vee2lbvAwqIonD5pwyXswc4QOVAZYSE55M0M+3DY1aAD6WY8Li5cH8xLqA==
X-Received: by 2002:a19:c51a:: with SMTP id w26mr45298465lfe.59.1555501171462;
        Wed, 17 Apr 2019 04:39:31 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f18sm10782549lja.91.2019.04.17.04.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 04:39:30 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hGiue-00040A-Fu; Wed, 17 Apr 2019 13:39:37 +0200
Date:   Wed, 17 Apr 2019 13:39:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH v2] Staging: greybus: Cleanup in greybus
 driver
Message-ID: <20190417113936.GB2520@localhost>
References: <20190416221318.21161-1-madhumithabiw@gmail.com>
 <20190417062518.GA23076@kroah.com>
 <a6bb72ed-5f98-86fd-33a3-8d68942eeae2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6bb72ed-5f98-86fd-33a3-8d68942eeae2@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 06:19:50AM -0500, Alex Elder wrote:

> I'm not completely sure about the inline function, but on the no blank
> lines thing (and many other minor issues) "checkpatch.pl" is to blame.
> There are lots of examples of issues that checkpatch points out that are
> matters of opinion and not hardened kernel style rules.
> 
> We try to encourage people to get involved with kernel development by
> fixing minor problems, and we tell them a good way to find them is
> by running checkpatch and "fixing" what it reports.  Unfortunately,
> it is often things of this type, and reviewers balk and say "no,
> please leave it," and the poor new person has a bad first experience.
> 
> I *like* "checkpatch.pl".  And the fact that it can point out some
> of these sorts of things is great.  But it would be nice if certain
> types of problems (like multiple blank lines, or lines that are 81
> characters wide for example) would only be reported when a "--strict"
> option or something were supplied.

The problem is that --strict is enabled by default when running
checkpatch on code in staging (and net).

And it has all sorts of weird tests (prefixed as "CHECK" rather than
"WARNING") to catch everyone and their mom's pet peeve.

I don't think the intention ever was that all those should be "fixed",
but this appears to be where this checkpatch mission creep comes from
(and we're now seeing --strict being used on code outside of staging
too).

IMO we're setting a bad example for new contributers by accepting such
changes by default. Blindly trusting a tool is not how kernel
development works, but that seems to be the message currently sent.

Johan
