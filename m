Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8615C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F35216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557349558;
	bh=iqIPlh1mmcFuBc/JzzhVLdenVANuihdttWuVAjvDzZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QFvUJ1oH1De//HJBV38pUHHZJrv18GhC+Ur8wBpNMjqIRyBQB9YButp4Ju8JAL5KM
	 E8cT2vIkCJHk8RTpPmMIFcFeKcv/+WOySRsz8s4HDr7b4Xexjm0dQgQDfNGbpdY+PI
	 Ec+RIQOQbGAGDaD95twTK58uNhkDpyMjPLlln89Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEHVFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:05:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41467 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEHVFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:05:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so15551719lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fckl0xjweeVSgmV6ZhbixKk1mxFtiIYGjnNtVdcmVxo=;
        b=Pp2t2GlyiZSXovwnh9PFrn4iYBJ/vbeGKAbfaCTmcGmXDPVHx18nUq63X85sD1beaH
         vac1zYT1UIe1PABtweZBtUEFhs5plA3qmlj8jeg9kFjNFnXE7BYze6WdSAokj1y/1eVq
         vphRbjzCRE7ZQdfdrFUZPXy5vbAMZbWAt9HWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fckl0xjweeVSgmV6ZhbixKk1mxFtiIYGjnNtVdcmVxo=;
        b=ULnG4gbLLHRKe2leVlY4Mb4BtRHUQ36/6M2VzdeGC7gTCH23D09taeggcMB8QLka2V
         COInnRKg/3Z0zLQPM6gx6fJpF0rYdHrctzokbjHD6WAAzXVN09V5adESDhpdX9JZj044
         q5YVtWOuJAVPQBvUCbN0/hxkdVo+KprkUw9Gns6scUZWjZRO1NQKaINNd+5ZZu5T1y4z
         Hq+enwhLS/BlTvRR7S8itGbVT9RsFj9s9Hg8xxGL39C/ppJiNrwC/b2j+B17FAZiU9oU
         dApvAhx2lecfDOahnmm/Rc/CkyZ9hr8vKUmUuds4m70ghe72yghXiDqZQLfUt/gWI+Bz
         /U2A==
X-Gm-Message-State: APjAAAV16w86gRQvS4W8HfI9MWiF/uNHLfmgwPlErII3g8OuKXd291sW
        ar9/RRDcD187VOLsmddHVuaMJkYh8Hk=
X-Google-Smtp-Source: APXvYqyL+1v+7rijvsxKCYl/IL6K08KAE+gKUgCwV9MqDbXN1gYGQ6KGkH4f+FhoGVtrsWfJ3sBGHQ==
X-Received: by 2002:a19:7411:: with SMTP id v17mr141615lfe.116.1557349553168;
        Wed, 08 May 2019 14:05:53 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f25sm11454lfc.46.2019.05.08.14.05.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 14:05:52 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r76so105445lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:05:51 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr22158854lja.125.1557349551465;
 Wed, 08 May 2019 14:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
 <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
 <CAHk-=whbrADQrEezs=-t0QsKw-qaVU_2s2DqxLAkcczxc62SLQ@mail.gmail.com>
 <CAHc6FU40HucCUzx5k2obs8m6dXS08NmXBM-tFOq7fSbLduHiGw@mail.gmail.com> <20190508145818.6a53dff5@lwn.net>
In-Reply-To: <20190508145818.6a53dff5@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 14:05:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUMj0nwj_ee59J4yLnbnR_UfMeRx4agijSc7DKJADoPw@mail.gmail.com>
Message-ID: <CAHk-=wiUMj0nwj_ee59J4yLnbnR_UfMeRx4agijSc7DKJADoPw@mail.gmail.com>
Subject: Re: GFS2: Pull Request
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 1:58 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> I think this certainly belongs in the maintainer manual, but probably not
> in pull-requests.rst.  There are a lot of things about repository
> management that seem to trip up even experienced maintainers; pre-pull
> merges is just one of those.  I would love to see a proper guide on when
> and how to do merges in general.

We had another pull request issue today, about a situation that I
definitely know you've written about in the past, because I linked to
lwn in my email:

   https://lore.kernel.org/lkml/CAHk-=wiKoePP_9CM0fn_Vv1bYom7iB5N=ULaLLz7yOST3K+k5g@mail.gmail.com/

and while I suspect people don't actually read documentation
(_particularly_ maintainers that have already been around for a long
time but still do this), maybe that part could be in the same
documentation?

                 Linus
