Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB1DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351962083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dfKIE2Nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfCLQcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:32:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38165 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfCLQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:32:35 -0400
Received: by mail-it1-f194.google.com with SMTP id k193so5518829ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gFPryUrYS7vffowFXQWUEV10mJmyY/YdZ7f1r06JmoQ=;
        b=dfKIE2NfkM1vbY8wnijPmACa8HbxZmobYXZDmNkxdvaGaEZ8xhN3UWs1e5MD/S1WJ3
         isFQXldV6Kq66t3wBpaQh//8qrpd4KbKtwlmtQW9fcSxwc6WhI0Yal8D8PtyfkVT7i2Q
         mXncVCDhyRqm4zCBrI4TbuQlXpKN/edSJkFc6UCA7vjl6mvm14XKJvijbfsxcwck8IFr
         lHinf+2v9e/2TY610VVnP573iXUcRprUwaFbh1fL3D93coFWL0QqAYIssazHNkwWWOYk
         jKWhBHKRoamWqkyO8KPdt+j4pIWevvmnJBAoKTGMJwbBbCxNLQH+Q0+YgGlAH6AMUpoX
         lnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gFPryUrYS7vffowFXQWUEV10mJmyY/YdZ7f1r06JmoQ=;
        b=aI5YNMNt0/CkLosQcce6lumvK50riu5RvLBUWfIl2zelOFCiAulfrIMSPCUVF3DUl1
         7X6EW7n+SJWGFNmrH3w4BYxU/Z9Xxbon3IhJ34TwjjKrdLQ8bm1yQCAQoUx/1cydrzDv
         S1rgI6yBlOYqkVxqFL2FFL7a/OFo4CrXcwNm+EiSAzffM73rLA9Bi8yDD8/Q8jPHSzRV
         voBbFBrEpq3qLKL4zl6p0+gDsbBRKRuXhz5jVNA8wLjxjCyu8XQRMmKNV/gE+QOY7Con
         gPKTYA954X7XTVg2cWfUWQMPgQE0jRu38TJX6+xarNJ9t5f7d0n/iuswrmev/mgwhw/O
         aAxw==
X-Gm-Message-State: APjAAAWweRwIpU82M3lo3nzSwpgLUKnaJMc5IFUJ1iqeT8mVmENqWK3j
        QGEY8HZlkJzsID7lHArETPfKWA==
X-Google-Smtp-Source: APXvYqxLp9h0zjtRF4n6JGDP+pxpQKCzjZToo0WRnbmWm4O1Rkk2ahbUchLqaTOdbBFuAnv/WCCroQ==
X-Received: by 2002:a24:1947:: with SMTP id b68mr2327795itb.121.1552408355047;
        Tue, 12 Mar 2019 09:32:35 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id f9sm379431ioo.24.2019.03.12.09.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:32:34 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:32:34 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] L2 Cache EDAC Support for HiFive Unleashed
In-Reply-To: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1903120925400.26459@viisi.sifive.com>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yash,

On Tue, 12 Mar 2019, Yash Shah wrote:

> This patch series adds a L2 Cache EDAC driver and DT documentation
> for HiFive Unleashed board.

This should also reference the "FU540-C000 chip" since there isn't 
anything board-specific about it.

Also - could you please describe in your patch 0 message what kernel 
commit this driver has been tested on; or, if it's not a mainline commit, 
what additional patches are needed to test it?

thanks,

- Paul
