Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53410C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC9B25EDD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="V8J8o0JH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE3R6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:58:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40618 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfE3R6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:58:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so4431807pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UdtCpjjQ91i6JdeO1o6cmQH2Jj5NVts/neyKdRuf9u0=;
        b=V8J8o0JH07x2wsBm99n7DGytzSCB9uQ7i73/R7tiHi2EW+jlFvc9gPYtl/fH4Vtxfk
         8+4Cfa4e63aA5rrFDRaRFWVlXZO4x+21PiB/3o4FZZJOF0sMkYhr4qoWdTzCynaKwyPZ
         kBcIAAH67jJTafpsCBQrUe1ANdMKdiKshInIwRJ+BUPz/kaCKBTlvGwLD0vk0Cy79OFL
         pQV8FyejxTWwBSkNkb2i0W+gU4dNKH5fQz3CURzx8VpGqok0gIMOvcEsrvCSRBvJK1VB
         UpIQ+Vac+NqKi2v6odcKj9Za3/R+Om3zqq5+o43oUOnVrotaFmWZapzBt60tB2lW5z7V
         S6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UdtCpjjQ91i6JdeO1o6cmQH2Jj5NVts/neyKdRuf9u0=;
        b=a1+4fofdQuL8pjt0aDrZz/81RkSeJXO0PF4vzptlfFWmECYRnmrKA4EzX8jJqJlWq3
         byuHpvWROZypDTwVt326J5uzfRatNIjDLDuzB97TUJgnzUCKv6FBP+n3b2tLd1YUvtZA
         dGeYtmmePO6XS4QcC7+X84eFCmc2E19+1xdjemSYL6w1AVGIeneSD0HheBtPUQArLbyJ
         etf8I5vH0o5GaG+Q49eTJhW/YnP0AAGBkoC2sz+t63kgYvMdCTfGYTYNEgnu10XpeKnN
         Sr27fp8v/CwPvKREuupW+lAQEvcryThRxusWiO9ClyyDvV8TELwyo1r5gtjFOrt7BGeR
         YOxw==
X-Gm-Message-State: APjAAAV2UOoXJSvwE7g9Ia17OZ4/8FVEr/ftaXTzXUHIBe5mBhw+kAHP
        j3I4hCogUnSq+h+ie3mvl2xRraQll1k=
X-Google-Smtp-Source: APXvYqzy2V8ZQUSqq4q5Py2O0ZZ+w6f/HjgTMagL9FbXBX1DIOdqD+h8jSz65+ynIN0EAeD3DVxpFw==
X-Received: by 2002:a63:fe51:: with SMTP id x17mr4712540pgj.339.1559239083470;
        Thu, 30 May 2019 10:58:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::7ef9])
        by smtp.gmail.com with ESMTPSA id d186sm3003141pgc.58.2019.05.30.10.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 10:58:02 -0700 (PDT)
Date:   Thu, 30 May 2019 13:58:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix page cache convergence regression
Message-ID: <20190530175800.GA10941@cmpxchg.org>
References: <20190524153148.18481-1-hannes@cmpxchg.org>
 <20190524160417.GB1075@bombadil.infradead.org>
 <20190524173900.GA11702@cmpxchg.org>
 <20190530161548.GA8415@cmpxchg.org>
 <20190530171356.GA19630@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530171356.GA19630@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:13:56AM -0700, Matthew Wilcox wrote:
> On Thu, May 30, 2019 at 12:15:48PM -0400, Johannes Weiner wrote:
> > Are there any objections or feedback on the proposed fix below? This
> > is kind of a serious regression.
> 
> I'll drop it into the xarray tree for merging in a week, if that's ok
> with you?

That sounds great, thank you.
