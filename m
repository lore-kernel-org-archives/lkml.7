Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C38FC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3770E2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Fk0UHyv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfDXBoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:44:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44078 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfDXBoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:44:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id s10so7705989qtc.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 18:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=iaiGitaPYWwoACiuEl2V/YVAyOnh2DD7B5fKEozHsuQ=;
        b=Fk0UHyv3s5A80Gj8y7jlukFKtiywGGo8CiWv4CTcCM1+y1fv7iJPmq1KVZqkEF9XK4
         7OXhp5c6/q1daP8aXaUFi0hiF55Ha/oBB3t8LrMHzWprNWOwCm0LUC6ZZ20RQHKJggFw
         X5XtNHkSntEF6Agg8pnkUNQzkGnlOAzQFFWHm9/dSRqKnwiOschn+UFVT7ZATdzSmBYn
         J6Ls2ox8FoaVNid5qFDa8ORWJfeSizow2jSaUyjUvmRMDqq7WjyEs7P7lx42ijH6MdRy
         kHvrNaWNt6uQemHRxD5cxFbFkYx5iIqByIDOaNoMXTZMaRxhL/cjXkcuEXIInR7ylFan
         AEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=iaiGitaPYWwoACiuEl2V/YVAyOnh2DD7B5fKEozHsuQ=;
        b=daBfQXNdk31FIi20wkLwgJaIhsEVYCTkF8Vfl9cSUIkrgZv+eLqMN8XGJZ+vLe1GqP
         NouKqJnN0lnTOZr42EiUywmjsN9XkCjf2dWRIodCQrmEBagF4o6KQvjRonK1Vmzv49Me
         7lZUr6VBOcF5YF+4v4PwMi9LCoexCg6M19o+aEcBhje3gjzM34Nhuvd3MRldLfLDjiGA
         Iyjqf0oCQuCNOMbEmqgP4Ln4KUtGMXx7aC3IkU3Uojvdn/uNWvRqW/OmH4zoAVwDsbrk
         1tLlHZmiGGyFUwG9sOC0YpyU/TC2oO4Rb+78uqvj50yshGICdihci4K61yvkreEOZzWU
         mWJw==
X-Gm-Message-State: APjAAAXN4BZqhS6902mQVK2BtyzOTAdkOnw4jqzkIGYiruVTivNHn6So
        xCvanklwsvmJ7U0KwdjAkWaXjg==
X-Google-Smtp-Source: APXvYqwUx7zNWXi3F6GurL4n/KvMjkuFsuW5f63GeOWNzBNlSEre6sZ8PSzzcADgDQLyAS59giDoXg==
X-Received: by 2002:ac8:2371:: with SMTP id b46mr23906414qtb.270.1556070277615;
        Tue, 23 Apr 2019 18:44:37 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r4sm7682721qkd.84.2019.04.23.18.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 18:44:37 -0700 (PDT)
Date:   Tue, 23 Apr 2019 18:44:33 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Tao Ren <taoren@fb.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net v4] net/ncsi: handle overflow when incrementing mac
 address
Message-ID: <20190423184433.764674b8@cakuba.netronome.com>
In-Reply-To: <20190424014310.24253-1-taoren@fb.com>
References: <20190424014310.24253-1-taoren@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 01:43:32 +0000, Tao Ren wrote:
> Previously BMC's MAC address is calculated by simply adding 1 to the
> last byte of network controller's MAC address, and it produces incorrect
> result when network controller's MAC address ends with 0xFF.
> 
> The problem can be fixed by calling eth_addr_inc() function to increment
> MAC address; besides, the MAC address is also validated before assigning
> to BMC.
> 
> Fixes: cb10c7c0dfd9 ("net/ncsi: Add NCSI Broadcom OEM command")
> Signed-off-by: Tao Ren <taoren@fb.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
