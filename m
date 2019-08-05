Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC4EC19759
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862E120B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWafSLJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfHEBDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 21:03:49 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41560 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfHEBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 21:03:48 -0400
Received: by mail-lf1-f44.google.com with SMTP id 62so51727166lfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 18:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmrFAHC07DlrBROd7WWwjkRjuc3qzI6oUcV/GoHKzYk=;
        b=iWafSLJaEp0VfnD00FV8DkZCUUcui7hR/eLGX47Wh4alduSlUkHdl2PLoX4j7wOFa7
         6ioeaUayLRoYahIpLPfCvenkZhbZa2hGi8TR1xpLJB0APzD8KaDBmk19+sSntPXAP6Jm
         apFDkyNwhJuMQbTmX+wVAmuSpgEOMg1RZ3QZo0pNu46Au5ZsIY6O4fyEMXd7Qjytukj1
         gCY1722Mgxhy25un956dYmMT9K5cmutcjHyf3K0uuoTb7d0oSE1caneCpy2NY5EnQj7w
         0cwKdkXDQEX7VhwGKXsDqWdsgURGy7ulZu+0cfXEdfOOc1Ggr7LB4JYDU/WTWcFVDkrI
         D0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmrFAHC07DlrBROd7WWwjkRjuc3qzI6oUcV/GoHKzYk=;
        b=qhgXB7HgQYjmxpKJ8I9cesi0ZvJHAcA1R29c8HuT1NRIm5hRYXlYzfc1raaYZ/Ladm
         sz17SLvUXxkRlEMwdQVF/B9w872tk9ifrHWPOxLktYUXkMs+kDnvrmurLAAOs2sYRhvl
         Oa/MeyMPKzS6FUBQKHYOpt0LmmZHF/TE1VehSK2/VD9vrlUAijrGFtsvzEkSQrnDTVom
         bKpYJCiFAEcJ3JeUDTMcrqrjw8Isvp8DT5p4UQujmj95JsHxUmnNMp82r/7ytW5wbcg3
         q94BEZRQyhpbqWL4Bn22zPSmabxBBb7ds4XnOpX9Igzz1iUV6mPGgGTpn+DHolde2mGa
         MoeQ==
X-Gm-Message-State: APjAAAUBpdAUBmufnJosw/u15HTLlcVE9c64M95k/VYYB879opZtVzFU
        lvygiNbrFfpAc8lF0DyLxxU/D543KH4OwcE6r4o=
X-Google-Smtp-Source: APXvYqySxgn/5teLdmDwFi+c6xRp59f1ywZmW6wEWVf6qrCjqr3LJLIRyhDIvjAYIsznufd8BX4pO11hDUMPPEIQZIw=
X-Received: by 2002:a05:6512:4c8:: with SMTP id w8mr4546391lfq.98.1564967026478;
 Sun, 04 Aug 2019 18:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNDYzcpDCM5P0fVWF30N+TMD62CXjv902z39mrCWULsjA@mail.gmail.com>
In-Reply-To: <CABXGCsNDYzcpDCM5P0fVWF30N+TMD62CXjv902z39mrCWULsjA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 5 Aug 2019 11:03:34 +1000
Message-ID: <CAPM=9tw5By7txR8UVriLxyveX0kff3aNNiMWCTjbVyk33wp5XQ@mail.gmail.com>
Subject: Re: The issue with page allocation 5.3 rc1-rc2 (seems drm culprit here)
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2019 at 08:23, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi folks,
> Two weeks ago when commit 22051d9c4a57 coming to my system.
> Started happen randomly errors:
> "gnome-shell: page allocation failure: order:4,
> mode:0x40cc0(GFP_KERNEL|__GFP_COMP),
> nodemask=(null),cpuset=/,mems_allowed=0"
> Symptoms:
> The screen goes out as in energy saving.
> And it is impossible to wake the computer in a few minutes.
>
> I am making bisect and looks like the first bad commit is 476e955dd679.
> Here full bisect logs: https://mega.nz/#F!kgYFxAIb!v1tcHANPy2ns1lh4LQLeIg
>
> I wrote about my find to the amd-gfx mailing list, but no one answer me.
> Until yesterday, I thought it was a bug in the amdgpu driver.
> But yesterday, after the next occurrence of an error, the system hangs
> completely already with another error.

Does it happen if you disable CONFIG_DRM_AMD_DC_DCN2_0, I'm assuming
you don't have a navi gpu.

I think some struct grew too large in the navi merge, hopefully amd
care, else we have to disable navi before release.

I've directed this at the main AMD devs who might be helpful.

Dave.
