Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0842C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80821218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJEJ8tMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGCUgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:36:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33054 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGCUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:36:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so3801447otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPXq+pIJPDQwSLT19cfFmw2Vcvo0FzOgU0YAUNu6RQk=;
        b=wJEJ8tMd3xtbZ2ihovoIGxTsU9YvYQTD507F06G8Qqxby/Sqvh3E1rTKa7dCWbAXsL
         h/isW/5dGZoENf01Ua1CCOvp4kgRYyzqLT7O6zHgJ8l7uoiYTsWdVJ21RHWF19PzlLAR
         9xr3ISuA4c2/xdscQyncXx03C+DMq5YRqIsnH9jeBCTGsOE+ieL9MGoSO8GfuWheduzo
         OQw5O8PpiOM9bedjbV9vjq+7W/dh1hZDoISE5FWjVv2qvKldf5IhSZUYIA0Ab1JM77l2
         6+vk3f1AQPzkm62ZK5lTASVX297bodhM/abR59OSn82RuuK+7lPzRMTZinSktvd1c4EB
         DFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPXq+pIJPDQwSLT19cfFmw2Vcvo0FzOgU0YAUNu6RQk=;
        b=DrWaiCcdn89aXGnWXZVBuIk4KEZAPMj14ZmMDlm/cfSuEJD9/iZsdZmahRwylwfjhP
         P6CQ+jO1vZT/Tijb+QQWY1Bbs/1hEVJQkJgd1t42Zq8ItCFf7leq8ueyS/E3GEMaOJMb
         jo0GfF3wm0xYI3ZNumIRvOvw2WEOP/4QLdSox7vxOrRAuyHFvqb93mzoMbgwuJG2A3YX
         Nzk0hwS1PY1JfNYsmg1EexpO9Rbw0yhNooS+d273EyrHuu+I/YHkWb8yUpyC51ilITdu
         mmn5Wi5XFw7ksReMXL5TV98yyEHDLO2nBq0TnDVaQor+VRzzzxQ4vioumrdx7Xn9a8t8
         ZhmQ==
X-Gm-Message-State: APjAAAWnEHdjnIsjchTjQRAWrhf3sEN4E4+Tp9lIUq3be8i+W9J7l+96
        6lqxhv8JVfljXiY9ek+/TYgCPKENkKsSCsf36pr6+w==
X-Google-Smtp-Source: APXvYqy900opobQMpHjkJXGmlkfMTJ/Fz3xLTchhFyxqL4NA93DGafUbOsl0BNsl2aa50mubporMqRqSONHDjBDYRfU=
X-Received: by 2002:a9d:1909:: with SMTP id j9mr14152896ota.139.1562186181028;
 Wed, 03 Jul 2019 13:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703063632.hl2lipcoeehplyxq@vireshk-i7>
In-Reply-To: <20190703063632.hl2lipcoeehplyxq@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Jul 2019 13:35:44 -0700
Message-ID: <CAGETcx9Dhzt9-Ys-8hLtoZ9RYWMWa59H5yismUJDWmJ3Kq-smQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        evgreen@chromium.org,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 11:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-07-19, 18:10, Saravana Kannan wrote:
> > Interconnects and interconnect paths quantify their performance levels in
> > terms of bandwidth and not in terms of frequency. So similar to how we have
> > frequency based OPP tables in DT and in the OPP framework, we need
> > bandwidth OPP table support in the OPP framework and in DT. Since there can
> > be more than one interconnect path used by a device, we also need a way to
> > assign a bandwidth OPP table to an interconnect path.
> >
> > This patch series:
> > - Adds opp-peak-KBps and opp-avg-KBps properties to OPP DT bindings
> > - Adds interconnect-opp-table property to interconnect DT bindings
> > - Adds OPP helper functions for bandwidth OPP tables
> > - Adds icc_get_opp_table() to get the OPP table for an interconnect path
> >
> > So with the DT bindings added in this patch series, the DT for a GPU
> > that does bandwidth voting from GPU to Cache and GPU to DDR would look
> > something like this:
>
> And what changed since V2 ?

Sorry, forgot to put that in. I just dropped a lot of patches that
weren't relevant to the idea of BW OPPs and tying them to
interconnects.

-Saravana
