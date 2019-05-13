Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13295C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB23720879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sa5hTJoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfEMXku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:40:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35901 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMXku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:40:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so8048125pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 16:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=J8kVwdfKryVwhVTqGuXeaVb2n8/8oNSbahQ/YtWP1xI=;
        b=sa5hTJoEG20bTMXXVU6g1aEoSJCap4+nQDLEavj4IVB0Q0WvFwch1WnSeHVzCeOf+6
         NozdunUylZsJGkfbUevW1O5aRpxemgsu+Cqap9XkehWY73/n/SPIStbxuSlubLpk9jO8
         EdTkhBdYfxzPwyCGLxp2WbiGrvxaRjzX4/otJYQd5sWrbLfmRbKm2YU867GS5Dd/D4wL
         sEP7BY3gwMRxi4fSJYa94KNLcP7twzqhYFbbRVeIS9dTm0jHaiLBh/MT3Yl0gpPfxKJf
         HYYblv/KEjMtWT0fDBkwACZ8qic4unhuM16gzLYZvPBFkhWVRoY/Gu6KOnbpTQz2XUao
         VVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=J8kVwdfKryVwhVTqGuXeaVb2n8/8oNSbahQ/YtWP1xI=;
        b=OzLjvNLjSpjBEWL1yOOBmSndADvwFNIodhelRN2rZsbCfjd+t+t5oi7ZJQ2EBxYzi3
         iuL9lEozjB251jDvsjvXGEonMxQRR3ogcT3QWA9pLASvNjYsVKmMk/49gRxXVvwRrK0z
         IyfYDkT4I3q4AQyEM+aJFG0hj4wkXMNo8XOFjtqVAz1//3YA/xHRWajEJ1qOpODbTO7R
         g+zJDTvLS2RRYCNWlCiKVVaMXdo3WzeJdXMAJakymvvIN13fIe16aVghfK47KLjtpIGa
         ja5K6784423T5zknGtTNE1gGM+FEvgTWvHavTeajdGTU5MjR3QMeRfU6NVFn19h3qvpW
         nVuA==
X-Gm-Message-State: APjAAAWBONae5pbg3F7SwX+Hk5tte2oe2uwVMLj/Tc4jvPN3PRrikfu7
        3iTmR6DzE1Gd8zo+z0ur9J22YshOB//f1w==
X-Google-Smtp-Source: APXvYqxJza/f7WkrQm4MQNmOM8P+Yp7+nyNFIKDtT5FejuIGuzHjEwFK6tl1nzjsKXvMKfPowpL0mg==
X-Received: by 2002:a65:5682:: with SMTP id v2mr34932877pgs.100.1557790849488;
        Mon, 13 May 2019 16:40:49 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id e14sm12696269pff.60.2019.05.13.16.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 16:40:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: meson: sei510: consistently order nodes
In-Reply-To: <b81b46f1-5e8f-26e8-399f-3baca8336e50@baylibre.com>
References: <20190510155327.5759-1-jbrunet@baylibre.com> <20190510155327.5759-2-jbrunet@baylibre.com> <7h4l62dlyh.fsf@baylibre.com> <3bad9dc8c53e50c4aea1212bf949215660259412.camel@baylibre.com> <b81b46f1-5e8f-26e8-399f-3baca8336e50@baylibre.com>
Date:   Mon, 13 May 2019 16:40:47 -0700
Message-ID: <7hef51c48w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 11/05/2019 17:52, Jerome Brunet wrote:
>> On Fri, 2019-05-10 at 14:43 -0700, Kevin Hilman wrote:
>>> minor nit: I kind of like "aliases" and "chosen" at the top since they
>>> are kind of special nodes, but honestly, I can't think of a really good
>>> reason other than personal preference, so keeping things sorted as
>>> you've done here is probably better.
>>>
>> 
>> You thought the same, then thought maybe memory was important too. But going
>> down that path, you end up sorting by feeling. It is going to be difficult
>> to all agree on which nodes are special.
>> 
>> In the end, we just want/need something that is easy to respect and verify.
>
> I think it would be better to have the same layout for aliases and memory over
> all the amlogic DTS, it's common over all socs to have these nodes on top.

aliases, chosen, memory and reserved-memory are ones that are typically
on the top for convience sake, but looking around we have not been
terribly consistent there either.

At this point, to continue the tradition, I'm not going to be too picky
about enforcing "standards" that are loosely defined (or undefined) and
will generally accept cleanups that are moving us towards consistency
and ease of rebasing.

Kevin
