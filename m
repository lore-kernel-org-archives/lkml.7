Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032A1C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C938B21848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnnnCymd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfHZF4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:56:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33231 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfHZF4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:56:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so9919799pgn.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zr3vid/Be9jDvSmy10++g3stkcNTsCuHjnJZ89+8CmU=;
        b=PnnnCymd36Rkp087Udk5dXGDI81ria9EJtsL8T2O3jvK0YJjg+QGcHrD3apGcjHOXQ
         HQKNt5ZmlZaLRAozla9mb2Dz3bPNoZhDX6N4OcjNoDh9CL6UCVKLpZrbMDS3e/uNrREN
         3CvEjOD+ZlNR4g6NLwS4CDzWJxGIQHLAb1OQqDoJ11r6vcoD1CQ7Wgmki8JWHfkbiESw
         K2s6CTQ0CalYE2OkovC/mQdjBh7vzCZNJTp4Gkjjg2+XBKPPLStHXOfuOxn4wgGZjkyR
         YZfGXH60HS1dHiU/0InQVOkLjoJ8p/vsIXIrq4uJX+grZ4QMaJLlBOVZih3IG0d1QVJo
         vEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zr3vid/Be9jDvSmy10++g3stkcNTsCuHjnJZ89+8CmU=;
        b=uE6QWqxFfdP7ss1ubcBkfAC5enMUjdwoSSLCUGgnU5ivHfZgblezxad66jcYb9kWOl
         H9O6z52RhKgCaDyUKo9Q7w8uGMxcSfjzFTJTEwtk7BNShYMMdZzblgB4x0l+DpYTWeqS
         tGRP8hfbxxUV32bC4BGtAdUl5TNN1Hwhl0CrksqZObyRSo9E/Xy+aMqQ5rmyo6jVA1t1
         McvQQvyVjM5M4dkvC0tf/gluWVzlIBzGW6DtFUTgi0702pNm2JBeZJirhEs/uWvem1Z9
         knKkwUswg8d/fZ0R099crdy8SpVXSbBzzSTKIB3DVlA5RTcYQzVhZzwQlq9q4hAZ/5fM
         2bNA==
X-Gm-Message-State: APjAAAU++wAjGxo2oEGjp0BUtUIdUAXJXhPGzie9OdQjYL9NOcu8JMU7
        EVl3U6T40zuC6MGquFL9cE8RUw==
X-Google-Smtp-Source: APXvYqy8nv3YahNw2tGFl6N/XoBD6GVoxRLds6wb4xDhj6avX3H2QmuYXu0wY/HUsAOnp+ZhNyRfKA==
X-Received: by 2002:a17:90a:a00d:: with SMTP id q13mr18287449pjp.114.1566798959377;
        Sun, 25 Aug 2019 22:55:59 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id a13sm5740526pfn.104.2019.08.25.22.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 22:55:58 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:25:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        David Lin <dtwlin@gmail.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH 7/9] staging: greybus: move core include files to
 include/linux/greybus/
Message-ID: <20190826055557.v6zkgyorbpr6bfmk@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-8-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-8-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> With the goal of moving the core of the greybus code out of staging, the
> include files need to be moved to include/linux/greybus.h and
> include/linux/greybus/
> 
> Cc: Vaibhav Hiremath <hvaibhav.linux@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> Cc: Mark Greer <mgreer@animalcreek.com>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
> Cc: greybus-dev@lists.linaro.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
