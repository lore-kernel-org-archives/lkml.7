Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0920679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZqKWS/7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfHEKnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:43:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37596 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHEKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:43:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so57485867lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNuA6/9fhDtZ2LA/XhT5TM5n9GcO4T42zHctSuCq+QE=;
        b=ZqKWS/7PAIhTkrjtw+GzHRAkD9966ILvMv4i8DSD/p0C0m6oeCBA5UKCB22elJeNfJ
         zWiKm8UHSaQlH8pUZ3AZbvyx4ZBqw6BkeYLgJireYNPJmj0q2uqDnTzJCp/jQxiaax89
         XCh32PWzJhWMXrG0JnXQJjWeNR65juG44BK9cUuZ2gKq8V14CF8zLoJyE3HcYK+XMi2Q
         DQtRf+3O3nR21FO5G/p3IrM7QSNRG15P4rv6CZEdT3mTViEGqgzNB+Lz65tM2cCIbL/b
         Mdp/TrttDV5dSNyEqTNV3L8pbAvkos2UKTsF8pX+/GaSCsnWP0IqyW1tDstJWH/iA/sw
         MBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNuA6/9fhDtZ2LA/XhT5TM5n9GcO4T42zHctSuCq+QE=;
        b=XzS7iaWmvLZjh+qbS/1m6jfpolmwJjPVCfULn6j8irovBQIvaemwC7Xu7bgSYjvVv+
         7y8GPU0s7NwdYE2mQ0P8MKrTFV5Rfeo3JH37vIlSLlVkfWW4EkfbuOip7j4HsI8td112
         ChvIUqhCZULepOzDKqJnMSLqn425v3VY0IrrffqOgUuA5OkIDxz5as+jDAOg+Nm5yu7W
         aBLJNg9yykgSl6933jUZuP8DtlFB5V315TKHxy4JZVlMo5C5Q8P4WVan118j+uJO6V4E
         FrwWtIkVlh4JxFBRFyP3zLmWIpeUh/RUOnZq0NczLQuCYrPgHgVuIRLImfN/TytNZhm5
         z6xw==
X-Gm-Message-State: APjAAAV0aNJCDAn624PrQnMVzKTNc5BM20eXiIqSJZVhrObUgm+EXQhf
        GSVUyAFAPw1pBigkJXc2oxz3z5SG8ofo91HPbozu8A==
X-Google-Smtp-Source: APXvYqzUEX+wRaUh5h+0CMDXrhYbMXJyYq5FgUc0gxHkybrHmYXBX420COs0UI1eqAlKWrcY6dDdA4a4Mno7k+9cWAE=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr1415879lfq.152.1565001783694;
 Mon, 05 Aug 2019 03:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190711041942.23202-1-andrew@aj.id.au>
In-Reply-To: <20190711041942.23202-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:42:52 +0200
Message-ID: <CACRpkdac+yqO9BEJ67UMD=uQVfMzE=s9oHqaSOB20-OboBMVVw@mail.gmail.com>
Subject: Re: [PATCH 0/6] pinctrl: aspeed: Add AST2600 pinmux support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, ryanchen.aspeed@gmail.com,
        johnny_huang@aspeedtech.com,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I applied this series now!

Thanks Andrew.

Yours,
Linus Walleij
