Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234AEC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38B62464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ABix7BZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfLEP3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:29:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55780 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEP3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:29:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so4310003wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cP+oM3NA7KncqmbMbjVli5611B4S2UpI7p/XGvy4+VM=;
        b=ABix7BZQE6/oBKIKzeq9oQL81G5DErroX9yrN0/xNE9ctYSu1ppRCD8sQMK77lOdts
         Mfr15V5jwVQ2rcMIcysM2MiH6VZLtLggMq0L0SRa1qBRPmMnHNXiOVbnOHvMqyCmHKRo
         6FOfi054BSOc5EOTe54VmuigHJSnbORH6oTtwGSAZ62YJOXkuowcArCg5VWS+hry7iqA
         BYAUeO6RGrCTf9WYI7VME/NZ8tbhZ9ObrWccYrSxw8c/16qUUnKIE2p4AArXHFhDovwA
         2FRNRjaSfG+YETDxzNHli16KZ1Pf0ZSSGdK2F/Pi7gjD94kcwr4bWPw9FAao/PFHNcVh
         925A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cP+oM3NA7KncqmbMbjVli5611B4S2UpI7p/XGvy4+VM=;
        b=J6zJDC4XK/xgZcQ+H5RF4wRudNMYRrf8D1U6pRKT8iSEcxnAXvyqcYdNrwAlgOUFMR
         4Ei49DcoFCaGqdtyliifik8kVZJgQxoEWaqvwl1ckF+aUQDl9+P2NTMANKEgxFDXBoyc
         Sf3q1vQrU3g6y9/lJdYTTnwcDPAgkAce9QgBO9WO+QlhIYlqmoSING7l6MNGrM6vjAfJ
         w45msSQXPgtL04SAzZ+1o/sH/IhcDF6MT+uD0sKvhduW81F36DIdBl+j1WLtgK97bh8N
         KfAmMfCXIKxzhB710hKJ0qofaFIVkbJM0B2ZSerG7nX+sG7XWvnqBTN/BloqQuPPswy5
         XwEA==
X-Gm-Message-State: APjAAAWN54pZMGCtvFePu7CcGbpxvZ6PKCGftv26lhrLmfUXp5Gvg7bl
        2eRfCU0sjKNOSrkM0X3x423s2Q==
X-Google-Smtp-Source: APXvYqwg7r5WIGyCZhCUyuc9pK/Q411mfTgj34TL5oqoEJcHF0kVbf5N6U5FZZj3N86LNm+WlNwMbQ==
X-Received: by 2002:a1c:61d7:: with SMTP id v206mr5704907wmb.13.1575559788631;
        Thu, 05 Dec 2019 07:29:48 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id z64sm176283wmg.30.2019.12.05.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:29:47 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:29:45 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     David Airlie <airlied@redhat.com>
Cc:     airlied <airlied@linux.ie>, arnd@arndb.de, fenghua.yu@intel.com,
        "KH, Greg" <gregkh@linuxfoundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] agp: minor fixes, does the maintainer still there
 ?
Message-ID: <20191205152945.GB10549@Red>
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
 <20191202133254.GA21550@Red>
 <CAMwc25obOebugXGSNVWd1bjPN+tR82wwFJ6PgqnvZXK4O6xAFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwc25obOebugXGSNVWd1bjPN+tR82wwFJ6PgqnvZXK4O6xAFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 06:01:15AM +1000, David Airlie wrote:
> On Mon, Dec 2, 2019 at 11:33 PM LABBE Corentin <clabbe@baylibre.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 08:14:40AM +0000, Corentin Labbe wrote:
> > > Hello
> > >
> > > This patch serie fixes some minor problem found in the agp subsystem
> > > There are no change since v1 (posted two years ago)
> > > This is simply a repost for trying to get an answer (gentle ping 6 month
> > > ago got no answer also).
> > >
> > > Regards
> > >
> >
> > Hello
> >
> > Does the AGP maintainer still maintain it ?
> 
> It's maintained but really loathe to touch it, I've no hw to validate
> any changes on so making any changes to it really has to get past my
> internal, I care enough about this change to risk applying anything to
> AGP.
> 
> I'll try and look and apply those patches today.
> 

Thanks for applying.
Perhaps you need to fix your address in MAINTAINERS.

When you has hardware, What was your tests procedure ?
I can on my freetime add some AGP hw on my kernelCI lab.

Regards
