Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07CEC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA1C216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcGQh8NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbfGYCax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:30:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44624 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388525AbfGYCax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:30:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so22725468plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 19:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z8Xo9F35Jnjc9XijZCcQ2rozL9xIXtmpcSL+K8PquAE=;
        b=mcGQh8NXcdBWu+xz3Gs/fefZAaR45ySwQq5ksz1Qk66f21qrMjSw+hhnQLd4PMLvVm
         K13LBdP8SDpQBZX9ewSOSLZ5QOHv6ZruKGrlTEMfrSRyfa4e7Q7+5yGsN/WQNFJhV8t7
         rmlwE1EQ93ETmdl7DM5hKnF281cbyZwDOG/r5qnr4u73daGEmENzLpRErgotT9gtUYHS
         jN8MPYVUC9SCME4FkR8B0ZTTzExFg75UyYJA1ocZ0pYqfU4ngMdCAhcpI63ZM96Pc47F
         ahxU51/X64iCjjKASFCbe1/3LGT5GL4Q7TmEn9QDxeQhaEV1wrzz+IBB6QSFDxrhtlZf
         rSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8Xo9F35Jnjc9XijZCcQ2rozL9xIXtmpcSL+K8PquAE=;
        b=gcdW1o9Td9R01VvPXLLE+yOtx1NDe/f3h9T6x8qOLmfEwKdcCzbUo7kCtl/T14WZqy
         u5cv2H74zday1E/MMhOOogvaoyfKVKbxAzCIacQ9RrCSolwSF0nQsnyFb24ldLyOXik5
         Co/FxuBykk7oziQpqk+J84jey85h+VVxojnJJFeCZsFpFbJGYtqIRb5MmhGvCjtDFqIX
         ZYUk2l8OQWYv25j+P68g1porZ2RqX/jaJxIgZc8wxEwA4s/FE9N9fv16XxNOCYyVtGt+
         lksk9jViDn9HbIZ69lfXnfvfC3yIopTRXnQAGY5O1ap+1BcqfG+pzzbOjNRbnM+bcwU9
         0g7w==
X-Gm-Message-State: APjAAAVQonC6fWSnlzLw3vtwMh9SopSLkopIx9ftq7OQd7QYLyWxUuHI
        GeSFk+DJPuQJa4tx9E8lDBamjg==
X-Google-Smtp-Source: APXvYqyQ+Idaqp2XOKlh2A+59UT3l7Es0V6fP+GpNTh+LEvHX5XPNjpHbZckqg4+pj1buEP+J8OsZA==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr88979000plb.103.1564021852454;
        Wed, 24 Jul 2019 19:30:52 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 35sm49333089pgw.91.2019.07.24.19.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:30:51 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:00:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
Message-ID: <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
References: <20190724014222.110767-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-19, 18:42, Saravana Kannan wrote:
> The devfreq passive governor scales the frequency of a "child" device based
> on the current frequency of a "parent" device (not parent/child in the
> sense of device hierarchy). As of today, the passive governor requires one
> of the following to work correctly:
> 1. The parent and child device have the same number of frequencies
> 2. The child device driver passes a mapping function to translate from
>    parent frequency to child frequency.

> v3 -> v4:
> - Fixed documentation comments
> - Fixed order of functions in .h file
> - Renamed the new xlate API
> - Caused _set_required_opps() to fail if all required opps tables aren't
>   linked.

We are already in the middle of a discussion for your previous version
and I haven't said yet that I am happy with what you suggested just 2
days back. Why send another version so soon ? The next merge window is
also very far in time from now.

Please wait for a few days before sending newer versions, I will
continue discussion on the previous version only for now.

-- 
viresh
