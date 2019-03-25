Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF43F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zP9rSMgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfCYU6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:58:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37043 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbfCYU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:58:44 -0400
Received: by mail-it1-f194.google.com with SMTP id u65so6987893itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WABXDHFfA2+4GTjIuzshcueyLCiO4qduoh74EQpZQQ=;
        b=zP9rSMgvmPiNRLj61JpnLrdrNr9BBcJrHTI3bPwYg5fV5bcrfnS2C3kZJ5nimSRXN2
         sfo3cuzkyBBGFROSgVkf627n0/P1V2+bez04xrjgMUsCVHogBPDY87Ehar2zW/7/3/EZ
         sHrIze9hNKNYQ7HpjV1QQODkl915Upwqmww1oOxxpCZg+8a7EdnjbdZ++EM5pRrN8mpT
         s8JJjWmqcAOaxb3oIEzPrpJh8dS/LC/fdAcGaKwP/YF4kp1F6TV/jlZDaZ4ueTTNrQ66
         rdGEzNk5pkXHRC4triCfNnmEW91uRwPf/55lg4ViR+26txha7u42J8u5eho37Vh6qppn
         iZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WABXDHFfA2+4GTjIuzshcueyLCiO4qduoh74EQpZQQ=;
        b=gF2Qe1IRNV9ESOszp76jTo6pE4hxsOZaDSjwPB+jlLMKeT77xYhpnR2q+4tsqN7T5v
         jR8gTdTP3dgCe6J8YC81SvB12B/k1rKutommmbOU0LZTaBTNf5TsNBlMG0+M2JhxDB4h
         zY6w8e2TuKQDkSqIPEHShUVNjeky/YZU8ofsrvuvJNOnaAC9usGJlpHaEI9Q10B/e/QN
         Imssrst9M+IqWhyCraLTv0q66UfD4jl7xwxBI50AwO56rhFrknSaFSOtDUPE4IubySZ+
         mTRWOZZ7WDRYuOFeGl7N1BZUBbFwGO/Z4ExUjDPbzeC0b3qUGYws0cgWwtkInqIS2gef
         QhdQ==
X-Gm-Message-State: APjAAAVg0D2eXCiT2ThjO2vMnzqKzVmRbAAf0MuXlu030KGggjiv2dNE
        J040tsVcLk8EO4bBFX05rsnCieJdwL/CV7agfe0cIw==
X-Google-Smtp-Source: APXvYqzy/ZSjCKJO3tqxAGrTwIa84dBUZgsw76w/LhxnJabIiRBQ/S1m0zc34MNlsOz7NZHzmMkfDGIVH6hwUzy2N5A=
X-Received: by 2002:a02:cd02:: with SMTP id g2mr19723382jaq.70.1553547523853;
 Mon, 25 Mar 2019 13:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
 <20190225065044.11023-5-vaishali.thakkar@linaro.org> <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com>
 <CANNG1HWDc-PraBwG=8TBcfJSFFe+X+k6oVhOqyU=i5fAjpuoLw@mail.gmail.com>
 <155257912871.20095.1653828341120157988@swboyd.mtv.corp.google.com>
 <CANNG1HV0Ai9oeUr55uk+wAf456vDn1qiYmeXYc3=rkpqhdoM4g@mail.gmail.com>
 <155329931528.20095.6505466693897029315@swboyd.mtv.corp.google.com>
 <CANNG1HUCvL3=mtitvDZ3fOtt3u5oK7kr=9Nftov71aOsUn3nXA@mail.gmail.com> <155352968162.20095.9900815050896900150@swboyd.mtv.corp.google.com>
In-Reply-To: <155352968162.20095.9900815050896900150@swboyd.mtv.corp.google.com>
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
Date:   Tue, 26 Mar 2019 02:28:30 +0530
Message-ID: <CANNG1HXSRnHTj4ZeWFA4ggaHytR+Zt+Fvb0hEE_Qrs3McaKFvQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 at 21:31, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Vaishali Thakkar (2019-03-24 10:42:36)
> > On Sat, 23 Mar 2019 at 05:31, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > > debugfs_create_devm_seqfile() which may work to print a string from some
> > > struct member. I'm not sure why you're using simple_attr_read(). Where
> > > does that become important?
> >
> > DEFINE_DEBUGFS_ATTRIBUTE has simple_attr helpers which
> > expects int value. So, in the case of a string it requires to implement
> > similar macro and separate helpers for the same.
>
> Why does DEFINE_DEBUGFS_ATTRIBUTE need to be used?

For defining files inside the debugfs code [with get/set functions].
Also, most of the similar functions in the debugfs core seems to be
using it.

>
