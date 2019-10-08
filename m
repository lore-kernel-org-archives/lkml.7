Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD112070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570547436;
	bh=ZwNYdJEcqdnycNPUhUKzVR7Mj81YHnVJ+qnDhlhWJbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UVy6QNBBn2Xjl68sBy9k5WNhOAxomi4tHtjQfBJpYxZQx4JRAkABOvj2YkdsDXg4z
	 tmkG7B2zaO3TQZBSmi6+4sTT9mqnL4IQlt8kmxUbcW5XBNq6CtpZiuJV7IkO7UxQAT
	 FJ9arbTWKYa4typMhzpA9Si/d/rsJpxcVBkisp0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfJHPKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:10:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36468 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJHPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:10:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so19868009wrd.3;
        Tue, 08 Oct 2019 08:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDr1BzlICCTlwhp3uNGJEPl314YzfcfD31Fib2fRNSo=;
        b=fxrRLXHiFr9wcrSrK69zhEYSFeedRkodUXLrs8Mdsd9rpVEY2kgpk2ejmAw/e7rmgt
         xptxfzSJ3cnZ+qQRsGc16l/NOy8dx2N5/tLvFAGCOqEUZ3ApVRgxixCZlTJ4//jj/UPf
         LsKWfifF/8HrsB9OYukj+kJWFLNO27319nuP1QtlmAFs4C1/UFWKsKNShl4AFgtjHfc6
         +kIK9YxqwjqsCHihiUKi+KL88Goqkljx/Urh0UbFQvoRisHpnqj+uDys63LST1/ah9F4
         XUZVEdBXDAuytgkq14CvU9nikhppnqLv1oodvsk9oFMJTZyxGWBcSa3s+5UU7xI5EKcY
         W2LA==
X-Gm-Message-State: APjAAAWKgsBa4WPakrimhevEwSuh0IMCRgT+U7XUNeu6Qec40HqWm6aK
        UPS1jVyDrRw2Ckbqec+Xa8QfimiI
X-Google-Smtp-Source: APXvYqzX4ka2psn6HEE8SlAx19V028jaUxy26b9V7r9ws/He1WJtNpQAY+Uuwiz4uo5g6s4xsd7i9w==
X-Received: by 2002:adf:ecc1:: with SMTP id s1mr19736353wro.223.1570547431457;
        Tue, 08 Oct 2019 08:10:31 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id 90sm26487496wrr.1.2019.10.08.08.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:10:30 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:10:28 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
Message-ID: <20191008151028.GA2720@pi3>
References: <20191004151414.8458-1-krzk@kernel.org>
 <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
 <20191008125038.GA2550@pi3>
 <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
 <CAL_JsqKBzZCShxx99aB4z15XYNbUionVicmfNNXEfq=iohWLCA@mail.gmail.com>
 <20191008142900.GA2635@pi3>
 <CAL_Jsq+ObMD=inkMFqkZbKFoKZUxw53gUMnjsC1pU5GwumK8LQ@mail.gmail.com>
 <20191008150456.GA2683@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008150456.GA2683@pi3>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:04:56PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 08, 2019 at 09:38:15AM -0500, Rob Herring wrote:
> > Are you running using DT_SCHEMA_FILES? If so, you won't get the core schema.
> 
> Ah, yes, now I see proper errors. Thanks for pointing this.
> 
> I'll send next version of this patch only (if others are ok).
> 

Of course, there will be no v2, this patch can be just skipped.

Best regards,
Krzysztof

