Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D4FC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FC421721
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p49ChQ13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfE2HJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:09:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46123 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2HJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:09:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id m15so1295175ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hmEt8XBAszMFOt/NHrMak9iR4Ln+O6rhKTThaepQX0=;
        b=p49ChQ13CkTgafcWq6Mx8FOk/3a/AeGpi05o5uxn0TRjMP7yQKQUwXpN1bbkt6bsUL
         BOp03/oTIkbFDCJgo8EFfNE0dDIo9i7rKReMyFNF1dZ/M1Tga6IFPJqU6RNwQ9ztAKEi
         kVPSOn09OJUcGey1NdvjzyLfUrSxYu2LvzfPCvj/ykDhrPxYoFREu8hf7+IFKkVuznxg
         wzzsesZ5sTsck6PUx8smbK+YfBzvT0kXI2A1La8N2CmQUuFn1pR26ai5oseyyE1t//7M
         Jp5OBTnFMGRX4xsL05DMLjI183G/vREXuSDRD9tAOSzGCVHCv3Od22rktQlI1NPK0/Wh
         hWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hmEt8XBAszMFOt/NHrMak9iR4Ln+O6rhKTThaepQX0=;
        b=n+VW0VvtJ6xS5GzeRNo78U9H48ms2BOpcKA3Ce/G0hwPVIysTFDqh4GJ8JrbuALCRk
         SzwpvlBcbdOOGK8uGU8JAKEnu8N743BVl5N4yyCPXbQHmA7au3artTfsXnPZOQrgRcJb
         HiStFb/CZ3evEBC3MS5vWYciYw+GbHouZfPy+T9T2ZYq6aru+mjwvRabmanspJIFaB42
         6QlSjhm5W+fwWFugPRYEXYGTm0B+uyHrhbM4HF4LBDQrUWoF8SK3MLkVTPVlgdOJox1Y
         GS/QBXwEHNpOrl2aNmtRMPAPJxmHgT0g+RiAASLneFIybQcvZWE5vIGY9EVs5cjXSvOh
         u/OA==
X-Gm-Message-State: APjAAAX1qow/Q0UkQGFG+K1SUpJa1ZAL2/DWXccs1tRaHqouwSpXyKjy
        VvV08yIzXvQ2n5nLToSyTdU5kIB+31Gm30fQ7iI=
X-Google-Smtp-Source: APXvYqzPybpE3leNNpeYsxD/syHNbqQB4AamoUBooFN787Z8X3jpIs8qqKLWY3d8qJDJTDSMGWjIGZogbhlUDWuIO+4=
X-Received: by 2002:a2e:9dc6:: with SMTP id x6mr1537784ljj.27.1559113778900;
 Wed, 29 May 2019 00:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190528193004.GA7744@gmail.com>
In-Reply-To: <20190528193004.GA7744@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 29 May 2019 12:39:27 +0530
Message-ID: <CAFqt6zZ0SHXddLoQMoO3LHT=50Br0x4r3Wn4XviypRxRUtn9zQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Fail when offset == num in first check of vm_map_pages_zero()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 1:38 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> If the user asks us for offset == num, we should already fail in the
> first check, i.e. the one testing for offsets beyond the object.
>
> At the moment, we are failing on the second test anyway,
> since count cannot be 0. Still, to agree with the comment of the first
> test, we should first there.

I think, we need to cc linux-mm.
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index ddf20bd0c317..74cf8b0ce353 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1547,7 +1547,7 @@ static int __vm_map_pages(struct vm_area_struct *vma, struct page **pages,
>         int ret, i;
>
>         /* Fail if the user requested offset is beyond the end of the object */
> -       if (offset > num)
> +       if (offset >= num)
>                 return -ENXIO;
>
>         /* Fail if the user requested size exceeds available object size */
> --
> 2.17.1
>
