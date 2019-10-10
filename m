Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F6AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6FE20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="cO4Crqi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfJJXmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:42:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35531 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJJXmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:42:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so11338910qtq.2;
        Thu, 10 Oct 2019 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9QoBYfKdHi53Oe2RDIOZ1fzd9eCKG99mcIBTMrkokE=;
        b=cO4Crqi0GzQ/SvRKjHRewM/6j5N3rPugEyhlFQAZBlUAKfoJTxKICJKQKZ8FBeVlAr
         zuquO0vrc7zgoMnhK45GwcTxKyziTrdzB+PgfKobgtANFJHI1/2RXmDgqtidhyqVrGOL
         pjOUdH0J3wO5zQ2DAm8yztXLZqxwAdj9HLUyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9QoBYfKdHi53Oe2RDIOZ1fzd9eCKG99mcIBTMrkokE=;
        b=KKCFrXRhc2aGKv7TWttoTs2BLfE1sf/qK5iWy23SzJ4X7EFmMch1Byi9fm8OQ3zRm0
         yuDCgoPd4mb/cDjN/ZQCHo/aoB9w/4Q2rvH3nFpB+yqiHqUhcJpwSq7zwdpvj481ed+I
         SO4hKDMNJViA3/XMTs1BkzaWwHujtjkvCnXVVT8nTar7Zbo/m8S77XzRwCsWQzx5y7Dn
         /UEvB0KR5g6uIo0v4O6NHhBMX+VkhDe454JX4Ezla3GI7v/HSVdmJG1BtkoLmQnknMJo
         qLtA/4NrREuHS3Fm9f6K5VXsjb8e7ktr9kFZ5266TYyYfStFg1TQO3H/mKHS489ZlvcG
         3edA==
X-Gm-Message-State: APjAAAX/03/7i7RYpiO7eI4dfJnC4cuUFs8GLdaftWQFdMcx9CKmFeJP
        tl7WDDatlhVewZUVJTfTd8Alx3C8+GY59viOVig=
X-Google-Smtp-Source: APXvYqzWepm2QMbtM7Mlxs1tWOx71xVvtmYjHL4TbcTYDDyesblSnW1JaBWkhPEpMEvXlcb/54LEXpm0ZrudpV1tBa8=
X-Received: by 2002:a0c:f792:: with SMTP id s18mr12877457qvn.20.1570750938971;
 Thu, 10 Oct 2019 16:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191010020725.3990-1-andrew@aj.id.au> <20191010020725.3990-2-andrew@aj.id.au>
In-Reply-To: <20191010020725.3990-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Oct 2019 23:42:07 +0000
Message-ID: <CACPK8XfqA3O+qWASdZdua8oDqe4GWVjB9HkSu_Aw8jqbQ9QHBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The AST2600 has an explicit gate for the RMII RCLK for each of the four
> MACs.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>
