Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD253C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C0D2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6s1zfB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfFRIP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:15:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36797 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFRIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:15:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so2147669wmm.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g8vYSlEh40qjxrDzT9jGJ/rFo/H3u7VmlwgvhhLCV2w=;
        b=X6s1zfB326S+/ukGcYonJRSv41H21bJmX0asSmEtS3cW/NnNEkkA5T7Jc0OpMmvwAl
         cjn1f11luCYmOVnDrEuczcXmBpTbH1qqkbTZ7p18CvKiemyQ5+egQpkRnJLgQBJSVHSh
         xVt//BFOfnt9VLqAwc2V0GKNDYZ1q09Fs9suqZyfwxHaiHRPv/eSHkNzZ9ndt/HdwLCY
         w5cmaY6gTrktfL+n4vtt/Ii7KagLKrN9UP1AXk9j720IC5PVx5/fIlzJpRtXW6o2BIWT
         vNWm2+LfHFsCAccfwhyMFQBlWUerWFMAo/4NyIgCeXjz7spHnXL8RhJvTla9CSnru8TV
         Oe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g8vYSlEh40qjxrDzT9jGJ/rFo/H3u7VmlwgvhhLCV2w=;
        b=X3VdE1Pr7THV3SHZQlHLqrSjuNMpeToEESVusCKP4MS3/W0yudaDJcmWP+5uA8yzhn
         5MVBEsZGmPVLBhJF+R281ZHEO4DajJJ9mjAVfQcGeLUlKW2V5s4TvKpqfmvren+EOUgg
         jp0LLZx5wkOIVchEl/W+RvBdt/LoL6QNAzzMl1B3j3NWP5YNkg6KGuPhiY2ABn8QMods
         Zqf0SiQqQAtibqru89K4gr285OBL1/q/0Jfo4dygP+C6Z+8yOWoU2bN0/50dhmrqkNNY
         NsL2EqbYDpZrjeK6V8rA9/bJUT5uwCK++LJFBVIAjg18cHWSjn0+KE+wvudE72X5mP8v
         k8aA==
X-Gm-Message-State: APjAAAVVDAdwnvSLdZApszX2EcSvNO55+1WhrHLyPFNf5LpORLsUL9h6
        EHOTkr9P1/AGup0o3mDHJH3k9wYj2bA=
X-Google-Smtp-Source: APXvYqzRL81ShqZ05aNVi640BmNpCaYsMEn0751A7X6xFT0/QeokhOt/u1bZkDJbm/+C1F+/FBa9vA==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr2233785wmj.2.1560845755075;
        Tue, 18 Jun 2019 01:15:55 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id p140sm1897862wme.31.2019.06.18.01.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 01:15:54 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:15:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] MFD fixes for v5.2
Message-ID: <20190618081553.GL16364@dell>
References: <20190617100054.GE16364@dell>
 <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Linus Torvalds wrote:

> On Mon, Jun 17, 2019 at 3:01 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Enjoy!
> 
> No.
> 
> This is still entirely wrong.
> 
> You can't just randomly cast an "u32 *" to "unsigned long *".
> 
> It wasn't correct when you did it the other way in regmap_read(), but
> it's also not correct when you now for it this way for
> for_each_set_bit().
> 
> You can do
> 
>     u32 regmap_bits;
>     unsigned long bits;
> 
> and then
> 
>     ret = regmap_read(stmfx->map, STMFX_REG_IRQ_PENDING, &regmap_bits);
>     ...
>     bits = regmap_bits;
>     for_each_set_bit(n, &bits, STMFX_REG_IRQ_SRC_MAX) ..
> 
> but casting pointers at either point is *completely* wrong.
> 
> Yes, yes, it happens to work on little-endian, but on a 64-bit
> big-endian machine, the low 32 bits of the "unsigned int" will have
> absolutely _zero_ overlap with the low 32 bits of the "unsigned long"
> in memory.
> 
> When you moved the cast to for_each_set_bit(), it only moves the
> access of the bogus bits to another place instead.
> 
> So that patch doesn't fix anything at all, it only moves the same error around.

Good catch.  Thank you for taking the time to review Linus.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
