Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF173C010B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6A421928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQwTMSPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfKELKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:10:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53689 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfKELKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:10:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id x4so9246365wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=y2qxlg9/WxYNrodQutppo1itEPPVt4haSvgHKc6Nv0U=;
        b=fQwTMSPfRFIr9Xsxooeb+ZdrmMotEymjjH3x72bOkSt6I5ppLg3TGDl6JXUCh79wZY
         nwh/hKrc9OI6tvuJ3Il5RdP4wXlfboHsTUlrqY+mzOEuVxVneFmlh4SUGwJe+KaZDMNB
         rJdSD17SV2fe77NLKdviMNLnHXDZlJX4ZUMOiKT8zQKBkNvomvt9TNizP4d3BLe2tRVI
         LL147AeUfVtjMz8qzIHGvcYoTWtIY6NptFe0e9xVWgwJJ198Dum5OrMRu/pMFflk1Gc5
         yA3SRUMgnJkIUX4pxomzJf/l5e7jgD3QWhfXtLQjHnD4vzPwScNRBHkdfcc1r/GyZzfZ
         P12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=y2qxlg9/WxYNrodQutppo1itEPPVt4haSvgHKc6Nv0U=;
        b=eMa1MLToBToKWKdGk83mZDE4IQsSJ0TYE1qVs+1W82QME5alG67faR7wxEPp8B52ku
         ediAz3z7aAtFzF6Wv4EcwkllszPs/SGn5WrqR3b28cWW46lGaPoLdYbaH34cFeYidrel
         oFcuYkFCZcm3hB1H4ELDaa/paPw9uax6p8j2EBehOZPUnUWvGhzP78/GqEXxkanauH3X
         +uAxGKJ/Td7lV0mkKkvjZLh+ZvC8aV8Ndn0e9xk+XfncixlLnGD7m909mhIsG7zbstm7
         d8ovlF+GFpo0GRnYBcO3fqYaHhc2cBc/FpJxQXImF5YmT60XEsu1qK9TSWfrAV5vz2ub
         U7CQ==
X-Gm-Message-State: APjAAAW7JN/32a3u7qO+5QXvKjQncLOBmhYydIf6Fv8h3mH2eMOTPs4S
        5lnkq+4vSF6Cqpua5ehmWgvQWCJE75kA
X-Google-Smtp-Source: APXvYqyvvSKLAZakm9eFYTOjJ3YOmB1B6VsR9rqH+5wCmZ7zKBaZ55nBL4aPq0HmDNVMb8XotKN8LQ==
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr3526268wmm.35.1572952228869;
        Tue, 05 Nov 2019 03:10:28 -0800 (PST)
Received: from ninjahub.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.gmail.com with ESMTPSA id y67sm1366175wmb.38.2019.11.05.03.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:10:28 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Tue, 5 Nov 2019 11:09:44 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: rewrite macro with GNU extension
 __auto_type
In-Reply-To: <20191104165148.GA2293059@kroah.com>
Message-ID: <alpine.LFD.2.21.1911051107590.11074@ninjahub.org>
References: <20191104164400.9935-1-jbi.octave@gmail.com> <20191104165148.GA2293059@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Nov 2019, Greg KH wrote:

> On Mon, Nov 04, 2019 at 04:44:00PM +0000, Jules Irenge wrote:
> > Rewrite macro function with GNU extension __auto_type
> > to remove issue detected by checkpatch tool.
> > CHECK: MACRO argument reuse - possible side-effects?
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  drivers/staging/rts5208/rtsx_chip.h | 92 +++++++++++++++++------------
> >  1 file changed, 55 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/staging/rts5208/rtsx_chip.h b/drivers/staging/rts5208/rtsx_chip.h
> > index bac65784d4a1..4b986d5c68da 100644
> > --- a/drivers/staging/rts5208/rtsx_chip.h
> > +++ b/drivers/staging/rts5208/rtsx_chip.h
> > @@ -386,23 +386,31 @@ struct zone_entry {
> >  
> >  /* SD card */
> >  #define CHK_SD(sd_card)			(((sd_card)->sd_type & 0xFF) == TYPE_SD)
> > -#define CHK_SD_HS(sd_card)		(CHK_SD(sd_card) && \
> > -					 ((sd_card)->sd_type & SD_HS))
> > -#define CHK_SD_SDR50(sd_card)		(CHK_SD(sd_card) && \
> > -					 ((sd_card)->sd_type & SD_SDR50))
> > -#define CHK_SD_DDR50(sd_card)		(CHK_SD(sd_card) && \
> > -					 ((sd_card)->sd_type & SD_DDR50))
> > -#define CHK_SD_SDR104(sd_card)		(CHK_SD(sd_card) && \
> > -					 ((sd_card)->sd_type & SD_SDR104))
> > -#define CHK_SD_HCXC(sd_card)		(CHK_SD(sd_card) && \
> > -					 ((sd_card)->sd_type & SD_HCXC))
> > -#define CHK_SD_HC(sd_card)		(CHK_SD_HCXC(sd_card) && \
> > -					 ((sd_card)->capacity <= 0x4000000))
> > -#define CHK_SD_XC(sd_card)		(CHK_SD_HCXC(sd_card) && \
> > -					 ((sd_card)->capacity > 0x4000000))
> > -#define CHK_SD30_SPEED(sd_card)		(CHK_SD_SDR50(sd_card) || \
> > -					 CHK_SD_DDR50(sd_card) || \
> > -					 CHK_SD_SDR104(sd_card))
> > +#define CHK_SD_HS(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> > +					 (_sd->sd_type & SD_HS); })
> > +#define CHK_SD_SDR50(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> > +					 (_sd->sd_type & SD_SDR50); })
> > +#define CHK_SD_DDR50(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> > +					 (_sd->sd_type & SD_DDR50); })
> > +#define CHK_SD_SDR104(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> > +					 (_sd->sd_type & SD_SDR104); })
> > +#define CHK_SD_HCXC(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_SD(_sd) && \
> > +					 (_sd->sd_type & SD_HCXC); })
> > +#define CHK_SD_HC(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_SD_HCXC(_sd) && \
> > +					(_sd->capacity <= 0x4000000); })
> > +#define CHK_SD_XC(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_SD_HCXC(_sd) && \
> > +					 (_sd->capacity > 0x4000000); })
> > +#define CHK_SD30_SPEED(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_SD_SDR50(_sd) || \
> > +					CHK_SD_DDR50(_sd) || \
> > +					CHK_SD_SDR104(_sd); })
> >  
> >  #define SET_SD(sd_card)			((sd_card)->sd_type = TYPE_SD)
> >  #define SET_SD_HS(sd_card)		((sd_card)->sd_type |= SD_HS)
> > @@ -420,18 +428,24 @@ struct zone_entry {
> >  /* MMC card */
> >  #define CHK_MMC(sd_card)		(((sd_card)->sd_type & 0xFF) == \
> >  					 TYPE_MMC)
> > -#define CHK_MMC_26M(sd_card)		(CHK_MMC(sd_card) && \
> > -					 ((sd_card)->sd_type & MMC_26M))
> > -#define CHK_MMC_52M(sd_card)		(CHK_MMC(sd_card) && \
> > -					 ((sd_card)->sd_type & MMC_52M))
> > -#define CHK_MMC_4BIT(sd_card)		(CHK_MMC(sd_card) && \
> > -					 ((sd_card)->sd_type & MMC_4BIT))
> > -#define CHK_MMC_8BIT(sd_card)		(CHK_MMC(sd_card) && \
> > -					 ((sd_card)->sd_type & MMC_8BIT))
> > -#define CHK_MMC_SECTOR_MODE(sd_card)	(CHK_MMC(sd_card) && \
> > -					 ((sd_card)->sd_type & MMC_SECTOR_MODE))
> > -#define CHK_MMC_DDR52(sd_card)		(CHK_MMC(sd_card) && \
> > -					 ((sd_card)->sd_type & MMC_DDR52))
> > +#define CHK_MMC_26M(sd_card)\
> > +	({__auto_type _sd = sd_card; CHK_MMC(_sd) && \
> > +					 (_sd->sd_type & MMC_26M); })
> 
> Ick, no.  These are obviously pointers, which can not be "evaluated
> twice" so this whole thing is just fine.
> 
> checkpatch is just a "hint" that you might want to look at the code.
> This stuff is just fine, look at how it is being used for proof of that.
> 
> thanks,
> 
> greg k-h
> 
Thanks for the feedback. It's good to know. I really appreciate.
Kind regards,
Jules
