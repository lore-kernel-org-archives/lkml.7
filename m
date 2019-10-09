Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53930C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2870420659
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmHbCL/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfJILqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:46:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42290 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfJILqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:46:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so1241194pgp.9;
        Wed, 09 Oct 2019 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uS9mErjexiYqpscpzCPSEdkzAe7OAyNyD3avSiLikIM=;
        b=KmHbCL/QwB0yoKhsX8fQN1LgGHi9YP7I/icWDLTIMYedCvFYFVNPGzgrullChnyvi2
         BTMcjy5eqbVvope4/Lex7VBfrb53Ryr2VEeB93WDezcP/Gj6n4cWWKvrOCEvGHhYtyV2
         gx0fy+rEaxCoMgDX4og/6vgJa3OpJGTVZKLX6eht58ChV4sMUlPjFlra6GjUuq07enWk
         GXRJdVqG4VgNVpvZGvj6bChhqSt2ChiE3ce06Pyr49Y+cfqGvjpmcVIqBC8A3vU8YFbA
         QCKkTemvCr/s5E+eY4NRs8E2UlQYq2Tc0DQ3CNk2rec0F6L0lcPDxuwzoJG6yA8cTF8f
         hftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uS9mErjexiYqpscpzCPSEdkzAe7OAyNyD3avSiLikIM=;
        b=GzJMDqTdioTH/RlwzjQbK5iLT2AEa9R8Aje9CqrntQ9hdF8+glGN+0Bn5ROFr8kUtW
         3WNEH9GpWlsbT9uejHABPhCbkaGdePOuj+x4w9fF7s9ClUVAqXv8c7kyuuFG7+jJzgdQ
         UffEb/a3jjkvbY7Brm2zMhyQkQxlIYkiAP8EGFCpplupI+sK26knRZIgTV0X7abJidpe
         hWUR7Mp8ZDXOM6cmQs12H8j9/XfDJUHSP1IF26SAFlVAk0qNnAQGzJFXIMLtGt5vsi3s
         0Tu1ayVOgT9PfZjmnogLu8htfIjOUFVghMdza8x9eKVc71teKqUDJiiHly1vh4ODKCdD
         fC3A==
X-Gm-Message-State: APjAAAW+IXwTlwidkJ8X1teJRyZNP50qArdodfDsZcnsstL4TrPFEvYX
        Kbkf+uDHhR6wXqvh42cyf6TDVDWrtoCkM5IhtnA=
X-Google-Smtp-Source: APXvYqw3fvOCCwZdu8etRKGUl+A0EcL6W+NwnuNaYHNthGzXg84eYTZMvn61pHZyFs8vXT75iPcVvqpMk9zcr+f7CXo=
X-Received: by 2002:a65:5a08:: with SMTP id y8mr3834154pgs.4.1570621593361;
 Wed, 09 Oct 2019 04:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Oct 2019 14:46:22 +0300
Message-ID: <CAHp75VeJPNhuWK0NiTg9dWk9Kg26ApzVi7NUKfGxydHm1v6bPA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Auto configuration mode and error
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 1:32 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> These are some changes, which help users to use the base-freq and
> turbo-freq features without going through multiple steps for
> basic configuration. Also add some error when user is trying
> to disable core-power feature while it is getting used.
>
> None of these patches are urgent and can wait for kernel version v5.5.

I'm completely lost in ISST patches.
Please send an updated version of the entire bunch of changes for ISST
driver and do the same for tools.
Thanks.

I'm going to drop these ones from my review queue, so, I'm expecting
it as a part of new version against tools.

-- 
With Best Regards,
Andy Shevchenko
