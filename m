Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A439C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDC92190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="KE2L3z+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfJJXlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:41:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39033 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJJXlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:41:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so7266560qki.6;
        Thu, 10 Oct 2019 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJAWywHBsS6HezKNK9ZjvcaTD5FSbDwrNVdcNRgDm5o=;
        b=KE2L3z+yLugM41vE7B7L/+3dd9xTaYJgrmfANqDmI8fbCFLsh0UujCnqd9/8GWOH8B
         UfhgN3vbEZ/X88jSoXyYh5P+uZ43u7Nm3c5BhOIAsmbyXB7guZN7BVxGP4lhE+Tuq9pR
         TMhy5BL1/1QjqdjMRFYvuws7J7g7sEDgr0q4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJAWywHBsS6HezKNK9ZjvcaTD5FSbDwrNVdcNRgDm5o=;
        b=n49Qp9gz/9YCtl9cukmDQoiEHPY8aQAzbnn4qi6+NPvdReOIJVCsjOILs7cjz85QH2
         GQQW6tbLGs7Am2k7sDHrPcRfYjpMABlXUueXpKZsD3DvyttHuGYSHVeSfLk3GLH6aNx2
         tTf/beDDfyUJchD+XxMJBS8VO3J8FbmYtpJoO73r2iWzQXQkQ0WXAxAXrLDX/WUT6PRq
         bchZydeoRHPpkmHcZqDY56G3sMd4St59u8jb9L3ZKI4jyPN0dyatykyI3oa5Ck3Zgyk1
         Xd2QlunNcc1hDve/13svsZesFt0vBhoHGAmA6ocVT4xWwpH8pupF/k5bajaDcy4wfiss
         7g1g==
X-Gm-Message-State: APjAAAUtCKAFWfaolzfCblcVEl9uMg28GClKlIKzwRqCv5gI4QGgfW7t
        mnQjmdlUK1YDDXXbcginEwrh2gM3tP0S2h57Dj0=
X-Google-Smtp-Source: APXvYqzF4Bybt3eQo1Tnv/6kiOrhu88uAqhznHPcGo14GIAGi4u2VEbpqF+T4r85m7xuYjknEB0C6RBGaWMOJSajbhc=
X-Received: by 2002:a37:4dca:: with SMTP id a193mr12683477qkb.292.1570750908045;
 Thu, 10 Oct 2019 16:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191010020655.3776-1-andrew@aj.id.au> <20191010020655.3776-3-andrew@aj.id.au>
In-Reply-To: <20191010020655.3776-3-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Oct 2019 23:41:35 +0000
Message-ID: <CACPK8Xcrc_2itUcGw6caa8Fp3sJE8oHBO5LJgBtqScwmVAuHJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500 MACs
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
> RCLK is a fixed 50MHz clock derived from HPLL that is described by a
> single gate for each MAC.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>
