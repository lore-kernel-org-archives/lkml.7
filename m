Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15ECB2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc0l0Thp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCTJbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:31:36 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37752 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfCTJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:31:36 -0400
Received: by mail-oi1-f181.google.com with SMTP id v84so1257948oif.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYyv2ZRwsPoVYMyEVcGnCp48q/ptTtHxZyIeAzw8TOY=;
        b=tc0l0ThpVqoLtsaB2H8fQq1clVPc94UjnPBYF2ByG9flAjBIPjypcsro+IYe1PEGCa
         CQkscJRiqJORBddBsZK7WxneeF8IyStb95Z3Y/87wjluzqADh87MW+MGvu/0FP9XXlrY
         ePzaLgPzxLf+rThI8d3hIUcf3KEQ08yBvEXV3j4PwXiwy/6RrHS8psTj4ogWkw0m7Y0u
         nxUPpcc16p+Ifl7KACsD3KUfxZZY/KJOzIAhsKtcYaS9dcgMoZXqyZ0TmJe3QVCXksHt
         sHzeoeZKnR+2k/mG3JdAnRLNKU69HjMANpkCIgvJqpKEBjG81IYmlmUMEARQX2MpSs3i
         bB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYyv2ZRwsPoVYMyEVcGnCp48q/ptTtHxZyIeAzw8TOY=;
        b=MlWgo3Nuq6m5odSIxis+P3KDJTsRnTDmmUZ0NzDhgO9ldbCvNP4T2yyxX/Gl1SRnpM
         3O5l4tzG2MP7uwiif7YJ9YRpNMjlSg7DQnXM28EM96gu97rs/kM86JtIsUPcEdz5t9ec
         2fqTR8bmjogYc1+bU//3yuugg9v0LTENhvOQPuROR2hcaXOEbxRevb+QLGAZvzBXf3j1
         KemcO66oRf9WU+mOhBkAS+8cO2h6vvZzOXkQ0H25eW7rzObukpFKOM0rZ/S51MjH1tpE
         Zzmkhl4PHz2dMKZrNv56xjQgc5f+Wgs0QR5lUxMMLJn/MPcYMVAe8Ub+6B2fwIxsATlL
         rfEw==
X-Gm-Message-State: APjAAAUUrt1rvkEjvJOa6OxL1jgx1YAQf6vsTUohg8rhrrGzhRPM5MEM
        MNPy7HPzCMXjyh7kWDnwJl9HAE0t1on5GGpekVeMHA==
X-Google-Smtp-Source: APXvYqwcMzacKuaEiDuiYLfXrPSCi0BX/25WTim2iqBWs851azpZMa+Y1+bF0kIi0EdzOA4PXJ9yBT5f9snTwTgS1pY=
X-Received: by 2002:aca:b589:: with SMTP id e131mr4554174oif.91.1553074295380;
 Wed, 20 Mar 2019 02:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190313064557.GA14531@unicorn.suse.cz> <CADVatmMem3t-Lx42vU+-xN94FW5hbXjaBz3jgW6nkVouyWW-Qg@mail.gmail.com>
 <20190317180546.GA26013@unicorn.suse.cz>
In-Reply-To: <20190317180546.GA26013@unicorn.suse.cz>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 20 Mar 2019 09:30:59 +0000
Message-ID: <CADVatmNVf+8fLsZjETx5nmYKmdQCg0Moqv5W3S0i4gtX9uMn=w@mail.gmail.com>
Subject: Re: regression (bisected): "modprobe parport_pc" hangs in current mainline
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Sun, Mar 17, 2019 at 6:05 PM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Sun, Mar 17, 2019 at 05:01:37PM +0000, Sudip Mukherjee wrote:
> > On Wed, Mar 13, 2019 at 6:45 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> > > I encountered a regression in current (post-5.0) mainline kernel which I
> > > bisected to commit 1aec4211204d ("parport: daisy: use new parport device
> > > model"). Running "modprobe parport_pc" hangs up:
> >
> > Can you please send me your .config so that I can test it from my side.
>
> Attaching two versions: config-full.gz is the real life config from the
> machine where I found the issue and config-mini.gz is a minimized config
> I was using while bisecting the issue. (I made a mistake and thought
> that I have seen the issue with snapshot before both parport commits so
> that I ran a full bisect instead of simply checking the two parport
> commits which came in the merge window.)

Sorry, I didn't get the chance to look at it yet and have kept it
pending for this weekend. But just had a quick look and I was
wondering if the machine on which you are trying the modprobe has an
actual parallel port or the machine is not having any parallel port.
And also will you be able to send me a dmesg please.


-- 
Regards
Sudip
