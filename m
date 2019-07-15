Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E811C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC7720659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uV4cZMJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfGOT5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:57:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42330 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfGOT5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:57:15 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so5803051iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Sug0O9NXLo3GeKUfp2V2/QUpa/FJDN6PQvg6dxEhGs=;
        b=uV4cZMJqpsv1MaFd6v3yIMTqWIdAaQKIAguNPDlxTnTIC7WgDs4hnszEFhEP1JcRgq
         u7tJH+guqw7uOY1t5dCh/8S+VG/+9gq/kkF+RbwCRLUZrmRac3qEWDUKafrdlxPiW6f1
         FhdLcaiZFwkGJ71CzFhmIRnms8ERdOCuXugS/njWjnffoKHD4BeD06b5Ztz+fU5Lgolu
         bu9CZCMkq5cr+8jmfMltSA1rUZi58yYyGh6AGIvt/sI9mhnpOyLRhbBqpr+R+AhoX/bi
         wzN51uAobFbcd30yeizl7wg/YGK5C+TZfHTL1Eeyz52E0RslOBCTc4xNlWoY+LhNBU8H
         mbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Sug0O9NXLo3GeKUfp2V2/QUpa/FJDN6PQvg6dxEhGs=;
        b=Aehrf9jdaW+M1z16is9Fq2rsz0rohVR80FmWKqlGHYyo9FDScq/UcGrb+WLXBJYIqi
         4Ii5kft0ACScYl1VIpkTm1nMWz+XHW8fe2Y/RAIhBEpYNM6FTIQxRL2oA4j3OD5+tu6M
         pE9Dm0jOqpHQLknjG1ebxwd5QPjOAHJcbGasLb8bjnFu9LkoS8qGNquJCsWvVvjRweLA
         R9eztgRFhdnYALPGrvMuBMm0suQ3qXI+p39Jm3l8sc/z0Q2TDJ0//I2+YUD3zKsvlXS6
         WtNd9WF922HqIVO7PjhfC5LxJXaqlmtz8bcd8gZU86onHAsb4Jp/nDm2Gs3kUNVKNHYG
         wYtg==
X-Gm-Message-State: APjAAAVRLkyPSI5EKvqPgWmHkQPxDfVuiZFzbqRY38MHCxg4cZ7M43H2
        jD9t4yrOt8PPstZQFSa0BymzIa0JmOv22+nTFkHMzA==
X-Google-Smtp-Source: APXvYqzZADsGOhVi7AHwT2K+8hlL6ssob5cdzmenN7tFOoPtlCcmVYEuQy1e0zQ4Nv38lWLqJn1TbaM5rOCF3jHTB8g=
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr27098490iok.75.1563220634269;
 Mon, 15 Jul 2019 12:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190715164705.220693-1-henryburns@google.com> <CAMJBoFMS2BiCdBFBEGE_p5fovDphGqjDjaBYnfGFWhNvCnAvdQ@mail.gmail.com>
In-Reply-To: <CAMJBoFMS2BiCdBFBEGE_p5fovDphGqjDjaBYnfGFWhNvCnAvdQ@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Mon, 15 Jul 2019 12:56:38 -0700
Message-ID: <CAGQXPTh-Z664T3Uxak-CiRn6Mc-s=esRzURLpwQaN+v0RgxFyg@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Reinitialize zhdr structs after migration
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> z3fold_page_migration() calls memcpy(new_zhdr, zhdr, PAGE_SIZE).
>> However, zhdr contains fields that can't be directly coppied over (ex:
>> list_head, a circular linked list). We only need to initialize the
>> linked lists in new_zhdr, as z3fold_isolate_page() already ensures
>> that these lists are empty.
>>
>> Additionally it is possible that zhdr->work has been placed in a
>> workqueue. In this case we shouldn't migrate the page, as zhdr->work
>> references zhdr as opposed to new_zhdr.
>>
>> Fixes: bba4c5f96ce4 ("mm/z3fold.c: support page migration")
>> Signed-off-by: Henry Burns <henryburns@google.com>
>> ---
>>  mm/z3fold.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/z3fold.c b/mm/z3fold.c
>> index 42ef9955117c..9da471bcab93 100644
>> --- a/mm/z3fold.c
>> +++ b/mm/z3fold.c
>> @@ -1352,12 +1352,22 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>>                 z3fold_page_unlock(zhdr);
>>                 return -EBUSY;
>>         }
>> +       if (work_pending(&zhdr->work)) {
>> +               z3fold_page_unlock(zhdr);
>> +               return -EAGAIN;
>> +       }
>>         new_zhdr = page_address(newpage);
>>         memcpy(new_zhdr, zhdr, PAGE_SIZE);
>>         newpage->private = page->private;
>>         page->private = 0;
>>         z3fold_page_unlock(zhdr);
>>         spin_lock_init(&new_zhdr->page_lock);
>> +       INIT_WORK(&new_zhdr->work, compact_page_work);
>> +       /*
>> +        * z3fold_page_isolate() ensures that this list is empty, so we only
>> +        * have to reinitialize it.
>> +        */
>
>
> On the nitpicking side, we seem to have ensured that directly in migrate :) Looks OK to me otherwise.
Ok, I see it happens in the call to do_compact_page(). Got it, new
patch coming out now.

>
> ~Vitaly
>
>> +       INIT_LIST_HEAD(&new_zhdr->buddy);
>>         new_mapping = page_mapping(page);
>>         __ClearPageMovable(page);
>>         ClearPagePrivate(page);
>> --
>> 2.22.0.510.g264f2c817a-goog
>>
