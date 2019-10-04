Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9CBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B7D215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E58EWgdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389444AbfJDOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:46:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36362 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389043AbfJDOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:46:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so4058888pfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=vrpAOV+426YcY2dvYTmCxBoSkb9QFrfgtxFZXoZ1T88=;
        b=E58EWgdvs+fgVnvg68jCcK9hRiNmsBZbNXQogt2zXknBgToFwfqE6QOOuIFjqqHiax
         S8ZOe8VERGUSJ9gIbHp5qxn/GdXNf9FhWJEpC8litDvzuoUo8e2lSNjDdPmcFbrqBjau
         BmoWDjGYpXlEO+iu7lNKfeAu/ekV5SLtUGlrBj6KKzwFMS3l6BhQ5kILJTf5/CAZx+HR
         EChLHgj7yy/w6tFLYDkPTk9kJihy3j/McdB1+dqHozQsYFHeMqMqfDhRNyNUE+oEZ4tL
         qPEqEF/YZ+4o4SD+navIpoAXd2lVnDGbh03yyds24AUDBUJc10AckJtvWagyhV32YrRw
         dyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vrpAOV+426YcY2dvYTmCxBoSkb9QFrfgtxFZXoZ1T88=;
        b=GAjhkWtLU1h8FekvtRgpgENKpJiw3F6Y5wdzP1KKu8zIu66TPVBjV9qNZxdkdERDjE
         54D66FPO9NYE1d89gz921zsCbnwpV8TYOyJ9COLzVrrQSiu0TR4aSfQNFwmoI1wqO5Rq
         ovs28Lp0X4+Eb6CsSjQxt2aihLPLmwyI3bX4VDb2Yn6IPBhdTX1HNrFroCaVyfqe/mLJ
         ocrqMcu5emFpibkvPutZbU6woVEHbx9RB8yAQSbKVTe3+4J3LIUnol2fEU72FuRwIM1U
         aS5qo5itEvJdRtYUutVKNWeZtujvAzCe8MhfXze5nKCUffN53y4N3q5z5ZumIGlBObtc
         anDQ==
X-Gm-Message-State: APjAAAUVSX3L1L5AxqZ5dTAfxmsUuL9Nokk49AY+ny+8yBlq77s+dB0l
        1GM8tQkc94tJpeC5SiW65Kw3cA==
X-Google-Smtp-Source: APXvYqzOUPGXab6AXJASP225dZhPjVnVqdYiSvOwfHQmdwXVgOva+jxCkR0avI35E8JbEplmXeZ7fQ==
X-Received: by 2002:a17:90a:cb07:: with SMTP id z7mr17162183pjt.67.1570200408918;
        Fri, 04 Oct 2019 07:46:48 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:6c63:e3e5:f440:92c9])
        by smtp.gmail.com with ESMTPSA id w10sm3834115pjq.3.2019.10.04.07.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 07:46:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Philipp Zabel <pza@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] reset: meson-audio-arb: add sm1 support
In-Reply-To: <20191003180311.hlv7s32twzcaxj3x@pengutronix.de>
References: <20190905135040.6635-1-jbrunet@baylibre.com> <1567693618.3958.4.camel@pengutronix.de> <1jk19oregr.fsf@starbuckisacylon.baylibre.com> <20191003180311.hlv7s32twzcaxj3x@pengutronix.de>
Date:   Fri, 04 Oct 2019 07:46:47 -0700
Message-ID: <7hpnjch8ko.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Zabel <pza@pengutronix.de> writes:

> Hi Jerome,
>
> On Tue, Oct 01, 2019 at 11:40:20AM +0200, Jerome Brunet wrote:
> [...]
>> Looks like this patchset missed v5.4-rc1.
>> Could you provide a tag with the bindings to Kevin so we can use the IDs
>> in DT until the next merge window ?
>
> Does
>
>   git://git.pengutronix.de/git/pza/linux.git reset/meson-sm1-bindings
>
> work for you?

I'd prefer a tag as that's more of an indicator that it will be static,
but if you're sure that's going to be static, and is the same branch/tag
you'll be sending upstream, that will work.

Kevin
