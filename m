Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF62C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AEB217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559065057;
	bh=1FcoIili3XrG5oy39D/QZoBeC/2tlCrTlbMxM5nbyhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2s6fXmdIwqpTJIiKi7+pcB1EJPgy08If6GYjqaC1z1C46cnY6C6IxjTKfix31XTbp
	 aXF62X6CejakvzgarUdPX2DGD9LwKPnDEunQ6v66ZA9IJgFerVKOUZraFprJDaFtX8
	 ytc/KPdbx3O+8x4jez3rqAlhG+zUdvFghIlIKbF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfE1Rhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:37:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42739 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1Rhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:37:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id 188so18507539ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2jMeMvfMZ6+f8aMiqek9ZN+qjHWyjCaTe5iI/rDq+E=;
        b=F1ETGdXeFfCBHmdWbLBHd8vZ7taVOvI6ORkmxBqkgmnSIzcWwbuL7Fhv0S2FLp97AT
         XCPInppgu1tkfwt4dcLiPmzEju6ML58hvTfKMWoxMW2Wuusd11zPUwBSNYNdyPwqwnst
         6LPs3DuCLXNIyE4Zp2se+L+KeAMs1gw7ROLd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2jMeMvfMZ6+f8aMiqek9ZN+qjHWyjCaTe5iI/rDq+E=;
        b=W4AObqTIiFN6Utsw5GAULitQz9FlEzzDHrLkTlGewtHsRhfKXxYHDmjEjKSsCa3q7Y
         umhUc/qBlCJavTcbpuIepP7VoztLPd3NvljdWfeCA2FUDn3RY99aH7nW1k+e2eJNs7Zo
         +fyIEAZv2sLfPF4iV+vA+zoQSnwB9qh2GYwh4FlEwgumfwMTtEu15Zc0MKDDQjLtDKOM
         dVthiafSaGrPJ2z5axBReDsvJqrYNN9pvxfWK/W6cfDmYMdXmpdUUk6msXbyRdrDk6xl
         1fLdWGWYOZpxZ/xUwpABtj5dMCKMGAGh0Yp/SY4ldniM4Pvo8+XtJL2y8ZuC+amsXvGL
         TafQ==
X-Gm-Message-State: APjAAAVKiyieIX6xDbZ95O0H/ug6RLhFjQ0f/wnRlrhGUt9AbqhTv8XA
        GNtNke6B4BdvHcCnCTjEYfaEUTj80go=
X-Google-Smtp-Source: APXvYqzO1EYRG7Bllt5G2Wu9S0cYZIOj+5slPhbMpzxoeqb4N/mZfDECw8plyvHM3oSRRohR9yJNCw==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr65590233ljd.65.1559065052784;
        Tue, 28 May 2019 10:37:32 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v16sm3063623lji.88.2019.05.28.10.37.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 10:37:31 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a10so7754697ljf.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:37:31 -0700 (PDT)
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr49489655ljj.1.1559065051361;
 Tue, 28 May 2019 10:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190520063534.GB19312@shao2-debian> <20190520215328.GA1186@cmpxchg.org>
 <20190521134646.GE19312@shao2-debian> <20190521151647.GB2870@cmpxchg.org> <CALvZod5KFJvfBfTZKWiDo_ux_OkLKK-b6sWtnYeFCY2ARiiKwQ@mail.gmail.com>
In-Reply-To: <CALvZod5KFJvfBfTZKWiDo_ux_OkLKK-b6sWtnYeFCY2ARiiKwQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 May 2019 10:37:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaLQjZ8AZj76_cwvk_wLPJjr+Dc=Qvac_vHY2RruuBww@mail.gmail.com>
Message-ID: <CAHk-=wgaLQjZ8AZj76_cwvk_wLPJjr+Dc=Qvac_vHY2RruuBww@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: don't batch updates of local VM stats and events
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 9:00 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> I was suspecting the following for-loop+atomic-add for the regression.

If I read the kernel test robot reports correctly, Johannes' fix patch
does fix the regression (well - mostly. The original reported
regression was 26%, and with Johannes' fix patch it was 3% - so still
a slight performance regression, but not nearly as bad).

> Why the above atomic-add is the culprit?

I think the problem with that one is that it's cross-cpu statistics,
so you end up with lots of cacheline bounces on the local counts when
you have lots of load.

But yes, the recursive updates still do show a small regression,
probably because there's still some overhead from the looping up in
the hierarchy. You still get *those* cacheline bounces, but now they
are limited to the upper hierarchies that only get updated at batch
time.

Johannes? Am I reading this right?

                   Linus
