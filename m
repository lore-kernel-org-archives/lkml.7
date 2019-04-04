Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9B3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ED620855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn6g/exY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfDDT4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:56:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42846 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:56:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id 103so3497399otd.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c/A5eqw6yK50rkMqQZj0f5rzX42DjVihBEh/+r4Pt9U=;
        b=dn6g/exYvuaO7XVehkz3CI55p8Ns9EU3gRKt2uJut1kv1GtrEEm+8uf2XtTlVnaJkO
         2sDziMX/xi3i6IeYAGtpvHJwydXjENZK3J3z7FT5NtA/4NGxnLRm0PNRNOccVwUKCyWG
         A9sd2GJknATAt1SA0XY0MVaiRgEPoyzM/qfz045wvRldzE+EV5wU088GmThk5OMfNcMy
         rcG6q7IIH49u9R7FTz2pSlBamWJ4dac1oX1TF6znIW0oKc+cYuC3OdqqYPE/piambtWg
         LLg214TYih7q4a7/gZDLjl1PRaZ+I5VhgwAQ88DRSh1ihMZ2diKPvW4+0dvqeMlYEutV
         4GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c/A5eqw6yK50rkMqQZj0f5rzX42DjVihBEh/+r4Pt9U=;
        b=Ad5X9yCZ3CnDnnGzgS7rowvfXSiczfXeJ5ffztNgs6squKsLVCDXRqhODT9XG9qtSl
         3BBxL49Da/gUW35WNPI50lD+9fijSjqWmqmdP1kui+g2vYpuw3TnuP3XNbYvour2fsQ5
         ZqFCMZsyLUW5ngW0BAk+Ka/zdxlyzBZFBBF9Tpz1JTg/BaHXTaxd3RdViDdCWrQpMTwD
         Um8y5+Tu1f2KLk2TJqU1Pf7E+mjDIqzqnM8C2rNWKJaJ4J8Qa3sIu6EuoctwQeY/FSIh
         D88aKyGzujRdUrNNpd6HoeED8I1FuBzM6Y6TUozgMZaFgxaBO6MWZ6c/ScEKjwcpm8lW
         KZAw==
X-Gm-Message-State: APjAAAXF5Ggr8Rbhj9Uy1q8EgYMpV0MSOfffT22Nr7F69wqtvHEe/Xjf
        Kcr9J1TTYYIbmts4mGczvlyhVGhJbnA=
X-Google-Smtp-Source: APXvYqzYDJUUwZdmaQNeWwJ3oWnxqmpj5z8zSCNG5x4eHn0CQ6Dj4ddtnaB/49a3p2PXnJ5Rb9VnZw==
X-Received: by 2002:a05:6830:2094:: with SMTP id y20mr5418720otq.316.1554407797709;
        Thu, 04 Apr 2019 12:56:37 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:7549:4e85:9095:b601])
        by smtp.gmail.com with ESMTPSA id y9sm7648653otk.20.2019.04.04.12.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 12:56:37 -0700 (PDT)
Date:   Thu, 4 Apr 2019 14:56:35 -0500
From:   Madhumthia Prabakaran <madhumithabiw@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: rtlwifi: Remove unwanted parentheses
Message-ID: <20190404195633.GA7215@madhuleo>
References: <20190403223851.22524-1-madhumithabiw@gmail.com>
 <20190404090900.GH32590@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404090900.GH32590@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:09:00PM +0300, Dan Carpenter wrote:
> You should probably update the subject line because now it's not just
> about parentheses any more.
> 
> [PATCH v2] Staging: rtlwifi: clean up crc16_ccitt()
> 
> So the one thing per patch rule is a little bit about selling your
> patch.  We never allow "Clean up whole_file.c" but we do sometimes allow
> "Clean up a function()" so long as the patch description sells it in
> the right way.
> 
> Blah blah function does "BIT(0) << i" instead of "BIT(i)".  Using !!
> is slightly shorter than "foo ? 1 : 0".  Blah blah, etc.


Thanks for feedback!

> 
> On Wed, Apr 03, 2019 at 05:38:51PM -0500, Madhumitha Prabakaran wrote:
> > @@ -351,13 +351,13 @@ static u16 crc16_ccitt(u8 data, u16 crc)
> >  		else
> >  			result |= BIT(0);
> >  
> > -		crc_bit11 = ((crc & BIT(11)) ? 1 : 0) ^ shift_in;
> > +		crc_bit11 = !!(crc & BIT(11)) ^ shift_in;
> >  		if (crc_bit11 == 0)
> >  			result &= (~BIT(12));
>                                   ^        ^
> I thought your Coccinelle script was going to complain about these
> parentheses.  Probably the &= confuses it?  There are a couple others
> in the same function.

I didn't included assignment operators in the earlier Coccinelle script. However, I
edited it now.

> 
> regards,
> dan carpenter
