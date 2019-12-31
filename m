Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B3BC2D0DE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 23:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D44B206EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 23:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZdv8Sgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfLaX4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 18:56:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35922 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfLaX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 18:56:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id 19so39450254otz.3;
        Tue, 31 Dec 2019 15:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D5S8IPW/h1uoAlBQIQx6nANKjd+aLLZTTNCAji5s5CU=;
        b=iZdv8SgqnRDXVuCHsAINVukwSVPIJd83mSCUrL5GOYSZNS3PrZ94is15np1cZBqKbU
         3O3vVhlpzPR4fBLDymWckN/1La8zcYiiFINrqD7gIa+b9YarAbPMLUhxs7J9pla0KwT+
         M9Dj/1R6PoMzIi4kogS5aSVQbLSoi/d/f8sanIDNWORF8nelFs349i/75aB2oQQediYl
         BCFwXT8HGFZEIv16hz3JscbUvSFP1IFxUf3aKCgwzOQ5rKWrfpWi40JbjfYf/D/scLsh
         4Ri54keRCQbO/EJH8aZgDTF2tlxk+I6IJ0cN27k6Ha4wkAUEOZkjpIlYsqAdVISUK4XF
         W6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D5S8IPW/h1uoAlBQIQx6nANKjd+aLLZTTNCAji5s5CU=;
        b=a8YMGjREg5Qc3oiLPAkJyQWV/sFW5r2IsPQVQqQLGo/9C93UWhX5TuLFzT2iZZ5p1W
         fZd8AmPJLn/ixZd/C+zKPP9cgR4/yQLnwMTjLVv3wAgTJ65FuVfCphf/r7X7iWNz0Je5
         Gz98dC1cDDzEjKE05FiKFP4EtQWGUW2vyTBqFGzrD6asBp6aBiaMK33bXncbcicmzbHA
         LO/F/8oaBzQYVqH9ACzqIDzNEbSlr53p+ru44BKHfdfRboQqoxgZplbJYHTOZl0QkFlR
         SgSEliL9eqS+dXyGmq3YZxm+tzyZDV8Of6knU5of+5qCmEeFOxRbfHEluPm/2ymt3eGm
         uAng==
X-Gm-Message-State: APjAAAUDarpqEUmqYXCfARZW1oDdsKG/AtGDzmKb0Zm7SwyyjTlhgfw5
        Yjyzl28mnPOW7d92vnZzHC0XldU3QTYnViK7NonCEg==
X-Google-Smtp-Source: APXvYqxufQPYr22hnbCvi8UElxCNbn/fQAEW4UO6BWA/q+GmQhZbBKWRMJd5d8R7F4JldW09VHtXmKDZvhyYKqffVO0=
X-Received: by 2002:a9d:6196:: with SMTP id g22mr85931846otk.204.1577836564711;
 Tue, 31 Dec 2019 15:56:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Tue, 31 Dec 2019 15:56:03 -0800 (PST)
In-Reply-To: <20191231151415.GE6788@bombadil.infradead.org>
References: <CGME20191220062731epcas1p475b8da9288b08c87e474a0c4e88ce219@epcas1p4.samsung.com>
 <20191220062419.23516-1-namjae.jeon@samsung.com> <20191231151415.GE6788@bombadil.infradead.org>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Wed, 1 Jan 2020 08:56:03 +0900
Message-ID: <CAKYAXd9xJM6s-cPeRho5u3+A=B4qCG2FFcYKq++SrQGy4cMX9A@mail.gmail.com>
Subject: Re: [PATCH v8 00/13] add the latest exfat driver
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020-01-01 0:14 GMT+09:00, Matthew Wilcox <willy@infradead.org>:
> On Fri, Dec 20, 2019 at 01:24:06AM -0500, Namjae Jeon wrote:
>> This adds the latest Samsung exfat driver to fs/exfat. This is an
>> implementation of the Microsoft exFAT specification. Previous versions
>> of this shipped with millions of Android phones, and a random previous
>> snaphot has been merged in drivers/staging/.
>
> Can one run xfstests against this filesystem?
Yes, We also use xfstests for exfat validation.

> Or does it require other tools, eg mkfs.exfat?
Some testcases(scratch) will not run without mkfs.exfat. I am
preparing exfat-tools included mkfs.exfat and fsck.exfat. Or may use
mkfs in fuse-exfat(https://github.com/relan/exfat) for now...
