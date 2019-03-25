Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B4D20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JeHCead/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfCYQB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:01:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41192 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfCYQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:01:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so1207423pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=78N6bBaUhqLno4mdRmaXFGrpPbEVeuEDXYEjq8jp+3M=;
        b=JeHCead/FV2nCMetbc4k47K69Bzkf17fRRAEOHpPc1GF7r33lv6QzVzQHCSoTxf18l
         Zd5V3qKbqCJqN53OOOpNadcuusvH2hdNCFNHVZUAq1dcUufxq6hUHt6+mixmfOQbcji6
         xjXHAD7f4VzqpG4WVjTI5Dy6iZitlgA6oJv7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=78N6bBaUhqLno4mdRmaXFGrpPbEVeuEDXYEjq8jp+3M=;
        b=Do2N+0zHp4B3oMJBkNSQ+8PeWS5CJOh0GDOr2NhSfEfVradwVMgXf1nsYdlrtAufuy
         zGw7HLA1SgYrROppP3r7b3CGuJ6jAYPhqBZOJbzOER72yfoZpb8bxeln47F1W836cgda
         wzT6nWaHBE/Ux5XGlMJUrZIYi3PQ1EqR7Y5YDKqb0dNpGvIL81qkr9NOgYHT3Jwsu6br
         CLm79v7wcGoZeqE71qhwC06fAMXEJPs7HflrH4y5dY6LmkWtWH3T3rPmCbXDdMnAPeo1
         cUcMop8pke2GQwdDdDVpYpD71oEUQNL6BB3wqD8kMDmkhosx17ELvz/fNoeZrCoOCf4r
         UigA==
X-Gm-Message-State: APjAAAUDkJSjxrRHEk3BbHVDM46Ve/VZOiqE/jBIVC8D2kWlj49O3/dB
        OqHxFjmsqAJ7OeGvxvQDQstyvQ==
X-Google-Smtp-Source: APXvYqwxSnTo5scg1bnEk/Vx2M7vnlIshiSi5Qx2QnXqwivfhRGgmKmkDDGNaikE/vLQobRVKNKJCw==
X-Received: by 2002:a63:490f:: with SMTP id w15mr22593291pga.247.1553529683400;
        Mon, 25 Mar 2019 09:01:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p34sm26722908pgb.18.2019.03.25.09.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:01:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANNG1HUCvL3=mtitvDZ3fOtt3u5oK7kr=9Nftov71aOsUn3nXA@mail.gmail.com>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org> <20190225065044.11023-5-vaishali.thakkar@linaro.org> <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com> <CANNG1HWDc-PraBwG=8TBcfJSFFe+X+k6oVhOqyU=i5fAjpuoLw@mail.gmail.com> <155257912871.20095.1653828341120157988@swboyd.mtv.corp.google.com> <CANNG1HV0Ai9oeUr55uk+wAf456vDn1qiYmeXYc3=rkpqhdoM4g@mail.gmail.com> <155329931528.20095.6505466693897029315@swboyd.mtv.corp.google.com> <CANNG1HUCvL3=mtitvDZ3fOtt3u5oK7kr=9Nftov71aOsUn3nXA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Message-ID: <155352968162.20095.9900815050896900150@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 25 Mar 2019 09:01:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaishali Thakkar (2019-03-24 10:42:36)
> On Sat, 23 Mar 2019 at 05:31, Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > debugfs_create_devm_seqfile() which may work to print a string from some
> > struct member. I'm not sure why you're using simple_attr_read(). Where
> > does that become important?
>=20
> DEFINE_DEBUGFS_ATTRIBUTE has simple_attr helpers which
> expects int value. So, in the case of a string it requires to implement
> similar macro and separate helpers for the same.

Why does DEFINE_DEBUGFS_ATTRIBUTE need to be used?

