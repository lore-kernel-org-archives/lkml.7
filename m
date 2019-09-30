Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D84FC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F192720842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDhmfO1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfI3HpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:45:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33127 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfI3HpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:45:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so8372545ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 00:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKsJKdSG5R8dGV+DIPEx5nlyGaSi4dLBqBkbszm5F9M=;
        b=fDhmfO1ekIhNvjKsqu2BsmStSF9nq0Zinum0JZkMIVnBK74vRI2OHnevK7Po77juxo
         wZNaqHXYAw0hfKDmBaM7F4RixYxIKCWaBO0mNC8iziTCWZK+uS4QHO4rXZDXiaEfLygH
         6dtTyf6tCdnC6iQInJWYB4tipgjNHLEjgX5SShutOLWDwlxB9t32yJrBytP2ps2TTFZn
         UUYqdQp9IKvyJ1o301IuR30H6QOSG3r3NYoOvnSRrk5OZep8gRjNYNPGhe6823CjLpoz
         CHZgYarv+oRpDsXMfjjM7ER0e9znBwxZs421i309nrrMRj3E+iyOBEbnkcJzkC3gxlQu
         ETQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKsJKdSG5R8dGV+DIPEx5nlyGaSi4dLBqBkbszm5F9M=;
        b=CSBy0Ez898UmJHtHaUN8dP09nKgPhg/PTSecsBIM0zqyks/o4XWbN3HxZT0WgsBgfN
         4S9Xs7TR7wYBmCCn0awB5HTHIfkOxmz2LsX+AlXTeXrftiFdCh3IFZ4S7132s4ArvEJn
         VZlw3tMnQGnWd1lstGubGjKjOeLjuH3To9d904VBYEHJoeA39sLjQ3Gegu7LYqqSNyvm
         Y9CryAM1TSGV4B+n+8B9nySes+Fs0fNV7/LxZHd5f9NX27Bkng4UoEoaiuQUJV+k6/t4
         nZ1QvjQmL7ALLa0ZLfKV7DOYCHcaWEYcHjeGpGBPXpozqloZxfvH5In+0KdxUT6Hvvww
         AGDA==
X-Gm-Message-State: APjAAAVXloC3s+WP3IRumM6PDZxMy+FKNamZ/BhU7d3QB6NBgk+sz3Ik
        tePQRHkX6PIzMgMLUeKjMw20FRl/TJyKrqN8FPrU8Q==
X-Google-Smtp-Source: APXvYqz1Eg/5CGuw4YGRcxqrRnPjjwX9NIiAoCcTMqWdBd7jpUR2FZkjOzSXb2LWVZZL+SGbi62rZYK8jzIfAczEbXU=
X-Received: by 2002:a2e:42c9:: with SMTP id h70mr10772967ljf.88.1569829499004;
 Mon, 30 Sep 2019 00:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org> <df9fc32955789e7fcd01623433faba8d2f446b6e.camel@surriel.com>
In-Reply-To: <df9fc32955789e7fcd01623433faba8d2f446b6e.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Sep 2019 09:44:47 +0200
Message-ID: <CAKfTPtD2_ZHUv5Kz3R2qV33RxrGNC=y+7-4jCdvj9Deo=7A77Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 at 03:13, Rik van Riel <riel@surriel.com> wrote:
>
> On Thu, 2019-09-19 at 09:33 +0200, Vincent Guittot wrote:
> >
> > Also the load balance decisions have been consolidated in the 3
> > functions
> > below after removing the few bypasses and hacks of the current code:
> > - update_sd_pick_busiest() select the busiest sched_group.
> > - find_busiest_group() checks if there is an imbalance between local
> > and
> >   busiest group.
> > - calculate_imbalance() decides what have to be moved.
>
> I really like the direction this series is going.

Thanks

>
> However, I suppose I should run these patches for
> a few days with some of our test workloads before
> I send out an ack for this patch :)

Yes more tests on different platform are welcome

>
> --
> All Rights Reversed.
