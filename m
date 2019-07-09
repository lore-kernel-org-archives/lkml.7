Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616FAC73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FE820693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562710153;
	bh=IJ+mrYGNF2oF+gZH1kmsPqloOPB7XfhUWutql//fZ5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sS8eZyn5pSpNtYyiwcr0haFWZViH+i8kD1VREOHaRzN+8507P33efeaXvJtV3VRTc
	 bRXZy9m3U5QP/JPhywPCpaFje72++F4Zi+atjtXj6sZECnqrtb5bKE8yfb82ptep8O
	 KfpgDxhhpWSXL0bG0UxUzGJOF/G//17GrjjR1Vbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGIWJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:09:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41950 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:09:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so272279qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GYzOMbWpyE1lpwp1gCViZuHJwd8p/Nxm1g5Qq1Zdkcw=;
        b=KV/SGOHdvmhgCqJWFoOzRwBc6ErsjMfqtHDV+pTiII7F+O3dn3Fy7nHifFR2fURgds
         nAg4WD/HU1faHzclkZ0+AKGFSQCrj/viPhtjUVc7V16cIBFAEA6o5PmX1ALqcOoFqL8+
         O4dHVaP5kW4p2qP/S7mWOsgkY4/xRReTjvpGQOBcFF81S73FAu/jPXPRmsPtrkU+9kLi
         +ceHzw96mQ3yvw5QDJXnNH0E4GOOaA3eGt1ZmaOfID3EWRuVl3IyWllRZu4HMMfU5Tk4
         Zj4XnThw/5oqQ/mmJmkHjqEzXztN1zkl9Ou3EE72R9MipmBWe6Ck42mQa3F91aVcOuaV
         1gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYzOMbWpyE1lpwp1gCViZuHJwd8p/Nxm1g5Qq1Zdkcw=;
        b=SZMnCWht06uoQtkWsAumF6Bb7Sd1uWDeY5WHS0SsU2sVgUIjklkRq6iS8wtMH0Vbsv
         lMzkW5P9yWHFcJ6zUhHKkWV0RRrkr/Yqz41gxn+6muJEXE/hbR6U7TC9Lh7soah969bi
         c3rL/X3olV5j8YSIYGUeoQUkP3kokCcSQNTt5rZBPnTKv+0MQt02OXEwlHt5VzrtkjqH
         z1gYuJHNtHj5ITP7ZC8c74GHy1VFxHAe5WQrP56cy2vgWhM14FkFUUS7zd/PrrnqvWLM
         8fb2O2Z9F5VFs7A+7nmkLn15mbwFO0ni0tLFgaVecQWlStHleEHn6OIkVckWncpbcAKo
         Z5cw==
X-Gm-Message-State: APjAAAUKtMlaRbdQ9D2MJuHLn8q7i3T55eM75bLY9jazTlE9oGSUfyG/
        uTBWxxAuwFGn52tx9nf882k=
X-Google-Smtp-Source: APXvYqz2sBsIZwfeXtkQccwfxxUfpSUIBIICzSK/Pv9S94ogQhIf0ai5BtTeVlHd/1H6wcHChp4qwA==
X-Received: by 2002:a0c:d066:: with SMTP id d35mr21305945qvh.221.1562710150579;
        Tue, 09 Jul 2019 15:09:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id z12sm161251qkf.20.2019.07.09.15.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 15:09:09 -0700 (PDT)
Date:   Tue, 9 Jul 2019 15:09:08 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190709220908.GL657710@devbig004.ftw2.facebook.com>
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709214602.GD19430@minyard.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Corey.

On Tue, Jul 09, 2019 at 04:46:02PM -0500, Corey Minyard wrote:
> I'm also a little confused because the CPU in question shouldn't
> be doing anything else if the schedule() immediately returns here,
> so it's not wasting CPU that could be used on another process.  Or
> is it lock contention that is causing an issue on other CPUs?

Yeah, pretty pronounced too and it also keeps the CPU busy which makes
the load balancer deprioritize that CPU.  Busy looping is never free.

> IMHO, this whole thing is stupid; if you design hardware with
> stupid interfaces (byte at a time, no interrupts) you should
> expect to get bad performance.  But I can't control what the
> hardware vendors do.  This whole thing is a carefully tuned
> compromise.

I'm really not sure "carefully tuned" is applicable on indefinite busy
looping.

> So I can't really take this as-is.

We can go for shorter timeouts for sure but I don't think this sort of
busy looping is acceptable.  Is your position that this must be a busy
loop?

Thanks.

-- 
tejun
