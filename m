Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE20C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrAabiJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfG3XGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:06:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43519 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfG3XGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:06:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id j11so10824909otp.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWk710+kd17q1OMPpu/V4kqYNuYX+KuVsErBpC5nLIk=;
        b=WrAabiJo3Dd0TtRAdJPNb1JBiYkFvBRm3vSWFQpJ+gwuoytfTPfI3f8PTELhhVKlyD
         Rhp07QkokIAzB6efv9wY6sdxtKIkuJTwvqZULuS9AfQ1pK3jcRPLwP5gxssPI/Ugw1H3
         tBK4pFecWaDN42C5f8c1CnMEoWW0vrwdcxuHjvtXSAvbkbAKwVQhmLFLECySRswMmtCs
         iJftiD9zxs5YSMoAkdp/M78U764JOqBiJhvvhAplQjacULBgh1O+teQhg2blsWFp540R
         8ZQSCjurivZoKK0qnm1XrlEo+kzJzeohTGG8uFoxO5TFALHfsShQTJ6Ae71NzRVe9gon
         H+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWk710+kd17q1OMPpu/V4kqYNuYX+KuVsErBpC5nLIk=;
        b=KD//G40oyD7PfJz53hNu039MaAxGK+8RyYH7nVb/ZBR5V+7YKQ5Xm0HB8axoH8cK6Y
         q10K9aFJRR9NWeTxb46g4+SXZTIVhK3fQdY/MjKu8Y2+XddN82zEvUj5Szi9vPMYk9pw
         Vdmw7Ee/mqkTVejKAESXDg/mzZnP/foKqBd19USj4fp2jT0JbAnjbj1MhJqfElmQ3NtU
         TxcUzEZD1/PEnkf7gnazSDnNxspt4L2i8vB+sEI4v1x9aAIxLue16g8YTGxGGYlG1elJ
         iRz43MyRgvzAMmsPXyocQr/XOQpEokD0b6lRoRqqPHmTWneapbYc0ouLrV2S76Jl9zEn
         fYyg==
X-Gm-Message-State: APjAAAU1Pe7t2f+FWa+5bIwubLiPkIEZU6gsYAvrXni5W7HMV4cRwRvo
        LIoaf1jdxdI8gG6++ZlBRzUnZ2c5ea5Bd+HmMGlUqg==
X-Google-Smtp-Source: APXvYqwRZBGclW0RsoKetYGEdOPnQk2VEPJBoWqPKFhs6YkunF2OBOxQev4HLUxITQUhOPKxNUn5nu5CyC5NSPsHFsA=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr33175342otr.231.1564527978919;
 Tue, 30 Jul 2019 16:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <CAJMQK-jQA6aeSMmrRKDeJz+mGDsu09=ywPv+kfuo26GhQJD4Ug@mail.gmail.com>
In-Reply-To: <CAJMQK-jQA6aeSMmrRKDeJz+mGDsu09=ywPv+kfuo26GhQJD4Ug@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Jul 2019 16:05:43 -0700
Message-ID: <CAGETcx_qKTDd+pid-jdapi4XqVnN1k4EBP9Vt238rUzhDTHzig@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 4:03 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Wed, Jul 17, 2019 at 10:23 PM Saravana Kannan <saravanak@google.com> wrote:
>
> > -free_required_tables:
> > -       _opp_table_free_required_tables(opp_table);
> > -put_np:
> > -       of_node_put(np);
> > +       for (i = 0; i < src->required_opp_count; i++) {
> > +               if (src->required_opp_tables[i])
> > +                       continue;
> > +
> > +               req_np = of_parse_required_opp(src_opp->np, i);
> > +               if (!req_np)
> > +                       continue;
> > +
> > +               req_table = _find_table_of_opp_np(req_np);
> Not yet tested in v4, but in v3:
> In _find_table_of_opp_np(), there's a lockdep check:
> lockdep_assert_held(&opp_table_lock);
> which would lead to lockdep warnings.
>
> Call trace:
> _find_table_of_opp_np
> _of_lazy_link_required_tables
> dev_pm_opp_xlate_opp

Thanks for testing. I'll keep this in mind based on where the rest of
the discussion goes.

-Saravana
