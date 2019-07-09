Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72073C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC9D216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562639022;
	bh=kz0ZlNhWZX5V7DK20EcB1vr6D7djw4a6UWhgR43WZwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CTpRhgjSlM1cSrCCc/IwHPe4ZsNihdMiQkzfyIkx+xusuU2yRboj3QFwOfAFpOMmM
	 +zL+Q2xYKeA+LED7TBRY/irsC3B21yHQgWhjVDOZ4ET92aGBqR2Xkg4XZ20axWsE44
	 2th2w2lVVGtudsPLo/QZbGMrqWBv00keg3jwsQhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGICXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:23:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39142 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:23:41 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so24331778ioh.6;
        Mon, 08 Jul 2019 19:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PoedJpBWRO2SDC+J/XcxusJFnLqT85yHLsoGZKfc6L8=;
        b=tc5zc6cqsa1InMasM3evpeHDreFwOitCZWSnHmzXwNEhd7sYu/rtrtmwmIXpjsMjVj
         l9X9hIN4AXrFhKU7S80XlLDh1k+08UgurvTh2Qt7gaHTr1QEqz3sjRhfVP6tN6gittSf
         iVF5LZ1Bs+Vtdn2SDArzNXxWKI+5e18Yx7SGP5zXjQOnzeTkX8X8lOONkn7tSpB3nNgg
         1E2FmA3rCnbaqPbLRbZToqZ7zyO3g5XcgAlWqknGHQuJzX7Rw2+bqfToE0jO4vB3IDa6
         /Og4nqxX2QOHC7Tb2sqWD28xhxDrUd/rxqY9DRw6WkAzE6OUcpDR9L3zESebYReMi1KY
         ngTQ==
X-Gm-Message-State: APjAAAUFoU490rp6B6+SgQcaKYjfv+aAj95rfqvjLRK7vOYLd97p3q3L
        OvCZxmMzSVhS7fIFEi9mhg==
X-Google-Smtp-Source: APXvYqyWgOpK053eSMXESfVY3jWDfI12f6hFUMu7Bb0OoWfzUvE17mnBknUJh1cLsZy5JuUL78ptxw==
X-Received: by 2002:a5d:9acf:: with SMTP id x15mr2667477ion.190.1562639019973;
        Mon, 08 Jul 2019 19:23:39 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j14sm16873761ioa.78.2019.07.08.19.23.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:23:39 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:23:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] of: unittest: simplify getting the adapter of a
 client
Message-ID: <20190709022338.GA18910@bogus>
References: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
 <20190610095157.11814-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610095157.11814-4-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 11:51:56 +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Reported-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/of/unittest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
