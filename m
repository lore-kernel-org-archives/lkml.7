Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B341C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5018820684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551745408;
	bh=PewehnSq3c3k8NIBiD7/hHc8GAvtJcUxcQ+QCIK57/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fg3Kp1fcN12VgM1in1qgzT9RBXzGSyecxiIqlN1Jq7emZZMmB2sQZeCg2XU2w9njY
	 wIObBxOEfk02JOvoDKuLtTqC21d2Eq0QsLXcngvKi1uPSl4IswftNo9S2NZssYtGcF
	 5G2BTbWXKoiLr4vviY1WGlhjGs6kyNagPrsh1q2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfCEAX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:23:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42587 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfCEAX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:23:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id d14so5972721ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fBZMds7fXJxOxATQ64cCYfev5cnLGxAAszQ8/tSaDI=;
        b=gY5qfcjytdBe/Oq3SVD5wBlfKUg42yBqqdrSCguMLmfDfA51eHijV2fj0IEWKVHOJY
         sjkrO3nJzWh0f2HUh6gBwl6/8oIwHSOxAaRFUeMAz0mid79qpmcwELMQPcbxQ/UpS21f
         szAI3XL4/qAo1SWxvLZkboaNNqdI6YPtI+CHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fBZMds7fXJxOxATQ64cCYfev5cnLGxAAszQ8/tSaDI=;
        b=S7g3Lr+tIIdQQ57p7Y08cnVrwb47tR25mqD9YHO7ceyv8qJp/Usd3OA7NQLIP4cbAY
         5b/myj/RWOv4HI81CzWRk65HoHgr+M7xNJ1RY4aoKhEP1YMgzju2xX8q/QiqvgSdqKLj
         VO/jEnlgM3c7lxZF29NCo2wIDSn5nejlxSNuFWma9N/WDtcbQd7pOPsbnbeXWW9W8oYc
         jLqCtX89UMiu8A3+oKf3Jcx/vTZxPNin0smp+pqv0/ZB5h3oeEmO+lcy5YUNfIY8RFcN
         0AjMwsdnBzCZamRuWUrQdoZCH2dQu4WTaLsobSsvL7SixINTgeEa7u5tvAoSCRQPHMV/
         MFBQ==
X-Gm-Message-State: APjAAAXDipyosdjIpQ/WpSAhjJ1eGiMGerUhK339g5uMbgrFRxzDi8RI
        g6qpro+v5ej5hFCHJo2y24U2WwHbogM=
X-Google-Smtp-Source: APXvYqyYOPYTtvKfUAD8biJSO+FGYbmSyYcw/peOX1uniAER5498kVMgHUeOXqis/fz8VdVM/Mqb0g==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr12808477ljg.146.1551745403614;
        Mon, 04 Mar 2019 16:23:23 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m77sm594414lfe.23.2019.03.04.16.23.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 16:23:22 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id z23so4870872lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:23:22 -0800 (PST)
X-Received: by 2002:ac2:5542:: with SMTP id l2mr155684lfk.136.1551745402316;
 Mon, 04 Mar 2019 16:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20190301200835.18286-1-jannh@google.com> <20190302034017.GM2217@ZenIV.linux.org.uk>
In-Reply-To: <20190302034017.GM2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Mar 2019 16:23:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJ1vY9Gte01+YhEOuKHbd=u4zwPxRCOfuiHw-kMvE26Q@mail.gmail.com>
Message-ID: <CAHk-=wjJ1vY9Gte01+YhEOuKHbd=u4zwPxRCOfuiHw-kMvE26Q@mail.gmail.com>
Subject: Re: [PATCH] fs: use KERNEL_DS instead of get_ds()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 7:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> No objections, but that kind of stuff might be better done in a different
> way: ask Linus to run this

Your script is disgusting, and I will not quote it for posterity for
that reason. I will just say that git has a "path exclusion" thing
that you can use to make it much more streamlined.

And I ended up going a bit further, and just got rid of it all in
commit 736706bee329 ("get rid of legacy 'get_ds()' function")

                  Linus
