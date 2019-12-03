Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2530CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7D320640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBua2pl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLCT2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:28:36 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38611 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLCT2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:28:36 -0500
Received: by mail-pf1-f180.google.com with SMTP id x185so2335454pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8NL17ON/XicxfpTxuuNh/N53BkIMVDrR4l3b9XAw50=;
        b=DBua2pl6UC5qpJtQzjq+yHw5VLDF82o8M/HdpRyfjcqfq1N7V/z2IdQEM1QkuFQt/e
         H9l14xZSV09e1WNj6fni0dLH0JrTln7Q9sb9eifN2fMvpFXjiIOyy/fUQxvPUqlx+kr3
         PF0X7+UwHrNzUb40DKWYREz6vcIVZ5kWR8BTYwLnpgwD3L/QHc+L7LtwKCFriU0YsUeb
         xjGyaJvVOpPGeoBN7NI/4axq8L/VYXBsRdsfeIu/pxpaTvGJW0sIWy/pNEbXkmXSt/4J
         xdKEFJQ5jjK9SqIVejfRKnko0T0Helhy7PRuHMHOoxnSSWo6Od4KwwO51Kk9+Uilsy0L
         UR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8NL17ON/XicxfpTxuuNh/N53BkIMVDrR4l3b9XAw50=;
        b=Wwx0QXlBa4dRqjp1UUHcUG1DWhzLGc8iZQzb1j7cOhpu/FmNGxVbpD0NCYB9G3mV+0
         RYYgdq0EFAx5RYVL0opUNbS7t1Q5VMtSzPzWQI0Ix1h7ASxib19kEH9Fe4oeaDw8qK+N
         HyWJMexP/JLkLB0lftuz0ATACtKm14jLStZcLXhud5/UXr+Kq51M2woiIfazuAmOLjs6
         /rzA/IKOLSRXWlLB2yYSm1Gezmk2VhSExhoiG/7gb+SFrSksg7xcDjlvGpr7rmOj25vL
         +Y7/wXov11ga0Ht8r99iHbcD41zi8FRKKaizQgwUYPdbo6bA3w9fnghosFGvZG8SD1U4
         +IMQ==
X-Gm-Message-State: APjAAAVEXy0cn6OsllsmwT8yf/OXVqSt78jN5zN6f4mrzMZmYCYHQfH7
        KzyTeMWBVxmsoiOu6SglZ0mK2tbQRiRiStSYCIE=
X-Google-Smtp-Source: APXvYqy4s4dfPk7xp2Ss+1hclHrZ6TwmfmX1otoaNzVldov/oHG+i44rkEm6Tq7d+xrqJkcj9Q+MvNI+CsRFw7hpZYA=
X-Received: by 2002:a62:2a4c:: with SMTP id q73mr6480011pfq.94.1575401315515;
 Tue, 03 Dec 2019 11:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-3-xiyou.wangcong@gmail.com> <20191202165921.GB30032@infradead.org>
In-Reply-To: <20191202165921.GB30032@infradead.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 3 Dec 2019 11:28:24 -0800
Message-ID: <CAM_iQpUC0v=0BETLP0=9O89g38Crx5pMB9jcvx3cEkafT+vUkg@mail.gmail.com>
Subject: Re: [Patch v2 2/3] iommu: optimize iova_magazine_free_pfns()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 8:59 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     return (mag && mag->size == IOVA_MAG_SIZE);
>
> > +     return (!mag || mag->size == 0);
>
> No need for the braces in both cases.

The current code is already this, I don't want to mix coding style
changes with a non-coding-style change. You can always remove
them in a separated patch if you feel necessary.

Thanks.
