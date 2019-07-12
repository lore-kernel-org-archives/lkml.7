Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28E6C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C492221670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tId65nli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfGLDws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:52:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39507 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfGLDws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:52:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so7912598edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 20:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P3Q6cX33JeEZeR4z0+wnkhuDYyByu9jPKIafQF/Bv80=;
        b=tId65nli6ZbZrOSSIurWH63eDKaybL2rMPGTvVrKcH5FO/Pb7tnabHWtdkmJ0UQ5t/
         Ah81xW4NiL530KsJOQQb/gUCzHQdtoseJi4K96kWRABaJrlDRX55Va79dc311qfiVX2w
         YqJ84pkdatHN7TarR6ZZwYLQrBr8yMrVhKchOciIxyq89gX8iMKpgeoM/IM/Gxk40F1v
         EQ9OhkPLcQcoD33yrGbp20dfOXpOX2DP1X4ZoWoqdIi4lfduRAKR9l7SU3x+iL5VTf66
         cI0UgCHTaMYEDrrXuDVhL3ESiubl9jPPc3+9yeyczKmuGnMGzyk8+/9fS8FOexqfFRX/
         UTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P3Q6cX33JeEZeR4z0+wnkhuDYyByu9jPKIafQF/Bv80=;
        b=g1PyEuD6G1D9i3ovVVCu/YFfqzlEJjfAZIVy1mZH1s2PNLkj7qH6g/2UzpH0NGN33v
         CPVzz+E6TXZW+3Pz1P8Yk8lek/jyTP8ff1kEHKZgulRcLJAqlBTl89ThT4QQ/L8wfujw
         ALqAKjzlaDuxONuH0R0n5tHSPpCog3kC0QvVDmXTZS9KmQYb65VdM63CvMqsfWL2ME73
         3mqYUdNxAW5hW78lv6DZhGZWiARrkrLUFx39NhDFAQI/wT9vPEpd2xAIfquTdGxDvgCB
         vCAK+cPgfu+545SgH8l6sWE2HFq8ohn2PTPwDwFs/4KL8yU2I5CpI/5rY/ulAmtoy4mQ
         KqkA==
X-Gm-Message-State: APjAAAWnrgClCpCLbmO3IGDICDxFe/PNufJz5NMg0w7bBf1eG2rtorMt
        lDsIdfhL5gSQ+qihGM4rlbw=
X-Google-Smtp-Source: APXvYqzEjKEpqTBdWuCG3TIWxHn33vt0SO56sxvUtIo1lLnAof3zAVpB874ZMsIU3Ox+rWUU4SWaFQ==
X-Received: by 2002:a17:906:a481:: with SMTP id m1mr6078797ejz.87.1562903566598;
        Thu, 11 Jul 2019 20:52:46 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id gz5sm1532335ejb.21.2019.07.11.20.52.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 20:52:45 -0700 (PDT)
Date:   Thu, 11 Jul 2019 20:52:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ASoC: audio-graph-card: Constify reg in
 graph_get_dai_id
Message-ID: <20190712035244.GA67442@archlinux-epyc>
References: <20190712014357.84245-1-natechancellor@gmail.com>
 <20190712014554.62465-1-natechancellor@gmail.com>
 <87muhk53j1.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muhk53j1.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 12:37:51PM +0900, Kuninori Morimoto wrote:
> 
> Hi Nathan
> 
> > clang errors:
> > 
> > sound/soc/generic/audio-graph-card.c:87:7: error: assigning to 'u32 *'
> > (aka 'unsigned int *') from 'const void *' discards qualifiers
> > [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> >                 reg = of_get_property(node, "reg", NULL);
> >                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> > 
> > Move the declaration up a bit to keep the reverse christmas tree look.
> > 
> > Fixes: c152f8491a8d ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/600
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Maybe
> 
> ec3042ad39d4e2ddbc3a3344f90bb10d8feb53bc
> ("ASoC: audio-graph-card: add missing const at graph_get_dai_id()")
> 
> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto

Ugh, I even checked Mark's tree before sending this, just completely
glossed over that patch. Sorry for the noise :(

Cheers,
Nathan
