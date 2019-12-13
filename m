Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A024C50702
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6F2474E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269445;
	bh=WGJnGZDSAb/3su/Bsns+6Up94xqkhMLCPaovsi6dqc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NI8t40NFE9OPL6RjUe0qz/72eMQzf/nEht8b2avDM/Qfj17ZTgyPESivSf4eKIXSn
	 KqsY1Zlp50JfL4PAMndGV4gsjUOS/6dIVfK/B5kHcbbyL1p4zdysLGmg5U+jmfAAum
	 bCqA1zlZxB8ALziwYNYWnBUkWp6offPwNJIj6tBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLMNoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:44:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36206 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfLMNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:44:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so2709500ljg.3;
        Fri, 13 Dec 2019 05:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOa24Ly2YjrxNhpjna7xkjqt641lU+NlQPN79+2k15M=;
        b=GIOtyMs+fXdNzUinqx6F1zhF3DcNnbHyfjYePLzfInq+SFXIUeWQO5pfXmK2VMRH+q
         wpzHJhT2YMpfnSlNtQwZL0P00DMSTBOfYwrHOhYoLHkwO8s+fSCIpNgTtDg47qaWebWg
         oZm8UIt687cLi54Ykq9IrSy7jmbZ2JTJDUcBNAyAnYF9RAfGDc0YEBwG7nP2B/voGpC0
         q0tNnd5oVA+8AVpVwIH4h+lBrjRjuVErPUJ91YD1scUxInQPbv4G2FnxVRLUz6S4d4bA
         hf+vbl1Ow9XOPLs/BczVU7cSL9iZgItYqVnww+5y2KJiTjdU/pY7vt3hpbpNlW0ppvig
         rLJA==
X-Gm-Message-State: APjAAAWqg66RcPwD7Lp32mzZtgWj7cMIs2jCM/Ql5S4f26CyH4NsKrRH
        eaGpKPnCqjtqdptJafZkND0AhG0L
X-Google-Smtp-Source: APXvYqxOAatHFWmXrETXkJa6JKkULUVMjW4FeeZ4iJ60VlCPUwPobsAtsDeS9dRBWMl/XHivTnFVng==
X-Received: by 2002:a2e:9b58:: with SMTP id o24mr9574161ljj.197.1576244644400;
        Fri, 13 Dec 2019 05:44:04 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id q27sm4900515ljc.65.2019.12.13.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 05:44:03 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iflEi-0000Yj-Mf; Fri, 13 Dec 2019 14:44:04 +0100
Date:   Fri, 13 Dec 2019 14:44:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     guillaume La Roque <glaroque@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Subject: Re: [PATCH v4] bluetooth: hci_bcm: enable IRQ capability from node
Message-ID: <20191213134404.GY10631@localhost>
References: <20191213105521.4290-1-glaroque@baylibre.com>
 <20191213111702.GX10631@localhost>
 <162e5588-a702-6042-6934-dd41b64fa1dc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162e5588-a702-6042-6934-dd41b64fa1dc@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:31:18PM +0100, guillaume La Roque wrote:
> Hi Johan,
> 
> On 12/13/19 12:17 PM, Johan Hovold wrote:
> > On Fri, Dec 13, 2019 at 11:55:21AM +0100, Guillaume La Roque wrote:

> >> @@ -1421,6 +1422,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
> >>  #endif
> >>  	bcmdev->serdev_hu.serdev = serdev;
> >>  	serdev_device_set_drvdata(serdev, bcmdev);
> >> +	bcmdev->irq = of_irq_get(bcmdev->dev->of_node, 0);

> > Shouldn't you be used using of_irq_get_byname()?

> i can use it if you prefer but no other interrupt need to be defined

Maybe not needed then. Was just thinking it may make it more clear that
you now have two ways to specify the "host-wakeup" interrupt (and in
your proposed implementation the interrupts-property happens to take
priority). Perhaps that can be sorted out when you submit the binding
update for review.

Johan
