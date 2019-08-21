Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE9AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9212922D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2IrsROH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfHURtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:49:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfHURtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:49:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so1894474pfk.9;
        Wed, 21 Aug 2019 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cuc7KArAwEZwDVhK9UQGoIlx3cYOJWBMGimfd+D8qCg=;
        b=Z2IrsROHrgGddTp70xQRuUmUImik5DFHyqPJBEP6guIEvSGDYKGOJna9rw7t2aVLZw
         foYQrmnHtGq7Ki7PRB8NZf6Wscpv2fB8sQzAzCM3hvTSLmICTHHqRS6eGMXcU5XfWYil
         U9xbtD0Eidq+jfFOoCyDwd5nP7gONspQC/4BXhg232blHOWG/686CZP4efQEqta+HQ6L
         EaHUBPyG1vfuzRn9Ph84/Phanu0+JN9lEgn8ucc6f7+GYXaMNkJ3DJw6yU/BpUI1VEGV
         mvBtumjQUGWk73sIGUkrpqkWO5LnqA0IRIeLsgHUZaNQswv/eJuVjfXUeRhwBupXGGI2
         lq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cuc7KArAwEZwDVhK9UQGoIlx3cYOJWBMGimfd+D8qCg=;
        b=b5qRgngRFTTI6vfxDoBXV1Yfbbka0hpr2rNyglfJ3koqQnZf3jmRvcNtaLBkyB9Hcn
         avBhkjzR4bHMB5jnTtFcnRYFWIaCbM4wMC40cbN+5E4WWA3vLzV/w9Eoxoozo6SMfl5W
         2tGan2IaL/X0OJazDjuGqEIhOIAn9JQEsdoamXbAHpKJYUHstHBNtHUdOJd1/awFu2Ct
         ebIYMVITOBt2N4Ccux7YkeY5pEGBq+paDyB3N2/+2ZnASVqt8xPTHdezo8w3x6ksOHGt
         gcGA6q8SrTafRsxO5VD6PdSCqqPrE7DtqYk3y+dtJrtjncT+G1hiP7Dt1P+ve6VfQy28
         mOvA==
X-Gm-Message-State: APjAAAUVpiras1mOqo/OhVnycSJIivyaZ88NudF6qThlx75RL/evaPp3
        OZGCrO0KllHJ4Hm9vt0SPn0=
X-Google-Smtp-Source: APXvYqx/voWIbNubBp2JnHr/iFkLr4llW1oBCP0mDz/dkwGM2Fjc8HNeHtK4u6PGmDt5386t4ke/Mw==
X-Received: by 2002:a17:90a:dac3:: with SMTP id g3mr1165426pjx.45.1566409740377;
        Wed, 21 Aug 2019 10:49:00 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b5sm23381967pfo.149.2019.08.21.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 10:48:59 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:48:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 2/2] drivers: input: mouse: alps: drop unneeded likely()
 call around IS_ERR()
Message-ID: <20190821174857.GD76194@dtor-ws>
References: <1566298572-12409-1-git-send-email-info@metux.net>
 <1566298572-12409-2-git-send-email-info@metux.net>
 <20190820111719.7blyk5jstgwde2ae@pali>
 <02f5b546-5c30-4998-19b2-76b816a35371@metux.net>
 <20190820142204.x352bftlvnb7s57n@pali>
 <2cd7178e-9713-7678-a02d-dde91e990c1e@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cd7178e-9713-7678-a02d-dde91e990c1e@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 21, 2019 at 01:37:09PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 20.08.19 16:22, Pali Rohár wrote:
> 
> Hi,
> 
> > > In that case, wouldn't a comment be more suitable for that ?
> > 
> > And why to add comment if current state of code is more-readable and
> > does not need it?
> 
> Readability is probably a bit subjective :p
> 
> With ongoing efforts of automatically identifying redundant code pathes,
> the current situation causes the same discussion coming up over and over
> again. Sooner or later somebody might get the idea to add a comment on
> that line, that it's exactly as intented :o
> 
> OTOH, I'm unsure whether it's important to document that is particular
> error path is unlikely, while we don't do it in thousands of other
> places. IMHO, error pathes are supposed to be unlikely by nature,
> otherwise we wouldn't call it an error situation ;-)
> 
> > People normally add comments to code which is problematic to understand
> > or is somehow tricky, no so obvious or document how should code behave.
> 
> Yes, but isn't this case so obvious that it doesn't need any
> documentation at all ? Is it so important to never ever forget that this
> particular path is a rare situation ?

Because if I see "if (IS_ERR(...))" in an interrupt path I will try to
see if it can be optimized out, but in this particular case we document
it with explicit "unlikely" and I know that I do not need to bother.

The fact that there is unlikely in IS_ERR is an implementation detail.
It may be gone tomorrow. I do not want to have to remember all
implementation details of all kernel APIs and readjust the code all the
time as they are change underneath me.

Thanks.

-- 
Dmitry
