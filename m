Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA15C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BCB2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY6jwcur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCWTVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:21:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35951 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCWTVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:21:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so5848864wrd.3;
        Sat, 23 Mar 2019 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IcgLdpf4tNCDojIxjG9Givs8tB752LrlIC6UfjUDeM8=;
        b=hY6jwcurxlZlQVcdbYVkgio11R8hqbd1kue/Y2UQwNVmqsW339zHdqItFXWIox14XF
         rd3zwvHVJSzKekowK1Oj6NJRB/8tIASYWeI0peC8oVLD6O2g4M0bypngbz9yHzI+fMDF
         Re5JnrCStDxjY1o/XJi6nRKvCY3VgZWryf95ykoT8Z2gjNZTR+izq5BV7KYqGSvtYMCg
         qCh4suiI1AxnNWNJ3RPz5EeHwjGQ3Ek3dgOVCa187R/ZmOKUgvwYq4ig5R2/f5aNiCCm
         lPhkGl59ndHE2K6Mix9xmZc4ncexhE7ZEHILcHev6RRyHrrSWTqKXKJWTWBZiJRI+xMk
         koJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IcgLdpf4tNCDojIxjG9Givs8tB752LrlIC6UfjUDeM8=;
        b=I+LiXXpM2RCwHq8sukeTR++en7ITA7A7WAqXB5EVJ6PZDtU5huKfL4JBp81vHQ68HL
         Cicp57G1EJo/VPtWS/wXzo4uN4Z0idQJwzO5kXE5J6KphTzcsdH7DG5cAGj5lXOchYDb
         ykPX2ANJhC44w3ur6QwFmuX0iKJMqiy6kNuTTzWNSb5btA8A4OMLVbdtSY3+ccvSj94W
         UC059NyVRpBAoXMlK13MSefsRHvwOYsubJ+FPZMi7fdn4ysez2tSpp0b3TZKN4HiF7Mx
         xVr5LWYGfeR9TjaiNOG8vr0+TOBfL28D0FZ8XkxzkWAl1c1lwCZvFYkry3ZwjzQkrc5r
         dWdA==
X-Gm-Message-State: APjAAAXLfqXV45B5uzh14OI6mYNCjFmGj0Tc2Q3QS1QI9EEVnnQ9G7PK
        2oMjCle5vZq9HeOXaZekJ5M=
X-Google-Smtp-Source: APXvYqyd7KXYcc+BMFCvG+/oc33d9CTOCu58hbr3Adhoj1Ut5Y5LzI2IMRN5i206CZ8cYgrWJe0GuQ==
X-Received: by 2002:adf:81c7:: with SMTP id 65mr494946wra.84.1553368894576;
        Sat, 23 Mar 2019 12:21:34 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id q2sm17764948wrd.46.2019.03.23.12.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 12:21:33 -0700 (PDT)
Date:   Sat, 23 Mar 2019 20:21:32 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] staging: iio: adc: Code refactoring and bool to
 bitfield change
Message-ID: <cover.1553366098.git.sicilia.cristian@gmail.com>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553335775.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some source refactoring, parameters alignment and camel case clearing.

Replacement of bool to bitfield in a struct, but not found
the population to check if it is done correctly.

Cristian Sicilia (5):
  staging: iio: adc: Tab alignment
  staging: iio: adc: Converted bool to bitfield format
  staging: iio: adc: Avoid precedence issues in macro
  staging: iio: adc: Adding temp var to improve readability
  staging: iio: adc: Remove CamelCase notation

 drivers/staging/iio/adc/ad7192.h  |  16 +++---
 drivers/staging/iio/adc/ad7280a.c | 109 ++++++++++++++++++--------------------
 2 files changed, 60 insertions(+), 65 deletions(-)

-- 
2.7.4

