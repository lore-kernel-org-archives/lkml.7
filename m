Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C17C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C942173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G40A4BNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfDPWFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:05:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40061 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:05:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so11070193pfc.7;
        Tue, 16 Apr 2019 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qQbFxLYMYwlP7onrPgWhLG4N+rabnF+FxSGrsuK302s=;
        b=G40A4BNFpkhvQvKlzBVKYzlG3n4a5XI7dJCXeyvVsOhqgQt2DOtmFTD4Ha8Ht0sW1b
         PwVouVGUnhPPjCSuZz27tJzJrgt9nJ4Kuz/es6EdbXIIqY3SeiXB7NTZAJ//R4ZyP2fE
         wR+ADoiFriuwdy5hM9e7C7mbL9K/HHS7WV2A95ZW2u1OhQfIxuebDlFsCbMN3O0nKl+n
         b6ckZm4k3aVFKeNqiVkodbFOkHn7h2ZVBwHazkb5FLAatasJJtURqLwF2eJZWygL0smz
         3ROYxyf3Q4zEKXD61z69MqyUkCDjsnqsdpJPD5E3C8hY155DOMt18ZFvCaICmEgYYqHD
         /hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQbFxLYMYwlP7onrPgWhLG4N+rabnF+FxSGrsuK302s=;
        b=UIR89x1mWIroS5knZ1+Rfx/3+5MEHPhzXwUrmD+JJobaIipLUwvhodya/WWchqPZf/
         wjxSz2ATMLw8HnD9ILZ1uO9e5YTXTSZogOIhk+Up++d5lXVj/qQrM79OfUAo6ZWUGX45
         JFsOQisG2xUzSnMv6Qpjc4hmS5w3cKzmWiEO6msBFC1D2XvIWW+beVHLrjKcIu34qsJ7
         wAM7DweOGnIwmTJUFEbho+BULHsQ7nlajjzFKQeeyAngt7F5M8AXgyF7iJ+rtYfDvsFF
         0PxBldG/Pjg9dPUB3JoAVKZ80rujKXPA0PbT/NUoWWYBtuTZQTrv18Qq4oWp0W+oQmZf
         yHJQ==
X-Gm-Message-State: APjAAAWVd/op1mU64M2egdx8v+j/PosECXmr9ROSnKRT3PC2prY+zvzM
        IiCA0d7kIQGfMXXPFHnTgF0dU4DK
X-Google-Smtp-Source: APXvYqyMKtQyB3GvStcrXo9zOUdpUI3q/qPYmBZVhKnXLa+eSTeVu220Os22duGsFTKQMFrsMrePIQ==
X-Received: by 2002:a65:524a:: with SMTP id q10mr76345024pgp.224.1555452345335;
        Tue, 16 Apr 2019 15:05:45 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id c1sm61792503pgk.44.2019.04.16.15.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 15:05:44 -0700 (PDT)
Date:   Wed, 17 Apr 2019 03:35:36 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
Message-ID: <20190416220536.GA3502@bharath12345-Inspiron-5559>
References: <20190415183707.712011689@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled(defconfig) and tested on my x86 machine. No dmesg regressions
observed.
