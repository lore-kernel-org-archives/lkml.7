Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41953C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E32F2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYa8JhBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfHZFwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:52:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35723 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbfHZFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:52:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so9913351pgv.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v1mN+PJ4/u/At+nrZH4p9oYVurqqQgIOn2/0TJTZ3aA=;
        b=oYa8JhBm8dZps01mGvJJ7EihivLZWL9IVeFOB3bisU4QDF3oAG3c00mNnCybhSTIt8
         sG/TtLLKPza0FQMNp8SD6tpnTXI83deBkdCptHRO7/s5IBkZAPI/7ji79LPDf1smlYB0
         aXHhLZZYjvP1ZQCC35CtRudGtTvMRav/m0oz2KWiVvH+YCO/1uL+AqNhHH/kdfO4eK5K
         WFOyHV47RBI+/nQlOqVl7RkO9GLAiTJyWl/XhDRTeFuU5Gf72QB4tTnLNsaaQsc4fKPL
         ToLwMH+3IzLKjWo1smfWBhtIEdo3HluCKy2qpiiA+tQT4ZFbc0Ss4SC/oNOXIs+NKbfB
         PJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v1mN+PJ4/u/At+nrZH4p9oYVurqqQgIOn2/0TJTZ3aA=;
        b=noC+EJze3sPjWZclserA3Mo0+uvbOMnRzg7nsEPMfA+VYfleq08CEhJxyfeazkz4yK
         7Ialsnv9e4/mOKQOODYzNYouIwY5Zz8cCl+SO8pewuKothcRiDxl3kOFj9ATY/nipPQf
         ocYeY/AiJBNXfmCZuq7s4wb5Gcx82MOW3FkP+fkQbsnznwXiNs+3zSt4Uw52BeLb+lWQ
         QSGuEqLtXM4JguOWtItYC5LGnAjcstONj+mg8Bjp9TCQiZaCW+vwOn45W6nTK9R1dToH
         Vp2n9iG8UNaJAmjHwXYDsyUMZRJ0aPt/X15H5q8GDcX5Vl7ZvYyMSgpETUzH99y1nWZK
         3kLw==
X-Gm-Message-State: APjAAAUgAH8wf+G8lLm5sxEjQ9Do1FfAt5MblgDNC1SMhbQeN7c7bmyd
        sir8v8BgpXiftGdSbUmEkcqjJw==
X-Google-Smtp-Source: APXvYqxLcGMYwSCfKwTksNB+K6eFlbyh6xDK9Gzl4gJ39cyvyk40/8Ba0qvaFGa7EbrwzZQNsOk3Sw==
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr18000340pjs.88.1566798735792;
        Sun, 25 Aug 2019 22:52:15 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id g2sm16208053pfq.88.2019.08.25.22.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 22:52:15 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:22:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH 2/9] staging: greybus: remove license "boilerplate"
Message-ID: <20190826055213.rqzh4hsvg4p3eudp@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-3-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> When the greybus drivers were converted to SPDX identifiers for the
> license text, some license boilerplate was not removed.  Clean this up
> by removing this unneeded text now.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> Cc: Mark Greer <mgreer@animalcreek.com>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
> Cc: greybus-dev@lists.linaro.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .../Documentation/firmware/authenticate.c     | 46 -------------------
>  .../greybus/Documentation/firmware/firmware.c | 46 -------------------
>  drivers/staging/greybus/arpc.h                | 46 -------------------
>  drivers/staging/greybus/audio_apbridgea.h     | 26 +----------
>  .../staging/greybus/greybus_authentication.h  | 46 -------------------
>  drivers/staging/greybus/greybus_firmware.h    | 46 -------------------
>  drivers/staging/greybus/greybus_protocols.h   | 46 -------------------
>  drivers/staging/greybus/tools/loopback_test.c |  2 -
>  8 files changed, 1 insertion(+), 303 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
