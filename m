Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A519C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCDC2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH7qnYlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfGYP5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:57:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38384 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfGYP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:57:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id h28so34862102lfj.5;
        Thu, 25 Jul 2019 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULqYeDV7I+6CArLFFBJl7JIclOwD5fdG0DCdL0ID39g=;
        b=hH7qnYlQOgtEkGULFvgqqd6pobshyPWqrWTY5b8vJjxGtBApb4EKU0rh1RtC7SW+6n
         0b9bxa6/DcvLIMJUgAv7BSQL21pwQdWbm+3unLlDtQjbtkPQxv7nYxxJIpN0gRwreDe0
         AtwTtiTJFrcqFgC+6abOSSL/VD9JowSFzj5gmrsILwRFKzKXCMy9fNqPCmpFF/LIgemH
         lYO49JWCKg4ICOspYlS+qAfInZhHq2ZNhPtiuqQtgI12VjRZQjiJpM0w1KEiXLlscJMy
         3BnRDCyNZTz+8UrsU2+goQWWezdZdyToJqKK0RnhfshARMJAkMZEUPPjL3mPZOHtjtxc
         pVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULqYeDV7I+6CArLFFBJl7JIclOwD5fdG0DCdL0ID39g=;
        b=q5O+mYVu0o+dbTZZvqjdjzq3AuI6ghkDs52AOQPxur2xbdVz/hSM8wLWryyiJCZW08
         RH9Kvi21og6unc96gi7+yazM9gJh4JkuJNXD7SiLp/TUq8e5zCVc7FP/wwwKMImTVMQJ
         p5KivZ++L65ZBMyslVCAwX3XHqiCbkF8Rm4eU9BObuvsC6iNwTDzGqBBUgSFxjlrDWvA
         kLG/aP1hUYQmuJLdiY3StcNmJSqgDr7m/T/zF5ejbegWruw/Dzfs72peU4tlHIZPRtWJ
         e/+AKIJ/+ObTHTq99OOM8Ge5Gr1JVx4swFIzKXtbFMJH2WXhVKgDzer14yTcqmtZdXGF
         wCjg==
X-Gm-Message-State: APjAAAV89WdiMjNtFboj2L8r0NH+PmZrwLdv+U6idJHjWtzFPl+rXj+6
        H40HJyadG5+L1OjggdBsRV73410Seyjumv+dtXA=
X-Google-Smtp-Source: APXvYqxgkTZ17uGidNHCLcVQ1k+j0kRbUzI/czHFRvg1thsCFWoyoIlu6IFy8abNhWLViHDmt/UTpuBBcWZixvP2XAE=
X-Received: by 2002:a05:6512:21e:: with SMTP id a30mr22025838lfo.107.1564070220267;
 Thu, 25 Jul 2019 08:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190725121452.16607-1-dafna.hirschfeld@collabora.com> <20190725121452.16607-2-dafna.hirschfeld@collabora.com>
In-Reply-To: <20190725121452.16607-2-dafna.hirschfeld@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Jul 2019 12:57:02 -0300
Message-ID: <CAOMZO5AH7Rdvh+wocqHXYSOVbK=jjCANgG=BzD8Kx5XSvK5f_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: imx: add imx8mq nitrogen support
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:56 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> From: Gary Bisson <gary.bisson@boundarydevices.com>
>
> i.MX 8Quad is a quad (4x) Cortex-A53 processor with powerful
> graphic and multimedia features.

Instead of describing the SoC, it would be better to describe the
i.MX8M nitrogen board instead.
