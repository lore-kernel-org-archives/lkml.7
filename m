Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F70C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4AC21530
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="cacfGXld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfFRNsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:48:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38931 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfFRNsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:48:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so9344595lfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iJmKAKxXNY/eDxKA8zSNselgrq1E+cvwinlMdmVZAj0=;
        b=cacfGXldfdERA2D7/w1ynW2VQsTn1b7qk3uj0WDFrM0xboK5HuBE6GGyV+UDRf8kby
         isgNXremPdDITxn9XQ/vhZh9Qv43SxXMctARDoJqV+BLdixewV8O+zlRT3BSODYIZ6DE
         nd86ZP5rZkLGJ2m9+2yJZJ0SeZpVE61F9L1k1NTHBbeIrCnyg9Y4z9TxD3ZWoAzY0Q4o
         uwRB2fzVH7UoX7H8L8iiEJPEtnDJk8VfvwHd9Nz1FXFYGb76d4kEUOQ7hzuz3FAlOk2d
         y35hrhm6+qp063fseqIsJmWv1CEwQz0+XFX0WlSYV7eu2meM0FBw1PzTiHUUfNJRkHr+
         zVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iJmKAKxXNY/eDxKA8zSNselgrq1E+cvwinlMdmVZAj0=;
        b=p3eUHjpwSHeXNJLdGMloQFteriI9rBtaDDhXeD5U6YHldtEm07WeqXakICZtbtGDmi
         5Kz9jgDhNSaZXe/v5UZRWFNi3TT0o5ys4RYh2HlEtwjkDQmbvEzx17A5aFc3ZsYlTEty
         dM15ITquRU7ifMfNnpzUM10NcTxYyejCCMn0NFhT6i6XpAaXqWDPf8IMDSV/qSUPBrVs
         STfMCOR/wReLysdn0rS7S2Lh2gWNBPCNiN3E2cxtdZ8MWDBemTppc2zlJJ78TZf159uw
         BW48vSQc4mlSQFUZr+IlemX8GVJlGNWAvTDYOZ11/I1EDH7XkrkNDMu/pGqgjetkojk8
         IWPQ==
X-Gm-Message-State: APjAAAWkDcQM146GJDHgRmXS2B13Qt8M7YX0MAlzojC/PnMuAqbeSCAW
        WAQRxaB7N6HKNTFFZGfnSuBKMA==
X-Google-Smtp-Source: APXvYqy5gTlGzzNc80V9pWkczYKQWK9Gi90EqAnxJCcIf/zlrnAT5z4Bdsksw3HQh5Y4IX5L/DHOZA==
X-Received: by 2002:ac2:495e:: with SMTP id o30mr59137674lfi.140.1560865701929;
        Tue, 18 Jun 2019 06:48:21 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id t21sm2211126lfl.17.2019.06.18.06.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 06:48:20 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:48:11 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     arm@kernel.org, Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: ixp4xx: npe: Fix an IS_ERR() vs NULL check in probe
Message-ID: <20190618134811.bfs5lxazaw66ubb7@localhost>
References: <CACRpkdaX66=g7dG7SFkgr5Dwmop-p4qe7ELkn0KERtqVvp0vNA@mail.gmail.com>
 <20190618115410.GE18776@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618115410.GE18776@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 02:54:10PM +0300, Dan Carpenter wrote:
> The devm_ioremap_resource() function doesn't return NULL, it returns
> error pointers.
> 
> Fixes: 0b458d7b10f8 ("soc: ixp4xx: npe: Pass addresses as resources")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks!


-Olof

