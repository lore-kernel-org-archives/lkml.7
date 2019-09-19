Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC1C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A7021A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaIt1v1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbfISKDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:03:05 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42146 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbfISKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:03:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id i207so1007871ywc.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbfIr6OQXLdhxdBKJUGehYuATbbMYOVoX4Zq+xNFWpY=;
        b=vaIt1v1ngk2wUVJXcbIHoIHXLmL/TBHF0n04p8ml3Py/MA8g4KOQUuvYwT3L9s9lLi
         c9v3H+DCeAX4bH8w3y84lLDGBPr2tjgxd4n7PXQeYGJBGs2e/d9aeX1iCXoCeKVvSnEU
         opDhtHqI72jUR3nG0aCOgdYskGwyuPoqGWbUvQCJ4Cyt6bjzjYgSf6zi36QDsUfVkOUc
         ZjoQhb5/TqJsZfKGFPlX6WEXMPWejaQbqucBQsLipMfyl702ZXRD4bv3s7v/dh0LHXOd
         aaOnM5Vp0EB5wWTC/X7MgBmi3M+cfNVbZ8KDCF8QxdZHFW3zqusodkQ1qDSueoZJnZpJ
         cxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbfIr6OQXLdhxdBKJUGehYuATbbMYOVoX4Zq+xNFWpY=;
        b=l4HDfsItlKstJiSlU3YoWNFFyI0YOAAAXsP5nA0v35Knwqf0v8q1wJMSnODmwyn58f
         KMXCUiczpTcg2MRuEpN5f5KZuxM3zXTPkJe/XAeVgO+7tqFn641z9SH89RO8AMzfYeI4
         ekIUjMbTFxBrXn3in4UaPEcrwKh5is/Wwp5CfzoaPtnEpsT5oibST1VzrKZW6HZplK9K
         ThisX77tEGFIT6sD6eeUTTE/GN+gdKjgzt9rACNxr1M0QQoQU8SSmoPxDc7KUUDO+w6O
         6UQgmoqjynRtmz8DNCjRpNvUKr5MHpnqnTdM/9yCyfAvIhOwzRtPwJY90503oPWyWupY
         zxnQ==
X-Gm-Message-State: APjAAAXmLoFJJGkSGrxeevgCHp2Rbaerum98fv5iZYdDYrtkEZaI9qjg
        S/TRQBm8aOwDh2vSoeFgZymmS+dOHGVsTNIIl3g=
X-Google-Smtp-Source: APXvYqwm40n8QgsVc8kcRdeZ+GCKm2aFLW8M50nQbNWhjhpZ3gOFAMo8UIPXBM9A5RhIkOhVGakOs4Su+Xkizx3vc6g=
X-Received: by 2002:a81:310f:: with SMTP id x15mr7045781ywx.257.1568887382238;
 Thu, 19 Sep 2019 03:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <1567687553-22334-1-git-send-email-bmeng.cn@gmail.com> <20190910061431.GB10968@infradead.org>
In-Reply-To: <20190910061431.GB10968@infradead.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 19 Sep 2019 18:02:51 +0800
Message-ID: <CAEUhbmVD8bfmELA30nLa-P5Y5CL4+z-R+bR5H=fKanuBrTNvwA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dts: sifive: Drop "clock-frequency" property of
 cpu nodes
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 10, 2019 at 2:14 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Sep 05, 2019 at 05:45:53AM -0700, Bin Meng wrote:
> > The "clock-frequency" property of cpu nodes isn't required. Drop it.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

What's the status of this patch? thanks!

Regards,
Bin
