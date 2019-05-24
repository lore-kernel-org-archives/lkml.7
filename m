Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A5DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304FE2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2IkeGBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404058AbfEXOEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:04:24 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:41609 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403934AbfEXOEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:04:24 -0400
Received: by mail-pf1-f179.google.com with SMTP id q17so551604pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGCuxTnXcnuBPou9nOPKiCg7hTgc62sGoEpZz2QaVJA=;
        b=N2IkeGBntueRNPhCZ83qcfcIVppSAWEI+9B/8/fkVaPBXGUDtB3RTkNyUad2Bd53Dk
         TEiQZZeVAV2LHAj6cH5CTvwCk2NfKT0LU1NlzZLKkoaT43cWn+HQpMg2j+4EFqX8Ili7
         6ChwuRTMoOejGpq4eJKamYDW5AjL6OpFVfbeuHHZbtVLUxQeUusq5MOx/rVTH9QJ/AOS
         MNu3WJaxosx/KXtey8W4xuHdgTefNpxXgwhiZJGGtSLZXFuB04/JTJhctjVGijxKpGU7
         aciFiQsHGX0Nk6G2YCeBmzBWcLvGTwohKjJxtdfgjwpt/EZUP1s8o8ETwKHg0fX/MdIi
         +l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGCuxTnXcnuBPou9nOPKiCg7hTgc62sGoEpZz2QaVJA=;
        b=osig7W1MKSnk6QjIyY/JGEOGb9KZY9eAsRXnlxHX13a3pmpOxINfde2bdF0DPecv5D
         xQbet8ZoeblnBS7ciqmMIF9BSWR43PKAGsxWiBIym6LdnfLMQYO/AKuI3YYuGC9eGYLM
         BgnPtTdiLQX/7+yXMVJOPArqq+d7GUXK7eFR7WQAAUO/Vaw97YD3zgKnqdHwB0OwydFe
         HNgxWFrWH3xSge0l/cLRvnkp+vdSeMcB+5JEWnExwPskIbEZGLdXNz3yR1Y4Bv4gZ+nk
         cjXeFFbW0C/TrL5l81W8ppYhKIujnQUmJFabxyjkAeJGpMI53MOD8aCLMuDGP2GufmwL
         ZBQg==
X-Gm-Message-State: APjAAAVvCiB5DclVO3yJWv6mQFuSbGEPWmbnwQu5GG2/bwHfvpuACvEl
        7nSlTjj/pXz8PgUGdTsb42EfE7QcNSbEHXaSSPTg8g==
X-Google-Smtp-Source: APXvYqyScmgXNGpoQAB2ohZOsIAUG8T1PrN/sD7h5nPpue4yC64XUBBwuPUDAuG70BcQ1T3g4p+PuimhAZ07wzpTgVM=
X-Received: by 2002:a62:7793:: with SMTP id s141mr46994901pfc.21.1558706663346;
 Fri, 24 May 2019 07:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmhGq+VCHWp4s-Xh3ZUtxEudgqK-C1LYhttFpc4MUOrzRD3Ag@mail.gmail.com>
 <20190523225423.372ef0b0@oasis.local.home>
In-Reply-To: <20190523225423.372ef0b0@oasis.local.home>
From:   Jason Behmer <jbehmer@google.com>
Date:   Fri, 24 May 2019 07:04:11 -0700
Message-ID: <CAMmhGqJVmoiWmQ67B4FMEk_n1cf0Gk4ugjg2-C6MVo033upF2w@mail.gmail.com>
Subject: Re: Correct commit mask for page data size
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Craig Barabas <craigbarabas@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, that makes sense, thanks for the response.


On Thu, May 23, 2019 at 7:54 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 1 Apr 2019 06:49:07 -0700
> Jason Behmer <jbehmer@google.com> wrote:
>
> Hi Jason,
>
> I just noticed this email. I know it's a late response, but since you
> Cc'd LKML, I figured I would respond anyway, and at least have an
> answer in the archives ;-)
>
> > Hi Steven,
> > We're wondering what the correct number of bits to take from the
> > commit field is when determining the size of the page data.  The
> > format file shows the bottom 56 bits not overlapping with anything:
> >
> >         field: local_t commit;  offset:8;       size:8; signed:1;
> >         field: int overwrite;   offset:8;       size:1; signed:1;
> >
> > We first naively interpreted this as the size, but eventually ran into
> > cases where this gave back a nonsense result.  But then in our
> > investigation of what the correct thing to do is, we found conflicting
> > answers.
>
> Yeah, I hated that above, but the format didn't have a good way to show
> the overwrite without breaking existing tools :-/
>
> >
> > In the kernel we see that commit is often updated to write, which is
> > masked against RB_WRITE_MASK.  So it seems taking the bottom 20 bits
> > is correct.  However, in trace-cmd, a fairly authoritative parser, we
> > see that COMMIT_MASK is set to take the bottom 27 bits and set that to
> > the page data size.
>
> The way the kernel uses that number is that the first 20 bits are the
> size. Then we have an internal counter (top 12 bits) used for
> synchronizing when the trace crosses pages. But these internal numbers
> will never be exposed when it is sent off to the reader. Hence, those
> bits are meaningless.
>
> Now I probably could make the trace-cmd header just use those 20 bits,
> as they never will be used for the size. When I wrote that, I just made
> sure that the flags that are added to the page by the reader code was
> not set. Which is why there is a discrepancy between the two masks.
> >
> > Could you provide some guidance?
>
> Thanks for pointing this out. Again, the reason for the difference is
> that they were created from two different perspectives. One was that it
> would use the top 12 bytes for internal purposes, the other was just to
> allow for up to 5 flags by the reader.
>
> Does that make sense?
>
> -- Steve
>
