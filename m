Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E8FC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB52C2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="azhHcHx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHNHIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:08:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40669 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHNHIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:08:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so50272219pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=noA9l+lac2tFbODKUiemces22bFWF2XvyoUUU0oGh3Y=;
        b=azhHcHx6e2GPzq1qiXPKq9L0/FCy+3K5Ug+7kOM9qsxRMQvVJbQdk4B+sd9jPo1Wzm
         XUFDfEyv1O0gaQeTg8YERL8VT4vQRl44Lr844PzeDUfdP8nDuTFzs1GEGVxpExF3xus2
         JT3IsxKxLZ47NG/5vgeIDnHRAbxQfVqpGdkjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=noA9l+lac2tFbODKUiemces22bFWF2XvyoUUU0oGh3Y=;
        b=LLXLmlcx/74OyH7DY/Ddpzr6HQ6GFgwRhZGhk4Xps10miJj8fVC30/2EHGxDXXG1b9
         BUaRU+k+vv32bZOz/UDEixJ0bs9KJDI7+6UbnLRJ0zFpZd0DHqOeRru5L4v+s87DMBPe
         zNJSyNIzXQs8qrqZTSPHeWngqI2AAStWOmG0aEYz8Ob1zEE1eWD1nt5P7T/wcqWU9141
         BSL1FPkKVYMkeNnF/uELe7bz77a7DTt9HIYfK8NxwL7ad2IEqIcs4KPnOcYW8m1/mdNy
         4dkT+UGlryHYRnaZ1KWwwww97x42Atwpqdm9tSPibW5fRQ9BLgmALMcne1OeIhdEsKfw
         gyxA==
X-Gm-Message-State: APjAAAVXSdOhts+9YlC/3R4EI2Bea+OT4yYIoCemBA6Uo0LmClB6GzgO
        H/GQsYcbAKMBHezxVwCq8T2Jfw==
X-Google-Smtp-Source: APXvYqwhleD1WxLn9SQPb5TBxm/FmAKBDsfXxxHaV50lM2/VS0F8JJMyxYA9vP5R1sXtEGB5XR73nA==
X-Received: by 2002:a17:902:7612:: with SMTP id k18mr40585980pll.48.1565766520648;
        Wed, 14 Aug 2019 00:08:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e6sm14135669pfl.37.2019.08.14.00.08.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 00:08:40 -0700 (PDT)
Message-ID: <5d53b378.1c69fb81.31b2e.5077@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814063803.GY52127@atomide.com>
References: <20190814063803.GY52127@atomide.com>
Subject: Re: Regression in Linux next with show wakeup sources stats in sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Tony Lindgren <tony@atomide.com>, Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 00:08:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Lindgren (2019-08-13 23:38:03)
> Hi all,
>=20
> Looks like commit 986845e747af ("PM / wakeup: Show wakeup sources stats
> in sysfs") has caused a regression in Linux next where I can now get
> some errors like this during the boot:
>=20
> kobject_add_internal failed for wakeup10 (error: -2 parent: usb)
>=20
> Any ideas why this might be happening? Maybe some deferred probe
> related issue?
>=20

Yeah! Take a look at this thread[1] and please test out patches I'm
throwing out there like a total cowboy(d).

[1] https://lkml.kernel.org/r/1565731976.8572.16.camel@lca.pw

