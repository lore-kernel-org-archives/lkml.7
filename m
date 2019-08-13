Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8ADC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166A72064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="weur1ciJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfHMHPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:15:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36995 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfHMHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:15:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so105425008qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8Vm8qKHn+LLHXv645mJ9CCM93oJwj4ds1tExL4TPwg=;
        b=weur1ciJNB0c2Ydn/tXH5TbApVTHeLKgj3aUj2q6HtXboQPd5ONcqH8BGCKBDRDvYL
         l4PpS131R7Z05t/6SzwRzdl98TXxhfxGBGOSKPvIW5g7hznSKr57yC1skkeWOdr6qCxQ
         ZS26R6N+RJL0/H/WLBByq3BiBJ836eWUFAxrYCRbsO+h4iVBKAvvn95nCM0dpVViiaa/
         Jcm5lzaKNFYgah/8x3RG3nq7pUcsOoBkNUQ+YVZTgUS/mENXA+CyGJl5ENdf9QZh5o6q
         xAqMfHPrcSpfpdZfi8RX3+xC+I4EoFM+NLg9BOuAJGPn99iJt3V5gfzGbzUCr7c7IsvE
         r9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8Vm8qKHn+LLHXv645mJ9CCM93oJwj4ds1tExL4TPwg=;
        b=iscQEorKylXDEPYIjoxoNs1qykm3rXAlSoCV15iaIzVKcUYbdSSx9CwYmkghm48ekb
         51zRqd7nuXqzNU5ynTe4IUxgVxgnHpPxgXd808TBK8pe9wezUPzaibKWSJFRhcEp3BA0
         w7NnwTjzAn30UAVQk3bQQbZHq/vKQxVS/P5EQ6kiW2VIJtoNUrTyMvXxxZvbOYCr8aYS
         CHy8GPu7a6pKA9dlHEcVPa24D5i+qdf1ejxthQElfarttFCCLjsLvzADYVs72PypTM5+
         nHGfPGtjPvQgSYVGTzFpAPjGgyrAnopk4+RE20FNVyQO3KdY+0t/rqOvVapfTwdjXdz2
         h+VQ==
X-Gm-Message-State: APjAAAVlq9GpdTHqkNKvXxNH34QxFnfHh3gePbS3Tq54c9fM0xrvBENK
        NKGy/zjHfsz691az8tSFzecxBo81a504feVYIII19Q==
X-Google-Smtp-Source: APXvYqyu0kNB2r7jqKEB5vIzNuhGX7Fl1NvnQaovuv67dupIefbkK72n4H8JPszWbVJkp5kEWzuFvZtmL2YlF/ckPrI=
X-Received: by 2002:a0c:c688:: with SMTP id d8mr32921143qvj.86.1565680542157;
 Tue, 13 Aug 2019 00:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190805131452.13257-1-chiu@endlessm.com> <d0047834-957d-0cf3-5792-31faa5315ad1@gmail.com>
 <87wofibgk7.fsf@kamboji.qca.qualcomm.com> <a3ac212d-b976-fb16-227f-3246a317c4a2@gmail.com>
In-Reply-To: <a3ac212d-b976-fb16-227f-3246a317c4a2@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 13 Aug 2019 15:15:31 +0800
Message-ID: <CAD8Lp47x8HOtVFBtBcp2uu3_fMyteEma5+5wr-dObWTtC1Q0PA@mail.gmail.com>
Subject: Re: [RFC PATCH v7] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Chris Chiu <chiu@endlessm.com>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:21 PM Jes Sorensen <jes.sorensen@gmail.com> wrote:
> On 8/12/19 10:32 AM, Kalle Valo wrote:
> > This is marked as RFC so I'm not sure what's the plan. Should I apply
> > this?
>
> I think it's at a point where it's worth applying - I kinda wish I had
> had time to test it, but I won't be near my stash of USB dongles for a
> little while.

The last remaining reason it was RFC was pending feedback from Jes, to
check that his earlier comments had been adequately addressed. So yes
I think it's good to apply now.

Thanks,
Daniel
