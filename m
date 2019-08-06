Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97867C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC92173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVu/AVxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfHFVzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:55:40 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38845 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfHFVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:55:40 -0400
Received: by mail-yb1-f195.google.com with SMTP id j199so31247078ybg.5;
        Tue, 06 Aug 2019 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+AWtp//iZQHBUSYNSKib/pmDOCkaOgoiXvpRJP7gmA=;
        b=tVu/AVxPuKr2O9yi66GUMZ0XXx4MnVzRGiRb5hTa+JT7ywAQfE41BLvGoUUMIyghG8
         SZ5XiFa529n7Okj5ezJgKeksYJiR2YLmFzz1SxrI7LtG8se1O+RwTMhODC4QE8K+ZYx5
         JBcR2ucDj+u/vRCXz0HKWyQ9s3QM6rS5U9Oca6MJmamX1aP7SY3Dli5qL6VEasaerW+u
         +wpk7a5Mc/GzmW6VS1nPI2XFJ7WxW8qWuDUabl0ZP+W31PbcppyijXI6/E6QIf+i4J1H
         Nm/SYfASp5hYQHFAaMZdipAZyocGfVwf0FOVfmOCJuVwPTp2NHWKM5+3EjVAwTxBTj9/
         H4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+AWtp//iZQHBUSYNSKib/pmDOCkaOgoiXvpRJP7gmA=;
        b=UOqeNtAUuiV36y0rHH5VbkM+DGK6iFB3UM0A2W3qO6hpSd9VrSQHBGaG2RDyxWMBEQ
         HiJ4cxcwhAh3i7abuusNgq1ZI1LTYHtR5sqh/FIGgW5aaKektvwUSFnSwNAOXcJOPxCE
         CFOSlLPVasdgFZlUMpYBRHRPK9gr78FhqTrhfndVBf91qWo+OK14aq7KLSi9OzwYG6tI
         52a2n+dYWk8J4rHtB1Y16cSoipbOOsiMMtTT1GoKn3s4zmdmobD/xcPAH2z4F8UgexTb
         F2fGq5LeAA9Da1EaGOIKZHg2/BJgR7nbT97rl0BjdwHb0Z0+RRn97g20VHDcGeJ0PJv+
         ec1Q==
X-Gm-Message-State: APjAAAWgb6UjcslD6PEiuysBFiISBfAIOZ0ryre5Z6WhhB+5RblEYzVV
        I3MX9cD75Yp0Hk8fOh10Nutjy9Uy0yZ/vv3SJSe7iw==
X-Google-Smtp-Source: APXvYqyzY27IzFJgojA2HdRgeqD+9agkpOGxxQswUtP53SFdrOWfXL20fObGcfS/l1k/+lQ8mZ6T/nAWZqzVrK+oCHs=
X-Received: by 2002:a25:6602:: with SMTP id a2mr4085214ybc.119.1565128539683;
 Tue, 06 Aug 2019 14:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190806213319.19203-1-sashal@kernel.org> <20190806213319.19203-7-sashal@kernel.org>
In-Reply-To: <20190806213319.19203-7-sashal@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 6 Aug 2019 14:55:29 -0700
Message-ID: <CAMo8BfJZ1aQoyjpfUE-WT=OpW7EvNC+vu878BPqON0u7E5Ujiw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.2 07/59] xtensa: fix build for cores with coprocessors
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 6, 2019 at 2:33 PM Sasha Levin <sashal@kernel.org> wrote:
> From: Max Filippov <jcmvbkbc@gmail.com>
>
> [ Upstream commit e3cacb73e626d885b8cf24103fed0ae26518e3c4 ]
>
> Assembly entry/return abstraction change didn't add asmmacro.h include
> statement to coprocessor.S, resulting in references to undefined macros
> abi_entry and abi_ret on cores that define XTENSA_HAVE_COPROCESSORS.
> Fix that by including asm/asmmacro.h from the coprocessor.S.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/xtensa/kernel/coprocessor.S | 1 +
>  1 file changed, 1 insertion(+)

This fix is only relevant to 5.3, as it fixes a bug introduced in 5.3-rc1.

-- 
Thanks.
-- Max
