Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BFFC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9502E217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkAOSsNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfHZGN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:13:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43238 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfHZGN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:13:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so9477455pld.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K4xTqVT3gSlsyJrTOrya5b7nDs+y3cG9ZLcN0dcxs5A=;
        b=EkAOSsNMOTvNOdNGd/38LlvgZDSOHTire+gwrsxVtrv7JM1H0phNlUP+GCRrrZYBsW
         7Ko7ELYrP0c+wIsPWP/BOwTYwEx5KoQ+BNaUjnBYxVoPXiKUt1Lpbe6SCjPWwa642Rj4
         VrKljVttBDG5Ihrr6biUZP1aTqSYax7ebXs9LEXpRFfuzIDMOZ42SII91cqGBFaVxRQn
         J6MewffqZMkxrZZAm+q4i0ko29I4sFW6rRjZHb9mcslxIbpKgP9UT0fzOuCkz00Gzc7N
         m3PDW85MbomzDvm8RLZWTWSKJwYFgrYWG512xpnjj8LFV0aQiVJzq1mqEjg4gvpHjqaR
         sfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K4xTqVT3gSlsyJrTOrya5b7nDs+y3cG9ZLcN0dcxs5A=;
        b=XC/3SnNhyov1zmxXiA0ByN1C3tkSvDrYxC7BUJFOIB9l3MsnmoobJJpxX0n6DxirMT
         Ub/szKAMJVarj44XdHVH3D4YR3PVYqdsedtis0vO+y/7N5yL6KXF1MF+JkVMHKFXYryt
         EWZ8uJoA+PlpItV9AtnTKBB1z8mDCTkjk/qX4I3Ev/3l3OTJJbVzfOzHyQh4TEqyVtmz
         uEmL4bsfLt56VtuOY7ETiCEpGL5A+co/wKvpyW/N5WUgnf8TA4ibQl6zIPiaOENbTSTb
         76SeiiqKhdXlbhh8zsa9Ys8kFDIyHZ+DeYAXFSXAeu+hntbtPLy2hb78neiAE3zXs3Dh
         c3vg==
X-Gm-Message-State: APjAAAXos/S/jOpEziE6lYiVqn8GM0l72G/yP2yecI3CQaYgO7rp9n9I
        nFHH38aUjAVZsQhTbs/PFovWYg==
X-Google-Smtp-Source: APXvYqxCNCxrBS4sn6xq67avgshvFQc+3q2JEbYVJ7Kjldm2lweFl1UnWd6Z6wIZ29ZSdOud3q8IqA==
X-Received: by 2002:a17:902:e584:: with SMTP id cl4mr16930492plb.160.1566800035845;
        Sun, 25 Aug 2019 23:13:55 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id c12sm14551590pfc.22.2019.08.25.23.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 23:13:54 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:43:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH 8/9] staging: greybus: move the greybus
 core to drivers/greybus
Message-ID: <20190826061353.em5rrwu342n6slnk@vireshk-i7>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-9-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-9-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> The Greybus core code has been stable for a long time, and has been
> shipping for many years in millions of phones.  With the advent of a
> recent Google Summer of Code project, and a number of new devices in the
> works from various companies, it is time to get the core greybus code
> out of staging as it really is going to be with us for a while.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: greybus-dev@lists.linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
