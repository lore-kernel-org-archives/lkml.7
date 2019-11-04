Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31144CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B1D21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572879748;
	bh=wx2WWE77VYovaRQjP+PFzhxfSOCW4+HTy+AxYVfCLd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CEyiMf3bAQp17z+7V4fTUgyU4Fxf7jWi59LT5DOKjTvxVvoXxIGq56Z860sykydRR
	 H3C1ej6UWgfig7vFBZFw74Qtim8EBQiWpHCerhcOG/2gdo4DRhzEZh08wvpb4I/5ea
	 mr0PIb+zmxN1EJIUKxiyMDQ2iVsyHs3gNBVDfn5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfKDPC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:02:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38082 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDPC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:02:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id v186so14348639oie.5;
        Mon, 04 Nov 2019 07:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5RrqU3JQJ7EH0ayzHoxuh4DISnrwTOJKl1dsTebWduQ=;
        b=lKTFrIcy/1HTFrstz3zAoFi2+g7leOOu6+i7khOprRn9dttMp9/O5FH0mq2YxGwdCE
         gQqvZx3R1Obzz3pnnTyR/u30Np32EDzgHptQGTPujtuBf95nHqvBHPiDiJEL2M8L+1t9
         4KS/h7YLlCWaG0osOfJLJo9igAcjzU/H4vPSTdme19w81MDm0Kj1jKAuzSoAM29sVJFY
         KBieLFKSlP+1sGpf1Z1lJEzMaf1pZ6/aeqEaMJQ24pv/2Anzlj1BonykAWt4CXJDKpG2
         3Kb/Fkk0vzeztSWKNzmrG52UHnBh0h9ixQBpB0y1epcjEKSUlNeS1ZZH4mIzQBQJ9ADO
         XMXQ==
X-Gm-Message-State: APjAAAUyqaZ/90PNFOyPEhZOvrpZjXzAmBjMsJPk1dS+86c95uqrmmIS
        5hNQ0/LtATc229CDye5Oi06Xxiw=
X-Google-Smtp-Source: APXvYqzQtWMe2X/SUN0+hS7AhBAmFxrRHdL30Cn0tqCXW3EudOyHKvVB9BcuhrYl0hpVj9L123E7nw==
X-Received: by 2002:a05:6808:18b:: with SMTP id w11mr4493466oic.25.1572879744445;
        Mon, 04 Nov 2019 07:02:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 34sm5058938otf.55.2019.11.04.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 07:02:23 -0800 (PST)
Date:   Mon, 4 Nov 2019 09:02:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scripts/dtc: dtx_diff - add color output support
Message-ID: <20191104150222.GA17784@bogus>
References: <20191025092215.23887-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025092215.23887-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:22:15AM +0200, Geert Uytterhoeven wrote:
> Add new -c/--color options, to enhance the diff output with color, and
> improve the user's experience.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> Tested-by: Frank Rowand <frank.rowand@sony.com>
> ---
> v3:
>   - Add Reviewed-by, Tested-by,
> 
> v2:
>   - Document that -c/--color requires a diff command with color support,
>   - Ignore -c/--color if diff command lacks color support.
> ---
>  scripts/dtc/dtx_diff | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thanks.

Rob
