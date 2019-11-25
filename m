Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0523DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 02:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACFA2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 02:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BqbheMcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKYCs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:48:57 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43552 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfKYCs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 21:48:57 -0500
Received: by mail-io1-f66.google.com with SMTP id p12so7132349iog.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JfC2mJ/tM0Gtil8eGoDF2rqsQ/Szyy5PK2H9MiBjWaY=;
        b=BqbheMcM+/+8L5FUajWmcRC1Jt2EFb2gJwq13R2AdKWr4u92cpi/Qku/FU9A2Eu+bw
         ynY6/cjU7Rtcg/TUulvsuyxfJbeMQqKE1Bx0d7bCGvwzC63FW/yS2hxaeTiWMC9Jp2uG
         vRibYDUPgmnMbpZYvsxjswCE6r9A/t7AaQPMd6/EzO+s01YSFOmtqZTeGwp1lgVm3eze
         y4DKreOlFHLvcUqPFKdhUhm4W51onBLMZZ1FAIwmxhjItpmYJcYkwxB7IFMbDBVSFV4x
         Eq8vviYfv3npRjVahtOivSpmld1ch/YnzuGoNXuN7vLSX7IIiNcR7DRQrKJ8lN3coW9m
         T7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JfC2mJ/tM0Gtil8eGoDF2rqsQ/Szyy5PK2H9MiBjWaY=;
        b=YpRDFyJjyhV39EwHdmL8zC1UwQJQnVwqLz+3k2bk5V+A+k6Dg0jmIJDgFWo0v8Y4ip
         HWM9WKLeMmuROa8mAoLEGZyXTOhBWOGlTzuH28R1qJCoy56OoRtJQu5LArc/cynS9l8B
         w4n0x1tq/+DNyS+IZBJQqwa9hkWbGKOmjtcAT22m2dK8Wdrscjd+eANA/fIDTH8veybs
         MCy1mopiBkOY3Su0ceLEZ8oU94a2oQYKNqon1f7aJA+mAWx7QuF8Hs+iAFJDpN1lP2Q8
         BLP713PJHF35XUSnYARWnglPYQlAuaBK+VYF//mcgpWhpeG3qjoLGRkbamUOG8Mxw8+S
         02ZQ==
X-Gm-Message-State: APjAAAULeI/LWvkpD/DgnytKHMwiXXKKMnpAnEixwmLba3nIaDQiGM43
        8t3R58XJJ379Booxh8Zm1RAoiA==
X-Google-Smtp-Source: APXvYqxgFYzEUsZQS6ILtiWRgw3rG7t6lwifkA15Te4VPLhoWxbBdRnWhS7ZYmL1Y/h4E9NFkL+lqw==
X-Received: by 2002:a02:aa0c:: with SMTP id r12mr26180623jam.75.1574650136249;
        Sun, 24 Nov 2019 18:48:56 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id w2sm1790189ilg.51.2019.11.24.18.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 18:48:55 -0800 (PST)
Date:   Sun, 24 Nov 2019 18:48:54 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
In-Reply-To: <CAPcyv4iqTR8s0v8jH7haWCBQAzhZinUEsypiH7Ts9FCf+F9Bvg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1911241841210.22625@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com> <20191123092552.1438bc95@lwn.net> <alpine.DEB.2.21.9999.1911231523390.14532@viisi.sifive.com> <CAPcyv4hmagCVLCTYmmv0U8-YD5BEoQPV=wtm5hbp3MxqwZRQUA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1911231546450.14532@viisi.sifive.com> <CAPcyv4hBNfabaZmKs0XF+UT9Py8zJqpNdu5KsToqp305NASKNA@mail.gmail.com> <alpine.DEB.2.21.9999.1911231637510.14532@viisi.sifive.com>
 <CAPcyv4iqTR8s0v8jH7haWCBQAzhZinUEsypiH7Ts9FCf+F9Bvg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2019, Dan Williams wrote:

> I'm open to updating the headers to make a section heading that
> matches what you're trying to convey, however that header definition
> should be globally agreed upon. I don't want the document that tries
> to clarify per-subsystem behaviours itself to have per-subsystem
> permutations. I think we, subsystem maintainers, at least need to be
> able to agree on the topics we disagree on.

Unless you're planning to, say, follow up with some kind of automated 
process working across all of the profile documents in such a way that it 
would make technical sense for the different sections to be standardized, 
I personally don't see any need at all for profile document 
standardization.  As far as I can tell, these documents are meant for 
humans, rather than computers, to read.  And in the absence of a strong 
technical rationale to limit how maintainers express themselves here, I 
don't think it's justified.


- Paul
