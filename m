Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21151C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4E621743
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4qI1sqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfHEU5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:57:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41608 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbfHEU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:57:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so36793603pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=9X2wQUGD6zLRbLMDjJdPs/T0gS5tBwgXYnxhEUgwlZs=;
        b=C4qI1sqY5cPtC8702dZsoxLBKBli0n5d9Z9O2vEYh2ertxbu6hUXjIjZKClqm+PzXK
         /u4wPgoxWn7MxlkmuFAQ3VKGQT7BRUf0qo3hsFSr3qOc+U94xB1yilPpxop7lrME1vQW
         J92InGoXV9qe8Wetff/eGKJZJaXNkOX9al4t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=9X2wQUGD6zLRbLMDjJdPs/T0gS5tBwgXYnxhEUgwlZs=;
        b=gpBoYOI8vexd38pi9MknaUWC88PkSwPrB1OD3duAFE+J+hWFycxJ8EBryn6g3i2RQe
         /H8B77BGtQYgE4MxCyibdCd9u0x+nqm0Tfh1xh+3qOczZUygbx7jtd8vV3SZJbu6rsH5
         I6jC4u5xMe4kPHf37g1Zn317TrBahZPxOaDMUTU/57OrO3KQlLTcaaWvRPtqFNG2jcaV
         xZ35j/LYPQKjdOkILXI/EQugCxg1eX11HbbOrGts1TO8OpXx7PBTy1KOPWinrVZKl1g8
         IdeZSbhnQjzAKm3VKSmpaVQUJLC1gqYBbjXAIEYtFeGvekgkEQAfnP1OFLAGB2nH/SLc
         zsEA==
X-Gm-Message-State: APjAAAV+rIW/JvO2RtxPm7+QL3cSkP3olfGOIv5UW1nLlBRwR66zsiSI
        Vwv2X9noUcOJDUk9/gYmT1cqFg==
X-Google-Smtp-Source: APXvYqyTOTWg3ZIKAIS+XbhN0FVRmCiUQ/gsBS+nyo3j37myD1T7jPeK+PByrLv5icEaniJu39f//w==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr145799271ply.170.1565038667796;
        Mon, 05 Aug 2019 13:57:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d8sm78607456pgh.45.2019.08.05.13.57.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 13:57:47 -0700 (PDT)
Message-ID: <5d48984b.1c69fb81.325a7.e2d9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190805175848.163558-3-trong@android.com>
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-3-trong@android.com>
Subject: Re: [PATCH v7 2/3] PM / wakeup: Use wakeup_source_register() in wakelock.c
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 13:57:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tri Vo (2019-08-05 10:58:47)
> kernel/power/wakelock.c duplicates wakeup source creation and
> registration code from drivers/base/power/wakeup.c.
>=20
> Change struct wakelock's wakeup source to a pointer and use
> wakeup_source_register() function to create and register said wakeup
> source. Use wakeup_source_unregister() on cleanup path.
>=20
> Signed-off-by: Tri Vo <trong@android.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

