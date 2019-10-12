Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DEC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B068B206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DovncKaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfJLWWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:22:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51570 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJLWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:22:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so13570825wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JFzKqMu/XOgZMy43SOwvpBuOXSOBfKqaUYBhEH3wBAI=;
        b=DovncKaL/vLX3YEKzcWSlGdAVm31UdyIXs/xVZKeUBAQA4AmepkEkI395gfJs16TuU
         XHtEkew2bPZwQeuD6OY91q9m9Ba87pWJeIASGs414H1t7a9vptQWiDgHrftvao28A4sc
         WwQOZSmUoLOZxe00YxK4zNWRLBAO947An4AbCnpmjHsLuauhzUFFvdJAkMMnH01jLzOh
         9OYZ7XLtMaK6BA1uZQfG0Ez68KnwHTziqN+c9+RRV9ZVPCIqPrUOjIWLb142kfsTogqD
         F3Bvv3iniMFTA/NGjfiAYYiEiVbi8tjF1Kn489UUCRnE+UgI9AmUXdJJ7aZQi05PbqOC
         oheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JFzKqMu/XOgZMy43SOwvpBuOXSOBfKqaUYBhEH3wBAI=;
        b=HOWfg5yfNOD//vDEXjUi5SBq1nZ7DgeV6cZlEc+bMiXr8oWJFSjneIA/10URtbCWk3
         ofxNVh+CvSLNdVe7WWNdXp9Bb8oaiGvaUfM+Ob8LDrJWiJ8LKVDHJ544ld9KcLUk05Gy
         Fsq4NwzMeZATZmGnrWnoYQ12L72ARbDd69PHMJVRn0goVB4EQb92urd8wKv8+YWHI63k
         1afXqCKyBy3Zohb+9G7v6W2rpV0goTrRPCFa0lDtHdzyYbxMoMQirpQ+d9j6iZj7a8iE
         iXVkfy5EeysPj4s2ffX+P/RnJXYAoUwBK2FdD8ndtRmbZZ9MoiWbr6n+1LZNK7lQR0m8
         OaOw==
X-Gm-Message-State: APjAAAXCi6jdXcJw1K1g/akiTlBtTCJ34AdpOOSIOKA8wUGn8c3SLcAH
        f9Ev8yBKDdT9f8EOmmNVK4A=
X-Google-Smtp-Source: APXvYqznaQ2I5zk2vZHv2CXimb9P7ATxRILO9G5M5Kk6EEMLuL4mDEulPc70Q1XGrPDkxaS/UFDKlQ==
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr8444358wml.58.1570918941499;
        Sat, 12 Oct 2019 15:22:21 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id z189sm22874407wmc.25.2019.10.12.15.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 15:22:20 -0700 (PDT)
Date:   Sun, 13 Oct 2019 01:22:15 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 3/5] staging: octeon: remove
 typedef declaration for cvmx_fau_reg_32
Message-ID: <20191012222215.GA30311@wambui>
Reply-To: alpine.DEB.2.21.1910122035380.3049@hadrien
References: <cover.1570821661.git.wambui.karugax@gmail.com>
 <b7216f423d8e06b2ed7ac2df643a9215cd95be32.1570821661.git.wambui.karugax@gmail.com>
 <alpine.DEB.2.21.1910122035380.3049@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910122035380.3049@hadrien>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 08:37:18PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 12 Oct 2019, Wambui Karuga wrote:
> 
> > Remove typedef declaration for enum cvmx_fau_reg_32.
> > Also replace its previous uses with new declaration format.
> > Issue found by checkpatch.pl
> >
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > ---
> >  drivers/staging/octeon/octeon-stubs.h | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> > index 0991be329139..40f0cfee0dff 100644
> > --- a/drivers/staging/octeon/octeon-stubs.h
> > +++ b/drivers/staging/octeon/octeon-stubs.h
> > @@ -201,9 +201,9 @@ union cvmx_helper_link_info {
> >  	} s;
> >  };
> >
> > -typedef enum {
> > +enum cvmx_fau_reg_32 {
> >  	CVMX_FAU_REG_32_START	= 0,
> > -} cvmx_fau_reg_32_t;
> > +};
> >
> >  typedef enum {
> >  	CVMX_FAU_OP_SIZE_8 = 0,
> > @@ -1178,16 +1178,18 @@ union cvmx_gmxx_rxx_rx_inbnd {
> >  	} s;
> >  };
> >
> > -static inline int32_t cvmx_fau_fetch_and_add32(cvmx_fau_reg_32_t reg,
> > +static inline int32_t cvmx_fau_fetch_and_add32(enum cvmx_fau_reg_32 reg,
> >  					       int32_t value)
> 
> These int32_t's don't look very desirable either.  If there is only one
> possible definition, you can just replace it by what it is defined to be.
> 
> julia
> 
Ok, I'll look into refactoring this.

wambui karuga
> >  {
> >  	return value;
> >  }
> >
> > -static inline void cvmx_fau_atomic_add32(cvmx_fau_reg_32_t reg, int32_t value)
> > +static inline void cvmx_fau_atomic_add32(enum cvmx_fau_reg_32 reg,
> > +					 int32_t value)
> >  { }
> >
> > -static inline void cvmx_fau_atomic_write32(cvmx_fau_reg_32_t reg, int32_t value)
> > +static inline void cvmx_fau_atomic_write32(enum cvmx_fau_reg_32 reg,
> > +					   int32_t value)
> >  { }
> >
> >  static inline uint64_t cvmx_scratch_read64(uint64_t address)
> > @@ -1364,7 +1366,7 @@ static inline int cvmx_spi_restart_interface(int interface,
> >  }
> >
> >  static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
> > -						  cvmx_fau_reg_32_t reg,
> > +						  enum cvmx_fau_reg_32 reg,
> >  						  int32_t value)
> >  { }
> >
> > --
> > 2.23.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/b7216f423d8e06b2ed7ac2df643a9215cd95be32.1570821661.git.wambui.karugax%40gmail.com.
> >
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.21.1910122035380.3049%40hadrien.
