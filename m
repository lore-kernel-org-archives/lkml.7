Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE18AC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 21:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D7D208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 21:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567890824;
	bh=quLzeutJ0LxF9NYR8EzYXWZfe2MsUzOP+cm5HAod3c8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vRBotj6u5z+o7587a1tLo9o5C2V73opHLulW5CAIxVwV2vEOMbFIcxDQYh9mvGQvk
	 OLAEu2DQB858A5Iiy81is9nnxQ7vTLQjodzxzR7BJLfMGUlnGPyeHzVDQPHqXLgbLO
	 Z5EaVciT+Ild87cZTD+UqYs/N3UvE4d++P7cuG7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436728AbfIGVNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 17:13:43 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:40689 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406397AbfIGVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 17:13:42 -0400
Received: by mail-lj1-f179.google.com with SMTP id 7so9123171ljw.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Urb2igNOM/k6LW8dmJ+dmnoxLtpMZlnMIvradymUuao=;
        b=NalrJQYnS2Lq6ipdTM/V2zDvgV3EzpivFmapu6nOmlZXtGrOWZT/MsiOTOHZP6edNd
         8v1DSeBJh1/V6FHPBzvk0lk2EdavevsknTPiTrDqATOLgRGrwlgRqsW7yWmlE1lBMktF
         Q53las5gIYHKoSHAWlKCGfNOobRxKF5amXtBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Urb2igNOM/k6LW8dmJ+dmnoxLtpMZlnMIvradymUuao=;
        b=OgpS63iKrkgBAPtwyUj4h85GndTrmqD62Tyyhu2fidm/WmwCiyRjc5T2cGiBNnCd64
         X39GotIAATktciby9jFrwQPlIgvkWzBP38pRXV6oXPlqlvHUE5JlfVJi8x69BufxM8u6
         cjGXkWaY7ZuQjX7oLBrwPHmlnroqnAycJtYAPi9G5+8WwJgDb7vYsELV9lPGiGq9Zy/o
         iWUGYm67LZA/TtedvBWNkdLJJfRtcZ8y1FXWS3QDBRsaIUqUuLVHn9oReIxyB+SYDQjy
         BU6CEXcSpVNDHNy+Giqora4bKCKOg1jjvQSRWuFoPfFDdFvuGI45oVQgu7/pyudEgwPO
         HPcg==
X-Gm-Message-State: APjAAAU53fxIAWxcvC9Vp2rfwefvlfQ6N5gpo15PEmJqxThhMrN+padG
        ohJRbDKh5Cbf9qk6hqEuNvDPmeA1tcI=
X-Google-Smtp-Source: APXvYqxiJWSyX5kuz2QgrBqp1rovpmOgQ6zU0ySdoC8OPgXMMSEXlJfoArT6lpaN6wyNvDvnZiZ3iw==
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr10341820ljj.5.1567890820106;
        Sat, 07 Sep 2019 14:13:40 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 6sm1855713ljr.63.2019.09.07.14.13.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 14:13:39 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id e17so9097471ljf.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 14:13:39 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr10530428ljg.72.1567890818839;
 Sat, 07 Sep 2019 14:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
 <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
 <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de>
 <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com> <alpine.DEB.2.21.1909072243570.1902@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1909072243570.1902@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Sep 2019 14:13:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5dS9QsC5Ay0BpLBQdBRcy0qCE2hP=K4_nJ4b6Lumf_Q@mail.gmail.com>
Message-ID: <CAHk-=wg5dS9QsC5Ay0BpLBQdBRcy0qCE2hP=K4_nJ4b6Lumf_Q@mail.gmail.com>
Subject: Re: Linux 5.3-rc7
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 1:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> That's what I just replied to Chris. Can you do it right away or should I queue it up?

Done.

Thanks,
          Linus
