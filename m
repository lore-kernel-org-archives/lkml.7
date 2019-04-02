Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FB0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EA32082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PorVRwq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDBUyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:54:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40620 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:54:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so13333309otp.7;
        Tue, 02 Apr 2019 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9FL7AtfGEmail+mg/F3uKZZ/lG1NctHkoOBjxpaGg4=;
        b=PorVRwq6YbASI+ecQq7hv5ptMjOrpHYaMokGWVSSD8tfpZ/jUO8KEAfeerllEKxmQW
         0CLQHZlzV0PhFHUzthNmbg8MMPE/S3BxEKbYx1ghj+S5w0qa1+g5BB8vUkM1dghu8UeO
         7pHYiTAguEEE+vbtJSPdm36u2xhnB5IR2TyMkcUPRW1vN1KsEhjAZKSsLiNY2dAA61AH
         01cAGya254JOdagFfqyfou27FgT3nii1t6UlwdBhh8eW/0GFzoDApwgvr3+9WCCIjG6z
         zBPKrRi3AyU3jGX/XGIFSBgXzWL7bwOoanf5DLlColYpjA/W5TA8hP1my6WrVS3r0LGU
         w8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9FL7AtfGEmail+mg/F3uKZZ/lG1NctHkoOBjxpaGg4=;
        b=AcdNqmAP10IWyWNl5W8048yFmsGLiMGj44Kef+YRFZDWOxnYBC0IhzviNOFJ1Rioeg
         o1ryDpGx4k1dZt+E+V5wiDMqYKZm0BGOVFNnzpKN6hK8tNmKiY53rVJu+80+dUSD8U2x
         sQ/Sf07qYDI5Ulc3CYD0JD/9BDtMDbgx9injlmGA6t9d4wY4EMB1/dDchF8yPuE/Rz9L
         6x+YSXeVOqf12J6UvC4mQE2Xm78hzc3+x6eL5CZzecu5bZkS9MmwkPRkDAmb4PnHKzV8
         CzLY/pvUylOgtaKiZGleJGL3T5jA73Jl+RoEkvpMtXLzzFy4ydH972SJ1gBqjPXGYTkg
         +TtQ==
X-Gm-Message-State: APjAAAXcGiXZWNeDH2x5W4HR3nteNrxo8m7KOM5Q4bosS1Qxyt6qeEb2
        myYKluXvTdRCHqqFyvQEU2tUWEnIsTQXlbEfDT8=
X-Google-Smtp-Source: APXvYqzDylUIuy4oCGNk5VM2ik2zFst9aMtPCWm4PQSBzXTZeEuxxiBRxNstAPwQLqyCZ4CpWOGYuuF0v0HxXeRAxCk=
X-Received: by 2002:a9d:5509:: with SMTP id l9mr6845683oth.195.1554238452776;
 Tue, 02 Apr 2019 13:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190322051759.15007-1-tomli@tomli.me> <20190322051759.15007-4-tomli@tomli.me>
 <20190331180947.s44eznujdeucnl7f@debian> <20190401162618.GB15736@localhost.localdomain>
In-Reply-To: <20190401162618.GB15736@localhost.localdomain>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 2 Apr 2019 21:53:36 +0100
Message-ID: <CADVatmO0_1mn7oQaLrQLXZ8re2R6uus9vPdXj4qZPi2CovS44g@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] fbdev: sm712fb: support 2D acceleration on SM712
 w/ Little-Endian CPU.
To:     Tom Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LFBDEV <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 5:26 PM Tom Li <tomli@tomli.me> wrote:
>
> On Sun, Mar 31, 2019 at 07:09:47PM +0100, Sudip Mukherjee wrote:
> > On Fri, Mar 22, 2019 at 01:17:55PM +0800, Yifeng Li wrote:
> > I didnot notice any performace improvement in my system. Infact, I have
> > never seen the performance problem that you mentioned. But, it will be
> > good to have the 2D feature back again.
>
<snip>
> But again, the 2D code is only used by Linux VT code internally, if you are
> not using VT console, the behavior cannot be tested properly. Are you testing
> it under the Linux tty console? And does your dmesg log says, "2D acceleration
> is enabled"?
>
> Running the "fbtest" testsuit is also a good way to "smoke-test" the fbdev
> code.

Yes, I do run fbtest as part of my testing.


-- 
Regards
Sudip
