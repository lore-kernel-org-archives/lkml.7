Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92084206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=forfun.net header.i=@forfun.net header.b="iG0HjAS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfDYQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:42:57 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43231 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:42:56 -0400
Received: by mail-ed1-f49.google.com with SMTP id j20so452882edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forfun.net; s=google;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kvDSvWg3OSha9ND81YKhiDU37qqwNANYvrLZCvwMqkk=;
        b=iG0HjAS7SQtffUOKn7RtTO6pYCOn5P3fhLXk4wXE1txT1y4FyHFCdTbIyiPLJ+qWpZ
         nawK0ag5ctb31c3JpKI0q9W1qySwiOGyyQ9V8Ag6OyRFa/tMEI23ULMbiV17EtrLvbjL
         8qU/y1q5lNBT8R39dPBplKZWyfIzK1jk+3dVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=kvDSvWg3OSha9ND81YKhiDU37qqwNANYvrLZCvwMqkk=;
        b=FSTvoBoADs43wozzqkLAJjgupfVNL8rCzGMyTvcmZbmM3kynhc4PyuBqPgn4T5EQAN
         l9oaU5goxCaR9Dt/C+QrvxG4O/lz1HS/mVFyDI065yVv82dlH2uzyb5TSAi076C9Tjil
         nsdLKP58nU/WgZCgzRRGVEmGD3BMZkl2/tzqPQH/fx/rBiKerfScRS2m26fXhn6fB4YG
         DrVpS9Sh8SAEsiuCBAsIEoGYxcWWj4JkRGrRY26UYfdSa4/C1BvmLFtMKNs0/lOmiiS3
         EDwgD3LJ+b39MtlxOex+beUyhokJ2MQtUmC7WpxBbNFlLCO85GyQ5hPrmVxwlktVtrN0
         1Rog==
X-Gm-Message-State: APjAAAWCL3GeM1rCKarzzzgyzgcJRcVi5xNkfYHVbovvgAoRVOCAiLwH
        WRjE6T1rTo7VJTIHiN5qepMqUHCcfaU=
X-Google-Smtp-Source: APXvYqyincZyBVFF9k77oWli5UTEiVr8f6cPLWz11cBBGLdJBSza2u72Ok7RPBiyZH7YoQUnv1+XNQ==
X-Received: by 2002:a17:906:c7ce:: with SMTP id dc14mr19420328ejb.143.1556210574292;
        Thu, 25 Apr 2019 09:42:54 -0700 (PDT)
Received: from iMac2.local ([2a02:a212:2680:9c80:9e7:8653:14fc:f14b])
        by smtp.gmail.com with ESMTPSA id r4sm1627634ejl.50.2019.04.25.09.42.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:42:53 -0700 (PDT)
Subject: Re: How to turn off IPv4 without disabling IPv6
To:     linux-kernel@vger.kernel.org
References: <87mukeqqgf.fsf () line ! ungleich ! ch>
From:   Marco Davids <mdavids@forfun.net>
Openpgp: url=https://forfun.net/pgp.php
Autocrypt: addr=mdavids@forfun.net; prefer-encrypt=mutual; keydata=
 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
 A1KUk1EoW34=
Message-ID: <85740792-d244-ba03-3e72-fb576ddcb7dc@forfun.net>
Date:   Thu, 25 Apr 2019 18:42:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87mukeqqgf.fsf () line ! ungleich ! ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op Thu, Apr 25, 2019 at 13:22, Nico Schottelius wrote:
> if I cannot turn off IPv4, I cannot test what needs to be fixed.

You know what? I actually agree with Nico on this.

It's 2019 and the adoption of IPv6 is actually gaining momentum (at last).

This is absolutely the time to seriously start thinking about unbundling 
IP-stacks the kernel, so that IPv4 can be truly disabled at compile time.

That will allow for further testing and fixes, just as Nico suggests.

> You can even fully get rid of ARP. Yes, there will
> be the need for some changes / updates, but all of this can only be
> spotted once IPv4 is turned off.

I couldn't agree more.

-- 
Marco

