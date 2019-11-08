Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C5AFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38EB21D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thAdKuiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfKHHiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 02:38:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36496 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfKHHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 02:38:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id m6so3685747lfl.3;
        Thu, 07 Nov 2019 23:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4AAshBfjoQEiO2K81TTl19q6wDqPj9DyhYRACRdMs3w=;
        b=thAdKuiC0wO/s/dzfd35oK1GLK0UZJV8qIfjuAlCTDFrwax8TpzR2jLJgp7aJEJ32c
         gscAOPI//t5kvDsvDzzD44w78rUcp2aHYnUqH3z8Hv8IF2kkTf1T+6wbTrP9eNil0vwz
         iuI+Sgm4kkmbpBCtGRvFm6XCtm7QRZhmECAk4zqy5mJ00uEojoWdLiITO9VJoUSby15Y
         h9IbKBMSJU2LmpWA5pCNNOL/pYAq8ZHCt1ADi7ay9HVOVXMXqtby2/22vvRz4/U47DHm
         uHhSZ5ucvKkE5MqRD+ZxVdr8KLCOf8AtnPZdXTZGvkSRZrFiykPE164rxEQa9i1pqIxg
         OcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4AAshBfjoQEiO2K81TTl19q6wDqPj9DyhYRACRdMs3w=;
        b=RaNBXCkav3eXzM85ouDSDfZl1DzhzTF4DOHnKBGPQVtdjUBYAIRfth3LAHEyo4gh4S
         oyvOuJVRhoIoprfgDUAUSOJ2C3iyTLt8aopBkjCrVvvM2FnCnZz82QvlZ//233X1SJuw
         coIcf1vczT4v8bL9wyHax4lAI8hxfLF05dK2TX+FP5zuQXxsSpuM9BJghv0XF8eYeKOL
         /mReDgTQL9LrdfmCulIvjsR4tNoIVYtkN7o9f16Z22w/K2jvmEQjkUXa0U47rjAm3pEJ
         5iCSsVJRC5Ew/0Arc14EleLRnHSBFVrfBG5CBtNy7Bj9jn71J6iH35yUBrqbTEuljR4l
         o/Sw==
X-Gm-Message-State: APjAAAUF9ZnxvTnbKUjurxtf/qKmmpIhRQPw8LnXlMz/O/tgSNO0JCuN
        /A7rBohB+zZmIcXPJJTvsi4=
X-Google-Smtp-Source: APXvYqzPdzmBLpJ23sspWX2PodL6cjACgfmwn+Rd10hJoaJ05t9jm3xetETKMt53TFUrI4lpJtCAAw==
X-Received: by 2002:ac2:5195:: with SMTP id u21mr5409224lfi.97.1573198693605;
        Thu, 07 Nov 2019 23:38:13 -0800 (PST)
Received: from gmail.com (c-5eea30e8-74736162.cust.telenor.se. [94.234.48.232])
        by smtp.gmail.com with ESMTPSA id p18sm2376857lfh.24.2019.11.07.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 23:38:13 -0800 (PST)
Date:   Fri, 8 Nov 2019 08:40:56 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Migrate MCP3911 documentation
 to yaml
Message-ID: <20191108074020.GB3844@gmail.com>
References: <20191108072530.3499-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108072530.3499-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 08:25:30AM +0100, Marcus Folkesson wrote:
> Rewrite bindings to use json-schema vocabulary.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Forgot Robs tag from v2

Reviewed-by: Rob Herring <robh@kernel.org>

