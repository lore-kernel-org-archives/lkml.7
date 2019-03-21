Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63AEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10B821902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAS4B8cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfCUTjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:39:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33295 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfCUTjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:39:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id k14so8056018qtb.0;
        Thu, 21 Mar 2019 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oIbxNJOHrP4Tp35aaca5VFQ6G2xshDozhpp5PLinYrQ=;
        b=hAS4B8cdmLlFzua42LmbP1KjfhaoQ79Qbg5aRRdXtQRCX4DM+oLX3X7olmnpK3iaUv
         9mrt3BIM7rE7rbbSQ/xCNonzbN+u0AUN4DvELgmPJfmKXUs68/21uDWo1XIth5f5tKbo
         nTPVfrOybhiSAa9XqtM/za0fDD7hMD2i+3n82WgO+C3e1WLrKQ8Tbjm2GiRpO/i1Ghov
         BLOvlGWZm3evnH9ZyqoZYxRSreWSuPb6nFVclxW7dbSoGgut/UUL9RJfpnrUwtErNjck
         yDuJHzoSOXllX53vVP2BKKiMtf4EQlUSAWih3DZn0FItCmPG69dX/2dvI91QBfNj3JeA
         RPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oIbxNJOHrP4Tp35aaca5VFQ6G2xshDozhpp5PLinYrQ=;
        b=g99SmdsENMsLGX6Cj0f3mL3KckzKtAY/UhRqiTJnzsrOtcQi27ZKioeecKcyPRrJsh
         aiyHWkKa3z4liRKW91eEWooag9Yht5PdfRFzrkWfKBOBNN5ajWeI9IWcOKrzx4Vtl+Zb
         Mtb7TiXBasIq2XMyZS5lhU579js0K4+ZBXeTWuEOA18yR+iplrZ4gQhBqr2memQfT0ko
         mY593x54NLgqrcz/hgZG1jePpxnYXE+iVo88V+0VW/g1cbLMsI9g/gcrM9N1RyjX5bby
         pLd3W+b6rxK3TlcbIim/Pk6gVnnZnD1Mk5M8d8LVPlmKKIA6LQs+ZgFGYDIijXeha11V
         RIqg==
X-Gm-Message-State: APjAAAVHH7VciOrJ3KIafD9rVIC2lONs/0m+Tr2GmMv9s7OvGlJZWauZ
        0JBHIw+DsQlSgx0t08A/SOk+PmC9hsapYQ==
X-Google-Smtp-Source: APXvYqwShOUUkxtgGWjJyhego/PekYmStT+6q88ltbJ8LhdWQKMdlGtm0InpDFJzTDbtVGMPz2XkCw==
X-Received: by 2002:ac8:26f7:: with SMTP id 52mr4521952qtp.325.1553197157849;
        Thu, 21 Mar 2019 12:39:17 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c21sm3447805qkm.8.2019.03.21.12.39.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 12:39:17 -0700 (PDT)
Date:   Thu, 21 Mar 2019 16:39:13 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     michael.hennerich@analog.com, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com, dragos.bogdan@analog.com,
        jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Help on testing ad5933 driver
Message-ID: <20190321193913.q46gq3h7h63ltpgp@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, would anyone mind helping me test ad5933 driver on actual
hardware?  I went through this
(https://oslongjourney.github.io/linux-kernel/experiment-one-iio-dummy/)
tutorial so I was able to load iio_simple_dummy driver, create and
inspect some dummy devices.  Now, as Jonathan has asked me, I would like
to test ad5933 driver on an EVAL-AD5933 board which was donated to FLUSP
(https://flusp.ime.usp.br/).

So far I've been hesitating to plug this device on my Debian distro
since this
(https://www.analog.com/media/en/technical-documentation/user-guides/UG-364.pdf)
user guide for Windows says not to connect it before driver
installation. Is there something that could harm the board if plugged
on a computer without a proper driver?

I also didn't understand the hardware configuration showed on this
(https://wiki.analog.com/resources/tools-software/linux-drivers/iio-impedance-analyzer/ad5933)
page.

Any advice will be greatly appreciated.
Thanks in advance,

Marcelo
