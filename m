Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC7FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0F820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maX1fJR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbfG2VzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:55:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46592 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfG2VzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:55:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so60172474ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBZi/FWYMVw+6x0q1L6ySXMBwWz8l9YOs94KLfDt+sM=;
        b=maX1fJR459j9bTT/i/FcZluuRJjdtq45t9ua4H0lkFp2Fvu8AvbQWRaoneF4GAendq
         GGsgRy5RasAfnEje6j1sDASgB3suDqgvaKXKvOHPqG35uRffPpCagqEr3tFVfyYOXOF/
         Kq3UZF03LBdNOdM8qNvFlAdI6otpsInC+84EUBzJi34EM8FcQdk5cKkl0wWCEC/XSUOe
         e+BX2jzySgUEhjUc3lit2/Pj/8p/dS0y8IVUKLwkWDr43YNOFDjh325Fr5uHGOso3mkn
         ZkihBU8oefvkAd2bgl6jK3GLZUvmL29WrT+9t6rAvC44wC+Id4+sg/x0ZNGWL0qPpgY/
         +VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBZi/FWYMVw+6x0q1L6ySXMBwWz8l9YOs94KLfDt+sM=;
        b=s15Lq68kBMSpWL7OxxP3PGDqtyKj7Qj12VGHf2cYMUYNrFK+KUQYiXgdAIVomaoU9/
         3P0fcS3fJNh8o6gpPBrwhYUWU9HtaAIHeJ0drK8K6ZZsuBBoYSpYLiBicJH6yQ900XSc
         C+/X6DTiV6X6gbLWgTL5iGY/bU+XcUuUApQK5BZOz21sNDkcIUGinW7bTlSDJ2ColWr/
         KHU41NMQv+VBk2qR23Wu8UJo9HJ6tt8RuNTlbNfZUmxrEVD1tYdlkZQxyu3l71G1u4x9
         hYGiE4iTWkSBpIDLZFz1h/AZgHEv7GI0l/yXYDh0txgk39sQQ/M6iJYWxAuqjlyvkdE+
         fylw==
X-Gm-Message-State: APjAAAWOeVbAUkrH7gOGyY802L74j5aAotYXyt37sMEWWRV8KVplxziJ
        +yngCTvzHywpTV5DcgwxLcG8CX9j/BIEhJyCdnaNrA==
X-Google-Smtp-Source: APXvYqz8xsOtkV0Tm7m5AoyjAnnPZwbpq0fVDCw0AcnBfOy1aP/HBlFsrVX+y2EqHLqO/PlpIPBTliVBh7mh/LILCMU=
X-Received: by 2002:a2e:9593:: with SMTP id w19mr12076182ljh.69.1564437313862;
 Mon, 29 Jul 2019 14:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190726053959.2003-1-andrew@aj.id.au>
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 23:55:02 +0200
Message-ID: <CACRpkdZVVgqdt=+YYEauChoxjqKk6=LNKzj-40u3CFLxJr0D7Q@mail.gmail.com>
Subject: Re: [RFC-ish PATCH 00/17] Clean up ASPEED devicetree warnings
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        anoo@us.ibm.com, a.filippov@yadro.com,
        Arnd Bergmann <arnd@arndb.de>, yang.brianc.w@inventec.com,
        Corey Minyard <minyard@acm.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        haiyue.wang@linux.intel.com, wangzqbj@inspur.com,
        chen.kenyy@inventec.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        Patrick Venture <venture@google.com>, sschaeck@cisco.com,
        Tao Ren <taoren@fb.com>, xow@google.com, yao.yuan@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 7:40 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> The aim of this series is to minimise/eliminate all the warnings from the
> ASPEED devicetrees. It mostly achieves its goal, as outlined below.

I suppose it will all be merged in  the Aspeed tree?
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
