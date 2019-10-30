Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1DFCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDB62087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EsBv0Dhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfJ3PWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:22:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46545 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3PWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:22:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id z22so2033187edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvMNKSCrNMxtROTkfOzlYhe7iouX9dJL649o/i6yCrk=;
        b=EsBv0DhfbRnsI0WEmZMkwydFvbWFPsRbbEbAZtBPdh9M083h/c5NSHWDtPHC75mpyi
         38XxlW39llSU8Ey7FQ3jEGYG3AJ4j39pFedtJGqpBXXE7G60UbKP/Vgay8/DWkhOK9ca
         ppA9WpqjfIpe0BN7xKE16kev55IHzH0ZowCMFiN0NOAiBU3s85SiaXzh10AgadtBLV92
         LMVZPV5pJ36JH6+CSwu+4r8Ib5OyjjmdR1NTiM+El6cGes9BHX+eeX0qHGRG/895/rrc
         XQb4s25qvWM6DoKEUtF/1vNKC6O9qHdO+iR7/YajL7kT0OZbHeeeuJ++73oS8loCcolq
         ZxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvMNKSCrNMxtROTkfOzlYhe7iouX9dJL649o/i6yCrk=;
        b=opshjPL4uAldE9Ks6mLqLLdCoHMYRveLpO6f4YbwLJfm5uR20pNU8TLPX90raKRjRa
         DYq3cfw2GQVOkeROXh5mGx3dUtQPOahYfFIhf2GDeVIWDrZ6w68bo4e17jTDc7c3p6sy
         KVKkOlUWV5iin8ozjiVEpv2136RMpkH0pjt9bEyjoe7zDZObOjyqIPBVy/ZhxXkBmZdA
         AOT1US4jc28DIO5rHaSHyFkl1qGWtgldis55CMoLhymS2tFBmqdt50+4/7LLdKNXCRdx
         WgB/P6NLWtKwFMU3fz0ZP00v4OTW0uPl8HU9vujsQA49Jjc3Mm+wFQbk4jU8MxmNjAbs
         8IMg==
X-Gm-Message-State: APjAAAVSUPPlud4WPTYZ20dIg5J0JLL4TmLGDTWrrMl0gYXBwos1+Wgf
        fH01t3vS9u/UmuC6yGL6hKUXRqVF+LbhQl+CdN7W1Q==
X-Google-Smtp-Source: APXvYqxkf+B29MLZi9AVfIHKME6DTKtd6/WLRp0HEHJrp2xexHMw3qaJaeHTNMiTJ6l3DYnaI0D3OibgfJIzJo6C3zo=
X-Received: by 2002:a17:906:b2c1:: with SMTP id cf1mr7523ejb.155.1572448926920;
 Wed, 30 Oct 2019 08:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
In-Reply-To: <20191030131122.8256-1-vincent.whitchurch@axis.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 30 Oct 2019 11:21:56 -0400
Message-ID: <CA+CK2bDDPn-nmoM7mYS0X8xUBF6q8_scpZY5-YQQXvGAdoCRpQ@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> (I noticed this because on my ARM64 platform, with 1 GiB of memory the
>  first [and only] section is allocated from the zeroing path while with
>  2 GiB of memory the first 1 GiB section is allocated from the
>  non-zeroing path.)
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

LGTM, Thank you!
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
