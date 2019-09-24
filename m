Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8D6C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B70F20644
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569285955;
	bh=G5+n0yTeI262hOAqLd2UKRmaptJSB1DKaIWuBFAS7GA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tvnrql1lVgpSDwWyZPqdJSnG0a93ZoC70IhAAcbHX24RkSAjXz14YY7TcteKT40Bl
	 3jDh9Nnd3T2LD2HLRzTTvgTAWLKITUsrQTd65ykDhhwsOAUC7sDqewiRmaqD/6uprb
	 baRtHGhu6q99g6c2jDcZOm5TpmDp8hb2JJUgo624=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503686AbfIXApx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 20:45:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33239 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIXApx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:45:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so74794ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 17:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6k/LKVxsjSrT2CO9Xt89a9E4se+ppAiNrE8ucF5Ejw=;
        b=L+OR0BsYjfCj/RTtWXae8fv9HttOeT/9/bi9Qlqfz3vbAuXLMeeyN2fkkbOU1woIpZ
         og+vDrY2YkQY9xXuyogHE8PzKTuoY7kEGyoTdzNoYLWsuWGfGVJw8tu2XtcH+Qprgx3/
         Ys5ep4nXuOY3NhTlQqyoJ8oFmqEv4HYcd+Yg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6k/LKVxsjSrT2CO9Xt89a9E4se+ppAiNrE8ucF5Ejw=;
        b=UwGuMRRR4abovPuKRYM+g3A5TH+sLHouYN08By6G3pcxDkRqwrGBRhu2GotA6IlCJn
         jdA6jEK1lTp0jemSjmRaipoCEI2x1DG2fKe4BsMkhIzAqfPVbchxfYpi7WzvK977VAHh
         jdW5/E/8P8+zYtEWFXmOuF9B4r+kJnF5rla62lyOE37J7OwablXtnPoabvKWCJVOkPrV
         YCVcUEJFu4l2OH6mS8YQIZAuOgPrhDyR+kB+qXYYDGQmVLqZUkbGZ8zHOttui/lo6isX
         9ywDKkTfSpICOHX+bm7go7WL9rYZ0tOQtf/KvJoeE9rd4Yq4KSgOukwQ6M/D2c2mlZda
         goCg==
X-Gm-Message-State: APjAAAWOEthhy/Rz8aFlaB8B+4Xzeg2by5XeaKt1buklupLMqZKkeotH
        MN7fT+m/7OETUo+4EVJPJSBptOhQA9g=
X-Google-Smtp-Source: APXvYqxFN3mEJlHuqhs/3P1z8m6JPbPxaQIRS6qCUE4oE8FDiyakmF/oYusCWE93pOQSPY2d0t7giA==
X-Received: by 2002:a2e:5714:: with SMTP id l20mr35321ljb.122.1569285950325;
        Mon, 23 Sep 2019 17:45:50 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f21sm61077lfm.90.2019.09.23.17.45.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 17:45:49 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m7so68995lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 17:45:49 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr37812lje.90.1569285948983;
 Mon, 23 Sep 2019 17:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
 <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com> <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
In-Reply-To: <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 17:45:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4cuHsE8jFHO7XVatdXa=M2f4RHL3VwnSkAf5UNHUJ-Q@mail.gmail.com>
Message-ID: <CAHk-=wh4cuHsE8jFHO7XVatdXa=M2f4RHL3VwnSkAf5UNHUJ-Q@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     James Morris <jamorris@linuxonhyperv.com>
Cc:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 4:35 PM James Morris <jamorris@linuxonhyperv.com> wrote:
>
> My understanding is that SafeSetID is shipping in ChromeOS -- this was
> part of the rationale for merging it.

Well, if even the developer didn't test it for two months, I don't
think "it's in upstream" makes any sense or difference.

                     Linus
