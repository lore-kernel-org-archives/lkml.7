Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0C5CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607F921872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="gvoy3JML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633117AbfJYQhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:37:50 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:36343 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633105AbfJYQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:37:49 -0400
Received: by mail-pf1-f174.google.com with SMTP id v19so1927724pfm.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=UYQi1UzbB7iZ/+eKxNJToErjLhDOEYJn/+pcDU6Q51Y=;
        b=gvoy3JML0FuZJ4rgTDUQ31bkdiDBxyr6ogVg5zGFYaYUCu1HuFEzXUHVndHUuSifpp
         bucFPK1zq6qsuMyKSBtlartp7gP8Mb74kwH+2zajpKFAcL/RmkWlcgZqEK7PWy/6nlOU
         8rFqVN0FryzoWjYhd7mkMUFViL4PWXe5arHB3nSzAV3PNy2ydkCf1qOicGro7L2j2C4n
         fyeIUR2t3QevI+vePXPOXBbZoyPhFGXmYosEv4A9ebbmP2/EeC8bKTkGzvwhCy8PIVDu
         ry2FNh1VPlo0lyr0nk73pb+AbDBtWr96Me3mkQN73Ckf+egJ6jMLPgTJjnvWiTq9YNJ/
         PjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=UYQi1UzbB7iZ/+eKxNJToErjLhDOEYJn/+pcDU6Q51Y=;
        b=ef6RfNVadP3OPFVLTauWQqNBV1wSHhGd3y/qKs7MvFA/hDeu2EWBfmleRfK1t9Un1s
         avIEhSFTipB9qdWNJAkLvTl01uDp5u7ZOjFDitSXz5Ids+QWAr62Mq5rw2KRIlNzukuK
         u45umhEuyhVfm1/ooEjjZF8Us7VBQCMy1cjdT7e6IrfGoD0h03u93cK7CZqBLW66apxr
         7bFoxj6d3ecU4vGTZnONqGLLAd4tlwnrKmSU6OxVGDByA11cCgqe4guD+NOdsL3uJZhH
         cBOXar8/LLpiVEu2oCFOiNZVje9xxAq1sTwKu6KFCl77/r9GOPRmxXqtaZ+VB78I+30p
         3Eow==
X-Gm-Message-State: APjAAAV+8A8q3gNLDVVSicFLEi4nuCiqxEaJ2erEcmDrti5sQh5H2tYX
        R2gp+nTg6zL4yYcj4NFPkA8JEw==
X-Google-Smtp-Source: APXvYqxakIs5zLyRaXbMPlWoXw1ffrHcyN8UtDf9R6ZXgLJ2TO3N4A4by4aXTKEvljfg/0VZVJvRtw==
X-Received: by 2002:a62:30c5:: with SMTP id w188mr5478533pfw.105.1572021468983;
        Fri, 25 Oct 2019 09:37:48 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id b14sm2805214pfi.95.2019.10.25.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:37:48 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:37:45 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
        glider@google.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+9e3b178624a8a2f8fa28@syzkaller.appspotmail.com>
Subject: Re: [net/tls] Re: KMSAN: uninit-value in aes_encrypt (2)
Message-ID: <20191025093745.29dcb185@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191025142924.7pgxabkbsbvpgygl@gondor.apana.org.au>
References: <00000000000065ef5f0595aafe71@google.com>
        <20191024172353.GA740@sol.localdomain>
        <20191024104537.5a98f5b7@cakuba.hsd1.ca.comcast.net>
        <20191025142924.7pgxabkbsbvpgygl@gondor.apana.org.au>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 22:29:25 +0800, Herbert Xu wrote:
> On Thu, Oct 24, 2019 at 10:45:37AM -0700, Jakub Kicinski wrote:
> >
> > Oh, thanks for the CC, I don't see any of these in my inbox. We have 
> > 6 TLS maintainers, the 3 that were CCed on the thread above don't
> > participate much :(  
> 
> Can you please ensure that all the maintainers are listed in the
> MAINTAINERS file so people can cc them when needed?

Yes, to be clear we are all listed. Coincidentally we're listed in
order of addition, which turns out to be reverse to the amount of
caring.. And in the threads above it seems someone decided to only 
CC first few (i.e. the oldest, i.e. the least caring).

I'll send a patch to remove Dave Watson at least. He's FB email address
is dead, I've been trying to get in touch with him for 2 months with no
luck..
