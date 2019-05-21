Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26AEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A197E21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+OBR2IK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfEUOop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:44:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33974 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:44:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so8717275pgt.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20boaGcuTy2P/q/l6C6tvbRVOXzptyGwu2wWe12RiuQ=;
        b=s+OBR2IKJQaoUQq9TkWY3iZcIs8e6aYEI+r9wKvUEcT6UD/19KTdDki3T0NaS/oTlM
         +AUNS/lE8i4+X3nMObC/Upl34o0z9IlyvRG0n4jyNjZFynpQi/uD3z1Z9bJ3kZo16giQ
         MNN9d/C2fQPFOeT54uoP1ys/ZyhVBmjq9jTpCe3LIi4CRhkRY+4cptVb3DdmWhdxZYGb
         2g0jKE4pArWrk05EE5w72g/dRPpSAPDInuTQ0R3ygjGVRXeK8/g3w6ihdS7zoPG9f4K9
         W1JIirwgP/gPga5Goqo5K/COqR4A3ngSLo8IhdDzo/fnMdqPzvGvR8ZGCzMD5xmpBTrB
         TYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20boaGcuTy2P/q/l6C6tvbRVOXzptyGwu2wWe12RiuQ=;
        b=mi0YdWHZ7e+rczVA4Y/kUukFkBpuBe7KN2ETVNzkAPSy7Kfp7aZ+wbSmy2/GJ7CDxk
         rQo10y7nwf2dzO4wmf3egdkOMAp16G6nJZTxO/UIkK/0JwvTn0sScnHqsDRapiZ+7vSG
         LEtvm84sstN9DbvrCfGvMH46lvoKUtOQE5/537z/9frQcziyhl9gWr1cNzyqTJ/UI26p
         1zelklkigKnBGnjY1zFgGIFauH9xRlQeUHUP4gduKzHgjyhT07/YST22KfgIS/2kfkhs
         FGbukzuAxYKquFrEDygIEvANysNYKpdOiTPozI9A1/ZNgsYz+pN8vpFeCvlqYiJYvP95
         zzYQ==
X-Gm-Message-State: APjAAAVg2kHjc/L+Kkrwqr6YHqO5Q9LwksfqdF20pyoF+0ONwHqzWHZn
        NWSwfHC203jJspxJBGnATfA0gV5ZMMbToSX3Y7zz+A==
X-Google-Smtp-Source: APXvYqyA+fanBPthrAZNEO/42AAbNH+ShAhflMTvjT9+edDFR0bIUpIat8IciWUEhLHFshzc8I4kS1LFJgVULD5dpK4=
X-Received: by 2002:aa7:8652:: with SMTP id a18mr85823169pfo.167.1558449882753;
 Tue, 21 May 2019 07:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190521142009.7331-1-TheSven73@gmail.com> <20190521143730.GJ31203@kadam>
In-Reply-To: <20190521143730.GJ31203@kadam>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 21 May 2019 10:44:31 -0400
Message-ID: <CAGngYiUagiM1qhiZyZ_BVACib-Mfk1wniq-CxZAC21F5Zni1wQ@mail.gmail.com>
Subject: Re: [PATCH v3] staging: fieldbus: core: fix ->poll() annotation
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Oscar Gomez Fuente <oscargomezf@gmail.com>,
        devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
>
> If you're resending someone's patch, you have to add your own Signed off
> by line as well.  Everyone who touches a patch has to sign that they
> didn't add any of SCO's all powerful UnixWare source code into the
> patch.
>

Thank you Dan, that's very useful to know !

Sven
