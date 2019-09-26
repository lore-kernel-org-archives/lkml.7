Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD75C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078FC222BD
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CxvxN1Og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfIZCJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 22:09:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34341 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfIZCJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:09:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id k7so592921pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 19:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4Qvr+Vq36lJK7eT6do5ApSmMPZYoIZa8xsw9/sgUwoA=;
        b=CxvxN1Ogf01q/7maIA+Lps+CDXG/nyEYsAaIxrAqtTBnkzCyjIWSN4lNyu6m5WU7fU
         AAisYDU6GvpyuyFuhVx9OGU0JOBF4jCcnQq7H/ol4gq1d7ObG3zM/btlwhflxRrPBcJm
         Zz8YTv9WfqZcPH8zc10iV+kvExXG2VgYiKAlEpCo8eHFi4a2jy0qQXEU0neryX5nsgiU
         bAAKJFyH9ItwH5NHZFDHeu9nwOENXyJFOvQHImXYdIf3wI0pUNsUxOTN6hk4Yo4h7uLD
         ET8l2bTm5+YYG0HVlWQzRYHnhD2KUScW9c48I4te1HYQkqGbHPPHnJaROjwHhNx4bTVT
         vg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4Qvr+Vq36lJK7eT6do5ApSmMPZYoIZa8xsw9/sgUwoA=;
        b=NjzJsFzmsEwPuzx2AI1oRYdo8E0QdbhWE4D3CAElO7TtshspXNSrCKDEUrGQGnsesD
         7Jb0X9/QAk9ffbILRriTyPE0hZulyQzWu7v0JcyzGuWw5MlSkr0cRc4cl7SKXLdiAfZR
         zThU78GP0ngisLf0WOorJth8kJWFVLB1/oVEG5YpaqHR9c+fiPVwhq1XLmWegFD6tV7H
         hsVJOZocHoRMREm40APyUiwXMlMz3TksANdINrWIL71mmZe5agryL9Bcbe60m5iwajbd
         wGmq5l6nEflcabL/pLb2dEtmQHSG+pRlsiK5l4LbuBUlIDqZ6ZSxMeBpkM62h4UKCb9b
         7bbg==
X-Gm-Message-State: APjAAAWMJAiR08/NTsfX8xBjAL9RRjuWP4vM3WQioRR5rV0qgvgxAX3g
        HVbOUF+8nfbauF8iQip4ixyeqg==
X-Google-Smtp-Source: APXvYqw+uH1sv1ftk9JTvni+8fEIkYi1Eg0n64bz8iq+sLbx2N8otKyBHJqizMA2EP+GOJW2vHjRDw==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr1668421plr.64.1569463761775;
        Wed, 25 Sep 2019 19:09:21 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id c128sm332461pfc.166.2019.09.25.19.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 19:09:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 0/6] arm64: meson-gx: misc fixes and updates
In-Reply-To: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
References: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
Date:   Wed, 25 Sep 2019 19:09:19 -0700
Message-ID: <7himpfst9s.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> This patchset:
>
> - Fixes bluetooth on Khadas VIM2
> - Fixes bluetooth on Khadas VIM
> - Fixes GPIO key dt on Khadas VIM
> - Updates model for AML-S805X-CC
> - Updates model/compatible for AML-S905X-CC

Queued for v5.5.

Thanks for the updates/fixups,

Kevin
