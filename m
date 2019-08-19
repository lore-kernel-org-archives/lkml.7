Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DE4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0A220644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="mXpS0Puu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfHSXwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:52:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33913 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbfHSXwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:52:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id m10so3031287qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=a/2XLdHfSdB0b6RIPrdy3mFXWwjPe+7l5bCqv2Lo3ZU=;
        b=mXpS0Puu27Rc54x05eebbDC0TGOxOcF7pPi9XLEJQiWepOTmboPHwcQutctjuE40SV
         0vOgp8/QSdSXeBFFS97m7rsH3qEZpkzmX9p/PGQIxU3bHembgxm4G8aoq49hGpkHYbuB
         fAo1Y5lgdMQn00YqCCJSGNFeAC+3IW7qj7JueJ2s2hYsplYGuPquLdsDCiZlg6nflUYS
         QKBnReyxrhpMPgaJtFUjqoXxZkCn02tA+QzvbR9x8qBKQMcTiM7CjkH8jWM2V5iTkpdM
         wovjXVvFfFP4VWCDNZiYXCLexf+qZsD03+XmfJZzxsd8qOCXvyVBC1VOMorVC8HSTAAr
         i5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=a/2XLdHfSdB0b6RIPrdy3mFXWwjPe+7l5bCqv2Lo3ZU=;
        b=V+s0acTXSKv52iKY00GB1rMjyekMd6fUCqtKHXq96Zfhy2ZPhIOyehJ6qXJmJgOsRz
         +BeKDuaHiiH9RXA8figs+U/EVDVrHnF84sQSsj5TYQaVr24r4bG85IUe5F8nXj4T0Ie6
         Gp36JEtN5TwsZpLjtG9nQzMxCm8+YFT7ocpEA6wGS8aAkxzaajLN6C5lMlyoRWKCMRwS
         p/62STW6y/qfexubfT8IWlZCIlzvVW6ijjaATAKWaHUccOSxDVynwuzFdsO2FlvQlris
         6ltAy8hCFzWMEiHSdwT9IgRsGGvLo4cZruYFwJHeKwEBdH6YBC2kMTy4IrzHh5/Q9+WK
         yIAQ==
X-Gm-Message-State: APjAAAViFi/7XlevAkt6Bht6+T85SMwpyKJNTUGI8qzGsRDJANS7m6Gu
        NVIywPkdlEo8SehLEMeLxmApsw==
X-Google-Smtp-Source: APXvYqwGNe8Ex149O1rS0+k/zybKrFzFtdGIiowvDePNSIyU8GYvbJ3wuW4uS2CwSOOrujZstu9ViA==
X-Received: by 2002:a05:620a:1590:: with SMTP id d16mr23669201qkk.18.1566258721246;
        Mon, 19 Aug 2019 16:52:01 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r14sm8007255qke.47.2019.08.19.16.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:52:01 -0700 (PDT)
Date:   Mon, 19 Aug 2019 16:51:51 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 00/17] Use MFD framework for SGI IOC3 drivers
Message-ID: <20190819165151.6ebd3063@cakuba.netronome.com>
In-Reply-To: <20190819163144.3478-1-tbogendoerfer@suse.de>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 18:31:23 +0200, Thomas Bogendoerfer wrote:
>  - requested by Jakub I've splitted ioc3 ethernet driver changes into
>    more steps to make the transition more visible; 

Thanks a lot for doing that!
