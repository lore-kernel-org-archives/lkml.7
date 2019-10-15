Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C193C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B482089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfJODsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:48:50 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43599 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfJODsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:48:50 -0400
Received: by mail-vk1-f196.google.com with SMTP id p189so4001838vkf.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 20:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShNj6dpdoV3qxQt4i9xwFO5EQ7UppT+qckLzoe6/RVM=;
        b=Xqn0PRGUh7L6FR68qPPZhSaHWTgxs3gG3efnhpBjDp5HpDpb1zAWTXNG2MyS5OtFSY
         RDNQ7wyXmXiRxsqKMgfAq/iE+PaMMzLT1aJUNTTUOv70VroV6mQkXgMVhDytqVXjK6tE
         7GVWv63nVx3XdJMHmbIBQ199uw9zyfOMn0/hpbIJU4aK8S2I+lT2bKEvLRe9u02w3c5e
         8MO+bPz4E4242c6iCZNFBycDYRW33vP1aKm7jbw6rsZYaX4VbfUzYLSmnp6Vagi8bJtJ
         kRjnGsOSOOK7Pem1iDTt2h2VtZYGdWC+rrJpJFyohxLsVJf0llCauYg3hbxVeRyPdekN
         je7g==
X-Gm-Message-State: APjAAAUwSVuL/bmoz1rhhIqoZgMKkcqW7TkrOY/fyZ9er0VyqA7XgSu3
        oPu68N0Xh9HsJ7Z2Yemw9tu4oIwiWxainJbw3U4=
X-Google-Smtp-Source: APXvYqxH5f7OmvnZ/VqNozEqskHJCWXLm5Yf1SmDDoJ889PXslulCrMngbZQcWghJZlRkZDfRWKDbqse5aSs/aSpn7Y=
X-Received: by 2002:a1f:1d15:: with SMTP id d21mr17456229vkd.55.1571111329347;
 Mon, 14 Oct 2019 20:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191011054240.17782-1-james.qian.wang@arm.com>
 <20191011054240.17782-2-james.qian.wang@arm.com> <CAKb7Uvik6MZSwCQ4QF7ed1wttfufbR-J4vNdOtYzM+1tqPE_vw@mail.gmail.com>
 <20191015011604.GA26941@jamwan02-TSP300>
In-Reply-To: <20191015011604.GA26941@jamwan02-TSP300>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 14 Oct 2019 23:48:38 -0400
Message-ID: <CAKb7Uvh7y20oikYR+UpabgXLHJM2i+2DPVyYSwE37d=NpheUGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/komeda: Add a new helper drm_color_ctm_s31_32_to_qm_n()
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 9:16 PM james qian wang (Arm Technology China)
<james.qian.wang@arm.com> wrote:
> On Mon, Oct 14, 2019 at 11:58:48AM -0400, Ilia Mirkin wrote:
> > On Fri, Oct 11, 2019 at 1:43 AM james qian wang (Arm Technology China)
> > <james.qian.wang@arm.com> wrote:
> > > + *
> > > + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
> > > + */
> > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > +                                     uint32_t m, uint32_t n)
> > > +{
> > > +       u64 mag = (user_input & ~BIT_ULL(63)) >> (32 - n);
> > > +       bool negative = !!(user_input & BIT_ULL(63));
> > > +       s64 val;
> > > +
> > > +       /* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */
> >
> > This implies that n = 32, m = 0 would actually yield a 33-bit 2's
> > complement number. Is that what you meant?
>
> Yes, since m doesn't include sign-bit So a Q0.32 is a 33bit value.

This goes counter to what the wikipedia page says [
https://en.wikipedia.org/wiki/Q_(number_format) ]:

(reformatted slightly for text-only consumption):

"""
For example, a Q15.1 format number:

- requires 15+1 = 16 bits
- its range is [-2^14, 2^14 - 2^-1] = [-16384.0, +16383.5] = [0x8000,
0x8001 ... 0xFFFF, 0x0000, 0x0001 ... 0x7FFE, 0x7FFF]
- its resolution is 2^-1 = 0.5
"""

This suggests that the proper way to represent a standard 32-bit 2's
complement integer would be Q32.0.

  -ilia
