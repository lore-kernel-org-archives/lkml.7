Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73379C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369F6217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Jt06OaIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDKCtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:49:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46988 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKCtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:49:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so5381480qts.13;
        Wed, 10 Apr 2019 19:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6xfl8gBKh9FFIA3rPKH5NLT6aS53rkoUtPnn1x+5RI=;
        b=Jt06OaIpwAHHLMBsQT671RZ/yQNeBBFFAVLHetuA8J3tMg/aOUwYrWQessrnTbfOjy
         8f9S51VaOQrc9Icz+AS3A9bMJGEnQc8h4iZryC0en5r8vQsANd8uz4Y+6gLxMrbvZCdv
         1C0BLRxhfa28x5yQRq1zMPuzfOzoN1eayhEQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6xfl8gBKh9FFIA3rPKH5NLT6aS53rkoUtPnn1x+5RI=;
        b=AnBJrQXTO0eF6LJ2jKLFseqVkoMt2eG8HJ+CC6iILxERiWdt4HByvcxgR9qiINEgyL
         fPVilq+iHBaYZV/WW1JFZihWdv2E/5DGkU4/OXffn0D+5sFjwBHfTzkWhsd2zhW8JAo7
         PNn25huH7+lhdstJ7eXcM348U8euMEa1fdjGdwwV/plARzPcQa3+OQYfcgjFo3/vXcn+
         Z7NQqYhvJNUsBJXNVsQ6zYewM0vzdC84E4TYjOrx9XQhbPT9qz4JVYlftbaSqaFdFQzu
         Wn7/YHuqRfudnd4cDFFzEKGe7vJU7FcHEK+xZ9gSMdTtYi7Q0b15QpxYF6s08r5XxyCv
         56dw==
X-Gm-Message-State: APjAAAWZ69mXIRHGWKFAhoOJHwaUyxP7Z7HonA3Tsd95yWUdqoIU4gaK
        x9sipZxpudwqv92sE/AZZbcTkjHt99FSPB60eVeqvnktu3sfoA==
X-Google-Smtp-Source: APXvYqyBYzM9hy0cYWGqzI+Mvgmq4YEUqbeAPNzoBeMTvpKVBxOFdb9WtS02FWe8ruqP1HqW849kiNC3TXxbMaK98jY=
X-Received: by 2002:a0c:b0c7:: with SMTP id p7mr38314464qvc.142.1554950957456;
 Wed, 10 Apr 2019 19:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com> <1554229504-5661-2-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1554229504-5661-2-git-send-email-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 11 Apr 2019 02:49:06 +0000
Message-ID: <CACPK8Xd7uYX+=T1Bwp37poFzGJODSHZigOaKhg_W5XzVnQ1mxA@mail.gmail.com>
Subject: Re: [PATCH 1/5] media: platform: Aspeed: Remove use of reset line
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, mchehab@kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 at 18:25, Eddie James <eajames@linux.ibm.com> wrote:
>
> The reset line is toggled by enabling the clocks, so it's not necessary
> to manually toggle the reset as well.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
