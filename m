Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A9CC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B8A20659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CbXK4cnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF0QN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:13:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40004 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0QN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:13:58 -0400
Received: by mail-io1-f66.google.com with SMTP id n5so5978313ioc.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YuETa3oDVUrfM1AlnG0XabGhzbNGHx9EIaL7BfD2Dwk=;
        b=CbXK4cnlfsLqgcWbk9J1O19cC7jqM5R1GyFC5RXTsmRqwoUEV2NJ9LPi2EmzXe+1vG
         qCoPj1cMOEmcGu7KLw8WXb3lc/xVqslxMXana0Sg4KkAdtyQUoLcgGJ7QdndwmAR188i
         8DcpkgAbLey+JqExVPrENeLIes2OsFyyBDyedRY3g3n6pmy8gKn7GuNEHTTBhGBZBNh9
         bPMLkc/2qSQ8GfEfUbzTK7euEZicmfeApx6Ym7qA9lay+DlWcKVsFYcKuE5E8I6BLdiG
         M+chfQoe+Vq9l2wmRUZRlBOEZeQhj9ljVpVNOQyC15iPt4MJWD1zPw60BZIChkPn2p5Q
         hSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YuETa3oDVUrfM1AlnG0XabGhzbNGHx9EIaL7BfD2Dwk=;
        b=FHqE+d+licZK84amZfWmlhelY8XbPrzEUxPS+U+i0xwY0HwZnu12UlAX3Yb9bjI6q6
         HtwVfbfyLdpGVtq2Ef7re+wtaesvxpTrjM7ymTLozfuQpMr5ch0xhHpgXeboYuG6Z62z
         nzyvzqLgglJMP1FeKwdmU8Oinv65QpTXFREOektyXpK38JZT6wnwtHHsFW3wB5usb9Cb
         TNw2/Z+uX2auDBJpvSzOZQhBAVZLXL1yy4FF+SpoX0NXaHx88B0YcO9hbyRPshwjUI2b
         BlBzPnbQfl6xtenKlRT0NsvOQ6WlzAASziTi/sMsIgjU6TzBK8PCiJb/zOqq8IF7jtWH
         r/Iw==
X-Gm-Message-State: APjAAAW4rZ1Yt1ufg1jF8iu2tEtGb/W5K3fQcldUamGbJXBN6VnwnuF3
        iB6A+eBrUR/tJDnH1XVveV8Jwq0NPFo=
X-Google-Smtp-Source: APXvYqzBXnSDmyScYxc36jaGMDBkMY9zvxNr9TAKEWXWOEcTbptqw9f6F4ZC/j0rxrwTCJUPKOYG0w==
X-Received: by 2002:a05:6638:3d6:: with SMTP id r22mr5561768jaq.71.1561652037218;
        Thu, 27 Jun 2019 09:13:57 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id p3sm2749248iog.70.2019.06.27.09.13.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 09:13:56 -0700 (PDT)
Date:   Thu, 27 Jun 2019 09:13:55 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@sifive.com, aou@eecs.berkeley.edu, sachin.ghadi@sifive.com
Subject: Re: [PATCH] riscv: ccache: Remove unused variable
In-Reply-To: <1561624486-22867-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1906270911270.12689@viisi.sifive.com>
References: <1561624486-22867-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Yash Shah wrote:

> Reading the count register clears the interrupt signal. Currently, the
> count registers are read into 'regval' variable but the variable is
> never used. Therefore remove it.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

This is a good start.  Could you also add comments in the code that 
describe what those reads are doing, as you did in the patch description?  
Otherwise they look pretty mysterious.


- Paul
