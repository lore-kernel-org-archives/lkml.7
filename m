Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7785EC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51736216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGP9PNjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbfGYDl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:41:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43680 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389704AbfGYDlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:41:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id j11so25917362otp.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 20:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r50KNczYHsGrLVGWh6ZQQJCk+euz0u5D2BdOZkkJPZ4=;
        b=vGP9PNjGPjrvV6Fp17JQsypCrE9DTKh2pkXmKyjXy2EaMuUVYCtUKcbSDIaL/jYjrg
         H/LtngKQGANQ3RXBjJLSD3hszRFxmYmvEFNEtpA3NmXiNi4jODZx1M+Y5cU/mmStKJCV
         tKk9elHbHNXo1TjqthSQpB3LUGgKjwpPdvLPSnfIy4fYfV+qLK5u01nGbDYWyhBI1Um8
         adSFzkt0eSGlF+xQ54DII4RTfWqJ9TPW5uiXrzj16zGffl5++7xkOsWkomHu9qg1Bd7v
         IPgGruwLxFy0GhyHUlrahUq8ofVWiKsywetB+kCYiBkyEsdlfg0iXjhdPR3SeEy+SDt9
         vV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r50KNczYHsGrLVGWh6ZQQJCk+euz0u5D2BdOZkkJPZ4=;
        b=l7Wbg2tqAOxM7QULqprO92EoUsrjfQR4gVrjtOY/14A6wluNoRGxRd0VY1ojDQ7KRy
         BdfTVC6hO/tDkWbxUGbNFgMUys256HF5KkYzO6Lu4Qd9eVx2UlFHcWgWELQqlkvB91fx
         JCPDhZSZhPr+KnSk6zVVxZi9d0U1Gz1xWtN4nwEwHU9461Lyu0p2SQ/zV5LlQKweH9cr
         HvIoTBgw0BcW4/hZD7iPjxk9JQhYi9gkUi7r+so8qk0eUHpZqWTssa9/FGYJyEYTqdw6
         2YjEKFCJLNtTDeuIgLBNyWzDBzkopEXRLjYAnWi5+2KLEAzW+w4vrtWTzvczFVkRo+/+
         JCoA==
X-Gm-Message-State: APjAAAW5i2YYsbImOe8vI/uh5q4Q5uBSdIPOyLfruERDdwLRSqRmVCSv
        0qw4XRUc6OpmxmNYGFocLKcyIrq/lPNWpafeBSQuMw==
X-Google-Smtp-Source: APXvYqxygEL51qcrcdZob6n1E2VXGdJ4wPnev6GIEcEYTj6Lf1kgwRqEvEl2ham2F8ZP4KwLZgHvcNm3EjqcDDYtvq4=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr42328108otk.139.1564026084726;
 Wed, 24 Jul 2019 20:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com> <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
In-Reply-To: <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 24 Jul 2019 20:40:47 -0700
Message-ID: <CAGETcx_ZHXkjZMBhO8YTW2fMyVqmsj8f9F8d6oJTn=NmRL1q=A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 7:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-07-19, 18:42, Saravana Kannan wrote:
> > The devfreq passive governor scales the frequency of a "child" device based
> > on the current frequency of a "parent" device (not parent/child in the
> > sense of device hierarchy). As of today, the passive governor requires one
> > of the following to work correctly:
> > 1. The parent and child device have the same number of frequencies
> > 2. The child device driver passes a mapping function to translate from
> >    parent frequency to child frequency.
>
> > v3 -> v4:
> > - Fixed documentation comments
> > - Fixed order of functions in .h file
> > - Renamed the new xlate API
> > - Caused _set_required_opps() to fail if all required opps tables aren't
> >   linked.
>
> We are already in the middle of a discussion for your previous version
> and I haven't said yet that I am happy with what you suggested just 2
> days back. Why send another version so soon ?

I wanted you to see how I addressed your comments. It didn't look like
you were going to make more comments on the code.

> The next merge window is
> also very far in time from now.
>
> Please wait for a few days before sending newer versions, I will
> continue discussion on the previous version only for now.

Ok

-Saravana
