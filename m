Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA8DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AFE2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aKIPYGdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfH0Xmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:42:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44191 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfH0Xmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:42:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so390035pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=zZhupswYJRpQl2nx+3EaAYIvNYHJJK6zS8VHQ2dEq0o=;
        b=aKIPYGdpDtpWjheRueo74FyiXWqdB3rxs9dqEadj9ooeD9wrrjQUXhGqf+pBNgzwRs
         +33Q0tKEOxQcQaIciDay3urxoZZ0LUm7TFkRiRAfERG+2rR1MEoMiyHVb8u+F2qFfgQB
         ERRMV4s4gpt7SyF4cI8pR7aT7vac+5uZ1BJMQMhrrJv1u6anWjbKOGJQtr6zZax0bQCT
         t/m5nv4XRPE05BHeGPgr/pNsl5TncA9GfVE1gIMiW93thDK0UYplitY5eIwCYxE3T39U
         4mv5Uooq96x961Ewdmqr1eo+72Znz4u1POBNBzJitLjUY6f8h+Mqy5JTAhNblnz3/sMC
         NZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zZhupswYJRpQl2nx+3EaAYIvNYHJJK6zS8VHQ2dEq0o=;
        b=YOelh0x/wQ1bNEaR0uLaSp2V9T/HcSF2tYvSuyqfRdQM7Qz4O8YLBZXIInlnidgVqh
         2tCF0Awoe2x90lI4SmbYPkDvAYEoekhsmOtk7Oy/7gdW5ruDA5Er/Bbqc7MQfzALQ7d5
         e1sRIjdsyr3pR/jnOOk+L1+jDNWyBpyVMGuKk8rVPHjXurXAPTY1kIplq0asJOCtYGCW
         xdjh6Lqr5suRX1JFS8tO9R2Pz6Io0JGawJ1x99ZsFSbxx3h28zu45QneyWBw8GG80MsF
         hLPafOSGZgR3hvIxmiu3QyBbWp7r65RqgvIBg8SniV0t9teXdldgxhy2D9zH1NNDa712
         qBXQ==
X-Gm-Message-State: APjAAAXIa/2Hxq62FZ3ZVxMyrdrVRIp3zTeWMBqfc9NDOKk0JYaRjnCm
        9ORgSP55I3xADIYr433D5QLgiQ==
X-Google-Smtp-Source: APXvYqwXfzwRgynraPWYmZHmZ4nqfdc0jVUarkPtMHItZPdLhXyQy/n60WaWTA3gyehqjYkOkVqSTw==
X-Received: by 2002:a17:90a:1a8d:: with SMTP id p13mr1342730pjp.15.1566949370220;
        Tue, 27 Aug 2019 16:42:50 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id h195sm468857pfe.20.2019.08.27.16.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 16:42:49 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: g12a: add tdm resets
In-Reply-To: <20190820121551.18398-1-jbrunet@baylibre.com>
References: <20190820121551.18398-1-jbrunet@baylibre.com>
Date:   Tue, 27 Aug 2019 16:42:49 -0700
Message-ID: <7hh862tbt2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the dedicated reset of the tdm formatters which
> have been added on the g12a SoC family. Using these help with the channel
> mapping when the formatter uses more than 1 i2s lane.

Because I forgot^W waited on this, we did the meson-g12a-common split,
so this no longer applies cleanly.  Could you rebase this on current v5.4/dt64
and I'll queue it for v5.4/dt64.

> Kevin, please note that to build, this patchset depends on the new reset
> bindings of the audio clock controller. I've prepared a tag for you [0]
>
> [0]: git://github.com/BayLibre/clk-meson.git - clk-meson-dt-v5.4-2

Thanks for the tag.  This is now included in v5.4/dt64.

Kevin

