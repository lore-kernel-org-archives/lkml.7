Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F923C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6964B20733
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574725682;
	bh=Qp7AOjegG3/6YWgxEi5Y1jDIBMFXeO5JTKgz9dR7sXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1h4AcsNQ2rxqYCKcDxyLct7stU7qvo1ZVx8ZTqlS9W5c+ai5IaxJNO0nRGa7NOeKb
	 j+Kp9vwjLEM+WaP7YYO+8zALwGNlssDKxWZyG4QY+OySH3b2llQL8M0muYmCaoKlTP
	 UY1rg0F5jzgAgdQHdyt8RAoSE1PZ406YPn2m2E3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKYXsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 18:48:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44976 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYXsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 18:48:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id e6so7985272pgi.11;
        Mon, 25 Nov 2019 15:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MeAqiLlUYvhPf8+12Rs2pe/QyDqA+63WVCf/WAXWie8=;
        b=XMQzyV+w7TmNh8J3FgbhcKJ8m2CmfcMwIe7JFqEZu1A+bSmfjHOWRBS5DkA3DkBlha
         gghh1jdqxli1scg6u1xNLDetltrSGm/ASf9QFRlRkd4gNTd7z443maq2BG8UYpzvjZu+
         NU77T7XGna1cHHzwaWNAstAznxWf9DXF5mphg68H3P3hDhjNAB1XOsUG65yfosdhvXxQ
         jWSChr3ZV6fdQDhopN1aTVz/rHprSNvqxjazGdoRIPIoGPX/kdSC76uQUtCOpSs+zsZW
         anPfuDoFvO4wuNYh1AbLOwFrmwJl9tty3SFNhElJSXk2CKrNK6B9DGVJ9qk7+ULK2YeR
         6Yyw==
X-Gm-Message-State: APjAAAUCSjYAmX4ulKCe+nB4UENzVu8EbGjixHXhSeZ1CGI3JCevrgRv
        /xSbt2ISnB01MG4Or4nu0+iUd62QCfrtuQ==
X-Google-Smtp-Source: APXvYqw4aM4Jq+ybWzZzqVckCs08yRDy6UeWVlGe99hhU4DiLGx9UZmxcz7pXYZDQBu2MilgcW+waw==
X-Received: by 2002:a63:6b82:: with SMTP id g124mr35552425pgc.178.1574725679797;
        Mon, 25 Nov 2019 15:47:59 -0800 (PST)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id r4sm471926pji.11.2019.11.25.15.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 15:47:59 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:48:42 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.4
Message-ID: <20191125234842.k53nspuqzbgx4zlq@lantea.localdomain>
References: <20191125094110.14667-1-geert@linux-m68k.org>
 <CAMuHMdX-N2AHHpBVJCqkh1RoMxFXhGikGn4mj9E7sj0qkR4ukg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdX-N2AHHpBVJCqkh1RoMxFXhGikGn4mj9E7sj0qkR4ukg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Nov 25, 2019 at 10:50:09AM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 25, 2019 at 10:44 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v5.4[1] to v5.4-rc8[3], the summaries are:
> >   - build errors: +3/-0
> 
>   + /kisskb/src/drivers/staging/octeon/ethernet-spi.c: error:
> 'OCTEON_IRQ_RML' undeclared (first use in this function):  => 224:12,
> 198:19
>   + /kisskb/src/drivers/staging/octeon/ethernet-spi.c: error:
> 'OCTEON_IRQ_RML' undeclared (first use in this function); did you mean
> 'OCTEON_IS_MODEL'?:  => 198:19, 224:12
>   + /kisskb/src/drivers/staging/octeon/ethernet-tx.c: error:
> 'OCTEON_IRQ_TIMER1' undeclared (first use in this function):  =>
> 716:11, 705:18
> 
> mips-gcc8/mips-allmodconfig
> 
> All seen before, but hidden in v5.4-rcX (X > 5) by other build failures.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/219d54332a09e8d8741c1e1982f5eae56099de85/
> (232 out of 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/af42d3466bdc8f39806b26f593604fdc54140bcb/
> (232 out of 242 configs)

As mentioned before[1], the fix for this[2] is already in staging-next
but sadly it didn't seem to make it for v5.4...

Thanks,
    Paul

[1] https://lore.kernel.org/lkml/20191014170440.mvwgnj4stpeuzzey@gmail.com/
[2] https://lore.kernel.org/driverdev-devel/20191007231741.2012860-1-paul.burton@mips.com/
