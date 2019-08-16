Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF2FC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3642B2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2WaBvC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfHPRcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:32:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34815 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfHPRcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:32:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so3281373pgc.1;
        Fri, 16 Aug 2019 10:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CIGPoAmGHGl5Ith4W5K2xt/H1iPB0XC3nArp4KW84Jk=;
        b=e2WaBvC48D15xJeMrITSbWWgl9T4/yBuqNFS01JD1U2xTEHU77RJ1wPTBVTf3xVKSz
         mo8erVa6Jf1XVtchBDxGSNyJGPTnoa8Kp+Jg9H72lj+6qMlsNKiKhbx3DNMYpdK93uuY
         r63yOmiGGxlibX3YQbACmt1e3IfPS+IwbkB0CpSb+YUH2JXWobs3yII9LSbaAZUgU9v5
         /bunE/UcPXbv2mX/BTUd6ug2TdA03aWhX+YTzgprxR8Giz8ZK2Do3rqnUGL2Fj5QywlU
         i3BsyL2+FcOTaoXZL40NM4Uxv0cRYxdwn/Z+TVyxtLMCwdZ83LaiV1OskuNOJstsgonw
         CBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CIGPoAmGHGl5Ith4W5K2xt/H1iPB0XC3nArp4KW84Jk=;
        b=BjkjqrrJsRyPogobj++asjTlH+pViX21CTX+AIYhrxGm1Lqj0M4WGC8x4UW+7fG3kJ
         WHvs/233E8H0+wWUrAzxgHVEieyje0Kvxf+6usuxPkqEl5RD/q9eCqQYFhKRkTqSvBsl
         MvCevcLOV89ui20ouLkpYuvZ1Qidsvhobr2mMtmXU2BN+NH6zoMAdj2HD81/CEutNLde
         U++OYMkSop7GXpl97u783T+F4opI0CBDkMv64Vbe0W3pyvv1RZf2rfWKC8vdloWdGyeh
         d1IbqTiBPLe4f7D5AC/F2BNf8nYKNHffF6AWeJUud4AMeFCI1H9hKxEOXdTiebuwhqwb
         zO9A==
X-Gm-Message-State: APjAAAWmH3yQPpk6HbpcV/uJ5Cb49YUKa3b1gmBhdbMpucUJxlhKvaYv
        pJJum7uVhdnPXdAkuh1HWw4=
X-Google-Smtp-Source: APXvYqwmKdu20blAv+n9DFxb7bICbqziYZ2E95ULxsq/70/xDU0b+VTR+Cfn0CK578miGfepVbyFIQ==
X-Received: by 2002:a17:90a:bf01:: with SMTP id c1mr7523058pjs.30.1565976732346;
        Fri, 16 Aug 2019 10:32:12 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a189sm7751191pfa.60.2019.08.16.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 10:32:11 -0700 (PDT)
Date:   Fri, 16 Aug 2019 10:32:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     nick@shmanahar.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, george_davis@mentor.com
Subject: Re: [PATCH v1 00/63] atmel_mxt_ts misc
Message-ID: <20190816173209.GL121898@dtor-ws>
References: <20190816082952.17985-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816082952.17985-1-jiada_wang@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada,

On Fri, Aug 16, 2019 at 05:28:49PM +0900, Jiada Wang wrote:
> This patch-set forward ports Nick Dyer's work in ndyer/linux github repository
> as long as some other features and fixes

I see a lot of chages that are fixups for older changes in your series.
They need to be identified and squashed together, as we do not need to
be aware of your development history.

Thanks.

-- 
Dmitry
