Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51E5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D75E20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554193718;
	bh=QXXS1GfV0+LdyRUzkEmsfjLPTvpM+Fpq6p68B0mg7uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XuKA9dCIxnUWwy/G9hKw7/xG05vdJb2e3v4gHsqBLSIn69U1qCaSg9Lh4rG4YAmgC
	 RD68McBuiRDPCO/2J5pHbJEWesOL6U1Aw2RuoeJ9rmXmeMDxrcvBs0sPYycWYQbone
	 kGSv9dfep2pRAcqqCJukgLudBm/TCV5watsJkBIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfDBI2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:28:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34510 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:28:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id y18so8325452lfe.1;
        Tue, 02 Apr 2019 01:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKzKBFbchjb8OGIFXp+AHnHvwxSuiIpkjh+AvDdeZx4=;
        b=HYfxl+/mVN9jLFvL5sBMYmOFGGoKnfl236kkrKp9+ZccFzklKbEGNCAQZYQBJXy9zG
         dM2lsb4mTnmV5DbwFNJTJizEJp0Znvcov8JekwG1aDJn5kL/B5qJnwED0Kq384qYosvp
         gYqenxylGWeliPfr8Lj8uEtQd9OcWupPiEYkD7GiNP9dVne7bO1/35L8qCP1EwqCn8Vw
         nvY3HLZjvxNhxX15dMIn514AgfIJNzqxqMGOAs1yb/jBKNzJOrNixL4q5jUP7RDCjxq3
         GUU8Yew8kikozb8Vpf2F3wUigTPtDQ62pUlX9Q+dDqgCUUzrULPkJ87Odsoyx8ijH8kP
         ntdQ==
X-Gm-Message-State: APjAAAXE0arjB5HIkB121uOerttPxr+2eqw5pNgRZbPdbbJ/saoLscXO
        0c3+26q4uwl7YQORWXESDlUpdKH3
X-Google-Smtp-Source: APXvYqy0Vi+kzjcOZt2XAfGBGR5k0zc65QeAcfuCYmU6ZYhcte3yEfWvf2bolhkC9o1tYsUiaYMBSw==
X-Received: by 2002:a19:c203:: with SMTP id l3mr8398770lfc.39.1554193714727;
        Tue, 02 Apr 2019 01:28:34 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t28sm2986798lje.9.2019.04.02.01.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 01:28:33 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hBEmq-0000QK-Vz; Tue, 02 Apr 2019 10:28:53 +0200
Date:   Tue, 2 Apr 2019 10:28:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     megous@megous.com
Cc:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/5] Add bluetooth, gps and accelerometer to TBS A711
Message-ID: <20190402082852.GL12562@localhost>
References: <20190401115616.21337-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401115616.21337-1-megous@megous.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 01:56:11PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> This series enables some peripherals on TBS A711 tablet that already
> have mainline drivers:
> 
> - GPS u-blox neo-6m (via gnss u-blox driver)
> - Bluetooth (via recently added OF support in the Broadcom
>   bluetooth driver)
> - Accelermomter BMA-250 (hooked to the I2C bus)
> 
> It also modifies A83T DTSI and adds missing UART interfaces.
> 
> I've added additional compatible to the gnss/u-blox driver for NEO-6M,
> because this board uses this module, and I don't think I can use
> the existing compatible for u-blox,neo-m8, even as a fallback.
> 
> Please take a look, and apply the patches if you have no objections.
> 
> Many of the patches will go through the sunxi tree, but I'm not
> sure who will want to take the GPS patches.

I'll take the GPS patches through my tree once I've had a chance to
review them. Perhaps easiest to resend the corresponding dts change once
that is done.

Johan
