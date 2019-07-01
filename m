Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F40C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91729208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIFbBqyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfGAGN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:13:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33034 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfGAGN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:13:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so5494170pgk.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 23:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D1O1X/cTjxSpLefdIwUl4AWn9m/5Z78Sy8Rbpsos6/M=;
        b=iIFbBqyg8V2wneFFrpr2exGWqjbsn3ThWYCBhBhZRZ6ymKyyUZit3oLo0dOOvDCCil
         RjmYVY7tNPApoNx4F61sVAQDeTq6q16CCYyL02sNMSaQweS38H4AqdWd7m3zkbz5lpA6
         KkpiCTYtJKuLOWXsrMDh+B9tdkjIcISwbYhH1Ld+ZH22YTWzHxq+DOfHui/0lJhKU2aL
         ypRIXEE3YVygNHOwWh+mlB/KaiLwE8HTZOLhFbJmNJ1u2uf3QKDzzAeTTpGleyxA662d
         ifjW5GDFUl/BaZNwI88ziq0uUJVcFu4IC/0ZuIl6X0od1ncov7xvnNyUhBrPi2rCu9gN
         FcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D1O1X/cTjxSpLefdIwUl4AWn9m/5Z78Sy8Rbpsos6/M=;
        b=kA24oiCrmXLljMkak8kGPaQQBg0RfTXD3OKkClPOm+IIDv5+hyCoBxqo5ySQJe1A43
         2pF9noJtc/lduFCepjTEP/vQ0A7YhD9NEbq2njon9n3PM7STT4osn6MHUUdcb9UF/532
         swXR6idSTCUM2aop4bY3Jtmalk2cRrBagpFC8WWBgY200bET5Q9J6FDL+VpdVYETcPkK
         lo4iWBdfaS3+2/qYZscZ6Yjc83CG5uyzRc2ikTsOp0eUrqvzyfKc8QEALeL6lW2u6i9V
         K0cmm3G4FkuFQ0ZD6rRxvDkMDI1k4tVWyjlh/IBmFPhY4+yuxcwsuqlcHFue9oAN41tS
         uDLA==
X-Gm-Message-State: APjAAAUUd4p2lEpc7F3Qs9Z+ZpQPZJ9EHFPhAEkCw9f+r+0LNJsiSYoZ
        66UngLH/b0mLHqj90Am2DId1jw==
X-Google-Smtp-Source: APXvYqw7HLuQ5++wNVoa6Twp44LTfQ9finOPfEkCayL9iiS7L7GZKdW++Q+goB1qmibmWMRR81zVVw==
X-Received: by 2002:a63:e40a:: with SMTP id a10mr22792178pgi.277.1561961636948;
        Sun, 30 Jun 2019 23:13:56 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c10sm8513453pjq.14.2019.06.30.23.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2019 23:13:55 -0700 (PDT)
Date:   Sun, 30 Jun 2019 23:13:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Xiang Xiao <xiaoxiang781216@gmail.com>, ohad@wizery.com,
        wendy.liang@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH 0/3] Enhance virtio rpmsg bus driver buffer allocation
Message-ID: <20190701061353.GE1263@builder>
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190605043452.GI22737@tuxbook-pro>
 <2d60dd1e-f7a0-ea63-9fda-0ea97aab0406@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d60dd1e-f7a0-ea63-9fda-0ea97aab0406@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Jun 00:33 PDT 2019, Arnaud Pouliquen wrote:

> Hi Bjorn,
> 
> On 6/5/19 6:34 AM, Bjorn Andersson wrote:
> > On Thu 31 Jan 07:41 PST 2019, Xiang Xiao wrote:
> > 
> >> Hi,
> >> This series enhance the buffer allocation by:
> >> 1.Support the different buffer number in rx/tx direction
> >> 2.Get the individual rx/tx buffer size from config space
> >>
> >> Here is the related OpenAMP change:
> >> https://github.com/OpenAMP/open-amp/pull/155
> >>
> > 
> > This looks pretty reasonable, but can you confirm that it's possible to
> > use new firmware with an old Linux kernel when introducing this?
> > 
> > 
> > But ever since we discussed Loic's similar proposal earlier I've been
> > questioning if the fixed buffer size isn't just an artifact of how we
> > preallocate our buffers. The virtqueue seems to support arbitrary sizes
> > of buffers and I see that the receive function in OpenAMP has been fixed
> > to put back the buffer of the size that was received, rather than 512
> > bytes. So it seems like Linux would be able to send whatever size
> > messages to OpenAMP it would handle it.
> > 
> > The question is if we could do the same in the other direction, perhaps
> > by letting the OpenAMP side do it's message allocation when it's
> > sending, rather than Linux pushing inbufs to be filled by the remote.
> 
> IMHO, both could be useful and could be not correlated.
> On-the fly buffer allocation seems more efficient but needs an
> allocator.This can be a generic allocator (with a va to da) for system
> where large amount of memories are accessible from both side.
> 
> Now what about system with small shared memory? In this case you have to
> deal with a limited/optimized memory chunk. To avoid memory
> fragmentation the allocator should have a pre-reserved buffers pool(so
> similar to existing implementation). This serie seems useful to optimize
> the size of the pre-reserved pool.
> 

Having an implementation that uses small fixed size buffers seems very
reasonable and I'm in favour of making the message size configurable.

I would however prefer to have this implemented in a way where the
remote side should not be receiving messages in a way that's based on
the remote side's allocation parameters.


I don't think this series prevents the introduction of such isolation,
but it would render this code unnecessary.

Regards,
Bjorn
