Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A69C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30DC20873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvOC26sX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfENTqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:46:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40773 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENTqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:46:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so551861eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SNWKhmqL1RfT8Ocb1OCe8VtXVVSNF6ph0Xhv4SOWB40=;
        b=CvOC26sX0Xespaa+PiqBMpVSVDalmpu07UNwcKEhcgmeP2TDr0wk6JF8RLwrn+q8XC
         tTzs0QE62dfTI68neDTbRlFyFY08xmW0ApwLtoG9MHfKXaTM9op4nNTlAisylxHhICqs
         Zn9bOWMTQWRFqK3iuLsX3ufb/cQ8OIaOscTRNoDTMK6SUPK8xlD5hPKhe737Gv5WMP/e
         8OYFSvpKd5U5A0a7Z5XGR9K3Vzlps8Dd7wEJNK5oGDkIPOgzbRRGDQKBHp39ynhfOUkj
         l0bxU5MA6DYnwb8//D2+Cw6tEhpXw8TMIh0ozArYTv8mAz9lJiTsa0Bb6Fjt4rYaf4Mu
         Yx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SNWKhmqL1RfT8Ocb1OCe8VtXVVSNF6ph0Xhv4SOWB40=;
        b=PWnuPqgZAQotFuNtP5e5jAXxqwYtnQWNwWM2wnv+23Z0gfo09KzLuSHTuImq/KhaFn
         TA1wUjUR4WFalsF23df4mtjqkQylA0j5n6vwSM5pM0L/FH5afkdx20CyC3GwW1M3G7Om
         POX0x86+4aDD1jI13VQzzGFsk/lI6mAOqwmu5adVEINctXAl8DR7c7x2YlLLzmoTmaYi
         stCm9cpRHKRI+U/QKUX4N3f8qyojG5hlOoKTYjP0PkPWZ9gNQMb6q1B00mRu1Av46MMJ
         lc1GUDuj0ejGis9AN5ddnoTfN9sM9bVRbl1X73XvoRMmNxKXifVH0qOoxdhraVI6rVub
         P6GQ==
X-Gm-Message-State: APjAAAX1PA6ZM+3Glnw8vFrJ0jI7UGVpBXboiyMG0PA+4UQyXPlIYfAO
        OzmQ1uizwpsYu40JIh19Sog=
X-Google-Smtp-Source: APXvYqzqsM6YxhwDwuwnA/BDNBMRsL7Bv72pN9sp+FWRDWg10cTe5/0GsN+ZRTKbAmaakhT/NWUJZA==
X-Received: by 2002:a50:9b10:: with SMTP id o16mr37943864edi.229.1557863160506;
        Tue, 14 May 2019 12:46:00 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id x49sm4911383edm.25.2019.05.14.12.45.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 12:45:59 -0700 (PDT)
Date:   Tue, 14 May 2019 12:45:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mfd: stmfx: Fix macro definition spelling
Message-ID: <20190514194557.GA12421@archlinux-i9>
References: <20190511012301.2661-1-natechancellor@gmail.com>
 <20190513073059.GH4319@dell>
 <20190514183900.GA7559@archlinux-i9>
 <20190514185404.GP4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190514185404.GP4319@dell>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 07:54:04PM +0100, Lee Jones wrote:
> On Tue, 14 May 2019, Nathan Chancellor wrote:
> 
> > On Mon, May 13, 2019 at 08:30:59AM +0100, Lee Jones wrote:
> > > On Fri, 10 May 2019, Nathan Chancellor wrote:
> > > 
> > > > Clang warns:
> > > > 
> > > > In file included from drivers/mfd/stmfx.c:13:
> > > > include/linux/mfd/stmfx.h:7:9: warning: 'MFD_STMFX_H' is used as a
> > > > header guard here, followed by #define of a different macro
> > > > [-Wheader-guard]
> > > > 
> > > > Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/475
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  include/linux/mfd/stmfx.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Applied, thanks.
> > > 
> > 
> > Hi Lee,
> > 
> > Thanks for picking it up. It seems this didn't make it into your MFD
> > pull request for 5.2, was that intentional? It would be nice to avoid
> > this warning.
> 
> Hmm... no it was not intentional.  Not sure what happened there.
> 
> I will pick it up for the -rcs.
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

Thank you, I appreciate it!

Nathan
