Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927BCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C85F233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6lfsgZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbfHVTrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:47:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44157 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHVTrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:47:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so4257632pgl.11;
        Thu, 22 Aug 2019 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geKo+r4JpYsWTyWrJg278HrPmOhiSRe0EiDLQt4J2MY=;
        b=a6lfsgZHZTUqp/CIKlh691UsSMy3tNcuTSdW59qvWTTNQuxhgnRBn+IJqoI+N9FJJT
         ru9IcW3OVUaw5WYIyI+U5v3Y8iIpIMBoUvyqkfXRsbscvxr8PW51w928bpbJtI4tayZ6
         Tfo5JnDMz0tfnrJuQfgyhI2N+8iirlMe6fkggA913cL8UPzwBwHSRkRduoC2vxNVi8yd
         ZYt8S1wCoMawjxJSLxj6TgSI8HoWW9dQi99O6Eu9OCSOSciYhqTTfBhukd8gcwVA3kv6
         Stl4xLuIdkSw+3Fv6an5SA9gpikg1+5PMZ4zAl7JxxgWwSRfhak/JlD4ENAl/aee9DCn
         1Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geKo+r4JpYsWTyWrJg278HrPmOhiSRe0EiDLQt4J2MY=;
        b=iOSUVIFAk7omqCmsW9U97a+DapvvazuuVEYKTV2Tdo6E/J/XBebLV04cGY/ldJxsV3
         Vzo5WDavUgFQdFpa9IFAAVptouYEkONAQmdaADPCl9Fm7cF3v4BAiPtzYjhMlnCV3vtU
         4onwjoN3AvEvW59hkbHsoD8vx4Qg/vhF3cWRsz2gTTPTIbEMow8uz5mEUsG9KKdWCMAw
         SfyntnYSZHBzFgJqennpGiNDflHoa84hyrleZKr0Irw33vLBBbgbrSqYm/btPrxPebEe
         +y1BgIjfEhDZBe7mKjKNl5SCtWCjmSFCI6vsFOJzLZuj/d/kW881izuDFJdUVXTzGoZW
         NIvw==
X-Gm-Message-State: APjAAAXSJ22mzUOEPW3LYYKCbMgxxXrss//tpWIvOwtC2lda4wXJmk9/
        9SyJAoY/pqn97WXkI6bzU+EMUb/Q3m+h/m3lhPSEzUa2UIs=
X-Google-Smtp-Source: APXvYqzrpL9qj/EmLT6e3tFYK9qL3VK1t38d28pYNQeGk3WBfjVb4bjJ/bbHG/cTwmU4V1l3q2pV8jviw2jK/sH5eBc=
X-Received: by 2002:a62:7503:: with SMTP id q3mr955466pfc.151.1566503237379;
 Thu, 22 Aug 2019 12:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <1566294992-703-1-git-send-email-info@metux.net>
In-Reply-To: <1566294992-703-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Aug 2019 22:47:05 +0300
Message-ID: <CAHp75VfFf7y5iLHSgS+mXa4cE78BC=maF6PWtwEGfgyi2pXKCg@mail.gmail.com>
Subject: Re: [PATCH] platform: x86: pcengines-apuv2: detect apuv4 board
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 12:56 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> GPIO stuff on APUv4 seems to be the same as on APUv2, so we just
> need to match on DMI data.
>

> Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe

Wrong format.

W/o SoB tag I can't take it.

-- 
With Best Regards,
Andy Shevchenko
