Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBD8C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA120833
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myjwga/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfDTTIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:08:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38592 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfDTTIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:08:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so3918245pfo.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXJ0ZyxzYNBI0PMuleP6H4PPb2fTaCy7jwLN2d2sFO0=;
        b=Myjwga/3Ri6FPkUorrxs3sqf/UQS/rTo5zcvlyHzLlZMOmpTvxMI/YlwAU8QYCHR/V
         /XkZzZ+rcSbDKQOdMfbZcPI0zWx33GmVoz55eFv1O0pVfZKZf6GUMm3f2gWjPZwCEIcH
         Q73vBcfh6sfC6ypzdvxI73CXN3QVdRWz1qs7bq4/Ft2ecuS3SCKjZ+yUipn0fQzvZSjQ
         fy2LdiVM8oSNokLn1kefy8lcAESb8ILS1HYCTsvhB7sUaCzGbMy97d7xaPVGOvKgCgsr
         n0LDTJAnbG/IFlmuEtC+t1SZSIZyRRh0z9wfT09xx1g+fcudWajbD7WkyWtJpcyV0sOD
         6W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXJ0ZyxzYNBI0PMuleP6H4PPb2fTaCy7jwLN2d2sFO0=;
        b=CBaaH2XS87R5ruN7t3Wran4HRpKVn8ec1IX3kBrEhiZGDWcaOS9Ohmx4dQhqS06X+9
         zfWiYrvsXgo50FkaPbaTqTPuhENokn5S8mnebmW9sNyccJIocNQ+vT3DPVSXjvnEO4DO
         a3GX6kjp/RdPiJ5NW7z/FhN9ZS4tO2oDft+/F4mh8dNnWrLnaAO7UliuLlpa6KhG1Qw/
         4MkhclZWmy1yFLr5jBvlKIpQGxSQcwKCCH9HdlGZC4L5KnYfBIqbCc/BQkqu59fl958O
         3UXvzMnM442rN1Eap6ASKNoM3phfw9i1PXLsysUOwou5vUjUMDtU9guJZnce5SAwDIbK
         Xqxg==
X-Gm-Message-State: APjAAAWG3RqPtTdsE+uQCDBVMkFpWPwErfc97ZGXjum4iToMXvMMy8W8
        sTtwHuX5kdbj/C9HiZX7P37ychwcPOprTkk01uM=
X-Google-Smtp-Source: APXvYqx/n5Vo39iJPvwo3hn6T/K0lNE8xjdtS3GXfX92YAZFzPTIjjiJ2NAesd+zJUOOOBFcdM0Tyyvjb0yci336hlA=
X-Received: by 2002:a63:ed48:: with SMTP id m8mr10792537pgk.104.1555787299294;
 Sat, 20 Apr 2019 12:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190418220229.32133-1-tony.luck@intel.com> <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic> <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic> <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
 <20190420091313.GA29704@zn.tnic> <CAM_iQpUaBOS92u7K+hzzRX5hw0Kbrp-0o0DSfLwSGBhenntVjA@mail.gmail.com>
 <20190420184751.GE29704@zn.tnic>
In-Reply-To: <20190420184751.GE29704@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 20 Apr 2019 12:08:08 -0700
Message-ID: <CAM_iQpVpnBoGbjUP4Ek0TDEN8aimq3ty=0EUmco9ywWDZa37Vw@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:47 AM Borislav Petkov <bp@alien8.de> wrote:
> IOW, when you have the CEC enabled, you don't need to log memory errors
> with a userspace agent. The CEC collects them and discards them if they
> don't repeat.

So, you mean breaking mcelog is intentionally, if so, why not break it
loudly?

That is, for example, preventing mcelog from starting by disabling
CONFIG_X86_MCELOG_LEGACY in Kconfig _automatically_ when
CONFIG_RAS is enabled? (Like what I showed in my PoC change.)

Or, for another example, print a kernel warning and let users know this
behavior is intentional?


>
> If they do repeat, then it offlines the page.
>
> Without user intervention and interference.
>
> Now, if you still want to know how many errors and where they happened
> and when they happened and yadda yadda, you *disable* the CEC.

Well, I believe rasdaemon has the counters too, it is not hard to count
the trace events at all. I don't worry about this at all. What I worry is how
we treat mcelog when having CONFIG_RAS=y.

>
> I hope this makes more sense now.

Yes, thanks for the information. It is kinda what I expected, as I keep saying,
I believe we can improve this situation to avoid users' confusion, rather than
just saying CONFIG_RAS=n is the answer.

Thanks.
