Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DECC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D89213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1NNcI75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDHWcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:32:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42887 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDHWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:32:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so8089668pgh.9;
        Mon, 08 Apr 2019 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9gURMCfoOgoTkHI/WJj+bRmGByb2rAQnY4p70cixdkM=;
        b=i1NNcI75+g2upSaeC1/N3mMZXEf5X0ASPgi1UDAZ1IxRbyeo5FdgSnuCx32plocEIb
         rcEEPo9Q1vH2Q1ZRUyW5jffOTFrAM/KegPvRsExYc3kPbrx5UQm+q/RHChaVu28aK9KF
         mvAD6jpTEG9ZU7Veh6+2UpZ64h81iu8TKdiqYnDZ1CvFTmd8eoooNgwTSO9Jw5qSk7wJ
         t1T9cFAVyWCBzkn2jiF65ny+cYWQJLf1u3x5KEFBRinR0NSIz6lXIH6Li2wg/whe2pUu
         JoqYO0kvX8YV/uyV3vzahAUpnX00OtE6w2n1AcH70z4gigK5OXtDGYspSv5tRPy7+1gL
         O6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gURMCfoOgoTkHI/WJj+bRmGByb2rAQnY4p70cixdkM=;
        b=qe2nHABtVT2fIKliCj+mY56+tTtXWK6BpN59SJSiGQNy/iVhobs0kcGHsKqN4ifiY3
         9Zx03TcDzFoPqSUPXIsjiS6Gx5LY1f/OKlIgyLGcbz/M35OdERNaoh+bL657tjn4NYWv
         m2FxphLuL3jzyhIbv51alSLpTNfxB3NMdSlWAlSorRoOfnWlhJTQWftcpM3YrbycqYEg
         GU57mS5ZyZMv+DOvs6JP2ZkorlPgOAxidpaxKeHOWJn8TWJtMOVoN6XnbZ8xNywqUnHF
         rkm8kdaH/XmhNawJeVzDXhyUZ+/9Mme/IIuBMRmzjlhSCeYrws23rVbR4Tq85noAiWc5
         5/ug==
X-Gm-Message-State: APjAAAVLXMPQ5t2P+PHTHzwTyVPjc1YqX0KrjDeoomWwgb9MaRRCvMgm
        dvcqxuY7ipL7OfocQm9aJo8=
X-Google-Smtp-Source: APXvYqzXp5yvcRUDAZ8JYCI+6Q8UQW2R43ki9hg1Qw7iMNcFXU1zZarpGTH+ofkOTCqO+fHHrSEPxg==
X-Received: by 2002:aa7:938b:: with SMTP id t11mr31966899pfe.67.1554762766686;
        Mon, 08 Apr 2019 15:32:46 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f22sm3107057pgv.45.2019.04.08.15.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 15:32:45 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:32:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/6] Input: add IOC3 serio driver
Message-ID: <20190408223243.GB200740@dtor-ws>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
 <20190408142100.27618-7-tbogendoerfer@suse.de>
 <20190408190218.GA200740@dtor-ws>
 <20190408190842.GS7480@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408190842.GS7480@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 09:08:42PM +0200, Alexandre Belloni wrote:
> On 08/04/2019 12:02:18-0700, Dmitry Torokhov wrote:
> > > +MODULE_AUTHOR("Stanislaw Skowronek <skylark@unaligned.org>");
> > > +MODULE_DESCRIPTION("SGI IOC3 serio driver");
> > > +MODULE_LICENSE("GPL");
> > 
> > "GPL v2" to match SPDX header?
> > 
> 
> I've been told this is not true:
> 
> https://lore.kernel.org/linux-rtc/371999940784dbd281669122c3027805ab0ecfd9.camel@perches.com/

Ah, great, nevermind then.

Thanks.

-- 
Dmitry
