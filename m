Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B278C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2320020B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd9U2BVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfFGMHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:07:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43007 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfFGMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:07:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so1902036wrl.9;
        Fri, 07 Jun 2019 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/OaEJfBR0xsC2fNRDUtUonZ/nH//Pb0hepbkfyw3/RI=;
        b=Vd9U2BVxBdN4mlMul4jehfdsI+khyQ8bNYC+PbZUd+MLkJldq0QvPqlw67/TBgEj9a
         YisCswUD8lyWjT+ne+NbBXnB0880+Q22bXGI2ydtUN9nduFOqOQ/jbTnnVUPzTmcwn7h
         hCVLa+O8KOLJmFRB8X6lYdlYhQNDnwMLoE8hzkhT+SkuSzmxRDkQoAbJvOBvmx27pg/f
         4WMav4+lrDRJnm/4dY9Sy1iLFnHWD+EwvWTMNrMXpyI0a6dWYI415XEBdVEeciUzBgfu
         Y9nuI3HvDTAir5TfDv7sTbHd9bJlKcm3F9cWjGcw7DAPTEkhyJR8PANVX06uYpYwVOLM
         j5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/OaEJfBR0xsC2fNRDUtUonZ/nH//Pb0hepbkfyw3/RI=;
        b=Sf0GXxoLInMTiiMEqTzgNteUa80VdkoXd+IQBRbp092v1uoP4lydQeYW1Ongzi2wpA
         Wl/NXWwbA+Vl/nvTsDqH0Y9lqbtpLXVOMeQwpeLCFyZJdmkQuIslq8ezuMJQaKJ379zK
         35MM7zlnvEeD0mlPvKcVDp6cqJxPr0VcS4gKhM0Y4N8GpIM7glr1qbroRVE39SgxAkw3
         SnafJjZXljo6M2U6X+B0kvbmq7YR0NXYAZno4v8EnspPbSj2cfugNKbZ169/JBxg1GUX
         tztRgjc6vE0VJ02oioSSQBmvT+Mn01JHJa8GII97RMdtXvo4kGsY90uGtoGcftwYKnm4
         XYEw==
X-Gm-Message-State: APjAAAWwyFVaoA3VrDksDwNl6xzGjppZQRj+9dW74pm7AcbHASTHsuvF
        giKkFzvIxDZ7lhoYuhQ9DMA=
X-Google-Smtp-Source: APXvYqzK/mt+UcZm1I3NP7PZiM+wVGTONiRjzP3kZpRLqca6N+PZrk2C6d/t/Ahk4y5O/JMEvU7JqA==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr9424156wrl.134.1559909248247;
        Fri, 07 Jun 2019 05:07:28 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id o3sm1543243wrv.94.2019.06.07.05.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 05:07:27 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:07:17 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: fix a missing-free bug in clk_cpy_name()
Message-ID: <20190607120717.GA3109@zhanggen-UX430UQ>
References: <20190531011424.GA4374@zhanggen-UX430UQ>
 <eb8e2d33-e8f7-93a5-c8bc-98731c0d63b6@suse.cz>
 <20190605160043.GA4351@zhanggen-UX430UQ>
 <20190606201646.B4CC4206BB@mail.kernel.org>
 <20190607015258.GA2660@zhanggen-UX430UQ>
 <e5b4639b-3077-59bb-6383-0c2bccdd9191@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b4639b-3077-59bb-6383-0c2bccdd9191@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 11:10:37AM +0200, Jiri Slaby wrote:
> On 07. 06. 19, 3:52, Gen Zhang wrote:
> >>>>> @@ -3491,6 +3492,8 @@ static int clk_core_populate_parent_map(struct clk_core *core)
> >>>>>                             kfree_const(parents[i].name);
> >>>>>                             kfree_const(parents[i].fw_name);
> >>>>>                     } while (--i >= 0);
> >>>>> +                   kfree_const(parent->name);
> >>>>> +                   kfree_const(parent->fw_name);
> >>>>
> >>>> Both of them were just freed in the loop above, no?
> >>> for (i = 0, parent = parents; i < num_parents; i++, parent++)
> >>> Is 'parent' the same as the one from the loop above?
> >>
> >> Yes. Did it change somehow?
> > parent++?
> 
> parent++ is done after the loop body. Or what do you mean?
> 
> >>> Moreover, should 'parents[i].name' and 'parents[i].fw_name' be freed by
> >>> kfree_const()?
> >>>
> >>
> >> Yes? They're allocated with kstrdup_const() in clk_cpy_name(), or
> >> they're NULL by virtue of the kcalloc and then kfree_const() does
> >> nothing.
> > I re-examined clk_cpy_name(). They are the second parameter of 
> > clk_cpy_name(). The first parameter is allocated, not the second one.
> > So 'parent->name' and 'parent->fw_name' should be freed, not 
> > 'parents[i].name' or 'parents[i].fw_name'. Am I totally misunderstanding
> > this clk_cpy_name()? :-(
> 
> The second parameter (the source) is parent_data[i].*, not parents[i].*
> (the destination). parent->fw_name and parent->name are properly freed
> in the do {} while loop as parents[i].name and parents[i].fw_name, given
> i hasn't changed yet. I am not sure what you mean at all. Are you
> uncertain about the C code flow?
> 
> thanks,
> -- 
> js
> suse labs
Thanks your patient explainaton. I think I need some time to figure out
this part of code.

Thanks
Gen
