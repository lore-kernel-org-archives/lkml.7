Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45CD20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V7OvuMib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfCVPfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:35:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33988 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfCVPfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:35:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so2437998ljb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnCsfw+9gHeo3z0Jh3UX77Kv5ns0QiRJD8uemSV68zs=;
        b=V7OvuMibaiLgiunqKKGWvfIZbYQ+pY2ugtU7bHsNdgcb3+ZdPzW1hja1eqOK90j2lb
         TBKkRIEQk/OXHZqnS3Sn2IG/C2SA2AENTp/tpWx6N2NOVeSwvb/1ma62sks5oPCWe9k6
         EVsUxz0iHW3BmXn1R+whSPnr5dUUTmPKtyu5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnCsfw+9gHeo3z0Jh3UX77Kv5ns0QiRJD8uemSV68zs=;
        b=mkcq90jalR+yf7N899mJwOpUCXFggfPHwzlWnnpVsaFvLoRVDARHrCRtYLbif3UUrF
         kJ6g/GPzQhMfLdObTlIIt+tmt5b8aboaduOgJMAQwxYiH7Ksx2nxi/0p3rb/43cRM/hh
         5jifJEdL6+G6KxFQhQ2V47q+RmvtEcDVzu+z5E+f6k5E48v02e50kPVuHafsWAikXQ7I
         zbjfOAby2OG/SYVmCyt2TBmAIGK0sM2GMJFMXb4R18e9gJ1DOijK11m/torclA5R5CSF
         ifoZSkhtWf4gQq1ApXJ7GiiKZGZcfDUuuPbUNUDWLqYfT04TDY8qLHsKChUHDAE2FkPu
         lvoQ==
X-Gm-Message-State: APjAAAVpToJ36UaNZ1XORYAud94vma4nP0sAsPdr6SmECBKkVdhQVQVT
        SlSNTkkHeu6kC1y3OT0bcYp0PM8LTi4=
X-Google-Smtp-Source: APXvYqzEKNwbvRIqEbffACubTE0P940iVuB4lXkvvT219Bpl3W8lxKN9Ytwjf2uUJhaQU1DUBEi5SQ==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr3610101ljh.91.1553268912210;
        Fri, 22 Mar 2019 08:35:12 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e3sm1759572lfn.80.2019.03.22.08.35.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:35:11 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id p1so1676813lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:35:10 -0700 (PDT)
X-Received: by 2002:ac2:4563:: with SMTP id k3mr5399948lfm.101.1553268910090;
 Fri, 22 Mar 2019 08:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190226065919.22218-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190226065919.22218-1-bjorn.andersson@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 22 Mar 2019 08:34:33 -0700
X-Gmail-Original-Message-ID: <CAE=gft5ZUHKQqYVL72_kojPr7vEUMY301gmGviCUVpBYdAoBDw@mail.gmail.com>
Message-ID: <CAE=gft5ZUHKQqYVL72_kojPr7vEUMY301gmGviCUVpBYdAoBDw@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:58 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> qcom_qmp_phy_init() is extended to support the additional register
> writes needed in PCS MISC and the appropriate sequences and resources
> are defined for SDM845.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

How badly does this conflict with my refactoring series at [1]? I
believe that series should be just about ready to go, do you want to
base your change on top of it?
-Evan

[1] https://lore.kernel.org/lkml/20190321171800.104681-1-evgreen@chromium.org/
