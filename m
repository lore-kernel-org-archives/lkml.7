Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D0C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B202081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UvCZv6je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgAGJog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:44:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52771 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgAGJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:44:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so18184724wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=4P9Czn9hAV4qLhQS6rqwFS/Mp4FZnmQh9QMIhhN4nIk=;
        b=UvCZv6je/aScOvdTEJw3xfnpdGmOs0ESmX5w/vY9S12hFr7FwLR+XOZeSAqUAuMN/+
         MQOpTW6rqlveJiHFbzphuz21FwzHgVW+eniqtZpiAs/pmnaIzXhFWNRTDaI3yGD/THF2
         ko3+wOFjXOch+CiMqfn6AiWZE4u7ckcNeRHEYSst3Oi0TP7Fe8jDfch2du1Xw4A2avge
         lugIMiHUEXE+xiuj4iFgqE6BpSXGw1UQJlA9loMQJUl0wgee2dVieIk0iFScqX4Ag76k
         JtUIoGfDTk13o+pm7BsJXucwAwFVWJx1coOc/WWsRD5DeF+n/+rm6gZQHbBZULTjJqL+
         ZuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=4P9Czn9hAV4qLhQS6rqwFS/Mp4FZnmQh9QMIhhN4nIk=;
        b=riHEa/xh5GaAn7atA6MKBdYS+DhxcetUbY25iwizQR0fhh5m7LMR1uI3nXJxNwYY3Y
         69oVUb7eAhs9+dsOWTPGJSXoa7yOdacoToxH3MDnPmSec6LBsumEBLU9gQWIgdn7FPw7
         l2+ozzgo8UCOfYY4gb7X789fZAL9fWe1SXDAf46v2mCONVbE5PDXINf2B4QD8SkGvfRN
         FdVovpzMsaHdEEmec7luISTl4eNB5eejzMJD48RRR6nWvwGxLxFPf1pMjxa1TZc4Po4n
         yz1yfksL9YiDpvonSnY5PN8DEX8M1bRrJRKSdEFYXQsL0BsjiMUE4Q0UDAoaH70kdfrn
         Zx9g==
X-Gm-Message-State: APjAAAVoDTvakrGB+AAqCaswCLOlc3t933oVTqNqww2xOLS/wWSh1eBQ
        vqoPFbWdy9esiMbk7JYy+eH2CQ==
X-Google-Smtp-Source: APXvYqyCezd+1+4EguOZgfPFmGtssceuvsfa1PvQEaRtjcKlGyU2HHUJRAHP29eAu6WsdAH3N7GkKw==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr39883345wmj.48.1578390274029;
        Tue, 07 Jan 2020 01:44:34 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z83sm26328213wmg.2.2020.01.07.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:44:33 -0800 (PST)
References: <20191001174439.182435-1-sboyd@kernel.org> <1jd0ffr1jh.fsf@starbuckisacylon.baylibre.com> <20200105075050.1B93E20866@mail.kernel.org> <20200105075556.60E1A20848@mail.kernel.org>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] clk: Don't cache errors from clk_ops::get_phase()
In-reply-to: <20200105075556.60E1A20848@mail.kernel.org>
Date:   Tue, 07 Jan 2020 10:44:32 +0100
Message-ID: <1jblrfsirj.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 05 Jan 2020 at 08:55, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Stephen Boyd (2020-01-04 23:50:49)
>> 
>> Quoting Jerome Brunet (2019-10-02 01:31:46)
>> > >
>> > > +     clk_core_get_phase(core);
>> > 
>> > Should the error be checked here as well ?
>> 
>> What error?
>> 
>
> Ah the error when clk_ops::get_phase() returns an error? I guess we
> should just silently ignore it to maintain the previous behavior?

Indeed, that's the previous behavior so we can keep it.
I'm just not a fan of silently ignoring errors. These choices tend to
come back to haunt us ...

> Or we
> can bail out of clk registration. Seems low risk to do that in another
> patch.

Why not, or at least a warning so we get a hint that something is wrong.
