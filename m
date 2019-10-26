Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7878CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A9E20863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572090045;
	bh=9sb1jJXzzKV1kpv0pBipGnYCWTFNZ/uSQ/5elRGl8gI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sdqgdp0J/eabhdiMYaRDJNozexaD/nOGgqUVRg8AshoHE2cOHP/9X+/WZFeiCRSHi
	 rtuYAmuNgCtFTd8cpwqhi6yHre0lz+stx5jjpNtYAPftFNP/3gK+pE7YZ0sFNSVHh8
	 sRJDtsq4tptouCoH1/bkOkVBfyllus+yjGGFaTpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfJZLko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:40:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51097 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfJZLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:40:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so4815462wmk.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/vxypmhdx/87an+/aP388jEJdL3hr+RUlVQLpWt2Kk=;
        b=kR3FIEvo/pIuxQ2pW4trmkGyw6H7NRo/3OEYxCTyYBmDxYfvAYf2tsxnnPhN5E8IaP
         eQe/LgwEAJq7m9d7y5MAZs1CeEk6CZSfq/prVCLFIismm8uK8ISS3URTMGqydh2D+dHv
         wImRPO2kyuvYJB9hJKUZb8Tb0G3Tj1ZveKOz6obLtSeNEczEKbIgxghHb/SUIzv1PzxG
         FbUGvqTm7uQTgGiYD6GSqeFbfQ4IV4VoV1k0yJl2mm79pUmUPIr00T8cIMVJH47T0v/l
         PNDyWCH13qU0TT5rVxLeryyORpYaviGEujOMLZXeB94RdJeqV4bBb6CHTlvHjeOGQZpe
         fOwg==
X-Gm-Message-State: APjAAAXXJ9AmRLM2UGeXTvElkCTmGFtLmTzd6EJmhvEztsmrS9stOTGE
        8w3fa45uvap8TpTDQ4T93ikz6NQrMPf6cJgs03Q=
X-Google-Smtp-Source: APXvYqz1oIBJniaz8JVkUffCRISuoTlUzqgFgKCb/DI0DSGVzrJpvXjsM53KxEB2DhPAIavQL8hmjrPTvzliOdOApbw=
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr7437100wml.67.1572090042021;
 Sat, 26 Oct 2019 04:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191016125019.157144-1-namhyung@kernel.org> <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com> <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
 <20191025110623.GH3622521@devbig004.ftw2.facebook.com>
In-Reply-To: <20191025110623.GH3622521@devbig004.ftw2.facebook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 26 Oct 2019 20:40:31 +0900
Message-ID: <CAM9d7cgY4_V1bj7ppVT-vutCob=rX+e90pjHE7-MMwBWsKp2_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 8:06 PM Tejun Heo <tj@kernel.org> wrote:
> Sure, but I think we should get the userland visible behaviors right.
> Ignoring implementation details:
>
> * cgroup vs. css IDs doesn't matter for now.  css IDs aren't visible
>   to userland anyway and it could be that keeping using idr as-is or
>   always using 64bit IDs is the better solution for them.

Yes, it can be done easily IMHO.

>
> * On 32bit ino setups, 32bit ino + gen as cgroup and export fs IDs.

This is the current behavior, right?

>
> * On 64bit ino setups, 64bit unique ino (allocated whichever way) + 0
>   gen as cgroup and export fs IDs.

Hmm.. we still need gen for 64bit?  Do you want 12-byte export fs ID?

Thanks
Namhyung
