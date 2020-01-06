Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE14C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3542214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP0b+kqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgAFWiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:38:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35160 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:38:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so27524988pgk.2;
        Mon, 06 Jan 2020 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S1FEEE6cCiUhglrJpwPJZH4zxshLjsGK5hYscNFBnAI=;
        b=sP0b+kqIgs0Wa01Ipe9vAxhjDci+QsIELt4Jxx3GKyj3kkoogjMroLTcTLoZGuzM06
         mcW7i8waLEOVEIet/Ye76nn5octXd9nntk0g25HRxSNdHGDW1tnZ81JNY415TaFdos2D
         MCOZQJikcAznKooB1G+TpbIcS9Z3ly1lH8XjbpetKzLOxgmrQUxlJvp3oeKbRkD2mvmW
         oxQH7yi7x+Hs254uljZlC1GiLQ7ZmgeChjbceYlBRG2BP+qdI7p8836mThhJT3yqS0Vu
         Q4MZ1yyewwbfkq37wEuYjld1cm824RztHw9m3lh+uwzu7tFa8g0DYsDV397O4TmdAs/k
         5CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S1FEEE6cCiUhglrJpwPJZH4zxshLjsGK5hYscNFBnAI=;
        b=mI9jZzP3VXwe9O8d6GzL+SQtfsnfGA2UTpHLYyeRr1/FSVLVqGZAz84AMdZvPadLfx
         UMZG2RMTRdj1wLg787DxatNjsxzQgUkSKxMdvxtcLcIMG8q9xvBKkgcSaOffE05MRRVX
         uUPDqzRQlGSAMLe88toTZh4RuF3wYFRHHSA39mN0STHNXO/NeycWZGbt+s6RYcZChPVs
         gieSOL63Bd9knAde7rTq7sOZOQN7s49mO5RIEM7Vg/uOik9iPQZ7XpykdAXnROhSC31d
         x/Xockk32kcaFWh/dLtitUkNiZu0JSr3ezG/FSM9NkTwpCG20d3nYBvsFsSmPTJAMwrk
         soSQ==
X-Gm-Message-State: APjAAAVNIA6Ajm5w82rfv0EoJox0y6Zwsp+UB+oF3Z93Uy6cTHlhQZ80
        EhxVOHQlqqsKrlYAg7Gs0y4FiVUp
X-Google-Smtp-Source: APXvYqyYMmJhcA1k5o0TuMxSxjZ9wt+SVCos6N/y/ApdDFDvdAdsTi6M/W6N+SOmLCd5twlY4rfB9Q==
X-Received: by 2002:a63:a508:: with SMTP id n8mr109588547pgf.278.1578350328970;
        Mon, 06 Jan 2020 14:38:48 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v8sm77416353pff.151.2020.01.06.14.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:38:48 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:38:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: st-asc: switch to using devm_gpiod_get()
Message-ID: <20200106223846.GH8314@dtor-ws>
References: <20200104202314.GA13591@dtor-ws>
 <20200106185816.GA597279@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106185816.GA597279@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 07:58:16PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Jan 04, 2020 at 12:23:14PM -0800, Dmitry Torokhov wrote:
> > The node pointer in question is not a child node, but the node assigned
> > to the port device itself, so we should not be using
> > devm_fwnode_get_gpiod_from_child() [that is going away], but standard
> > devm_gpiod_get().
> > 
> > To maintain the previous labeling we use gpiod_set_consumer_name() after
> > we acquire the GPIO.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/tty/serial/st-asc.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> What changed from v1 of this patch?  Please put that below the --- line
> and versino your patches.

I did not add a version or changelog because I believe this is
essentially a different patch, with different justification and
different API that is being used.

The first one was a simple switch to devm_fwnode_gpiod_get(), the new
one is abandoning the use of explicit node reference, and instead uses
standard devm_gpiod_get() to get a GPIO assigned to a device +
gpiod_set_consumer_name() to maintain the naming.

Thanks.

-- 
Dmitry
