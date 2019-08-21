Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6893EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3809022DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2AQ6w2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfHUEYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 00:24:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41661 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfHUEYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:24:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so595511pls.8;
        Tue, 20 Aug 2019 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MUy6WQ1xoK9lJfNLjEvn57XDcafYhRNiEwXA8Tk63hA=;
        b=o2AQ6w2hzvdylDkGbQ4pDyR/cuDlx1jU8ZUDk2Y2Y6xVqKPYirpYBYgwTS5XthsdXc
         wdykV+BK5LfYKk1+OcVw01Vj1p4R4d1vRi1drzxMFYAgRizN/3FaGChOgfdKQ5Aw57oj
         UphcE3ekxjyf5jsUaGiMNCQbWgJ9yW4OZET6xG4iFztVrbtUTHsEQNDxeZUrB2ovsJO2
         Aqa4LB5Zou+iZfc+whmnfTo9esmCvam+UGqwGe1Mm9V5nK4PKpLsXfJUkYQ/FBvGYOLs
         O16YaYhAcXv2HMdaohN61cf+oQzoYygjXa48Ce8GetAMW/DO9WMfSsx0ED7L/kb3JDGG
         gPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MUy6WQ1xoK9lJfNLjEvn57XDcafYhRNiEwXA8Tk63hA=;
        b=PHG7t5dat4SdP34WcyegYl6wUKqxrd3ldN5yku4iQz17wNZD3WZyFFEGJIRnLmWhJC
         Q9D0QnJcf2CAFie5SUYALD4J48U9OyfsdGWzP2EwLZtuIGBPyjP+eYgpq0Rkb/1NCTN5
         VlWZhRskb+FyVrFH64j5paLL5ynV2MeXXOVSJtgI4jmKh4gIoWUQ0+TPrAzKF/U6eyDO
         sF8GbdercgT0flLLge44jDZBUNJSj4FmrVRTm32J+/nfhKH5JBZ6FuWXozKIqLsBU2SR
         pKynGKEt9FICsUkZJ1y0pOQWpfqaX7X1RZLYjKrlea0+ChkE5vrIOAZn2wCpdAlIpqGy
         ewtA==
X-Gm-Message-State: APjAAAX1Siel14G8ijD1nJzGux2ZhFX1ErKHmOs8FsOzcDT/hXY8l4ib
        TAO2aU2wKJ2r9w/qlNSQkpw=
X-Google-Smtp-Source: APXvYqwai5cAkqOIhGquS4Yv9DULTJ6E8oyvFg/ISEE/lFGOD3GAK991WB57QFuu2WTF1SFRr0ba5g==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr28533828plp.17.1566361454421;
        Tue, 20 Aug 2019 21:24:14 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-137-176-042.mycingular.net. [166.137.176.42])
        by smtp.gmail.com with ESMTPSA id g2sm39866695pfq.88.2019.08.20.21.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 21:24:13 -0700 (PDT)
Subject: Re: [PATCH v7 1/7] driver core: Add support for linking devices
 during device addition
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-2-saravanak@google.com>
 <32a8abd2-b6a4-67df-eee9-0f006310e81e@gmail.com>
 <CAGETcx8Q27+Jnz+rHtt33muMV6U+S3cmKh02Ok_Ds_ZzfBqhrg@mail.gmail.com>
 <522e8375-5070-f579-6509-3e44fe66768e@gmail.com>
 <CAGETcx-9Bera+nU-3=ZNpHqdqKxO0TmNuVUsCMQ-yDm1VXn5zA@mail.gmail.com>
 <a4c139c1-c9d1-3e5a-f47f-cd790b42da1f@gmail.com>
 <CAGETcx-J7+d3pcArMZvO5zQbUhAhRW+1=FUf7C1fV9-QhkckBw@mail.gmail.com>
 <6028b35b-a4ca-18de-84c6-4a22dbd987c9@gmail.com>
 <20190821015647.GA12237@kroah.com>
 <CAGETcx8eVfJ0mn08E6pTDytjVE+RFcj_gOt_enide4E6G1NAWw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <113e6881-4c47-58fb-13fc-181e792818e5@gmail.com>
Date:   Tue, 20 Aug 2019 21:24:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx8eVfJ0mn08E6pTDytjVE+RFcj_gOt_enide4E6G1NAWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 7:01 PM, Saravana Kannan wrote:
> 
> 
> On Tue, Aug 20, 2019, 6:56 PM Greg Kroah-Hartman <gregkh@linuxfoundation.org <mailto:gregkh@linuxfoundation.org>> wrote:
> 
>     On Tue, Aug 20, 2019 at 06:06:55PM -0700, Frank Rowand wrote:
>     > On 8/20/19 3:10 PM, Saravana Kannan wrote:
>     > > On Mon, Aug 19, 2019 at 9:25 PM Frank Rowand <frowand.list@gmail.com <mailto:frowand.list@gmail.com>> wrote:
>     > >>
>     > >> On 8/19/19 5:00 PM, Saravana Kannan wrote:
>     > >>> On Sun, Aug 18, 2019 at 8:38 PM Frank Rowand <frowand.list@gmail.com <mailto:frowand.list@gmail.com>> wrote:
>     > >>>>
>     > >>>> On 8/15/19 6:50 PM, Saravana Kannan wrote:
>     > >>>>> On Wed, Aug 7, 2019 at 7:04 PM Frank Rowand <frowand.list@gmail.com <mailto:frowand.list@gmail.com>> wrote:
>     > >>>>>>
>     > >>>>>>> Date: Tue, 23 Jul 2019 17:10:54 -0700
>     > >>>>>>> Subject: [PATCH v7 1/7] driver core: Add support for linking devices during
>     > >>>>>>>  device addition
>     > >>>>>>> From: Saravana Kannan <saravanak@google.com <mailto:saravanak@google.com>>
> 
>     This is a "fun" thread :(
> 
>     You two should get together in person this week and talk.  I think you
>     both will be at ELC, can we do this tomorrow or Thursday so we can hash
>     it out in a way that doesn't end up talking past each other, like I feel
>     is happening here right now?
> 
> 
> That would be great. Wednesday would be better for me. I might not make it to ELC on Thursday. Let us know Frank.
> 
> Thanks,
> Saravana

I am really glad that you are here at ELC.  It should be very productive to
sit down together and figure some things out.

I'll send a separate reply with my phone number off list.

-Frank
