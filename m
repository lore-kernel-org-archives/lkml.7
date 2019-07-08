Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AB0C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8184F216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="g4XD/1ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404954AbfGHUVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:21:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39390 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGHUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:21:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so17243574ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ryt0cZPm5+/IznGSSDvtmucCW76NK93kkjZBDBiSaU0=;
        b=g4XD/1ZCBPdBw3MXPRXdyCJWvsrzTaIUe6jPY4axcAEQWJc/15BcXBNxDYRFvpd2JW
         8scl6PQh/JhxMhyJIcBt5+WwtCxICN5NktW76UrgZP4y0COZQzsqjaeUM0RzV4f57MPm
         Z5LRsjsbIqdRu0JFi1MZSeMAjQl9+BeL1XobQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ryt0cZPm5+/IznGSSDvtmucCW76NK93kkjZBDBiSaU0=;
        b=M4FZrpOs/OR78rHI2Fdg+3y4H3E60Z+HtMtbwOqeswfd8QqTn0KDA/C3qC96scXXT9
         OF6bzGBKK0SLMboEVB0qWu7h2LN86gMvhVePkpReomoH5oqPJ0WFhWmwojs9pYh+zwgz
         1UZGNEIL/PwTRfbe8IRb9CovzLQS+FiqCt4iNK1rBe/DiG21QkmJB30XFi8I14INFg9Q
         LfKAgsPJqnoTePrNtxls0DeSK7+SMJ4TJb85Vv43Op6bDEgRAKW2qF9j6qq2tmr0XX9c
         rfUXcpGLtxXjM+T5PQIv5eK5UIZBOghGC8indHSVqDCL3yZu2aKN+SLQCBmyKVPbpJJk
         YJCg==
X-Gm-Message-State: APjAAAW3nj4+2+fx2w/FosiJBwIjORh+sOMAd0bnzhjldTYm8cErWEub
        jFWJ4T59FgqPcGa2TzGHoCm+x+tTKIxAyNO8
X-Google-Smtp-Source: APXvYqxyeekyU2hfvc4ui92LSo7VMCed5IvscKuBWkBE75dmui02gIGzS6x4JiYAHFe9IbcMW4WewA==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr11599096ljg.134.1562617312886;
        Mon, 08 Jul 2019 13:21:52 -0700 (PDT)
Received: from luke-XPS-13 (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id y5sm3834659ljj.5.2019.07.08.13.21.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 13:21:52 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:21:50 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [PATCH 3.16 000/129] 3.16.70-rc1 review
Message-ID: <20190708202150.GB13296@luke-XPS-13>
References: <lsq.1562518456.876074874@decadent.org.uk>
 <20190708130511.GA4626@luke-XPS-13>
 <85820ecbcc368f992eb061481c388bb2ebb8ad65.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85820ecbcc368f992eb061481c388bb2ebb8ad65.camel@decadent.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:29:22PM +0100, Ben Hutchings wrote:
> On Mon, 2019-07-08 at 06:05 -0700, Luke Nowakowski-Krijger wrote:
> > Hello, 
> > 
> > I got 1 error when applying this patch series to the latest linux-3.16.y
> > stable branch
> > 
> > fs/fuse/file.c:218:3: error: implicit declaration of function ‘stream_open’
> 
> It is added by the previous patch and declared in <linux/fs.h>. 
> fs/fuse/file.c always includes that (via fs/fuse/fuse_i.h), so I don't
> see how this error can happen.
> 
> Ben.
>

I was actually in another src tree. My mistake.

Rebuilding it off of your tree, I get no compilation errors and it
boots on my x86_64 machine. 

> -- 
> Ben Hutchings
> Time is nature's way of making sure that
> everything doesn't happen at once.
> 
> 

Also this is a good thing to remember. 

Thanks, 
- Luke

