Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECA4C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B580421E6D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1XbgAzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfGVH4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:56:31 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:39795 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGVH4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:56:30 -0400
Received: by mail-io1-f45.google.com with SMTP id f4so71924976ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8geFXXVXfHhAz5hAbzZmIPKSSa6hTGBtefRp2yOmwvY=;
        b=N1XbgAzTqgPrawTL/w45g/LfC7QGk+9xu7IbhImK8mVLIaECEWGm98ZGbCvqNQ0yDd
         uJuf2axzPpkPbODs60OBo8E2jExxxKOogG08w2axhkT4y9nw/XyHFxm+nmHlm5KHFTNu
         p0RgTeiPhjM0t3YG8u7zbAa8Q1brUWrA76/GRVQAmCKTcp4Ys/oSjeHLpjYzFYAztXn+
         BFS7fRUiv5HSPB2tOP1rknpXv/4Kf8b2F4URckc/2su4p+7FjM097GxEoWipIq9j/SEh
         d4rfKc/MiK4inVoOM+jJiHdAqoBMEDvg1TOk3EymBoEd4NE9aj1fw52QMwMi7tAyVspY
         Qwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8geFXXVXfHhAz5hAbzZmIPKSSa6hTGBtefRp2yOmwvY=;
        b=ORnBg9jAepOmPMdzhlRtQ6O1dZCPYXyZTNjJAhFFOv1W5ctEmluXISXj5iVMSKHMGr
         0RdN8L6Gn925c1UjofwbnfG6D58uyLIo6pGoBGDz9BCTDGusRlatL7Y+Ii8onrYhFx/i
         oIU5OiO1W2vZlac1/iX8qXGi1r7bOsXyxx4tZxDNyEP61ntYvEMMNoOMc/MsEt8WIW2o
         SLdElMVpJ8PLDD4bTSE0W3tSOf4wdkG2gYTfOIcnZ6OkLCV3hI4dukxUnNL9oOhrYUee
         np5oOw2tg01G2x2j1aTeRJhFPU0GJpHkesE8IWLUk6XwUtEJBrlYbIrTH3gThgfHAJzc
         FUXA==
X-Gm-Message-State: APjAAAVdLTPvD1xII7XQMhOJg4y599VyFjSrv4q+QDQ8HN06E5O3Ahxk
        +VufEnvKNK9K7rEFgIIVx9B++uu/PLo0p97qcGOjWcgZpYw=
X-Google-Smtp-Source: APXvYqwOhVMWNrMDgv5wpZzi3eBfgLTMQr2cjl8B1jjsVSMdjdXxE2YI1CpJ4If4ifppm0SH8qms0q0UzPEnGxYgBJk=
X-Received: by 2002:a6b:6611:: with SMTP id a17mr40200646ioc.179.1563782189924;
 Mon, 22 Jul 2019 00:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
 <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com> <878ssqbj56.fsf@yhuang-dev.intel.com>
In-Reply-To: <878ssqbj56.fsf@yhuang-dev.intel.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 22 Jul 2019 12:56:18 +0500
Message-ID: <CABXGCsOhimxC17j=jApoty-o1roRhKYoe+oiqDZ3c1s2r3QxFw@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 at 12:53, Huang, Ying <ying.huang@intel.com> wrote:
>
> Yes.  This is quite complex.  Is the transparent huge page enabled in
> your system?  You can check the output of
>
> $ cat /sys/kernel/mm/transparent_hugepage/enabled

always [madvise] never

> And, whether is the swap device you use a SSD or NVMe disk (not HDD)?

NVMe INTEL Optane 905P SSDPE21D480GAM3

--
Best Regards,
Mike Gavrilov.
