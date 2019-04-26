Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37215C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B26220869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6X5R9ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDZU2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:28:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42172 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZU2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:28:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id i186so4053299lji.9;
        Fri, 26 Apr 2019 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vNqpn5xniedwq6bdEG4ZBJ7r5VKfW92JqgJ7I1o6XRc=;
        b=U6X5R9ij96eNOg0GV7rD/iUuCuqNHLKsI98LT4pbF0kl4c6Db3x1fDMjiCrA/MZhNO
         UeHU0vbwue5+NTkYWpiVsORmJomJ+i1j8pBcO3VPDSK5adqbkKXfj9Q0lhWyCJBh8+3V
         q+OiPfWLZvxgdVyXz+1+4fWg5ItXd7lLEgG0TioLCKyRL5X+9YDtY5NxSOtrM/YMwoAB
         U1tcu+Z0qvvU+GvRAlgQUc1qgNiylvM1du+0DjtpuyZcbT+PIbwojTDWaqyZDKvoVlHz
         nWZFn1Yb/PBWscIchQQl1AvV79dIVpP0zm3tFIOY7MulwN2xA9KQqkmcgXvPvo1EBNiS
         nPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vNqpn5xniedwq6bdEG4ZBJ7r5VKfW92JqgJ7I1o6XRc=;
        b=CmCQhSwy/7pscNTwT+XzUNdqDc+QgQGrSKS2oLlAE+W2Vutqa7cIWeJNvrHch990//
         w4abKV9zx6aON/OZRecDlYljgjoiKdRhNkn8QOqx9su6jk8QXcE15IIHhjb5Y1nUCSrQ
         ziDBdGWdFZXgN+dUioxtC/yLdp8PJgv6dTCjj7tIiNIM1u9zpxeT7T8ER4uuDnoy8zFS
         6+cIojwkvVtqo+SYzqegTniTEXXFpR4vns6JAOCc2T15tubygorMXZD1XKDKgFrEZf8M
         DxJ5v4R/qkf/+qan22I+VtSKp5AlCcuJ2kFn+mn0zha1vkUB7aSuvmtRHUVB4xP3p459
         mpLQ==
X-Gm-Message-State: APjAAAW//nmoy7Wm+MtQm2yYpXfUXyUyxz5X3GYagB4O4eboi0bKrZ+k
        diu6vROkDnt+F7oft7wGsf65g8/P6UE=
X-Google-Smtp-Source: APXvYqwrOt3icHtjntruyJLHVbyDFFLQE6FYVvvyw3SKy/+dL6wduxgSXriYsadLlzVUTG/hdiCovg==
X-Received: by 2002:a05:651c:106:: with SMTP id a6mr334374ljb.157.1556310503286;
        Fri, 26 Apr 2019 13:28:23 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id y3sm5750491lfh.12.2019.04.26.13.28.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 13:28:22 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:28:20 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: Add rtl8211e rx/tx delays config
Message-ID: <20190426202819.xtzwxjyp6piyuaqz@mobilestation>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426132821.GB14432@lunn.ch>
 <20190426191935.ihppqlmtpemzp3kr@mobilestation>
 <20190426200521.GH4041@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426200521.GH4041@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:05:21PM +0200, Andrew Lunn wrote:
> > Hello Andrew
> > 
> > Thanks for the comment. I'll alter the code the way you said. The mode will
> > be changed by the config_init-function only if the interface is selected to be
> > rgmii-like (rgmii, rgmii-id, rgmii-txid and rgmii-rxid), otherwise it will
> > be left as is.
> > 
> > But I've got a question regarding this then. What about for instance rtl8211f
> > phy config_init-method? It setups the delay config in any case, no matter
> > whether interface is configured to be of rgmii or another mode. Is it correct
> > to configure rtl8211e and rtl8211f differently? Especially seeing the U-boot
> > driver also perform the rtl8211f phy configuration.
> 
> Hi Sergey
> 
> It is not correct and rtl8211f should be changed. Please add a second
> patch for that.
> 
> We got burnt recently with PHY drivers doing the wrong thing with
> respect to RGMII delays. We have learnt from that experience, but
> there is code in the kernel which still does things wrong.
> 
>       Andrew

Ok. I'll send the updated patchset with rtl8211f_config_init fixed soon.

-Sergey

