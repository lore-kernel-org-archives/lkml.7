Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61EAC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7837C20859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSDGbhJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDVDXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 23:23:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35653 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfDVDXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 23:23:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so5053411pfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 20:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z+sDPrkVShQ3SV/eZUAJkyobdgecsoIqwEYrWD1W76s=;
        b=ZSDGbhJyxjWrjtlzjZrWNtPSJeDJho5p6X5BJZM350JlqZy4knfTvU9nhjIcRHOgEH
         jSad+pL4r37wVD7oj0XFgaQ3LttHOwtjJCnTHYswfRMBBO0SFeYsPoLz8aq+GuwPukYY
         BdZSrQyguCMqUG8lES6qRjkmHQkZLhTY/YMSsh4ZAv5ObkDQAA37osl0S+Ed8VM48Gx0
         gkrEO+zhW22L9/+phghX6ji3t5vmtdr+zmi2pHZ3Z7nNbmfAHUAyowvK9UtWNKGvJAqW
         XxkHoALIf//QtKINl7MWbIrwCoar7m+/5t0ohfmZsz47hDiLQIvh4usuo6L1PT8G+fZC
         PizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z+sDPrkVShQ3SV/eZUAJkyobdgecsoIqwEYrWD1W76s=;
        b=GZztU526PpFXyq/GPiN+uNVtLFWlbKhf12yv84d9VKmevUyjG5r7/Jk33oOBpNX7ac
         KybDqI2Cl8zBvpPTdes68sRT7GxM4CswOC86JWlB8pa+1HVtIrtsAg3BeO4JbPpSkyVq
         xJN6CpIreU4wQsqF6ouGEKh24xi7Auycz7y3zJ7ifWO/G5NYoV7d4nSzEgIqG2crW37y
         I+9xHHzyyyUwcb0cYD+BpQZ+0xWn8gmAF48JlKnqVGyxlKjO3+ZWPbbLN3/RvK2zXAU7
         TUoczdrviXDLfxbFW1qxyblm6swNJFPgUbes3aUeEO/DNE3fGjfk1HDsE5GECahSCbOs
         xmpg==
X-Gm-Message-State: APjAAAVG1kxOYv8hnHE/LDbcFz+RLrZitCZ91KXs9O6CgXkVgH1hwqN/
        xMqHyHmUHe8yQeLbCGwoltQ=
X-Google-Smtp-Source: APXvYqzdHTD2SBWS8zz9XUjeR4TAVRuYUMZjFUqeTU2U7VAWVpYQgTuksvO6MXdv8ubqPB9K01MrwQ==
X-Received: by 2002:a63:5560:: with SMTP id f32mr16971001pgm.334.1555903398132;
        Sun, 21 Apr 2019 20:23:18 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id b16sm15530733pfo.168.2019.04.21.20.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 20:23:17 -0700 (PDT)
Date:   Sun, 21 Apr 2019 20:23:11 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190422032310.GA8300@Asurada>
References: <VE1PR04MB6479817B69545A662FFB43B4E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479817B69545A662FFB43B4E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 03:15:34AM +0000, S.j. Wang wrote:
> Hi
> 
> > 
> > 
> > On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> > > When we want to support more sample rate, for example 12kHz/24kHz
> > we
> > > need update the process_option table, if we want to support more
> > > sample rate next time, the table need to be updated again. which is
> > > not flexible.
> > >
> > > We got a function fsl_asrc_sel_proc to replace the table, which can
> > > give the pre-processing and post-processing options according to the
> > > sample rate.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > 
> > A couple of more small comments.
> > 
> > And please add this when you resend:
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > 
> > > + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin
> > 
> > Since we have a ratio validation somewhere else, it's okay to drop this line -
> > - it may confuse people since the function no longer checks these
> > unsupported cases.
> 
> I add this for may be in the future we forget the limitation. Just for a reminder.

Okay. Let's use something more practical like:

+* Make sure to exclude following unsupported cases before calling the function:
+* 1) outrate > 8.125 * inrate
+* 2) outrate > 16.125 * inrate
