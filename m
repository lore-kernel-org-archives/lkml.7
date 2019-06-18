Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F9C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B3420645
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWOBNmuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfFRW5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:57:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35102 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfFRW5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:57:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so8496130pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bhgB/XOS87xzY5SYQXCbXc3LyNLA5aTw5d9mEOvvGXc=;
        b=bWOBNmuQxe/oJdiMWlLuEdrYGMprNyvVlWgcV9EH6e3D49USh+OnAM5ZWU+ppGHW7Q
         MooNtT21chrxmOuI1vPtho1CP+enUHNppSTDuGjJAx1GOfEMEYMx70Bd6jeVgpSrvNJn
         RLSoWPnQimbh1EYo5EcIntgRq5VEO03WtpXIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bhgB/XOS87xzY5SYQXCbXc3LyNLA5aTw5d9mEOvvGXc=;
        b=LOuAB/1suhVMmRqMPgoCpvbXBT3kOUO1FVHjY/j2QCi2Kfdc1ND74JG0Kgu0FfyfhS
         3D18SI6VPYHoIuaZNGeD4JHP1NoFEc8IDGZ8VyLTlLs/YwVfoi/kLp8b55Z4ftCwqL4S
         gV0MdAPmya+PYYt0OZyarJVuGauJuR+FT8+e9uga8PPWD9Gwqzw3SjuQmgQXgJ6xiKz+
         feWp/FZEHD/h8K4CnSxgD/bYZCOG6VN447NwvYZhPxwnNEUHUJmnQLkOYEbZK/dVc+9y
         cikfewEIKB8zVYPXWvsQTnn73ak7pqWqMHwSTiGORB0wYOW5rS/t15ZRnVQ7pAx8enEl
         p5/Q==
X-Gm-Message-State: APjAAAV5+GZWaJ5J7O/LIqmleAZsmgQ8OWs1+U2p5GDMSGHy+WsylF12
        f34QT8IEDK+pZDK0dqFhqNPk7g==
X-Google-Smtp-Source: APXvYqx5M9CfqCQlzLQLDQ3EKaZRX9aoa28F7oOTlwpDt44S+lIZDcQL/TLQVK6debmgbpPmNIPA2A==
X-Received: by 2002:a62:bd11:: with SMTP id a17mr48690314pff.126.1560898644798;
        Tue, 18 Jun 2019 15:57:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p23sm3105121pjo.4.2019.06.18.15.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 15:57:24 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:57:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net/ipv4: fib_trie: Avoid cryptic ternary expressions
Message-ID: <20190618225721.GV137143@google.com>
References: <20190618211440.54179-1-mka@chromium.org>
 <CAD=FV=V6TqT93Lb2UoQdkyO2j7OHrggCn-4qwDLEFw=N7RZ2Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=V6TqT93Lb2UoQdkyO2j7OHrggCn-4qwDLEFw=N7RZ2Eg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 02:45:34PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 18, 2019 at 2:14 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > empty_child_inc/dec() use the ternary operator for conditional
> > operations. The conditions involve the post/pre in/decrement
> > operator and the operation is only performed when the condition
> > is *not* true. This is hard to parse for humans, use a regular
> > 'if' construct instead and perform the in/decrement separately.
> >
> > This also fixes two warnings that are emitted about the value
> > of the ternary expression being unused, when building the kernel
> > with clang + "kbuild: Remove unnecessary -Wno-unused-value"
> > (https://lore.kernel.org/patchwork/patch/1089869/):
> >
> > CC      net/ipv4/fib_trie.o
> > net/ipv4/fib_trie.c:351:2: error: expression result unused [-Werror,-Wunused-value]
> >         ++tn_info(n)->empty_children ? : ++tn_info(n)->full_children;
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > I have no good understanding of the fib_trie code, but the
> > disentangled code looks wrong, and it should be equivalent to the
> > cryptic version, unless I messed it up. In empty_child_inc()
> > 'full_children' is only incremented when 'empty_children' is -1. I
> > suspect a bug in the cryptic code, but am surprised why it hasn't
> > blown up yet. Or is it intended behavior that is just
> > super-counterintuitive?
> >
> > For now I'm leaving it at disentangling the cryptic expressions,
> > if there is a bug we can discuss what action to take.
> > ---
> >  net/ipv4/fib_trie.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> I have no knowledge of this code either but Matthias's patch looks
> sane to me and I agree with the disentangling before making functional
> changes.

I in terms of the -stable process it might make sense to either
disentangle & fix in a single step, or first fix the cryptic code
(shudder!) and then disentangle it. I guess if we make it a series
disentangle & fix could be separate steps.

I'm open to whatever maintainers & stable folks prefer.

> My own personal belief is that this is pointing out a bug somewhere.
> Since "empty_children" ends up being an unsigned type it doesn't feel
> like it was by-design that -1 is ever a value that should be in there.

good point that 'empty_children' is unsigned, that indeed reinforces
the bug theory.

> In any case:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!
