Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA23C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C658021881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4T6Gque"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfICFby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:31:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36735 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfICFbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:31:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so16609296wmh.1;
        Mon, 02 Sep 2019 22:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sdTc5Col9gW6RO/wUIFLd9Ir0j2e9yKZwNZmVQ90wII=;
        b=R4T6GqueH4Qho03y99R1OJ7lpN3EOzwGjqO/Hxlf6NWmhobqQLXz+aM5ybWMA8M3eM
         MqTf5odZCddxCDu1/xag4JzYqF9qv3MU8Lho/1PNMONq5/6Jz3/3/i866qPMBGTNcuNi
         0rmClZhaHdp+b+fhVo6AvHoSN+6ZoP3W2IrWeWZmFuMyPohn1SS9tVn9pZzRHVz/kwGy
         MBOOGRfkl1N2xbCWnkg9I5Gy4flUaM6OXhbCo7ytsZHY4cgqWI42h+mtvw27O8tUWuC2
         djwv1S6aq5WORUYcBE1Ce0spF2k69eg0yHyJ6gDYMOc4/VhL4lj7BrFwh1YHfKo5Mhyy
         eZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sdTc5Col9gW6RO/wUIFLd9Ir0j2e9yKZwNZmVQ90wII=;
        b=hBHlV6ehrh3KQDA418g70kEOgg1E6v5tfk/EXlYOSUGywXlQqCrEM9W3McaFx8gMTm
         Hll98JSh7YK4e4SEeG2V1eMjiGJ94p5IgeGpUE/CNGVehm/jPch2j4Gv6rZsUGKhdh2q
         auodHOesP7CIUiakCjkVhRFjmEYRBvlSgbTORAdGMFw0Kzo0SChMW6s8hfDkTPkhW3PI
         ZDIjvVld7I72k2zFSZH+V4s+FLR3SsxvNDbNT2HsVsWYeIQvBoPTezB03bozzg6ke2MQ
         4NSqnN1sMfVS4cVpbcgUA1QEfmsx1U7PJborolQhrBMk+vqeQ8G4n/XYsoKT5da44Q6K
         JauQ==
X-Gm-Message-State: APjAAAURmXVxHQqP11jrTU3UUGNxoP+kzdR30nWeLD01+NsDStHwrxzw
        cDj1C9yIuvmsV1wwRYgEUCVxrdU869E=
X-Google-Smtp-Source: APXvYqzU0OzUqhyCh6F+DEeckS/Al/RvOuCOKRjN0LgPq6DjX3hdGdbPVeuCGGT5w3R+/B3EKct7hQ==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr32071273wme.15.1567488711366;
        Mon, 02 Sep 2019 22:31:51 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id n14sm57733246wra.75.2019.09.02.22.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 22:31:50 -0700 (PDT)
Date:   Mon, 2 Sep 2019 22:31:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: fix uninitialized variable ret
Message-ID: <20190903053149.GA56440@archlinux-threadripper>
References: <20190830184644.15590-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830184644.15590-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 07:46:44PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there are error return paths in ffsReadFile that
> exit via lable err_out that return and uninitialized error
> return in variable ret. Fix this by initializing ret to zero.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: c48c9f7ff32b ("staging: exfat: add exfat filesystem code to staging")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Clang also warns about this:

drivers/staging/exfat/exfat_super.c:885:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (p_fs->dev_ejected)
            ^~~~~~~~~~~~~~~~~
drivers/staging/exfat/exfat_super.c:892:9: note: uninitialized use occurs here
        return ret;
               ^~~
drivers/staging/exfat/exfat_super.c:885:2: note: remove the 'if' if its condition is always true
        if (p_fs->dev_ejected)
        ^~~~~~~~~~~~~~~~~~~~~~
drivers/staging/exfat/exfat_super.c:776:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 warning generated.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
