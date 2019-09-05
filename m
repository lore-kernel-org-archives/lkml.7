Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96804C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C7620870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzUPwQmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbfIEPps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:45:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33989 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732169AbfIEPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:45:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so1513786plr.1;
        Thu, 05 Sep 2019 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xq7PaIvlw1cq6VwhN/gvh/Nn++emmClwqvlixNp8Y2o=;
        b=hzUPwQmN7EORi+VGDVDqL+5++GqrSKsuzNCFA7v95mNrCz/fUvKiXTkwKPOkCSiEKK
         d5pQZE/2Hk6lcvVpOtmniPr/+FDVtd1HxBpwXYuFCZdKUdfipEP2TsEso0DBkA743Cuf
         Gxv8CUiyexyy1nRkQ1Crad6mNaZ0iDIdKhnto86P8AIL+6m+OBDyyUf7LeVhugKNreii
         Y5DrLGfNHw5QYQq3GoJ0CER6Bb46C7xnnd+yzDksE4oCTwNua0cqPThzE6dAv9JHSm5j
         3D6jo+QrI0ExZ1mXMuNVNwwcrK1J4t+77FHmgU3tjiVUCiq/XKGvBVrKKD746fiFvwIk
         FDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xq7PaIvlw1cq6VwhN/gvh/Nn++emmClwqvlixNp8Y2o=;
        b=XirGndUlQ/bww5mBvCqG/DtojCPN4OEAx6Zg3D/gpX/4a0cXs5VTGb0hnAW2nLfX5u
         aHafjsF0TD0AOF9yd54jw1trbW+r0WOpxxN+xYz41iSuKdOcqOiJqYLMqP8KwOJgomUg
         fpQ6D0//etLL81W8fTVlUNIkiXJJ22gK54pXVPTpnLMtCu6cFdbMQF5IZdx0+tmpa58N
         pTyyu2Sf0ImJkCJzoyZAORBIPtGC6rdwHa2UHj+3lorlrJ/8ZrFiJfu1HL0gQsO3Z3EU
         Mybmisgoj7ancEXaxM1zbDkewhns0npHrULnDk1HYJyNrv80HpQOaodO+pkVAVBNZae6
         FVeg==
X-Gm-Message-State: APjAAAUTajdlGc7UzM9BgX38sYTVYk7aNDgFyZDActE9DsF2C8NBO01j
        8hmVEg0HxV1C2gkpEOhywVY=
X-Google-Smtp-Source: APXvYqzTpFQc65RCjYdk+Yw52dpVNUXIwNxnnk+gHNOU9tJx5Ze32YdHV5zp4mVb9hPbFYEh9A4cAg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr4261599plp.100.1567698347210;
        Thu, 05 Sep 2019 08:45:47 -0700 (PDT)
Received: from SD ([106.222.7.143])
        by smtp.gmail.com with ESMTPSA id f27sm2357999pgm.60.2019.09.05.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 08:45:46 -0700 (PDT)
Date:   Thu, 5 Sep 2019 21:15:36 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     peda@axentia.se, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: muxes: pca9541: use BIT() macro
Message-ID: <20190905154448.GA3378@SD>
References: <20190905131318.GA21280@SD.eic.com>
 <1d248333-abe9-cff8-ad29-d3b618643dc6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d248333-abe9-cff8-ad29-d3b618643dc6@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 06:21:06AM -0700, Guenter Roeck wrote:
> linux/bitops.h should be included when using BIT().

It's included from linux/i2c-mux.h and it compiled successfully.
But if it's needed I'll update the patch and resend.

Just a question - What is the best practice in such case? Should the 
header included explicitly?

-Saiyam
